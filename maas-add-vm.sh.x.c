#if 0
	shc Version 3.8.9b, Generic Script Compiler
	Copyright (c) 1994-2015 Francisco Rosales <frosal@fi.upm.es>

	shc -f maas-add-vm.sh 
#endif

static  char data [] = 
#define      rlax_z	1
#define      rlax	((&data[0]))
	"\154"
#define      msg1_z	42
#define      msg1	((&data[10]))
	"\327\155\273\322\011\051\154\067\122\006\050\005\002\330\346\341"
	"\043\244\324\201\020\174\267\311\300\050\014\026\370\312\222\215"
	"\103\206\155\312\173\335\021\003\222\126\012\227\020\110\215\126"
	"\244\156\170\311\215\100\104\143\335"
#define      msg2_z	19
#define      msg2	((&data[60]))
	"\153\073\016\371\135\222\161\105\103\256\147\233\277\211\071\344"
	"\061\115\072\155\101\244\162\272"
#define      tst2_z	19
#define      tst2	((&data[86]))
	"\253\077\205\203\230\205\270\023\223\225\312\351\042\111\026\254"
	"\351\375\334\322\313\154\237\324\134"
#define      chk2_z	19
#define      chk2	((&data[109]))
	"\372\271\253\176\101\377\271\257\257\201\375\076\224\273\375\353"
	"\146\035\241\067\125"
#define      opts_z	1
#define      opts	((&data[128]))
	"\136"
#define      xecc_z	15
#define      xecc	((&data[131]))
	"\251\043\157\324\201\234\356\320\133\035\224\034\250\327\130\337"
	"\174\052"
#define      inlo_z	3
#define      inlo	((&data[147]))
	"\264\271\160"
