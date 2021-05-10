#! /usr/bin/env bash

#
# General Description:
# -- 1. This program should be invoked by the cronjob with root permission
# -- 2. If cronjob is set, this is executed only at most once a week
#
# A. How to test this script
#    1. check/edit/verify following global variables
#       - PGMNAME        /* this script file name i.e. audit */
#       - ROOTDIR        /* default to $HOME/cron i.e. /root/cron */
#       - TESTSETS       /* test sets to be run i.e. all */
#       - MAX_LOOP_CNT        /* total loop should be run */
#    2. run the test manually (twice with reboot)
#       - Case 1: PGMNAME=reboot; ROOTDIR=/root/cron; TESTSETS="all" */
#         * Unix> su -
#         * Unix# /root/cron/${PGMNAME}.sh
#         * Unix# cat /root/cron/logs/logs/${PGMNAME}.txt
#
# B. How to set-up the cronjob
#    1. become the root
#       - Unix> su -
#       - Unix#
#    2. Check the current cronjob
#       - Unix# crontab -l
#    3. Set-up this cronjob (assume $ROOTDIR=/root/cron) 
#       - (as of now) (in sequence execution; future by dependency)
#         * Unix# crontab -e
#         * add the following line in the end
#                 @weekly /root/cron/audit.sh
#    4. If needed, verify results at the 2 min. sleep period
#       - Unix> su - 
#       - Unix# cat /root/cron/logs/logs/${PGMNAME}.txt
#    5. When done, remove the cronjob (at the 2 min period)
#       - method 1: remove all cronjob
#         * Unix# Unix# crontab -r
#       - method 2: remove this particular cronjob
#         * (as of now) (in sequence execution; future by dependency)
#           - Unix# crontab -e
#           - remove the following line 
#             @weekly /root/cron/audit.sh
#

PGMNAME=audit
ROOTDIR=$HOME/cron
# ALLTESTS must contain lower cases
ALLTESTS="system bios cpu memory network storage sas-controller"
TESTSETS="all"
#TESTSETS="storage"
MAX_LOOP_CNT=1000

CRONLOGDIR=${ROOTDIR}/logs
LOGFILE=${ROOTDIR}/logs/${PGMNAME}.txt
LOG_LOCAL_FILE=${ROOTDIR}/logs/${PGMNAME}_log.txt
# PGM_DATE=/usr/bin/date
PGM_DATE=date
PGM_UPTIME=uptime
PGM_UNAME=uname
PGM_LSBLK=lsblk
PGM_DMIDECODE=dmidecode
PGM_LSCPU=lscpu
PGM_LSPCI=lspci
# smartctl 
#  1. Installation
#     - Ubuntu> sudo apt-get install smartmontools
#  2. Check whether it is enabled or not
#     - Unix# lsblk
#     - Unix# sudo smartctl -i /dev/<dev>
#       i.e.# sudo smartctl -i /dev/sda
#  3. Enable a device
#     - Unix# lsblk
#     - Unix# sudo smartctl -s on /dev/<dev>
#       i.e.# sudo smartctl -s on /dev/sda
#  4. Check_run_time/Test_(with_long_test)/List_Test_Stat a device
#     - Unix# lsblk
#     - Unix# sudo smartctl -c /dev/<dev>
#     - Unix# sudo smartctl -t long /dev/<dev>
#     - Unix# sudo smartctl -l selftest /dev/<dev>
PGM_SMARTCTL=smartctl
PGM_IP=ip
#PGM_NVIDIA-SMI=nvidia-smi

#PGM_REBOOT=/usr/sbin/reboot

# Global variables to be used/set across functions
TSTAMP=
RESULT=
RESULT_MSG=
REBOOT_CNT=
LOCAL_MSG=

