#include <stdio.h>
#include <stdint.h>

//Q24.8
#define FIXEDPT_BITS 32
#define FIXEDPT_WBITS 24 //parte inteira
#define FIXEDPT_FBITS (FIXEDPT_BITS - FIXEDPT_WBITS)

#define FIXEDPT_FMASK (((int32_t)1 << FIXEDPT_FBITS)-1)//max da parte fracionaria

#define FIXEDPT_ONE ((int32_t)(int32_t)1 << FIXEDPT_FBITS)

#define fixedpt_rconst(R) ((int32_t)(R*FIXEDPT_ONE))

#define fixedpt_fromint(I) ((int32_t)(I) << FIXEDPT_FBITS)
#define fixedpt_toint(F) ((F) >> FIXEDPT_FBITS)
#define fixedpt_tofloat(T) (float)((T)* ((float)1/(float)(1 << FIXEDPT_FBITS)))
#define fixedpt_fractofloat(L) (float)(L&FIXEDPT_FMASK) / (float)(1 << FIXEDPT_FBITS) 

#define fixedpt_add(A,B) (A+B)
#define fixedpt_sub(A,B) (A-B)
#define fixedpt_mult(A,B) ((int32_t)((int64_t)A * (int64_t)B >> FIXEDPT_FBITS))
#define fixedpt_div(A,B) ((int32_t)(((int64_t)A << FIXEDPT_FBITS) / (int64_t)B))

void fixedpt_print(int32_t A){
    printf("%d.%ld\n", (A >> FIXEDPT_FBITS), (long)((A & FIXEDPT_FMASK)*10000) / (1<<FIXEDPT_FBITS));
}

void main(void){
    int32_t a, b, c;

    printf("Max (fixedpt): ");
    fixedpt_print(0x7FFFFF00);

    printf("Min (fixedpt): ");
    float min = fixedpt_fractofloat(0x00000001);
    printf("%f\n", min);

    a = fixedpt_rconst(2.5);
    b = fixedpt_fromint(3);

    fixedpt_print(a);
    fixedpt_print(b);

    c = fixedpt_add(a,b);
    fixedpt_print(c);

    c = fixedpt_sub(b,a);
    fixedpt_print(c);

    c = fixedpt_mult(b,a);
    fixedpt_print(c);

    c = fixedpt_div(b,a);
    fixedpt_print(c);
}