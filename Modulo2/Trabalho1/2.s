		;Considerei	que a funçao recebe como parametro um endeco de memoria, contendo 40 bytes, em R0
		;Essa funçao coloca os 10 primeiros elementos da sequencia de fibinacci em R0
		
TESTE ;NAO eh uma MAIN. Apenas inicializa os parametros da funcao para testar o codigo
		MOV		R0, #0X100 ;vetor com 10 elementos
		BL		QUESTAO2
		END
		
QUESTAO2
		STMFD	SP!, {R4}
		MOV		R1, #0
		MOV		R2, #1
		STR		R1, [R0]
		STR		R2, [R0, #4]
		
		MOV		R4, #8
WHILE
		CMP		R4, #40
		BHS		DONE
		
		ADD		R3, R1, R2
		STR		R3, [R0, R4]
		MOV		R1, R2
		MOV		R2, R3
		ADD		R4, R4, #4
		B		WHILE
		
DONE
		LDMFD	SP!, {R4}
		MOV		PC, LR
