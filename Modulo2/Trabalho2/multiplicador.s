				;		OBSERVACOES:
				
				;1		As matrizes A, B e C sao passadas como vetores, como na linguagem C
				;2		Em C, o elemento M[i][j] eh dado por M[(i * colunaM + j) * 4]
				;3		A funçao foi implementada usando a aritmetica do item 2
				;4		A funçao recebe como parametro, de R0 a R3, qtd_linhas_A, qtd_colunas_A/qtd_linhas_B, qtd_colunas_B, endereco_C
				;5		A funcao recebe como parametro, na pilha, endereco_A e endereco_B
				;6		A funcao tem como retorno o endereco da matriz C com o produto A * B
				;7		A matriz C DEVE ser passada pela caller
				;8		Mesmo a funçao de multiplicaçao usando de R0-R2, eu optei por nao utilizar R3 para armazenar valores importantes pois assim o codigo pode ser reutilizado
				
MATRIZ_A			DCD		1, 5, 9, 8, 1, 3 ;A2x3
MATRIZ_B			DCD		3, 8, 1, 9, 0 ,2 ;B3x2
MATRIZ_C			DCD		0, 0, 0, 0 ;C2x2
				
TESTE
				MOV		R0, #2 ; linhas da matriz A
				MOV		R1, #3 ; colunas da matriz A / linhas da matriz B
				MOV		R2, #2 ; colunas da matriz B
				LDR		R3, =MATRIZ_C ; endereço da matriz resultante
				LDR		R4, =MATRIZ_A ; endereço da matriz A
				LDR		R5, =MATRIZ_B ; endereço da matriz B
				STMFD	SP!, {R4, R5} ; coloca os endereços das matrizes A e B, na pilha como parametro de funçao
				
				BL		MULT_MATRIX ; retorna o produto A * B na matriz C
				END
				
				;PARAMETROS	DA FUNÇAO
				
				;		R0 = linhas da matriz A
				;		R1 = colunas do A / linhas do B
				;		R2 = colunas do B
				;		R3 = endereço da matriz resultante C
				;		[R13] = endereço da matriz A
				;		[R13, #4] = endereço da matriz B
				
				;VARIAVEIS	LOCAIS QUE SAO ACESSADAS FREQUENTEMENTE
				
				;		R4 = i
				;		R5 = j
				;		R6 = k
				;		R7 = soma
				;		R8 = tmp
				;		R9 = i * colunaA
				
				;		O restante das variaveis eh armazenado na pilha
MULT_MATRIX
				STMFD	SP!, {R0, R1, R2, R3, R4, R5, R6, R7, R8, R9} ; Coloca os parametros da funcao na pilha e os registradores r4-8 que a funçao vai precisar usar
				MOV		R4, #0 ; i = 0
				
				B		WHILE_I
				
MULT_MATRIX_DONE
				LDR		R0, [R13, #12] ; endereço do vetor resultante
				LDMFD	SP!, {R1, R2, R3, R4} ; Desempilha os parametros da funcao que foram colocados na pilha
				LDMFD	SP!, {R4, R5, R6, R7, R8, R9} ; Restaura os valores originais
				LDMFD	SP!, {R1, R2} ; Desempilha os parametros da funcao que foram colocados na pilha pela caller
				
				MOV		PC, LR
				
WHILE_I
				LDR		R0, [R13] ; linhasA
				CMP		R4, R0
				BHS		MULT_MATRIX_DONE ; if(i >= linhasA)
				
				LDR		R0, [R13, #4] ; colunaA
				MOV		R1, R4
				STMFD	SP!, {LR}
				BL		MULT
				LDMFD	SP!, {LR}
				MOV		R9, R0 ;  i * colunaA
				
				MOV		R5, #0 ; j = 0
				B		WHILE_J
				
WHILE_I_PLUS
				ADD		R4, R4, #1 ; i++
				B		WHILE_I
				
WHILE_J
				LDR		R0, [R13, #8] ; R1 = colunaB
				CMP		R5, R0
				BHS		WHILE_I_PLUS ; if(j >= colunaB)
				
				MOV		R6, #0 ; k = 0
				MOV		R7, #0 ; soma = 0
				B		WHILE_K
				
WHILE_J_PLUS
				ADD		R5, R5, #1 ; j++
				B		WHILE_J
				
WHILE_K
				LDR		R0, [R13, #4] ; LinhaB
				CMP		R6, R0
				BHS		WHILE_K_DONE ;if(k >= (ColunasA/LinhasB))
				
				ADD		R0, R9, R6 ; (i * colunaA + k)
				MOV		R1, #4
				STMFD	SP!, {LR}
				BL		MULT ; (i * colunaA + k) * 4
				LDMFD	SP!, {LR}
				
				LDR		R1, [R13, #40] ; *A
				LDR		R8, [R1, R0] ; R8 = A[i][k]
				
				LDR		R0, [R13, #8] ; colunaB
				MOV		R1, R6 ; k
				STMFD	SP!, {LR}
				BL		MULT ;
				LDMFD	SP!, {LR}
				
				ADD		R0, R0, R5 ; R0 = k*colunaB + j
				MOV		R1, #4
				STMFD	SP!, {LR}
				BL		MULT ;
				LDMFD	SP!, {LR} ; (k*colunaB + j) * 4
				
				LDR		R1, [R13, #44] ; *B
				LDR		R0, [R1, R0] ; B[k][j]
				
				MOV		R1, R8 ; A[i][k]
				STMFD	SP!, {LR}
				BL		MULT ; A[i][k] * B[k][j]
				LDMFD	SP!, {LR}
				
				ADD		R7, R7, R0 ; Soma += A[i][k] * B[k][j]
				ADD		R6, R6, #1 ; k++
				B		WHILE_K
				
WHILE_K_DONE
				LDR		R0, [R13, #8]
				MOV		R1, R4
				STMFD	SP!, {LR}
				BL		MULT ; i * colunaB
				LDMFD	SP!, {LR}
				
				ADD		R0, R0, R5 ; i * colunaB + j
				MOV		R1, #4
				STMFD	SP!, {LR}
				BL		MULT ; (i * colunaB + j) * 4
				LDMFD	SP!, {LR}
				
				LDR		R1, [R13, #12] ; *C
				STR		R7, [R1, R0] ; C[i][j] = soma
				
				B		WHILE_J_PLUS
				
MULT ; Multiplica R0 por R1 usando somas sucessivas
				MOV		R2, #0
				
				CMP		R0, #0
				BEQ		MULT_DONE
				
				CMP		R1, #0
				BEQ		MULT_DONE
				
				B		MULT_WHILE
				
MULT_WHILE
				CMP		R1, #0
				BEQ		MULT_DONE
				
				ADD		R2, R2, R0
				SUB		R1, R1, #1
				B		MULT_WHILE
				
MULT_DONE
				MOV		R0, R2
				MOV		PC, LR
