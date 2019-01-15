#if 0
	shc Version 3.8.9b, Generic Script Compiler
	Copyright (c) 1994-2015 Francisco Rosales <frosal@fi.upm.es>

	shc -f github-setup.sh 
#endif

static  char data [] = 
#define      msg1_z	42
#define      msg1	((&data[8]))
	"\175\242\122\253\041\344\107\376\163\370\141\213\274\312\377\132"
	"\230\167\046\044\041\323\030\153\053\312\235\126\355\107\351\367"
	"\025\316\147\122\065\106\073\306\163\013\240\225\376\120\252\331"
	"\225\067\055\162\152\055\217\237\160\300\154"
#define      chk2_z	19
#define      chk2	((&data[63]))
	"\330\071\030\362\077\252\235\152\117\175\203\112\101\263\125\140"
	"\232\237\146\151\305\254\243\242"
#define      tst2_z	19
#define      tst2	((&data[87]))
	"\375\304\035\172\041\164\327\374\055\261\161\107\216\030\037\254"
	"\143\143\142\246\330\217\067\146"
#define      lsto_z	1
#define      lsto	((&data[107]))
	"\225"
#define      inlo_z	3
#define      inlo	((&data[108]))
	"\014\007\354"
#define      tst1_z	22
#define      tst1	((&data[116]))
	"\260\157\217\040\057\226\115\033\346\300\054\357\141\123\004\325"
	"\125\262\233\050\144\157\345\271\267\267\073\374\037\055\114\367"
#define      chk1_z	22
#define      chk1	((&data[145]))
	"\010\104\054\043\230\130\253\273\264\300\346\104\013\360\346\315"
	"\352\147\232\101\261\231\235\220\351\114\102\255\152"
#define      opts_z	1
#define      opts	((&data[172]))
	"\323"
#define      pswd_z	256
#define      pswd	((&data[212]))
	"\120\040\263\060\020\143\237\240\204\317\234\243\374\350\232\143"
	"\115\204\154\221\155\271\324\032\043\220\056\376\163\311\057\303"
	"\351\342\364\372\105\224\232\151\321\077\213\266\272\126\246\252"
	"\366\274\115\107\302\231\270\235\166\043\230\267\047\254\146\241"
	"\215\233\103\045\373\010\217\315\107\032\203\001\160\051\253\146"
	"\345\370\256\250\222\146\105\010\211\335\277\260\211\045\122\027"
	"\301\226\075\274\236\314\211\346\346\015\347\126\067\222\275\035"
	"\213\153\305\035\322\012\046\134\347\346\015\161\014\137\210\315"
	"\366\305\212\225\222\024\173\170\041\142\317\130\365\215\166\201"
	"\370\073\237\312\106\305\047\056\254\064\237\270\223\050\206\212"
	"\356\020\037\200\044\232\371\105\375\310\236\362\126\024\164\116"
	"\120\023\031\226\330\100\304\204\165\143\075\010\213\303\223\172"
	"\324\262\372\370\115\363\076\113\274\335\076\022\362\262\141\102"
	"\305\173\330\236\274\234\043\061\000\140\072\214\044\315\006\370"
	"\200\001\360\316\365\057\031\261\014\127\304\376\011\046\100\316"
	"\241\031\155\135\266\220\217\267\360\311\103\024\226\112\014\027"
	"\113\375\345\100\054\376\362\071\126\267\067\137\335\170\056\177"
	"\222\233\335\110\053\154\377\034\065\103\060\314\215\075\343\331"
	"\073\310\032\150\307\015\241\311\143\067\154\140\037\007\303\154"
	"\213\060\376"
#define      date_z	1
#define      date	((&data[480]))
	"\370"
#define      shll_z	10
#define      shll	((&data[481]))
	"\024\072\345\013\030\372\274\022\005\275\102"
#define      xecc_z	15
#define      xecc	((&data[495]))
	"\073\233\365\122\203\227\357\100\031\107\351\223\052\337\204\111"
	"\325\161"
#define      msg2_z	19
#define      msg2	((&data[512]))
	"\142\043\220\133\304\101\244\165\136\316\153\240\132\161\227\340"
	"\072\331\277\346\075\212\054\207\301"
#define      rlax_z	1
#define      rlax	((&data[535]))
	"\366"