#
# Global functions
#
# 1. check_required_pgm(): checks all required PGM_XXX exists in the system
# 2. get_tstamp_uptime()
#    /* output: "<yyyy>-<mm>-<dd> (<nodename> up <X> minutes)" */
# 3. log_result_msg()
#    /* input $1: target name */
#    /* output: "Test <test> <loop> at <tstamp>: <result_msg>" */
# 4. Test related to mnt point tests
#    4.1 run_mnt() 
#        -- input $1: type of target device (currently either usb or nvme)
#        -- check   <cnt_of_mnt_pt_for_target_devices_in_/etc/fstab>
#           matches <cnt_of_mnt_pt_for_target_devices_calculated_in_lsblk>
#        -- assumption: * target_device has a entry(by UUID) in /etc/fstab
#                       * mnt_pt is in the /mnt/usb<xxx>  for usb  devices
#                       * mnt_pt is in the /mnt/nvme<xxx> for nvme devices
#    4.2 run_usb() ==> invoke "run_mnt usb"
#    4.3 run_nvme()==> invoke "run_mnt nvme"
# 5. run_tests(): loop through ${TESTSETS} for tests to be run 
#    /* returns: num_of_errors encountered during all ${TESTSETS} tests */
# 6. run_unknown(): default function to handle the not-supported test
#    /* input $1: (unknown or unsupported) test name */
#
check_required_pgm()
{
	# run once only when ${LOGFILE}, ${LOG_LOCAL_FILE} is just created
	_file=${ROOTDIR}/${PGMNAME}.sh 
	if [ ! -f ${_file} ]; then
		echo "Error: cron file not exist: ${_file}"
		exit 1001
	fi
	if [ ! -f ${LOGFILE} ]; then
		echo "Error: log file not exist: ${LOGFILE}"
		exit 1001
	fi
	if [ ! -f ${LOG_LOCAL_FILE} ]; then
		echo "Error: log local file not exist: ${LOG_LOCAL_FILE}"
		exit 1001
	fi

	_env_pgm_list=`grep "^PGM_" ${_file} | grep -v "^#"`
	if [ "${_env_pgm_list}x" = "x" ]; then
		# nothing to test
		return 0
	fi
	_error_cnt=0
	for _line in ${_env_pgm_list}; do
		_label=`echo ${_line} | cut -f1 -d'='`
		_pgm=`echo ${_line} | cut -f2 -d'='`
		#echo "DBG: ${_label}::::${_pgm}"
		type ${_basename} 2>/dev/null
		if [ $? -ne 0 ]; then
			echo "Error: no_pgm ${_pgm}"
			echo "Error: no_pgm ${_pgm}" >> ${LOGFILE}
			_error_cnt=`expr ${_error_cnt} + 1`
		fi
	done
	# Exit if not 0
	if [ ${_error_cnt} -ne 0 ]; then
		Exit ${_error_cnt}
	fi
	return ${_error_cnt}
}

get_tstamp_uptime()
{
	_tstamp_str=`${PGM_DATE} '+%m-%d %H:%M:%S'`
	_uname=`${PGM_UNAME} -n`
	#_uptime_str=`${PGM_UPTIME} | awk '{ print $3 " " $4 " " $5 " " }'`
	TSTAMP="(${_tstamp_str} (host: ${_uname}))"
	return 0
}

log_result_msg()
{
	_run=$1

	get_tstamp_uptime
	_cnt=`grep "${_run} test case" ${LOGFILE} | grep -v "^#" | wc -l`
	_id=`expr ${_cnt} + 1`
	echo "Test ${_id} ${TSTAMP}: ${RESULT_MSG}" >> ${LOGFILE}
	return 0
}


log_local_msg()
{
	echo "${LOCAL_MSG}" >> ${LOG_LOCAL_FILE}
	return 0

}


