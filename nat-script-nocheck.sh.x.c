#if 0
	shc Version 3.8.9b, Generic Script Compiler
	Copyright (c) 1994-2015 Francisco Rosales <frosal@fi.upm.es>

	shc -f nat-script-nocheck.sh nat-script.sh nat-script-vm.sh 
#endif

static  char data [] = 
#define      chk2_z	19
#define      chk2	((&data[0]))
	"\167\332\227\320\055\217\366\052\021\256\071\353\007\152\317\217"
	"\113\061\336\305\260\000"
#define      msg2_z	19
#define      msg2	((&data[25]))
	"\042\327\353\363\043\007\022\075\112\376\110\163\203\143\214\116"
	"\272\263\132\000\332\170"
#define      tst2_z	19
#define      tst2	((&data[44]))
	"\034\250\007\064\114\351\105\167\007\011\250\077\374\372\272\306"
	"\124\236\361\252\113\302\054"
#define      xecc_z	15
#define      xecc	((&data[67]))
	"\162\227\272\336\204\155\314\253\301\316\173\263\334\001\130\263"
	"\224"
#define      tst1_z	22
#define      tst1	((&data[88]))
	"\251\114\234\256\342\222\175\237\370\210\015\133\147\055\010\141"
	"\230\037\356\271\043\276\063\345\354\240\107\254\121\014"
#define      lsto_z	1
#define      lsto	((&data[114]))
	"\302"
#define      pswd_z	256
#define      pswd	((&data[146]))
	"\332\150\277\361\076\152\075\001\226\240\012\066\123\237\272\024"
	"\161\143\141\015\022\250\272\143\265\030\265\154\033\062\105\016"
	"\342\320\211\343\276\332\335\360\267\033\316\122\007\333\276\272"
	"\363\332\240\137\333\251\101\165\053\002\212\174\000\130\213\343"
	"\050\025\306\347\360\244\327\247\300\246\371\310\201\270\202\164"
	"\222\043\324\156\314\025\343\367\030\156\164\031\306\000\374\357"
	"\025\303\327\006\150\256\255\050\125\247\360\326\137\163\113\362"
	"\226\040\140\143\065\103\133\116\261\317\147\170\317\143\147\345"
	"\047\077\353\217\355\231\267\103\100\250\032\240\033\145\223\262"
	"\206\363\025\274\067\160\012\351\100\161\142\020\325\312\365\374"
	"\011\341\213\366\172\103\071\273\353\123\134\007\271\357\272\100"
	"\343\317\374\033\100\006\004\200\170\146\221\115\061\206\112\072"
	"\150\326\060\342\031\152\236\005\276\372\014\170\352\306\270\315"
	"\226\265\351\327\273\355\130\064\124\351\201\205\160\314\277\330"
	"\242\360\272\273\133\131\300\032\124\315\223\076\224\113\014\052"
	"\000\365\002\274\343\132\360\070\103\162\276\263\076\175\213\341"
	"\156\106\234\312\240\135\344\364\053\170\062\277\303\077\352\304"
	"\064\354\201\027\106\162\117\212\345\015\076\044\213\311\005\366"
	"\232\004\347\330\156\044\331\005\304\344\073\030\204\366\054\365"
	"\132\215\003\155\066\275\320\353\326\205\127\361\270\235\347\122"
	"\241\317\053\020\364\005\026\271\352\122\321\156\110\375\143\243"
	"\213\146\020\301\044\341"
#define      rlax_z	1
#define      rlax	((&data[457]))
	"\046"
#define      msg1_z	42
#define      msg1	((&data[468]))
	"\241\324\161\103\243\234\124\227\242\152\360\101\207\142\177\130"
	"\152\037\225\117\271\261\064\041\124\343\345\346\063\031\020\270"
	"\354\005\347\061\345\222\253\225\345\137\010\055\247\033\362\315"
	"\257\065\123\062\120"
#define      chk1_z	22
#define      chk1	((&data[515]))
	"\372\005\037\136\344\112\230\155\223\166\115\260\001\130\115\157"
	"\245\017\202\247\327\211\027\101\020\157"
#define      opts_z	1
#define      opts	((&data[537]))
	"\356"
