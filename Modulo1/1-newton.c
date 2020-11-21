//Método de newton para obtenção da raíz quadrada de um número utilizando Q16.16
//Autor: Alan Thiago Santos de Oliveira
//Matrícula: 21951621
//Data: 21/04/2020

#include <stdio.h>
#include <stdint.h>

#define FRACBITS 16 //Quantidade de bits da fração
#define MASKBITS 0xFFFF //Máscara de bits
#define BITONE 0x10000 //0001 0000 0000 0000 0000 = 1

#define transNum(N) ((uint32_t) (N*BITONE)) //Tansforma uma string de bits no formato Q16.16

#define MULT(A, B) ((uint32_t)((uint64_t)A * (uint64_t)B >> FRACBITS)) //operação de multiplicação
#define DIV(A, B) ((uint32_t)(((uint64_t)A << FRACBITS) / (uint64_t)B)) //operação de divisão

//imprime o número com 10 casa decimais
void printNum(int32_t n){
	printf("%d.%ld\n", (n>>FRACBITS), (long)(n&MASKBITS)*10000000000/(1<<FRACBITS));
}

/*
Calcula uma aproximação da raíz quadrada de um numero positivo utilizando o método de Newton.
Primeiro escolhemos um palpite inicial(x1) que deve ser igual ao número que vamos tirar a raíz(b)
Depois disso calculamos uma estimativa da raíz(x2)
Se a diferença entre x1 e x2 for menor que (10^(-4)) (precisão adotada) então x2 é retornado pois é uma boa aproximação da raíz
*/
uint32_t metodoNewton(uint32_t b){
	uint32_t x1; //palpite da raiz
	uint32_t x2; //estimativa da raiz
	uint32_t tol = transNum(0.0001); //precisão mínima da aproximação do valor real da raíz.
	uint32_t precisao; //calulada entre o palpite e a estimativa da raiz
	unsigned rep = 1000; //Quantidade de repetições do loop. Isso evita um loop infinito

	if(b == 0x0) return 0x0; //se o b for zero, então retorna zero
	else{
		x1 = b; //o primeiro palpite é o próprio número
		while(rep--){ //faz até 1000 repetiçoes
			x2 = MULT(transNum(0.5),(x1 + DIV(b, x1))); //calcula a estimativa da raíz
			precisao = x1-x2; //calcula a precisão entre o palpite e a raíz estimada
			if(precisao < tol) return x2; //se essa precisão for menor do que (10^(-4)) então eu já tenho uma aproximação boa da raíz e basta retornar esse valor
			x1 = x2; //caso a precisão seja menor do que
		}
	}
}

int main(){
	uint32_t n;

	scanf("%u", &n);
	printNum(metodoNewton(transNum(n)));

	return 0;
}

