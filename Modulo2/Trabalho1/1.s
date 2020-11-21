		;		Considerei	que o endereço do vetor esta em R0 e A QUANTIDADE DE ELEMENTOS em R1
		
TESTE ;NAO eh uma MAIN. Apenas inicializa os parametros da funcao para testar o codigo
ARRAY	DCD		1, 9, 1, 2, 6, 7, 7, 8, 2, 6, 9
		LDR		R0, =ARRAY ;endereco do vetor
		MOV		R1, #11 ;Quantidade de elementos
		BL		QUESTAO1
		END
		
QUESTAO1 ; int	 semRep(int *v, int n)
		STMFD	SP!, {R4, R5, R6}
		LSL		R1, R1, #2 ;multiplica a quantidade de elementos por 4 para facilitar na implementacao
		MOV		R4, #0 ;
		MOV		R3, #0 ;
		
WHILEEXT ;para ao encontrar um numero com uma unica ocorrencia
		CMP		R3, #1
		BEQ		DONE
		
		LDR		R2, [R0, R4]
		ADD		R4, R4, #4
		MOV		R3, #0
		MOV		R5, #0
		
WHILEINT ;soma a quantidade de ocorrencias de cada numero
		CMP		R5, R1
		BHS		WHILEEXT ;se i >= n
		
		CMP		R3, #2
		BHS		WHILEEXT ;se houverem duas ocorrencias do msm elemento
		
		LDR		R6, [R0, R5]
		CMP		R6, R2
		ADDEQ	R3, R3, #1
		
		ADD		R5, R5, #4
		B		WHILEINT
		
DONE ;retorna o numero com um unica ocorrencia
		MOV		R0, R2
		LDMFD	SP!, {R4, R5, R6}
		MOV		PC, LR