#define      text_z	1904
#define      text	((&data[597]))
	"\053\252\143\024\033\017\123\240\222\050\375\203\267\054\176\161"
	"\307\260\174\055\157\311\327\222\363\044\107\322\335\070\125\011"
	"\342\271\035\375\311\161\236\134\231\233\340\121\310\136\302\217"
	"\017\077\275\177\011\224\022\375\270\132\317\226\222\045\240\164"
	"\337\276\162\250\057\021\005\311\255\345\033\165\104\336\005\123"
	"\036\302\323\047\127\345\044\017\077\364\246\322\031\107\106\371"
	"\005\271\242\064\313\247\376\170\215\032\356\321\370\363\045\027"
	"\266\371\076\015\336\142\035\036\127\304\360\160\013\067\151\020"
	"\361\013\105\274\263\104\065\100\136\043\022\127\027\070\156\316"
	"\061\255\334\020\017\371\056\146\276\037\327\311\126\101\332\107"
	"\115\037\003\001\143\071\101\302\134\124\031\163\214\210\102\276"
	"\065\036\316\105\030\374\254\326\034\204\240\162\305\172\272\023"
	"\232\276\024\375\367\126\300\123\252\332\307\067\142\011\365\230"
	"\050\303\335\100\300\211\026\334\015\266\117\323\061\011\347\313"
	"\307\373\311\277\122\211\022\374\143\332\064\306\344\052\136\014"
	"\356\073\114\256\305\143\213\323\031\333\247\113\345\216\026\254"
	"\212\340\153\334\151\176\331\315\131\015\224\075\067\362\111\045"
	"\056\225\324\364\370\140\310\022\073\157\136\041\376\164\315\210"
	"\124\071\145\276\270\076\214\021\114\040\116\204\023\230\252\102"
	"\055\177\067\046\337\377\071\033\157\227\074\155\014\012\366\140"
	"\104\133\037\375\232\253\017\347\314\136\153\340\366\026\042\044"
	"\225\132\112\165\131\204\221\311\033\316\067\047\331\055\210\036"
	"\211\250\033\044\124\053\013\040\211\167\000\177\215\043\243\043"
	"\175\356\230\327\162\052\240\216\371\327\266\322\005\077\361\216"
	"\347\014\262\073\070\276\134\301\065\134\100\302\177\344\346\375"
	"\322\176\324\105\251\165\324\242\115\213\165\122\312\146\341\262"
	"\163\224\356\253\122\112\154\207\247\255\112\047\221\060\044\144"
	"\257\371\252\131\156\177\373\273\012\160\016\324\327\357\206\113"
	"\260\067\347\363\345\050\365\015\157\203\176\077\300\023\276\124"
	"\351\321\007\031\272\117\114\310\030\332\335\375\275\377\322\164"
	"\033\067\377\147\265\163\010\314\174\177\271\031\126\110\043\247"
	"\065\361\165\202\116\125\021\240\226\203\046\012\116\150\337\267"
	"\352\376\317\017\040\106\117\016\202\300\243\156\320\065\275\122"
	"\255\076\317\073\221\201\171\254\236\201\223\150\107\365\365\337"
	"\043\176\223\306\145\040\056\312\161\207\137\176\325\341\045\171"
	"\170\144\262\052\004\153\076\016\001\340\107\267\062\235\247\201"
	"\316\150\237\336\263\122\374\242\301\324\350\106\204\062\303\316"
	"\230\375\244\113\307\310\167\041\137\146\325\100\002\253\156\261"
	"\032\272\276\075\173\205\204\266\262\006\217\012\312\144\221\116"
	"\226\244\005\220\074\300\016\024\175\032\201\311\011\011\360\177"
	"\227\177\165\232\203\170\024\050\161\310\355\255\217\031\263\066"
	"\355\160\314\115\050\327\102\267\035\147\302\330\271\250\331\272"
	"\167\137\165\107\365\334\263\150\373\215\034\170\056\151\073\323"
	"\124\302\277\047\353\365\343\015\236\136\313\243\232\011\274\335"
	"\047\022\075\013\167\062\012\135\204\010\372\153\134\141\146\163"
	"\145\005\152\357\305\234\215\051\003\202\124\122\260\026\240\330"
	"\302\235\027\124\174\055\321\255\116\211\123\253\347\041\075\355"
	"\256\346\020\221\136\031\165\151\333\232\165\131\364\357\155\343"
	"\126\347\016\141\373\200\121\302\000\221\053\325\322\100\132\356"
	"\107\204\036\074\130\230\103\000\304\102\255\232\272\222\242\170"
	"\331\055\136\071\356\246\003\272\363\053\241\075\355\262\350\316"
	"\166\344\073\264\123\234\273\067\054\257\205\035\346\343\106\050"
	"\217\225\176\112\271\234\060\045\063\266\224\372\122\336\244\364"
	"\272\004\306\065\241\031\361\163\054\173\131\036\007\366\057\051"
	"\370\042\116\121\330\014\150\376\373\117\340\327\333\032\041\003"
	"\320\203\260\172\060\377\326\367\336\111\243\257\041\052\207\214"
	"\341\046\342\324\247\140\173\135\243\331\131\240\033\334\010\311"
	"\134\142\117\061\035\244\032\230\056\373\114\041\236\250\046\212"
	"\165\071\043\261\046\222\222\212\263\347\027\325\356\217\000\301"
	"\354\345\205\111\367\277\216\361\010\165\152\122\370\061\055\113"
	"\260\077\022\101\210\202\160\214\172\347\160\072\100\313\060\246"
	"\202\012\276\355\163\312\064\205\360\364\006\314\277\017\302\127"
	"\076\103\076\175\230\150\372\040\373\043\235\177\143\252\065\022"
	"\013\321\132\164\371\364\347\242\131\032\022\144\271\105\211\211"
	"\164\000\373\233\060\135\075\265\324\025\274\034\244\170\333\334"
	"\346\004\122\011\300\200\300\233\003\256\137\301\231\072\314\251"
	"\312\376\163\150\374\060\231\071\276\160\073\104\370\333\075\166"
	"\254\165\120\352\311\351\147\226\110\066\054\056\200\200\244\062"
	"\314\055\360\167\117\033\000\220\333\153\225\203\310\112\070\322"
	"\001\175\174\027\221\206\354\242\273\347\265\355\214\130\177\200"
	"\301\355\133\121\251\373\045\004\246\250\377\372\322\344\374\362"
	"\041\071\314\153\155\331\017\155\353\046\160\226\102\141\111\203"
	"\134\001\260\226\366\010\346\133\235\142\102\356\031\370\075\226"
	"\105\323\042\241\143\005\004\367\315\257\302\220\250\104\072\243"
	"\303\067\334\374\057\113\333\307\277\101\044\171\053\267\040\223"
	"\074\133\243\242\171\235\322\055\150\333\153\030\312\061\011\133"
	"\036\366\357\026\263\345\037\251\103\144\037\322\072\171\237\247"
	"\275\000\230\373\053\136\075\260\110\001\214\232\350\374\025\246"
	"\210\041\377\327\332\306\265\107\305\374\251\235\217\305\164\324"
	"\154\114\363\017\006\307\156\201\065\036\225\041\142\064\213\064"
	"\237\036\234\034\347\164\361\265\043\270\151\171\136\250\035\311"
	"\073\367\376\106\300\066\035\000\272\337\332\250\315\043\356\010"
	"\302\250\050\220\232\026\111\277\321\006\162\172\107\027\352\255"
	"\070\342\250\325\253\202\337\267\266\044\011\004\055\143\304\257"
	"\310\275\111\047\377\337\267\027\100\121\322\300\353\244\361\361"
	"\051\067\136\024\207\017\333\323\234\236\345\325\021\162\162\266"
	"\131\031\144\040\154\006\316\267\012\077\233\001\273\365\151\203"
	"\143\135\073\363\143\034\334\262\261\264\376\362\055\135\256\252"
	"\376\221\123\126\206\370\226\145\041\332\105\162\237\303\221\124"
	"\050\241\336\163\252\101\327\007\112\020\075\344\241\040\023\232"
	"\152\273\211\231\202\342\330\130\057\240\125\156\270\242\023\301"
	"\377\260\330\326\112\154\162\037\075\041\015\145\171\070\167\331"
	"\042\053\315\160\350\004\312\315\337\262\105\171\077\374\012\174"
	"\062\150\331\120\374\030\166\306\062\114\007\130\306\331\131\040"
	"\247\275\303\374\220\043\235\112\224\206\374\124\010\173\253\107"
	"\244\003\002\327\214\077\214\011\154\070\072\234\140\117\007\075"
	"\021\376\244\377\342\326\352\131\172\276\230\201\217\031\202\222"
	"\377\252\241\263\241\356\246\000\045\271\160\210\042\244\213\015"
	"\352\374\237\311\321\306\063\022\245\055\140\155\161\370\013\064"
	"\301\071\124\336\021\023\222\140\360\166\106\076\042\207\340\272"
	"\201\073\106\372\057\210\264\073\221\070\364\167\145\064\161\151"
	"\230\241\225\142\234\213\067\011\372\200\030\202\175\353\235\264"
	"\357\377\325\000\274\224\346\220\042\035\345\216\313\052\001\057"
	"\303\206\245\374\114\173\350\051\131\356\117\217\135\144\106\221"
	"\144\250\127\356\353\357\041\114\136\067\350\156\371\332\356\305"
	"\231\371\105\126\341\272\031\303\220\136\120\012\164\063\103\156"
	"\323\323\314\124\241\054\135\053\222\042\264\011\120\247\100\057"
	"\376\367\137\223\300\002\004\076\270\215\226\013\325\271\256\001"
	"\065\263\027\325\355\320\306\150\306\225\264\040\313\151\037\150"
	"\370\127\304\364\250\233\133\362\060\121\123\134\267\140\100\220"
	"\316\303\364\153\223\142\015\344\037\011\371\164\020\272\224\266"
	"\150\300\372\124\033\300\314\175\144\232\047\045\120\237\173\334"
	"\366\223\117\351\106\145\201\260\112\300\015\311\061\206\365\067"
	"\333\265\223\357\153\241\226\020\226\243\076\134\305\230\107\350"
	"\010\057\240\315\364\161\106\007\174\302\364\031\061\236\050\364"
	"\263\116\232\256\243\333\023\045\047\357\140\162\164\107\233\153"
	"\076\326\051\266\211\307\065\103\334\034\023\226\076\154\275\325"
	"\271\375\200\355\227\006\343\365\347\241\352\366\011\103\070\305"
	"\237\324\173\233\117\214\236\362\327\255\262\151\062\226\064\224"
	"\362\231\273\153\063\061\236\326\115\230\234\356\340\107\251\236"
	"\151\057\103\352\144\246\133\113\065\172\143\074\021\037\022\330"
	"\230\230\161\144\012\210\065\214\175\212\246\235\133\010\203\225"
	"\336\365\234\027\270\330\263\227\011\217\242\270\147\012\101\016"
	"\375\254\173\330\217\155\132\225\102\363\017\356\126\204\105\231"
	"\014\322\051\276\124\236\166\137\106\145\021\030\103\034\332\037"
	"\126\131\013\265\176\250\274\054\344\017\356\070\067\027\250\277"
	"\111\271\371\140\355\214\306\023\040\353\366\120\173\326\242\141"
	"\075\254\361\237\301\264\241\217\155\245\232\106\205\253\040\001"
	"\117\226\136\021\132\114\252\073\165\371\114\300\371\133\162\272"
	"\237\207\077\340\121\066\215\163\073\024\316\162\031\022\211\014"
	"\034\213\012\040\054\101\041\176\023\315\216\243\174\367\236\266"
	"\032\160\223\244\044\344\370\343\320\176\130\005\236\211\335\361"
	"\230\121\040\200\356\147\373\056\114\105\124\360\320\322\146\007"
	"\127\164\313\254\376\327\354\031\076\326\260\006\311\214\324\302"
	"\352\355\120\231\357\224\226\033\134\251\324\004\133\034\260\013"
	"\274\202\315\164\203\302\100\372\136\334\150\063\205\060\263\106"
	"\112\352\102\010\357\355\064\342\311\365\322\051\342\204\302\313"
	"\056\022\247\353\202\136\021\055\240\230\164\011\043\130\366\274"
	"\203\114\356\061\037\313\224\136\220\277\301\013\032\343\150\141"
	"\234\331\231\001\061\065\315\260\173\157\022\077\005\326\205\123"
	"\024\111\143\307\312\126\346\261\122\267\132\353\004\150\255\226"
	"\172\166\300\314\101\310\247\214\047\003\031\333\270\175\356\244"
	"\250\046\015\362\252\172\024\124\375\063\345\106\354\033\141\372"
	"\012\163\232\077\254\343\173\363\312\072\164\105\315\225\110\043"
	"\301\272\202\324\174\045\313\165\001\304\366\210\116\233\146\155"
	"\153\045\022\321\127\207\042\266\201\313\244\056\131\224\010\001"
	"\354\221\230\116\313\255\315\336\225\076\111\027\140\140\123\112"
	"\204\165\365\326\277\142\136\146\017\251\215\241\332\262\006\212"
	"\253\261\343\032\060\336\326\072\117\344\016\046\324\225\161\130"
	"\012\147\057\312\311\216\061\331\067\277\173\022\161\201\234\035"
	"\062\177\067\142\136\015\235\255\362\253\324\306\101\106\036\114"
	"\255\116\026\166\334\107\120\024\006\313\046\170\115\302\225\200"
	"\101\315\342\237\333\177\115\315\053\042\223\154\150\262\271\025"
	"\000\317\214\335\026\334\361\035\250\027\225\365\332\052\165\033"
	"\370\130\273\323\330\011\240\004\053\064\161\224\346\052\251\347"
	"\371\066\304\020\022\265\055\273\315\303\261\247\356\046\303\346"
	"\177\177\271\127\211\131\133\264\215\314\111\164\367\362\133\360"
	"\050\040\001\073\326\057\367\243\362\250\113\340\316\017\306\116"
	"\216\177\245\027\331\001\314\146\316\025\333\305\010\066\266\061"
	"\126\267\154\054\346\143\320\331\014\033\271\332\053\177\050\271"
	"\377\316\321\330\320\236\077\237\263\032\145\274\121\033\355\250"
	"\323\132\325\272\276\245\223\312\301\115\245\354\314\316\246\314"
	"\235\170\245"
