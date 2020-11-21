#include <stdio.h>
#include <limits.h>

void imprimirBits(void *ptr, unsigned size){
  unsigned char *bytes = (unsigned char *) ptr;
  unsigned char bits, b;

  for(int i = size-1; i > -1; i--){
    bits = bytes[i];
    b = 7;
    do{
      printf("%u", (bits>>7)&0x1);
      bits <<= 1;
    }while(b--);
  }
  printf("\n");
}

int main(){
  

  return 0;
}