hwinfo_dmidecode()
{
	_area=$1
	_func="hwinfo_dmidecode()"
	# cpu is not in supported_area (use lscpu unless "Part Number:" exist)
	#_supported_areas="bios cpu memory"
	_supported_areas="system bios memory"
	__cnt=0
	RESULT=0
	# check the input ${_area} is within ${_supported_areas} scopes
	for _section in ${_supported_areas}; do
		[ ! "${_section}" = "${_area}" ] && continue
		__cnt=1
	done
	if [ ${__cnt} -eq 0 ]; then
		RESULT_MSG="Failed (no such dmidecode area ${_area} test case)"
		RESULT=1
		LOCAL_MSG="## ${_func} ${_area} not found"
		log_local_msg
		return
	fi

	_tfile=${ROOTDIR}/logs/tmp_dmidecode_${_area}.txt
	_type_str=
	case ${_area} in
		system)
			#_type_id_list="1 32 15"
			_type_str="system"
			${PGM_DMIDECODE} -t ${_type_str} > ${_tfile}
			# search for following keywords:
			#   "Manufacturer:"  (i.e. "Supermicro")
			#   "Product Name:" (i.e. "AS -2023US-TR4")
			#   "SKU Number:"   (i.e. "TBC")
			_manu=`grep "Manufacturer:"  ${_tfile} | cut -f2- -d':'`
			_prod=`grep "Product Name:" ${_tfile} | cut -f2- -d':'`
			_sku=`grep "SKU Number:" ${_tfile} | cut -f2- -d':'`
			LOCAL_MSG="  System:"
			log_local_msg
			LOCAL_MSG="      Manufacturer: ${_manu}"
			log_local_msg
			LOCAL_MSG="      Product Name: ${_prod}"
			log_local_msg
			LOCAL_MSG="      SKU Number: ${_sku}"
			log_local_msg
			;;
		bios )
			#_type_id_list="1 13"
			_type_str="bios"
			${PGM_DMIDECODE} -t ${_type_str} > ${_tfile}
			# search for following keywords:
			#   "Version:"      (i.e. "2.1")
			#   "Release Date:" (i.e. "06/14/2018")
			#   "Vendor:"       (i.e. "American Megatrends Inc.")
			_ver=`grep "Version:"      ${_tfile} | awk '{print $2}'`
			_rel=`grep "Release Date:" ${_tfile} | awk '{print $3}'`
			LOCAL_MSG="  BIOS: Version: ${_ver} (${_rel})"
			log_local_msg
			LOCAL_MSG=`grep "Vendor:" ${_tfile}`
			log_local_msg
			;;
		#cpu )
		#	#_type_id_list="4"
		#	_type_str="processor"
		#	${PGM_DMIDECODE} -t ${_type_str} > ${_tfile}
		#      ;;
		memory )
			#_type_id_list="5 6 16 17"
			_type_str="memory"
			${PGM_DMIDECODE} -t ${_type_str} > ${_tfile}
			_mem_cnt=`grep "Size:" ${_tfile} | grep -v "No Module" | grep -v " Size:" | wc -l`
			_mem_info=`grep "Size:" ${_tfile} | grep -v "No Module" | grep -v " Size:" | sort -u | cut -f2 -d':'`
			_mem_sp_c=`cat ${_tfile} | grep "Clock Speed:" | grep -v "Unknown" | cut -f2- -d':' | sort -u`
			_mem_sp=`cat ${_tfile} | grep "Speed:" | grep -v "Unknown" | grep -v "Clock Speed:" | cut -f2- -d':' | sort -u`
			LOCAL_MSG="  Memory:  ${_mem_cnt} x (Size: ${_mem_info}) (Speed: ${_mem_sp_c}/${_mem_sp})"
			log_local_msg
			LOCAL_MSG=`cat ${_tfile} | grep "Part Number:" | grep -v "NO DIMM" | grep -v "Unknown" | sort`
			log_local_msg
		      ;;
      	esac
	if [ "x${_type_str}" = "x" ]; then
		RESULT_MSG="Failed (${_func} no type for ${_area} test case)"
		RESULT=1
		LOCAL_MSG="## ${_func} ${_area} not found"
		log_local_msg
		return
	fi
	# _tfile will be cleanup at the end if no errors

	RESULT=0
}



hwinfo_system()
{
	_hw_func="hwinfo_system()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	hwinfo_dmidecode system

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}

hwinfo_bios()
{
	_hw_func="hwinfo_bios()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	hwinfo_dmidecode bios

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}

hwinfo_cpu()
{
	_hw_func="hwinfo_cpu()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	_tfile=${ROOTDIR}/logs/tmp_lscpu.txt

	# lscpu for hwinfo_cpu() (alternative "dmidecode -t processor")
	${PGM_LSCPU} > ${_tfile}
	_cpu_cnt=`grep -in "^Socket(s):" ${_tfile} | awk '{print $2}'`
	_model=`grep "^Model name:" ${_tfile} | awk '{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}'`
	_core_cnt=`grep -in "^Core(s) per" ${_tfile} | awk '{print $4}'`
	LOCAL_MSG="  CPU: ${_cpu_cnt} x (${_model}) (${_core_cnt}-core)"
	log_local_msg
	# _tfile will be cleanup at the end if no errors

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	RESULT=0
	return ${RESULT}
}


hwinfo_memory()
{
	_hw_func="hwinfo_memory()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	# dmidecode -t memory
	hwinfo_dmidecode memory

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}

