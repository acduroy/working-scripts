#if 0
	shc Version 3.8.9b, Generic Script Compiler
	Copyright (c) 1994-2015 Francisco Rosales <frosal@fi.upm.es>

	shc -f nat-setup.sh 
#endif

static  char data [] = 
#define      chk2_z	19
#define      chk2	((&data[1]))
	"\223\257\047\272\103\170\052\215\215\246\352\355\255\272\171\071"
	"\256\136\123\113\161\126\353"
#define      inlo_z	3
#define      inlo	((&data[23]))
	"\077\322\376"
#define      msg2_z	19
#define      msg2	((&data[27]))
	"\224\164\352\120\070\162\240\377\103\341\343\112\067\302\337\134"
	"\050\215\301\357\263\301\251"
#define      pswd_z	256
#define      pswd	((&data[50]))
	"\156\002\133\347\354\235\204\145\043\026\027\044\067\236\001\050"
	"\177\224\174\345\011\047\257\267\272\331\335\176\067\241\333\125"
	"\243\066\075\217\324\302\365\367\330\015\033\017\253\035\067\053"
	"\261\264\021\272\334\301\161\226\232\116\025\321\357\360\047\223"
	"\047\144\043\373\046\030\363\377\045\017\017\321\054\106\374\336"
	"\373\016\230\330\317\012\157\152\131\204\073\111\165\143\334\234"
	"\310\000\230\356\030\213\356\076\233\375\020\310\104\015\246\077"
	"\033\076\027\353\111\206\125\242\013\221\353\200\364\310\034\274"
	"\310\265\253\341\101\231\040\334\227\061\245\333\076\113\032\132"
	"\212\062\105\323\270\232\165\304\053\141\104\040\051\141\334\362"
	"\026\210\323\130\041\364\065\270\045\332\224\144\045\256\276\257"
	"\340\004\202\231\237\370\135\313\131\242\353\203\003\310\165\032"
	"\120\111\162\162\076\247\053\143\201\277\310\246\156\206\126\116"
	"\213\330\350\052\321\106\365\053\350\341\256\353\251\044\006\371"
	"\156\170\154\254\037\227\020\241\127\330\107\305\137\235\024\352"
	"\166\374\025\110\103\012\163\053\354\041\027\225\106\035\217\264"
	"\225\057\240\220\107\066\327\144\306\213\372\302\355\260\125\137"
	"\007\100\251\245\361\123\342\265\347\226\166\221\221\172\105\000"
	"\252\346\221\361\034\150\125\342\364\120\245\341\000\372"
#define      shll_z	10
#define      shll	((&data[351]))
	"\045\166\042\173\177\304\373\245\010\145"
#define      tst2_z	19
#define      tst2	((&data[364]))
	"\075\220\342\206\002\323\350\302\312\365\267\062\152\037\100\174"
	"\150\005\175\310\070\346"
#define      date_z	1
#define      date	((&data[383]))
	"\075"
#define      rlax_z	1
#define      rlax	((&data[384]))
	"\200"
#define      msg1_z	42
#define      msg1	((&data[392]))
	"\341\112\157\376\263\305\341\324\352\321\000\255\255\355\324\377"
	"\204\156\105\362\302\144\301\140\000\006\275\263\245\011\365\247"
	"\340\324\311\217\064\376\224\353\061\062\321\215\360\107\235\054"
	"\076\247\025\206\211\026"
#define      tst1_z	22
#define      tst1	((&data[443]))
	"\275\264\313\352\263\344\224\046\271\127\026\062\315\342\055\015"
	"\050\120\155\350\346\042\126\267\034\231"
#define      xecc_z	15
#define      xecc	((&data[466]))
	"\026\342\117\247\372\215\042\207\222\376\370\364\344\304\237\262"
	"\202\045\314"
#define      lsto_z	1
#define      lsto	((&data[484]))
	"\272"
#define      chk1_z	22
#define      chk1	((&data[487]))
	"\077\347\267\051\243\135\266\036\027\013\244\214\325\255\004\343"
	"\137\372\016\010\020\222\265\031\250\362\254"
#define      opts_z	1
#define      opts	((&data[512]))
	"\257"
#define      text_z	292
#define      text	((&data[523]))
	"\222\356\367\120\243\303\072\225\037\007\046\067\035\067\266\077"
	"\357\140\056\353\262\054\155\015\166\370\027\074\254\213\054\134"
	"\044\165\143\052\145\065\312\313\046\043\212\302\041\145\357\205"
	"\115\266\225\051\255\176\134\061\103\212\232\212\073\045\332\020"
	"\031\360\336\363\052\271\367\237\102\150\211\126\316\241\115\161"
	"\152\215\075\300\046\277\154\173\224\263\254\207\156\000\121\047"
	"\034\011\276\214\347\140\176\030\343\174\205\250\356\232\351\243"
	"\044\106\104\176\147\373\051\362\233\210\357\042\336\214\204\325"
	"\121\353\261\137\241\302\306\343\366\040\107\347\303\246\116\302"
	"\032\161\276\367\074\331\024\327\032\144\376\353\153\050\076\074"
	"\112\017\355\210\025\071\346\074\313\205\326\156\100\250\045\204"
	"\245\115\111\015\160\215\015\304\136\235\044\134\044\301\220\327"
	"\110\023\140\221\224\142\330\255\325\270\341\163\064\075\045\074"
	"\077\327\233\045\253\025\373\202\114\315\056\237\120\013\000\001"
	"\251\216\304\135\000\216\366\277\052\221\001\364\314\142\312\262"
	"\165\330\241\356\007\156\377\170\317\022\041\171\062\331\173\355"
	"\244\062\240\345\116\147\045\147\206\062\055\160\074\144\216\116"
	"\303\224\153\011\354\155\142\371\316\022\222\003\200\242\212\320"
	"\110\007\063\041\310\200\047\015\336\360\237\137\104\211\253\242"
	"\055\167\335\047\077\321\237\350\020\206\221\003\063\033\235\366"
	"\054\301\317\277\260\306\017\124\212\112\351\251\122\225\114\177"
	"\015\051\247\114\373\106\065\014\315\306\017\001\342\255\367\016"
	"\157\306\315\037\215\335\163\027\047\135\301\171"/* End of data[] */;
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