#define      text_z	891
#define      text	((&data[684]))
	"\053\332\114\044\304\037\070\321\203\172\335\133\205\030\366\172"
	"\065\205\152\230\251\364\305\060\265\136\027\226\376\302\344\052"
	"\235\060\117\141\120\207\062\324\001\020\057\207\050\045\002\136"
	"\253\154\367\125\141\274\205\026\033\235\255\032\140\221\104\375"
	"\302\223\136\022\032\221\347\034\242\026\243\312\073\245\051\347"
	"\022\041\074\163\336\302\211\371\140\067\023\300\310\127\276\212"
	"\353\035\235\006\256\204\042\120\233\305\033\327\153\105\276\175"
	"\146\373\360\104\276\172\076\036\261\121\337\171\251\235\004\224"
	"\273\242\232\151\047\275\272\302\202\326\231\356\034\130\153\202"
	"\124\133\307\022\202\352\000\140\016\142\130\010\234\115\017\040"
	"\316\171\216\337\117\103\040\077\132\061\325\003\230\374\142\316"
	"\266\012\325\073\314\177\121\243\271\075\350\144\072\172\065\123"
	"\216\305\105\062\012\316\323\316\310\042\040\220\150\146\326\045"
	"\217\344\115\320\050\065\262\330\043\216\137\347\260\322\357\356"
	"\101\112\105\151\016\147\033\017\170\223\007\142\000\361\004\125"
	"\241\303\015\300\041\220\310\170\351\023\255\143\172\213\346\250"
	"\323\225\176\063\006\300\127\325\213\243\256\161\161\301\006\312"
	"\014\046\321\126\200\252\024\255\377\046\273\204\174\234\265\023"
	"\342\176\221\074\232\131\266\012\055\244\161\152\333\002\121\100"
	"\312\037\326\126\132\040\153\145\237\371\353\351\226\010\266\005"
	"\252\271\146\313\122\124\226\257\267\317\253\356\375\335\313\012"
	"\032\013\012\253\062\060\244\004\023\314\270\035\133\006\051\030"
	"\153\162\103\200\163\114\335\336\103\004\127\066\162\244\313\204"
	"\136\251\340\162\034\364\276\346\021\130\132\032\075\251\140\352"
	"\022\015\134\127\145\344\060\010\105\077\054\363\161\071\304\064"
	"\243\250\245\111\241\131\146\376\212\115\237\232\177\354\032\163"
	"\133\260\114\134\122\204\312\037\020\241\243\364\004\374\055\342"
	"\372\271\147\155\155\251\206\045\003\033\063\035\017\000\102\163"
	"\203\240\066\274\220\343\136\372\127\057\060\070\157\173\042\215"
	"\355\317\054\125\001\346\146\377\134\253\307\205\031\050\277\037"
	"\264\041\214\030\017\377\342\353\161\324\362\121\113\266\312\172"
	"\270\150\132\206\205\201\137\167\342\260\016\301\120\305\263\076"
	"\253\306\332\101\133\371\240\276\022\377\164\272\220\273\142\345"
	"\237\213\353\211\214\015\104\253\245\340\353\331\062\170\220\226"
	"\225\126\202\106\162\100\241\163\127\250\111\061\245\036\144\055"
	"\243\375\037\013\310\352\271\066\134\271\011\346\150\220\001\366"
	"\356\116\160\044\361\375\041\127\024\263\233\203\013\370\265\241"
	"\231\137\042\022\154\344\361\217\043\241\343\224\340\161\245\350"
	"\227\264\177\274\240\331\100\207\076\037\003\311\234\261\007\041"
	"\243\273\373\123\031\200\025\251\113\177\217\344\070\225\210\125"
	"\242\143\057\015\266\306\222\300\231\164\267\323\173\060\052\306"
	"\070\272\321\030\067\325\304\057\134\262\144\326\172\355\167\007"
	"\046\234\053\040\211\272\210\166\217\014\345\231\164\113\273\253"
	"\051\204\124\157\035\042\061\341\165\252\143\150\072\364\170\165"
	"\331\300\020\254\232\151\177\055\314\234\062\326\226\254\324\177"
	"\165\256\114\337\123\111\151\357\252\066\356\006\342\331\147\060"
	"\174\163\220\053\117\272\374\325\000\356\314\331\313\072\026\165"
	"\137\146\203\201\266\007\326\002\220\233\266\066\061\113\326\332"
	"\240\032\272\144\343\374\263\131\025\153\237\027\374\246\354\147"
	"\031\105\155\225\061\351\045\006\360\000\115\026\364\124\353\212"
	"\231\010\050\216\171\066\223\011\313\300\230\102\035\114\137\141"
	"\133\356\356\037\323\036\347\246\323\070\115\367\173\127\365\221"
	"\351\005\317\334\146\346\123\042\111\236\101\242\123\032\166\151"
	"\205\063\373\354\355\170\173\212\345\357\004\301\250\067\205\021"
	"\136\273\230\163\272\301\134\153\240\125\123\372\003\141\013\313"
	"\222\301\101\066\050\112\203\353\232\244\351\250\075\246\360\064"
	"\216\233\031\227\011\274\327\212\263\020\021\252\021\251\341\300"
	"\257\224\234\227\025\011\123\303\363\137\223\142\267\106\004\255"
	"\005\145\257\125\037\356\163\070\252\054\036\122\102\351\372\212"
	"\247\005\013\315\323\355\223\345\046\233\144\230\142\107\116\161"
	"\325\271\163\062\144\264\327\235\016\330\153\267\330\013\331\357"
	"\122\145\340\335\063\075\177\015\310\114\231\050\116\053\143\372"
	"\225\264\205\011\141\127\015\276\337\254\233\040\146\324\313\047"
	"\225\314\056\157\367\110\260\233\041\273\342\137\174\252\335\072"
	"\305\002\041\040\033\105\226\004\015\033\315\270\160\013\263\325"
	"\005\061\206\126\021\000\000\257\004\224\152\246\057\324\315\354"
	"\217\220\157\145\052\135\201\202\311\004\327\044\313\352\372\321"
	"\034\200\050\055\200\050\335\204\275\107\053\354\033\371\331\252"
	"\211\111\020\263\247\222\066\160\226\015\225\142\370\217\063\024"
	"\017\134"/* End of data[] */;