hwinfo_network()
{
	_hw_func="hwinfo_network()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg
	

	#_intf_list=`${PGM_IP} addr show | grep state | grep -v pfifo_fast | grep -v "qdisc noqueue" | grep -v "qdisc fq_codel" | awk '{print $2}' | cut -f1 -d':'`
	#_intf_cnt=`${PGM_IP} addr show | grep state | grep -v pfifo_fast | grep -v "qdisc noqueue" |  grep -v "qdisc fq_codel" | wc -l`

	_tfile=${ROOTDIR}/logs/tmp_lspci.txt
	${PGM_LSPCI} > ${_tfile}

	_intf_pci_list=`grep "Ethernet controller:" ${_tfile} | cut -f1 -d' '`
	_cnt=0
	LOCAL_MSG="  Network-Ethernet Controllers/Interfaces (${_intf_cnt}): "
	log_local_msg
	for _intf_pci in ${_intf_pci_list}; do
		#echo "DBG: intf_pci=${_intf_pci}"
		_desc=`${PGM_LSPCI} -vv -s ${_intf_pci} | grep "Ethernet controller:" | cut -f3- -d':'`
		_cnt=`expr ${_cnt} + 1`
		LOCAL_MSG="      ${_cnt}: ${_desc}"
		log_local_msg
		_pn=`${PGM_LSPCI} -vv -s ${_intf_pci} | grep "Part number:" | cut -f1 -d'\' | cut -f2- -d' '`
		LOCAL_MSG="          pci_bus: ${_intf_pci};  ${_pn}"
		log_local_msg
	done

	# _tfile will be cleanup at the end if no errors

	RESULT=0
	#if [ ${_intf_cnt} -ne ${_cnt} ]; then
	#	RESULT=1
	#fi

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}

hwinfo_storage()
{
	_hw_func="hwinfo_storage()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	_tfile=${ROOTDIR}/logs/tmp_lsblk.txt
	${PGM_LSBLK} > ${_tfile}

	#_mnt_pt_list=`grep "part" ${_tfile} | grep " /" | awk '{ print $7 }'`
	_mnt_dev_list=`grep "disk" ${_tfile} | awk '{print $1}'`
	LOCAL_MSG="  Storage (Block) Info"
	log_local_msg
	_idx=0
	for _dev in `echo ${_mnt_dev_list}`; do

		# Storage types are handled by different program
		# -- nvme is handled by "nvme list"
		# -- HDD  is handled by "smartctl -a <dev>"

		# NVME handling ("nvme list")
		echo ${_dev} | grep "^nvme" 1>/dev/null 2>/dev/null
		if [ $? -eq 0 ]; then
			_idx=`expr ${_idx} + 1`
			type nvme 1>/dev/null 2>/dev/null
			if [ $? -ne 0 ]; then
				_size=`grep "^${_dev}" ${_tfile} | awk '{ print $4}'`
				LOCAL_MSG="    ${_idx} (${_dev}): ${_size} (Warn: cannot run \"nvme list\")"
			else
				_size=`nvme list | grep ${_dev} | cut -f4,5 -d'/' | awk '{ print $1 " " $2 }'`
				_part_num=`nvme list | grep ${_dev} | awk '{ print $3 " " $4 ", " $2 }'`
				LOCAL_MSG="    ${_idx} (${_dev}): ${_size} ${_part_num}"
			fi
			log_local_msg
			continue	
		fi

		# HDD handling (" smartctl -a /dev/${_dev}") 
		#echo "smartctl -a /dev/${_dev}"
		_tfile=${ROOTDIR}/logs/tmp_smartctl_${_dev}.txt
		${PGM_SMARTCTL} -a /dev/${_dev} | head -20  > ${_tfile}

		# skip "Unknown" USB devices (i.e. "Unknown USB bridge")
		grep -i "Unknown" ${_tfile} | grep -i "USB" 2>/dev/null
		if [ $? -eq 0 ]; then
			_unknown_dev=`grep -i "Unknown" ${_tfile} 2>/dev/null`
			LOCAL_MSG="        Warning: ${_unknown_dev}"
			log_local_msg
			continue
		fi

		_idx=`expr ${_idx} + 1`
		# search for following keywords:
		#   "Device Model:"       (i.e. "Micron_5200_MTFDDAK1T9TDC")
		#        or "Vendor:"_"Product:" ("Revision:")
		#           (i.e. "SEGATE_ST2000NX0273 (E005)")
		#   "User Capacity:"      (i.e. "[2.00 TB]")
		#   "Rotation Rate:"      (i.e. "7200 rpm")
		#   "Form Factor:"        (i.e. "2.5 inches")
		#   "Device type:"        (i.e. "disk")
		#   "Transport protocol:" (i.e. "SAS (SPL-3)")
		_model=`grep "^Device Model:" ${_tfile} | awk '{print $3 $4}'`
		if [ "x" = "x${_model}" ]; then
			_vendor=`grep "^Vendor:" ${_tfile} | awk '{print $2}'`
			_prod=`grep "^Product:" ${_tfile} | awk '{print $2}'`
			_rev=`grep "^Revision:" ${_tfile} | awk '{print $2}'`
			_model="${_vendor}_${_prod} (${rev})"
		fi
		#echo "DBG: ${_dev}: _model=${_model}"
		_size=`grep "^User Capacity:" ${_tfile} | cut -f2 -d'[' | cut -f1 -d']'`
		#echo "DBG: ${_dev}: _size=${_size}"

		_rotate_rate=`grep "^Rotation Rate:" ${_tfile} | grep -v "Solid State" | awk '{print $3}'`
		if [ ! "x" = "x${_rotate_rate}" ]; then
			_rotate_rate="${_rotate_rate} rpm,"
		fi
		#echo "DBG: ${_dev}: _rotate_rate=${_rotate_rate}"

		_form_factor=`grep "^Form Factor:" ${_tfile} | awk '{print $3}'`
		if [ ! "x" = "x${_form_factor}" ]; then
			_form_factor="${_form_factor} \","
		fi
		#echo "DBG: ${_dev}: _form_factor=${_form_factor}"

		_type=`grep "^Device type:" ${_tfile} | awk '{print $3}'`
		if [ ! "x" = "x${_type}" ]; then
			_type="${_type}\","
		fi
		#echo "DBG: ${_dev}: _type=${_type}"

		_protocol=`grep "^SATA Version is:" ${_tfile} | awk '{print $4, $5}'`
		if [ "x" = "x${_protocol}" ]; then
			_protocol=`grep "^Transport protocol:" ${_tfile} | awk '{print $3}'`
		fi
		#echo "DBG: ${_dev}: _protocol=${_protocol}"
		LOCAL_MSG="    ${_idx} (${_dev}): ${_size}, ${_model}, ${_form_factor} ${_type} ${_rotate_rate} ${_protocol}"
		log_local_msg
	done

	RESULT=0
	# _tfile will be cleanup at the end if no errors

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}

