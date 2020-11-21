			;Considerei	que o vetor esta em R0, o pivot em R1 e a quantidade de elementos em R2.
			;Se		a chave estiver no vetor, retorna seu valor. Caso contrario, retorna -1
			
TESTE ;NAO eh uma MAIN. Apenas inicializa os parametros da funcao para testar o codigo
ARRAY		DCD		1,1,2,3,5,9,10,11,31
			LDR		R0, =ARRAY ; *v
			MOV		R1, #11 ; chave
			MOV		R2, #9 ; quantidade de elementos
			BL		QUESTAO3
			END
			
			;		int  buscaBinaria(int *v, int chave, int n)
QUESTAO3
			STMFD	SP!, {R4, R5}
			SUB		R2, R2, #1 ;subtrai 1 da quantidade de elementos para facilitar na implementacao
			MOV		R3, #0 ;esq = 0
			MOV		R4, R2
			LSR		R4, R4, #1
			LSL		R4, R4, #2
			
WHILE ; while(esq <= dir)
			CMP		R3, R2
			BGT		NAOENCONTROU
			
			LDR		R5, [R0, R4]
			CMP		R5, R1
			BLO		MAIOR
			BHI		MENOR
			B		DONE
			
MAIOR
			LSR		R4, R4, #2
			ADD		R3, R4, #1
			ADD		R4, R3, R2
			LSR		R4, R4, #1
			LSL		R4, R4, #2
			B		WHILE
			
MENOR
			LSR		R4, R4, #2
			SUB		R2, R4, #1
			ADD		R4, R3, R2
			LSR		R4, R4, #1
			LSL		R4, R4, #2
			B		WHILE
			
NAOENCONTROU
			MOV		R1, #-1
			
DONE
			MOV		R0, R1
			LDMFD	SP!, {R4, R5}
			MOV		PC, LR