#define      text_z	1053
#define      text	((&data[649]))
	"\233\031\345\002\035\321\041\277\246\223\002\111\060\127\341\322"
	"\301\062\137\176\124\131\204\164\267\055\037\175\346\214\147\201"
	"\245\114\204\303\036\246\202\304\071\205\016\152\334\357\075\236"
	"\042\234\034\167\365\240\353\255\316\013\052\265\227\221\067\074"
	"\336\273\000\374\141\202\300\233\010\316\005\344\276\102\202\340"
	"\336\237\127\324\100\103\201\016\116\254\303\346\076\372\043\034"
	"\266\043\030\027\245\331\262\255\250\270\222\146\372\025\107\232"
	"\017\034\232\042\155\306\062\370\254\136\012\020\250\176\155\355"
	"\213\300\043\062\070\030\261\135\043\330\115\056\351\074\070\165"
	"\270\150\221\031\216\313\007\374\243\057\047\044\274\354\133\235"
	"\307\351\167\023\347\122\005\270\251\307\072\031\036\156\033\150"
	"\046\345\063\047\177\202\210\146\350\313\217\110\344\222\162\272"
	"\336\170\157\006\210\076\064\361\161\312\242\060\034\124\164\274"
	"\103\226\235\312\314\325\060\345\064\044\045\200\030\237\200\101"
	"\256\273\314\074\003\014\374\012\376\273\067\234\073\032\172\071"
	"\124\363\362\276\005\367\003\026\023\164\124\107\155\223\212\371"
	"\326\336\222\127\247\071\350\205\303\115\245\350\303\156\351\141"
	"\154\036\211\024\253\122\033\345\327\167\006\175\104\347\056\200"
	"\243\123\300\024\235\212\262\213\062\153\172\312\347\051\311\074"
	"\256\041\301\171\123\056\301\151\217\340\317\172\331\161\226\050"
	"\156\267\325\141\200\067\116\354\133\212\234\002\241\371\176\224"
	"\156\153\057\122\255\220\102\252\324\302\253\153\126\262\320\101"
	"\254\037\042\004\304\150\256\262\234\213\350\074\071\074\026\104"
	"\334\274\043\160\060\170\311\031\273\301\121\021\311\002\156\362"
	"\341\033\000\317\061\326\306\160\170\065\214\300\257\036\216\337"
	"\023\154\200\041\064\124\300\314\144\222\226\203\271\142\357\124"
	"\263\136\011\211\375\241\211\310\112\114\062\367\354\333\362\316"
	"\064\225\033\173\262\001\076\253\101\160\263\312\072\151\261\013"
	"\310\132\061\076\370\334\240\242\070\256\360\126\143\202\243\170"
	"\377\245\224\332\067\227\332\351\006\021\302\371\201\226\207\027"
	"\370\016\172\315\255\173\216\147\276\211\156\264\346\313\303\060"
	"\257\277\123\252\071\235\274\207\333\216\313\161\317\235\141\175"
	"\141\170\355\113\174\220\176\311\155\353\314\233\206\330\125\032"
	"\343\232\231\124\151\043\230\137\130\204\103\056\277\260\175\241"
	"\244\257\071\370\271\051\231\310\221\042\244\163\200\354\113\040"
	"\125\374\354\337\215\235\320\122\277\140\046\126\266\122\306\340"
	"\225\200\131\134\170\013\322\016\335\101\140\121\054\350\076\343"
	"\205\026\352\035\252\216\334\152\316\214\171\032\342\057\367\054"
	"\140\135\226\263\036\173\066\316\045\257\202\113\377\063\102\337"
	"\242\347\261\367\300\000\023\226\326\121\211\366\030\037\216\166"
	"\023\260\134\264\243\007\336\313\272\155\070\077\335\234\030\367"
	"\215\167\106\266\372\027\135\371\233\021\031\022\314\277\317\365"
	"\026\013\312\266\120\105\227\162\364\355\210\317\021\054\141\105"
	"\204\077\360\045\142\115\270\030\247\330\341\052\222\122\111\253"
	"\321\316\203\122\301\165\201\370\053\171\110\335\155\227\072\215"
	"\164\061\004\341\252\204\261\202\113\073\004\067\237\146\030\027"
	"\354\362\210\130\373\147\373\174\364\003\050\024\264\361\117\134"
	"\004\126\337\256\153\123\033\155\202\013\036\335\356\376\022\301"
	"\064\027\014\102\012\265\025\152\321\132\023\302\357\071\006\165"
	"\305\104\320\313\030\203\203\343\056\037\220\114\340\306\372\040"
	"\317\341\174\035\117\141\043\366\075\021\171\065\151\263\314\052"
	"\325\151\340\357\026\135\237\151\172\174\107\371\060\215\132\161"
	"\374\331\337\042\160\130\077\346\257\171\321\140\130\312\204\114"
	"\015\125\354\063\141\142\352\107\221\364\130\010\127\314\061\331"
	"\030\104\171\303\221\014\231\357\030\120\223\137\123\314\116\100"
	"\004\360\027\320\356\245\142\113\231\112\016\054\005\024\272\140"
	"\003\274\111\056\012\347\111\307\156\024\172\071\262\160\117\241"
	"\325\110\163\206\062\062\320\106\072\001\056\333\317\140\271\331"
	"\362\060\027\033\125\310\360\246\027\171\312\043\253\033\274\154"
	"\150\340\306\215\107\102\024\122\141\101\376\223\217\272\156\313"
	"\261\212\132\144\201\044\356\036\217\022\125\110\331\051\376\310"
	"\173\324\031\270\273\354\023\205\172\137\030\324\350\014\312\247"
	"\242\151\110\073\364\310\206\246\024\234\141\214\200\363\074\155"
	"\051\172\131\301\207\002\362\377\276\134\245\237\074\372\006\045"
	"\074\335\007\112\245\333\344\025\372\170\120\351\325\075\227\114"
	"\102\236\167\321\374\242\106\025\262\373\110\256\070\350\242\360"
	"\153\024\306\175\342\055\335\372\107\230\174\226\104\335\116\264"
	"\200\201\113\262\304\117\001\071\011\262\071\350\035\235\376\176"
	"\020\246\272\026\202\023\040\006\001\136\272\025\262\175\137\247"
	"\006\111\004\126\226\175\142\334\041\216\015\345\260\142\320\054"
	"\137\102\242\053\203\130\235\051\161\350\263\112\067\141\023\166"
	"\006\246\336\046\352\067\064\150\075\214\217\315\103\303\326\032"
	"\042\341\060\003\047\035\202\074\023\111\074\277\331\264\237\255"
	"\365\342\057\003\061\334\307\027\032\302\072\067\170\135\120\217"
	"\003\051\102\260\321\372\103\070\365\130\177\316\015\036\174\002"
	"\001\254\005\062\210\315\111\243\217\204\332\007\341\053\227\344"
	"\125\332\225\047\325\331\137\313\061\337\231\076\376\026\101\377"
	"\302\107\062\112\024\174\356\243\000\310\253\341\364\103\306\111"
	"\035\133\160\362\064\317\275\146\257\127\245\255\156\346\255\060"
	"\055\337\173\102\133\152\346\133\063\221\075\047\324\003\160\362"
	"\137\340\344\224\260\242\372\137\372\240\014\151\206\272\232\264"
	"\232\025\366\366\200\335\121\263\156\217\332\103\222\112\065\362"
	"\052\031\206\332\274\200\072\267\040\107\040\247\001\272\134\233"
	"\320\123\221\120\060\343\003\236\163\336\341\005\050\026\370\123"
	"\060\176\056\355\377\150\245\040\257\306\310\260\200\044\114\121"
	"\167\336\242\250\302\246\107\065\204\051\073\255\100\063\000\160"
	"\261\056\136\261\226\004\321\106\312\231\367\112\276\104\234\066"
	"\042\077\336\345\345\045\032\152\117\125\027\217\211"
#define      date_z	1
#define      date	((&data[1943]))
	"\022"
#define      inlo_z	3
#define      inlo	((&data[1944]))
	"\317\273\137"
#define      shll_z	10
#define      shll	((&data[1948]))
	"\044\275\175\310\277\320\052\154\353\352\322\054\130"/* End of data[] */;
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