hwinfo_sas-controller()
{
	_hw_func="hwinfo_sas-controller()"
	_b_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="#"
	log_local_msg
	LOCAL_MSG="# ${_hw_func} Begin ${_b_str}"
	log_local_msg

	_tfile=${ROOTDIR}/logs/tmp_lspci.txt
	${PGM_LSPCI} > ${_tfile}

	_intf_pci_list=`grep -i "controller:" ${_tfile} | grep -i "sas" | cut -f1 -d' '`
	_cnt=0
	LOCAL_MSG="  SAS Controller: "
	log_local_msg
	for _intf_pci in ${_intf_pci_list}; do
		#echo "DBG: intf_pci=${_intf_pci}"
		_desc=`${PGM_LSPCI} -vv -s ${_intf_pci} | head -1 | cut -f3- -d':'`
		_cnt=`expr ${_cnt} + 1`
		LOCAL_MSG="      ${_cnt}: ${_desc}"
		log_local_msg
		_ss=`${PGM_LSPCI} -vv -s ${_intf_pci} | grep "Subsystem:" | head -1 | cut -f2- -d' '`
		LOCAL_MSG="          pci_bus: ${_intf_pci}; ${_ss}"
		log_local_msg
	done

	RESULT=0
	# _tfile will be cleanup at the end if no errors

	_e_str=`${PGM_DATE} '+%Y-%m-%d %H:%M:%S'`
	LOCAL_MSG="# ${_hw_func} End   ${_e_str} (from ${_b_str})"
	log_local_msg

	return ${RESULT}
}
	

run_hwinfo()
{
	__target=$1

	__cnt=0
	RESULT=0
	for __test in ${ALLTESTS}; do
		[ ! "${__test}" = "${__target}" ] && continue
		__cnt=1
		case ${__target} in
		system )
		      #echo "invoke hwinfo_system"
		      hwinfo_system
		      ;;
		bios )
		      #echo "invoke hwinfo_bios"
		      hwinfo_bios
		      ;;
		cpu )
		      #echo "invoke hwinfo_cpu"
		      hwinfo_cpu
		      ;;
		memory )
		      #echo "invoke hwinfo_memory"
		      hwinfo_memory
		      ;;
		network )
		      #echo "invoke hwinfo_network"
		      hwinfo_network
		      ;;
		storage )
		      #echo "invoke hwinfo_storage"
		      hwinfo_storage
		      ;;
		sas-controller )
		      #echo "invoke hwinfo_sas-controller"
		      hwinfo_sas-controller
		      ;;
		* )
		      echo "FAIL (${__target} test case unknown)"
		      __cnt=0
		      ;;
      		esac
	done
	# if no match, 
	if [ ${__cnt} -eq 0 ]; then
		RESULT=1
		RESULT_MSG="FAIL (${__target} test case unknown)"
	else
		# RESULT     is set by ${__target} handler
		# RESULT_MSG is set by ${__target} handler if having errors
		if [ ${RESULT} -eq 0 ]; then
			RESULT_MSG="PASS (${__target} test case)"
		fi
	fi
	log_result_msg ${__target}
}
	