#define      hide_z	4096
#define DEBUGEXEC	0	/* Define as 1 to debug execvp calls */
#define TRACEABLE	0	/* Define as 1 to enable ptrace the executable */

/* rtc.c */

#include <sys/stat.h>
#include <sys/types.h>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

/* 'Alleged RC4' */

static unsigned char stte[256], indx, jndx, kndx;

/*
 * Reset arc4 stte. 
 */
void stte_0(void)
{
	indx = jndx = kndx = 0;
	do {
		stte[indx] = indx;
	} while (++indx);
}

/*
 * Set key. Can be used more than once. 
 */
void key(void * str, int len)
{
	unsigned char tmp, * ptr = (unsigned char *)str;
	while (len > 0) {
		do {
			tmp = stte[indx];
			kndx += tmp;
			kndx += ptr[(int)indx % len];
			stte[indx] = stte[kndx];
			stte[kndx] = tmp;
		} while (++indx);
		ptr += 256;
		len -= 256;
	}
}

/*
 * Crypt data. 
 */
void arc4(void * str, int len)
{
	unsigned char tmp, * ptr = (unsigned char *)str;
	while (len > 0) {
		indx++;
		tmp = stte[indx];
		jndx += tmp;
		stte[indx] = stte[jndx];
		stte[jndx] = tmp;
		tmp += stte[indx];
		*ptr ^= stte[tmp];
		ptr++;
		len--;
	}
}

/* End of ARC4 */

/*
 * Key with file invariants. 
 */
int key_with_file(char * file)
{
	struct stat statf[1];
	struct stat control[1];

	if (stat(file, statf) < 0)
		return -1;

	/* Turn on stable fields */
	memset(control, 0, sizeof(control));
	control->st_ino = statf->st_ino;
	control->st_dev = statf->st_dev;
	control->st_rdev = statf->st_rdev;
	control->st_uid = statf->st_uid;
	control->st_gid = statf->st_gid;
	control->st_size = statf->st_size;
	control->st_mtime = statf->st_mtime;
	control->st_ctime = statf->st_ctime;
	key(control, sizeof(control));
	return 0;
}

#if DEBUGEXEC
void debugexec(char * sh11, int argc, char ** argv)
{
	int i;
	fprintf(stderr, "shll=%s\n", sh11 ? sh11 : "<null>");
	fprintf(stderr, "argc=%d\n", argc);
	if (!argv) {
		fprintf(stderr, "argv=<null>\n");
	} else { 
		for (i = 0; i <= argc ; i++)
			fprintf(stderr, "argv[%d]=%.60s\n", i, argv[i] ? argv[i] : "<null>");
	}
}
#endif /* DEBUGEXEC */

void rmarg(char ** argv, char * arg)
{
	for (; argv && *argv && *argv != arg; argv++);
	for (; argv && *argv; argv++)
		*argv = argv[1];
}

int chkenv(int argc)
{
	char buff[512];
	unsigned long mask, m;
	int l, a, c;
	char * string;
	extern char ** environ;

	mask  = (unsigned long)&chkenv;
	mask ^= (unsigned long)getpid() * ~mask;
	sprintf(buff, "x%lx", mask);
	string = getenv(buff);
#if DEBUGEXEC
	fprintf(stderr, "getenv(%s)=%s\n", buff, string ? string : "<null>");
#endif
	l = strlen(buff);
	if (!string) {
		/* 1st */
		sprintf(&buff[l], "=%lu %d", mask, argc);
		putenv(strdup(buff));
		return 0;
	}
	c = sscanf(string, "%lu %d%c", &m, &a, buff);
	if (c == 2 && m == mask) {
		/* 3rd */
		rmarg(environ, &string[-l - 1]);
		return 1 + (argc - a);
	}
	return -1;
}