#define      lsto_z	1
#define      lsto	((&data[2745]))
	"\063"
#define      pswd_z	256
#define      pswd	((&data[2797]))
	"\162\206\121\215\164\371\141\316\316\033\215\164\257\130\066\374"
	"\375\043\311\314\311\226\151\101\073\327\127\040\344\042\040\126"
	"\250\161\344\035\152\105\354\071\141\171\256\020\322\344\015\317"
	"\007\327\234\303\300\374\207\243\045\073\175\301\042\355\223\051"
	"\217\150\113\207\353\064\345\324\123\316\336\100\100\313\031\152"
	"\107\325\056\007\322\265\252\367\360\047\271\023\025\114\075\244"
	"\265\210\054\240\274\021\165\020\340\123\120\040\037\152\213\146"
	"\100\271\155\022\156\030\012\137\100\303\162\125\020\257\372\305"
	"\070\047\146\365\071\334\005\031\060\126\072\117\300\305\265\000"
	"\176\043\023\355\074\035\114\174\341\276\322\362\156\315\267\246"
	"\364\036\234\055\373\242\106\053\370\200\173\271\106\061\272\304"
	"\124\316\262\221\354\376\015\315\274\340\277\053\255\167\322\242"
	"\226\156\317\221\020\026\275\011\227\070\303\335\151\175\242\276"
	"\114\124\117\070\122\135\005\017\076\305\072\353\075\014\215\324"
	"\173\135\145\214\163\043\225\012\134\131\350\305\327\213\204\043"
	"\337\324\133\062\062\141\102\160\046\175\134\144\212\351\070\005"
	"\107\236\221\272\302\047\305\036\200\256\344\127\071\151\172\031"
	"\075\326\114\160\067\216\340\135\014\075\302\226\047\373\234\156"
	"\232\055\050\134\125\356\172\326\234\137\056\326\310\251\360\006"
	"\177\074\166\321\155\005\023\250\334\153\311\300\215\351\026\065"
	"\132\372\122\305\100\076\377\241\270\255\262\212\221\300\132\231"
	"\227\366\152\004\374\175\255\330\350\166\231\165\137\260\253\272"
	"\253\376\200\353\075\177\215\366\054\077\201\276\377\333\127\226"
	"\322\302\233"
#define      date_z	1
#define      date	((&data[3117]))
	"\362"
#define      shll_z	10
#define      shll	((&data[3118]))
	"\344\165\344\055\005\071\260\073\076\002\100\236"
#define      tst1_z	22
#define      tst1	((&data[3135]))
	"\330\233\111\130\207\301\312\141\047\054\140\124\040\031\272\360"
	"\131\115\133\065\135\013\277\360\336\334\033\206"
#define      chk1_z	22
#define      chk1	((&data[3158]))
	"\035\234\202\331\354\327\023\032\027\240\123\236\030\074\020\022"
	"\311\367\170\260\236\031\004\123"/* End of data[] */;
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