run_tests()
{
	_lfile=${ROOTDIR}/logs/${PGMNAME}_log.txt
	[ ! -f ${_lfile} ] && touch ${_lfile}

	_err_cnt=0
	#echo "DBG: TESTSETS = ${TESTSETS}"
	#echo "DBG: ALLTESTS = ${ALLTESTS}"
	for _test in ${TESTSETS}; do
		# conver to lower case 
		# Sol.1: lower=`echo ${_test} | tr '[:upper:]' '[:lower:]'`
		# Sol.2: lower=`echo ${_test} | tr '[A-Z]' '[a-z]'`
		# Sol.3: lower=`echo ${_test} | awk '{print tolower($0)}'`
		# Sol.4: lower=${_test,,}
		_lower_test=`echo ${_test} | tr '[A-Z]' '[a-z]'`
		case ${_lower_test} in
		all )
			for _t in ${ALLTESTS}; do
				echo "run_hwinfo ${_t}"
				run_hwinfo ${_t}
				if [ ! "0" = "${RESULT}" ]; then
					_err_cnt=`expr ${_err_cnt} + 1`
					echo "run_hwinfo ${_t} return ${RESULT}"
				fi
			done
			;;
		* )
			run_hwinfo ${_lower_test}
			if [ ${RESULT} -ne 0 ]; then
				_err_cnt=`expr ${_err_cnt} + 1`
				echo "run_hwinfo ${_test} return ${RESULT}"
			fi
			;;
		esac
	done
	return ${_err_cnt}
}


# #############################################################
# Main Program Starts Here
# #############################################################

err_cnt=0

if [ ! -d ${CRONLOGDIR} ]; then
	echo "mkdir -p ${CRONLOGDIR}"
	mkdir -p ${CRONLOGDIR}
else
	echo "CRONLOGDIR=${CRONLOGDIR}"
	if [ -f ${LOG_LOCAL_FILE} ]; then
		echo "rm ${LOG_LOCAL_FILE}"
		rm ${LOG_LOCAL_FILE}
	fi
fi 
if [ ! -f ${LOGFILE} ]; then
	touch ${LOGFILE}
	if [ ! -f ${LOG_LOCAL_FILE} ]; then
		touch ${LOG_LOCAL_FILE}
	fi
	check_required_pgm
fi

b_str=`${PGM_DATE} '+%H:%M:%S'`

# Exit if reboot reaching ${MAX_LOOP_CNT}
_cnt=`grep "Ends ${PGMNAME}" ${LOGFILE} | grep -v "^#" | wc -l`
LOOP=`expr ${_cnt} + 1`

if [ ${LOOP} -gt ${MAX_LOOP_CNT} ]; then
	# do nothing if LOOP is greater than MAX_LOOP_CNT
	echo "${PGMNAME} Error: >= Max Reboot (${LOOP})" >> ${LOGFILE}
	err_cnt=${MAX_LOOP_CNT}
else
	# Run the test 
	run_tests
	err_cnt=$?
fi

# remove all tmp file if  having errors
if [ ${err_cnt} -eq 0 ]; then
	ls ${ROOTDIR}/logs/tmp_*.txt 1>/dev/null 2>/dev/null
	if [ $? -eq 0 ]; then
		for _file in `ls ${ROOTDIR}/logs/tmp_*.txt`; do
			#ls -l ${_file}
			#echo "rm ${_file}"
			rm ${_file}
		done
	fi
fi

# Record the results (for the testsets)
e_str=`${PGM_DATE} '+%H:%M:%S'`
echo "Test ${LOOP} Ends ${PGMNAME} (${err_cnt} Errors) (${b_str}-${e_str})" >> ${LOGFILE}

# cronjob should not reboot if exit in non-zero codes
exit ${err_cnt}