#if !defined(TRACEABLE)

#define _LINUX_SOURCE_COMPAT
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

#if !defined(PTRACE_ATTACH) && defined(PT_ATTACH)
#	define PTRACE_ATTACH	PT_ATTACH
#endif
void untraceable(char * argv0)
{
	char proc[80];
	int pid, mine;

	switch(pid = fork()) {
	case  0:
		pid = getppid();
		/* For problematic SunOS ptrace */
#if defined(__FreeBSD__)
		sprintf(proc, "/proc/%d/mem", (int)pid);
#else
		sprintf(proc, "/proc/%d/as",  (int)pid);
#endif
		close(0);
		mine = !open(proc, O_RDWR|O_EXCL);
		if (!mine && errno != EBUSY)
			mine = !ptrace(PTRACE_ATTACH, pid, 0, 0);
		if (mine) {
			kill(pid, SIGCONT);
		} else {
			perror(argv0);
			kill(pid, SIGKILL);
		}
		_exit(mine);
	case -1:
		break;
	default:
		if (pid == waitpid(pid, 0, 0))
			return;
	}
	perror(argv0);
	_exit(1);
}
#endif /* !defined(TRACEABLE) */

char * xsh(int argc, char ** argv)
{
	char * scrpt;
	int ret, i, j;
	char ** varg;
	char * me = argv[0];

	stte_0();
	 key(pswd, pswd_z);
	arc4(msg1, msg1_z);
	arc4(date, date_z);
	if (date[0] && (atoll(date)<time(NULL)))
		return msg1;
	arc4(shll, shll_z);
	arc4(inlo, inlo_z);
	arc4(xecc, xecc_z);
	arc4(lsto, lsto_z);
	arc4(tst1, tst1_z);
	 key(tst1, tst1_z);
	arc4(chk1, chk1_z);
	if ((chk1_z != tst1_z) || memcmp(tst1, chk1, tst1_z))
		return tst1;
	ret = chkenv(argc);
	arc4(msg2, msg2_z);
	if (ret < 0)
		return msg2;
	varg = (char **)calloc(argc + 10, sizeof(char *));
	if (!varg)
		return 0;
	if (ret) {
		arc4(rlax, rlax_z);
		if (!rlax[0] && key_with_file(shll))
			return shll;
		arc4(opts, opts_z);
		arc4(text, text_z);
		arc4(tst2, tst2_z);
		 key(tst2, tst2_z);
		arc4(chk2, chk2_z);
		if ((chk2_z != tst2_z) || memcmp(tst2, chk2, tst2_z))
			return tst2;
		/* Prepend hide_z spaces to script text to hide it. */
		scrpt = malloc(hide_z + text_z);
		if (!scrpt)
			return 0;
		memset(scrpt, (int) ' ', hide_z);
		memcpy(&scrpt[hide_z], text, text_z);
	} else {			/* Reexecute */
		if (*xecc) {
			scrpt = malloc(512);
			if (!scrpt)
				return 0;
			sprintf(scrpt, xecc, me);
		} else {
			scrpt = me;
		}
	}
	j = 0;
	varg[j++] = argv[0];		/* My own name at execution */
	if (ret && *opts)
		varg[j++] = opts;	/* Options on 1st line of code */
	if (*inlo)
		varg[j++] = inlo;	/* Option introducing inline code */
	varg[j++] = scrpt;		/* The script itself */
	if (*lsto)
		varg[j++] = lsto;	/* Option meaning last option */
	i = (ret > 1) ? ret : 0;	/* Args numbering correction */
	while (i < argc)
		varg[j++] = argv[i++];	/* Main run-time arguments */
	varg[j] = 0;			/* NULL terminated array */
#if DEBUGEXEC
	debugexec(shll, j, varg);
#endif
	execvp(shll, varg);
	return shll;
}

int main(int argc, char ** argv)
{
#if DEBUGEXEC
	debugexec("main", argc, argv);
#endif
#if !defined(TRACEABLE)
	untraceable(argv[0]);
#endif
	argv[1] = xsh(argc, argv);
	fprintf(stderr, "%s%s%s: %s\n", argv[0],
		errno ? ": " : "",
		errno ? strerror(errno) : "",
		argv[1] ? argv[1] : "<null>"
	);
	return 1;
}
