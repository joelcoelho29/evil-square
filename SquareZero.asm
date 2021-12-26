;********************************************************
;                    ORDEM DO CÓDIGO
;********************************************************

; 1) Inicialização
; - Main
; - Menu 
; - Insere Nome

; 2) Lógica principal do jogo
; - Funções que avaliam as condições dos Level's
; - Movimentação Good Square
; - Movimentação Evil Square

; 3) Funções auxiliares / de controle
; - Printa String
; - Printa Tela
; - Delay


;********************************************************
;                DECLARAÇÃO DE VARIÁVEIS
;********************************************************	

;Variáveis de posição
positionGoodSquare: var #1
positionPreviousGoodSquare: var #1

positionEvilSquare1: var #1
positionPreviousEvilSquare1: var #1
EvilSquareLastMove: var #4
EvilSquareLastOperationMove: var #1

positionEvilSquare2: var #1
positionPreviousEvilSquare2: var #1
EvilSquareLastMove2: var #4
EvilSquareLastOperationMove2: var #1

positionEvilSquare3: var #1
positionPreviousEvilSquare3: var #1
EvilSquareLastMove3: var #4
EvilSquareLastOperationMove3: var #1

positionEvilSquare4: var #1
positionPreviousEvilSquare4: var #1
EvilSquareLastMove4: var #4
EvilSquareLastOperationMove4: var #1

positionEvilSquare5: var #1
positionPreviousEvilSquare5: var #1
EvilSquareLastMove5: var #4
EvilSquareLastOperationMove5: var #1


; String's
InsertString: string "Insert your Nickname"
Nickname: var #27

LevelString: string "Level "
LevelUpString: string "Level UP"

WelcomeString1: string "Welcome"

GameOverString1: string "G A M E   O V E R"
GameOverString2: string "Do you want to play again? <y/n>"

ThanksString: string "Thanks for playing"

; Auxiliares
Level: var #1
Option: var #1
PalavraSize: var #1									; Tamanho do Nickname
Letter: var #1

MOVE_VERTICAL: var #4
MOVE_LEFT_DIAGONAL: var #4
MOVE_RIGHT_DIAGONAL: var #4
MOVE_HORIZONTAL: var #4

;------------------------------------------------------------------


;********************************************************
;                       MAIN
;********************************************************	
main:
	loadn r0, #40
	store MOVE_VERTICAL, r0
	loadn r0, #39
	store MOVE_LEFT_DIAGONAL, r0
	loadn r0, #41
	store MOVE_RIGHT_DIAGONAL, r0
	loadn r0, #1
	store MOVE_HORIZONTAL, r0

	loadn r0, #0
	store PalavraSize, r0

	loadn r0, #1
	store Level, r0									; Guarda o Level

	call InitializeVariables
	call menu
	; call Story

	call DrawScenery
	jmp LevelUp

;--------------------------------------------------------


;********************************************************
;                       MENU
;********************************************************	
menu:
	push r1
	push r2
	call EraseScreen

	loadn r1, #StartScreen1Line0
	loadn r2, #0 
	call PrintScreenMenu

	loadn r1, #StartScreen2Line0
	loadn r2, #2816 
	call PrintScreenMenu

	loadn r1, #StartScreen3Line0
	loadn r2, #2304 
	call PrintScreenMenu
	
	call InputNickname

	pop r2
	pop r1
	rts

;--------------------------------------------------------

;********************************************************
;                       HISTORIA
;********************************************************	
Story:
	push r0
	push r1
	push r2
	push r3

	loadn r3, #9
	call EraseScreen

	; Rotina de impressão da história part 1
	loadn r1, #StoryScreen1Line0
	loadn r2, #0 
	call PrintScreenStory

	; Rotina de impressão do castelo
	loadn r1, #StoryScreen2Line0
	loadn r2, #2048
	call PrintScreenStory

	; Rotina de impressão dos personagens
	call PrintPerson

	CountStory:
		call Time
		dec r3
		jnz CountStory

	call EraseScreen

	; Rotina de impressão da história part 2 e da cena do Rei dando a sentença
	;loadn r1, #StoryScreen3Line0
	;loadn r2, #0 
	;call PrintScreenStory

	; Rotina de impressão da cena do GoodSquare sendo preso
	;loadn r1, #StoryScreen4Line0
	;loadn r2, #2816
	;call PrintScreenStory


	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------

;********************************************************
;              IMPRESSÃO DOS PERSONAGENS
;********************************************************		
PrintPerson:
	push r0
	push r1

	loadn r0, #1174									
	loadn r1, #1661								; Soma o codigo ascii do soldado com a cor TEAL
	outchar r1, r0

	loadn r0, #1058									
	loadn r1, #1661								; Soma o codigo ascii do soldado com a cor TEAL
	outchar r1, r0

	loadn r0, #1136									
	loadn r1, #'!'								; Soma o codigo ascii do GoodSquare com a cor X
	outchar r1, r0
	
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;              INICIALIZAÇÃO DE VARIÁVEIS
;********************************************************		
InitializeVariables:
	push r0
			
	loadn r0, #1059
	store positionGoodSquare, r0					; Guarda posição GoodSquare
	
	loadn r0, #159
	store positionEvilSquare1, r0					; Guarda posição EvilSquare1
	
	loadn r0, #59
	store positionEvilSquare2, r0					; Guarda posição EvilSquare2
	
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                    	LEVEL UP
;********************************************************	
LevelUp:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	loadn r1, #1
	cmp r0, r1
	jeq Level1

	loadn r2, #1									; Atualiza a variavel Level
	load r0, Level
	add r0, r0, r2
	store Level, r0

	call LevelUpAnimation
	
	loadn r1, #2
	cmp r0, r1
	jeq Level2

	loadn r1, #3
	cmp r0, r1
	jeq Level3

	loadn r1, #4
	cmp r0, r1
	jeq Level4
	
	loadn r1, #5
	cmp r0, r1
	jeq Level5

	jmp Win

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                  ANIMAÇÃO DO LEVEL UP
;********************************************************
LevelUpAnimation:
	push r0
	push r1
	push r2
	
	call InitializeVariables

	call EraseScreen

	loadn r1, #LevelUpScreen1Line0
	loadn r2, #0 
	call PrintScreenLevelUp

	loadn r1, #LevelUpScreen2Line0
	loadn r2, #2816 
	call PrintScreenLevelUp

	call Time

	call DrawScenery
	
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                 ESTRELAS DO LEVEL UP
;********************************************************	
Win:
	push r0
	push r1
	push r2
	push r3

	call EraseScreen
	
	; Aqui imprimimos as telas que a coroa do rei está caída

	loadn r1, #WinGameScreen1Line0
	loadn r2, #0 
	call PrintScreenWinGame

	loadn r1, #WinGameScreen2Line0
	loadn r2, #2816 
	call PrintScreenWinGame
	
	; Aqui fazemos um delay para dar tempo do usuário ler o que está escrito na tela

	loadn r3, #4

	Looping:
		call Time
		dec r3
		jnz Looping
	
	call EraseScreen

	; Aqui imprimimos nossos agradecimentos

	loadn r0, #612									; Posicao que vai imprimir a string
	loadn r1, #ThanksString						    ; Mensagem de agradecimento
	loadn r2, #0
	call PrintString

	loadn r1, #WinGameScreen3Line0
	loadn r2, #2816
	call PrintScreenWinGame

	pop r3
	pop r2
	pop r1
	pop r0
	halt
	rts

;--------------------------------------------------------


;********************************************************
;                        LEVELS
;********************************************************	
Level1:
	call MovementEvilSquare1
	call MovementGoodSquare
	call Delay
	jmp Level1

Level2:
	call MovementEvilSquare1
	call MovementEvilSquare2
	call MovementGoodSquare
	call Delay
	jmp Level2

Level3:
	call MovementEvilSquare1
	call MovementEvilSquare2
	;call MovementEvilSquare3
	call MovementGoodSquare
	call Delay
	jmp Level3

Level4:
	call MovementEvilSquare1
	call MovementEvilSquare2
	;call MovementEvilSquare3
	;call MovementEvilSquare4
	call MovementGoodSquare
	call Delay
	jmp Level4

Level5:
	call MovementEvilSquare1
	call MovementEvilSquare2
	;call MovementEvilSquare3
	;call MovementEvilSquare4
	;call MovementEvilSquare5
	call MovementGoodSquare
	call Delay

	jmp Level5

;--------------------------------------------------------


;********************************************************
;                 MOVIMENTAÇÃO DO GOOD SQUARE
;********************************************************	
MovementGoodSquare:
	push r0
	push r1
	push r3
	push r4
	
	loadn r3, #80

	call MovementGoodSquare_RECALC					; Recalcula Posicao do GoodSquare

	load r0, positionGoodSquare						; So' Apaga e Redesenha se (position != positionPrevious)
	cmp r0, r3
	
	jle LevelUp
	
	load r1, positionPreviousGoodSquare	
		
	cmp r0, r1
	jeq Skip
	
	call DeletePreviousGoodSquareDraw
	call DrawGoodSquare
  
  	Skip:
	  	pop r4
		pop	r3
		pop r1
		pop r0
		rts

;--------------------------------------------------------


;********************************************************
;                CALCULA POSIÇÃO DO GOOD SQUARE
;********************************************************	
MovementGoodSquare_RECALC:							; Recalcula posicao do GoodSquare em funcao das Teclas pressionadas
	push r0
	push r1
	push r2
	push r3

	load r0, positionGoodSquare
	
	inchar r1										; Le Teclado para controlar a GoodSquare
	loadn r2, #'a'
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_A
	
	loadn r2, #'d'
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_D
		
	loadn r2, #'w'
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_W
		
	loadn r2, #'s'
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_S
	
	
  MovementGoodSquare_RECALC_Fim:					; Se nao for nenhuma tecla valida, vai embora
	store positionGoodSquare, r0
	pop r3
	pop r2
	pop r1
	pop r0
	rts

  MovementGoodSquare_RECALC_A:						; Move GoodSquare para Esquerda
	loadn r1, #40
	loadn r2, #0
	mod r1, r0, r1									; Testa condicoes de Contorno 
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_Fim
	dec r0											; pos = pos -1
	jmp MovementGoodSquare_RECALC_Fim
		
  MovementGoodSquare_RECALC_D:						; Move GoodSquare para Direita	
	loadn r1, #40
	loadn r2, #39
	mod r1, r0, r1									; Testa condicoes de Contorno 
	cmp r1, r2
	jeq MovementGoodSquare_RECALC_Fim
	inc r0											; pos = pos + 1
	jmp MovementGoodSquare_RECALC_Fim
	
  MovementGoodSquare_RECALC_W:						; Move GoodSquare para Cima
	loadn r1, #40
	cmp r0, r1										; Testa condicoes de Contorno 
	jle MovementGoodSquare_RECALC_Fim
	sub r0, r0, r1									; pos = pos - 40
	jmp MovementGoodSquare_RECALC_Fim

  MovementGoodSquare_RECALC_S:						; Move GoodSquare para Baixo
	loadn r1, #1159
	cmp r0, r1										; Testa condicoes de Contorno 
	jgr MovementGoodSquare_RECALC_Fim
	loadn r2, #1079
	cmp r0, r2										; Testa condicoes de Contorno
	jgr MovementGoodSquare_RECALC_Fim
	loadn r1, #40
	add r0, r0, r1									; pos = pos + 40
	jmp MovementGoodSquare_RECALC_Fim

;--------------------------------------------------------


;********************************************************
;               MOVIMENTAÇÃO DO EVIL SQUARE 1
;********************************************************	
MovementEvilSquare1:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	load r0, positionEvilSquare1
	store positionPreviousEvilSquare1, r0 
	loadn r1, #' '									; Char em branco para apagar o EvilSquare
	outchar r1, r0									; Apaga o EvilSquare

	loadn r7, #40
	mod r2, r0, r7									; pega a posicao x do evil square
	div r3, r0, r7									; pega a posicao y do evil square

	load r1, positionGoodSquare						; Criterio de parada

	mod r4, r1, r7									; pega a posicao x do good square
	div r5, r1, r7									; pega a posicao y do good square
	
	; Lógica para ver qual vai ser a movimentação do evil square

	cmp r3, r5										; compara y do evil com o y do good
	jle EvilAboveGood
	
	cmp r3, r5										; compara y do evil com o y do good
	jgr EvilBelowGood

	jmp EvilEqualGoodInRow

	EvilAboveGood:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilAboveRightDiagonalGood
	
		cmp r2, r4									; compara x do evil com o x do good
		jle EvilAboveLeftDiagonalGood

		jeq EvilStrictlyAboveGood

	EvilBelowGood:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilBelowRightDiagonalGood

		cmp r2, r4									; compara x do evil com o x do good
		jle EvilBelowLeftDiagonalGood

		jeq EvilStrictlyBelowGood

	EvilEqualGoodInRow:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilRightGood

		jmp EvilLeftGood
	
	EvilAboveRightDiagonalGood:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood
		
		jmp MoveEvilBasedOnLastMove

		ContinueAboveRightDiagonalGood:
			load r7, MOVE_LEFT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal esquerda
	    	loadn r6, #0
			jmp DrawEvilSquare1
	
	EvilAboveLeftDiagonalGood:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood
		
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood
		
		jmp MoveEvilBasedOnLastMove

		ContinueAboveLeftDiagonalGood:
			load r7, MOVE_RIGHT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal direita
	    	loadn r6, #0
			jmp DrawEvilSquare1

	EvilStrictlyAboveGood:	
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove
		
		load r7, MOVE_VERTICAL
		add r0, r0, r7								; move estritamente para baixo
		loadn r6, #0
		jmp DrawEvilSquare1

	EvilBelowRightDiagonalGood:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood
		
		jmp MoveEvilBasedOnLastMove

		ContinueBelowRightDiagonalGood:
			load r7, MOVE_RIGHT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal esquerda
			loadn r6, #1
			jmp DrawEvilSquare1

	EvilBelowLeftDiagonalGood:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood
		
		sub r7, r4, r2								; good square x - evil square x
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood

		jmp MoveEvilBasedOnLastMove

		ContinueBelowLeftDiagonalGood:
			load r7, MOVE_LEFT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal direita
			loadn r6, #1
			jmp DrawEvilSquare1

	EvilStrictlyBelowGood:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove

		load r7, MOVE_VERTICAL
		sub r0, r0, r7								; move estritamente para cima
		loadn r6, #1
		jmp DrawEvilSquare1

	EvilRightGood:
		loadn r6, #3
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jle MoveEvilBasedOnLastMove

		load r7, MOVE_HORIZONTAL
		sub r0, r0, r7								; move estritamente para a esquerda
		loadn r6, #1
		jmp DrawEvilSquare1

	EvilLeftGood:
		loadn r6, #3
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6 
		jle MoveEvilBasedOnLastMove

		load r7, MOVE_HORIZONTAL
		add r0, r0, r7								; move estritamente para a direita
		loadn r6, #0
		jmp DrawEvilSquare1

	;--------------------------
	
	MoveEvilBasedOnLastMove: 
		; breakp
		load r7, EvilSquareLastOperationMove		; 1 significa que decrementou e 0 significa incrementou 
		loadn r6, #1
		cmp r7, r6									; compara a ultima operação com 1 para ver se decrementou
		jeq SUBTRACTMoveEvilBasedOnLastMove

		jmp ADDMoveEvilBasedOnLastMove

	ADDMoveEvilBasedOnLastMove:
		load r7, EvilSquareLastMove
		add r0, r0, r7
		loadn r6, #0
		jmp DrawEvilSquare1

	SUBTRACTMoveEvilBasedOnLastMove:
		load r7, EvilSquareLastMove
		sub r0, r0, r7
		loadn r6, #1
		jmp DrawEvilSquare1

	DrawEvilSquare1:
		call DeletePreviousEvilSquareDraw

		cmp r1, r0
		jeq GameOver
		
		store positionEvilSquare1, r0
		store EvilSquareLastMove, r7
		store EvilSquareLastOperationMove, r6
		
		loadn r1, #2337								; Char do EvilSquare 
		outchar r1, r0								; Desenha Char
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0	
	rts

;--------------------------------------------------------


;********************************************************
;               MOVIMENTAÇÃO DO EVIL SQUARE 2
;********************************************************	


MovementEvilSquare2:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	load r0, positionEvilSquare2
	store positionPreviousEvilSquare2, r0 
	loadn r1, #' '									; Char em branco para apagar o EvilSquare
	outchar r1, r0									; Apaga o EvilSquare

	loadn r7, #40
	mod r2, r0, r7									; pega a posicao x do evil square
	div r3, r0, r7									; pega a posicao y do evil square

	load r1, positionGoodSquare						; Criterio de parada

	mod r4, r1, r7									; pega a posicao x do good square
	div r5, r1, r7									; pega a posicao y do good square
	
	; Lógica para ver qual vai ser a movimentação do evil square

	cmp r3, r5										; compara y do evil com o y do good
	jle EvilAboveGood2
	
	cmp r3, r5										; compara y do evil com o y do good
	jgr EvilBelowGood2

	jmp EvilEqualGoodInRow2

	EvilAboveGood2:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilAboveRightDiagonalGood2
	
		cmp r2, r4									; compara x do evil com o x do good
		jle EvilAboveLeftDiagonalGood2

		jeq EvilStrictlyAboveGood2

	EvilBelowGood2:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilBelowRightDiagonalGood2

		cmp r2, r4									; compara x do evil com o x do good
		jle EvilBelowLeftDiagonalGood2

		jeq EvilStrictlyBelowGood2

	EvilEqualGoodInRow2:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilRightGood2

		jmp EvilLeftGood2
	
	EvilAboveRightDiagonalGood2:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood2
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood2
		
		jmp MoveEvilBasedOnLastMove2

		ContinueAboveRightDiagonalGood2:
			load r7, MOVE_LEFT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal esquerda
	    	loadn r6, #0
			jmp DrawEvilSquare2
	
	EvilAboveLeftDiagonalGood2:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood2
		
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood2
		
		jmp MoveEvilBasedOnLastMove2

		ContinueAboveLeftDiagonalGood2:
			load r7, MOVE_RIGHT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal direita
	    	loadn r6, #0
			jmp DrawEvilSquare2

	EvilStrictlyAboveGood2:	
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove2
		
		load r7, MOVE_VERTICAL
		add r0, r0, r7								; move estritamente para baixo
		loadn r6, #0
		jmp DrawEvilSquare2

	EvilBelowRightDiagonalGood2:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood2
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood2
		
		jmp MoveEvilBasedOnLastMove2

		ContinueBelowRightDiagonalGood2:
			load r7, MOVE_RIGHT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal esquerda
			loadn r6, #1
			jmp DrawEvilSquare2

	EvilBelowLeftDiagonalGood2:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood2
		
		sub r7, r4, r2								; good square x - evil square x
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood2

		jmp MoveEvilBasedOnLastMove2

		ContinueBelowLeftDiagonalGood2:
			load r7, MOVE_LEFT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal direita
			loadn r6, #1
			jmp DrawEvilSquare2

	EvilStrictlyBelowGood2:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove2

		load r7, MOVE_VERTICAL
		sub r0, r0, r7								; move estritamente para cima
		loadn r6, #1
		jmp DrawEvilSquare2

	EvilRightGood2:
		loadn r6, #3
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jle MoveEvilBasedOnLastMove2

		load r7, MOVE_HORIZONTAL
		sub r0, r0, r7								; move estritamente para a esquerda
		loadn r6, #1
		jmp DrawEvilSquare2

	EvilLeftGood2:
		loadn r6, #3
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6 
		jle MoveEvilBasedOnLastMove2

		load r7, MOVE_HORIZONTAL
		add r0, r0, r7								; move estritamente para a direita
		loadn r6, #0
		jmp DrawEvilSquare2

	;--------------------------
	
	MoveEvilBasedOnLastMove2: 
		; breakp
		load r7, EvilSquareLastOperationMove2		; 1 significa que decrementou e 0 significa incrementou 
		loadn r6, #1
		cmp r7, r6									; compara a ultima operação com 1 para ver se decrementou
		jeq SUBTRACTMoveEvilBasedOnLastMove2

		jmp ADDMoveEvilBasedOnLastMove2

	ADDMoveEvilBasedOnLastMove2:
		load r7, EvilSquareLastMove2
		add r0, r0, r7
		loadn r6, #0
		jmp DrawEvilSquare2

	SUBTRACTMoveEvilBasedOnLastMove2:
		load r7, EvilSquareLastMove2
		sub r0, r0, r7
		loadn r6, #1
		jmp DrawEvilSquare2

	DrawEvilSquare2:
		call DeletePreviousEvilSquareDraw2

		cmp r1, r0
		jeq GameOver
		
		store positionEvilSquare2, r0
		store EvilSquareLastMove2, r7
		store EvilSquareLastOperationMove2, r6
		
		loadn r1, #2337								; Char do EvilSquare 
		outchar r1, r0								; Desenha Char
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0	
	rts

;--------------------------------------------------------


;********************************************************
;               MOVIMENTAÇÃO DO EVIL SQUARE 3
;********************************************************	


MovementEvilSquare3:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	load r0, positionEvilSquare3
	store positionPreviousEvilSquare3, r0 
	loadn r1, #' '									; Char em branco para apagar o EvilSquare
	outchar r1, r0									; Apaga o EvilSquare

	loadn r7, #40
	mod r2, r0, r7									; pega a posicao x do evil square
	div r3, r0, r7									; pega a posicao y do evil square

	load r1, positionGoodSquare						; Criterio de parada

	mod r4, r1, r7									; pega a posicao x do good square
	div r5, r1, r7									; pega a posicao y do good square
	
	; Lógica para ver qual vai ser a movimentação do evil square

	cmp r3, r5										; compara y do evil com o y do good
	jle EvilAboveGood3
	
	cmp r3, r5										; compara y do evil com o y do good
	jgr EvilBelowGood3

	jmp EvilEqualGoodInRow3

	EvilAboveGood3:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilAboveRightDiagonalGood3
	
		cmp r2, r4									; compara x do evil com o x do good
		jle EvilAboveLeftDiagonalGood3

		jeq EvilStrictlyAboveGood3

	EvilBelowGood3:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilBelowRightDiagonalGood3

		cmp r2, r4									; compara x do evil com o x do good
		jle EvilBelowLeftDiagonalGood3

		jeq EvilStrictlyBelowGood3

	EvilEqualGoodInRow3:
		cmp r2, r4									; compara x do evil com o x do good
		jgr EvilRightGood3

		jmp EvilLeftGood2
	
	EvilAboveRightDiagonalGood3:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood3
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveRightDiagonalGood3
		
		jmp MoveEvilBasedOnLastMove3

		ContinueAboveRightDiagonalGood3:
			load r7, MOVE_LEFT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal esquerda
	    	loadn r6, #0
			jmp DrawEvilSquare3
	
	EvilAboveLeftDiagonalGood3:
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood3
		
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6
		jgr ContinueAboveLeftDiagonalGood3
		
		jmp MoveEvilBasedOnLastMove3

		ContinueAboveLeftDiagonalGood3:
			load r7, MOVE_RIGHT_DIAGONAL
			add r0, r0, r7							; move para baixo na diagonal direita
	    	loadn r6, #0
			jmp DrawEvilSquare3

	EvilStrictlyAboveGood3:	
		loadn r6, #3
		sub r7, r5, r3								; good square y - evil square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove3
		
		load r7, MOVE_VERTICAL
		add r0, r0, r7								; move estritamente para baixo
		loadn r6, #0
		jmp DrawEvilSquare3

	EvilBelowRightDiagonalGood3:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood3
		
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jgr ContinueBelowRightDiagonalGood3
		
		jmp MoveEvilBasedOnLastMove3

		ContinueBelowRightDiagonalGood3:
			load r7, MOVE_RIGHT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal esquerda
			loadn r6, #1
			jmp DrawEvilSquare3

	EvilBelowLeftDiagonalGood3:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood3
		
		sub r7, r4, r2								; good square x - evil square x
		cmp r7, r6
		jgr ContinueBelowLeftDiagonalGood3

		jmp MoveEvilBasedOnLastMove3

		ContinueBelowLeftDiagonalGood3:
			load r7, MOVE_LEFT_DIAGONAL
			sub r0, r0, r7							; move para cima na diagonal direita
			loadn r6, #1
			jmp DrawEvilSquare3

	EvilStrictlyBelowGood3:
		loadn r6, #3
		sub r7, r3, r5								; evil square y - good square y
		cmp r7, r6
		jle MoveEvilBasedOnLastMove3

		load r7, MOVE_VERTICAL
		sub r0, r0, r7								; move estritamente para cima
		loadn r6, #1
		jmp DrawEvilSquare3

	EvilRightGood3:
		loadn r6, #3
		sub r7, r2, r4								; evil square x - good square x
		cmp r7, r6
		jle MoveEvilBasedOnLastMove3

		load r7, MOVE_HORIZONTAL
		sub r0, r0, r7								; move estritamente para a esquerda
		loadn r6, #1
		jmp DrawEvilSquare3

	EvilLeftGood3:
		loadn r6, #3
		sub r7, r4, r2								; evil square x - good square x
		cmp r7, r6 
		jle MoveEvilBasedOnLastMove3

		load r7, MOVE_HORIZONTAL
		add r0, r0, r7								; move estritamente para a direita
		loadn r6, #0
		jmp DrawEvilSquare3

	;--------------------------
	
	MoveEvilBasedOnLastMove3: 
		; breakp
		load r7, EvilSquareLastOperationMove3		; 1 significa que decrementou e 0 significa incrementou 
		loadn r6, #1
		cmp r7, r6									; compara a ultima operação com 1 para ver se decrementou
		jeq SUBTRACTMoveEvilBasedOnLastMove3

		jmp ADDMoveEvilBasedOnLastMove3

	ADDMoveEvilBasedOnLastMove3:
		load r7, EvilSquareLastMove3
		add r0, r0, r7
		loadn r6, #0
		jmp DrawEvilSquare3

	SUBTRACTMoveEvilBasedOnLastMove3:
		load r7, EvilSquareLastMove3
		sub r0, r0, r7
		loadn r6, #1
		jmp DrawEvilSquare3

	DrawEvilSquare3:
		call DeletePreviousEvilSquareDraw3

		cmp r1, r0
		jeq GameOver
		
		store positionEvilSquare3, r0
		store EvilSquareLastMove3, r7
		store EvilSquareLastOperationMove3, r6
		
		loadn r1, #2337								; Char do EvilSquare 
		outchar r1, r0								; Desenha Char
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0	
	rts

;--------------------------------------------------------


;********************************************************
;                    DESENHA GOOD SQUARE
;********************************************************		
DrawGoodSquare:										; Desenha caractere do GoodSquare
	push r0
	push r1
	
	load r0, positionGoodSquare
	loadn r1, #'!'									; Char do GoodSquare
	outchar r1, r0
	store positionPreviousGoodSquare, r0			; Atualiza Posicao Anterior do GoodSquare = Posicao Atual
	
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;           DELETA POSIÇÃO ANTERIOR DO GOOD SQUARE
;********************************************************	
DeletePreviousGoodSquareDraw:						; Apaga o GoodSquare preservando o Cenario!
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, positionPreviousGoodSquare				; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #Screen0Line0							; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0									; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4									; r3 = posAnt/40
	add r2, r2, r3									; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2									; r5 = Char (Tela(posAnt))
	
	outchar r5, r0									; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------
	

;********************************************************
;          DELETA POSIÇÃO ANTERIOR DO EVIL SQUARE 1
;********************************************************	
DeletePreviousEvilSquareDraw:						; Apaga o EvilSquare preservando o Cenario!
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, positionPreviousEvilSquare1			; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #Screen0Line0							; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0									; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4									; r3 = posAnt/40
	add r2, r2, r3									; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2									; r5 = Char (Tela(posAnt))
	
	outchar r5, r0									; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;          DELETA POSIÇÃO ANTERIOR DO EVIL SQUARE 2
;********************************************************	
DeletePreviousEvilSquareDraw2:						; Apaga o EvilSquare preservando o Cenario!
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, positionPreviousEvilSquare2			; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #Screen0Line0							; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0									; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4									; r3 = posAnt/40
	add r2, r2, r3									; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2									; r5 = Char (Tela(posAnt))
	
	outchar r5, r0									; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------

;********************************************************
;          DELETA POSIÇÃO ANTERIOR DO EVIL SQUARE 3
;********************************************************	
DeletePreviousEvilSquareDraw3:						; Apaga o EvilSquare preservando o Cenario!
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, positionPreviousEvilSquare3			; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #Screen0Line0							; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0									; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4									; r3 = posAnt/40
	add r2, r2, r3									; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2									; r5 = Char (Tela(posAnt))
	
	outchar r5, r0									; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                       GAME OVER
;********************************************************	
GameOver:
	call EraseScreen

	loadn r1, #GameOverScreen1Line0
	loadn r2, #0 
	call PrintScreenGameOver
	
	loadn r1, #GameOverScreen2Line0
	loadn r2, #2304
	call PrintScreenGameOver
	
	; Le Teclado para verificar se quer jogar novamente
	Read_Keyboard:
		call CheckOption
		loadn r4, #'n'
		load r5, Option
		cmp r4, r5
		jeq EndGame									; Se tiver inserido Y volta para o jogo
		
		loadn r4, #'y'
		cmp r4, r5
		jeq main

		jmp Read_Keyboard

;--------------------------------------------------------


;********************************************************
;                       END GAME
;********************************************************
EndGame:
	push r0
	push r1
	push r2
								
	call EraseScreen

	loadn r1, #EndGameScreen1Line0
	loadn r2, #0 
	call PrintScreenEndGame

	loadn r1, #EndGameScreen2Line0
	loadn r2, #2304 
	call PrintScreenEndGame

	loadn r0, #287
	loadn r1, #Nickname
	loadn r2, #0
	call PrintString
	
	pop r2
	pop r1
	pop r0
	halt

;--------------------------------------------------------


;********************************************************
;                   INPUT NICKNAME
;********************************************************
InputNickname:										; Rotina que recebe uma palavra para que o segundo usuario tente adivinhar
	push r0											; Recebe letra digitada
	push r1											; codigo do enter
	push r2											; Contador de letras para o vetor que armazena a palavra
	push r3											; ponteiro para palavra
	push r4											; palavra[r3+r2]
	push r5											; Tamanho maximo da palavra
	push r6											; Guarda próxima posicao da letra a ser digitada

	loadn r1, #13									; codigo enter
	loadn r2, #0									; inicia r2 = 0
	loadn r3, #Nickname								; ponteiro para palavra
	loadn r5, #26									; Tamanho maximo da palavra
	loadn r6, #887									; Primeira posicao da letra da palavra
	;----------------
	
	;call PrintInsertString							; Seleciona uma mensagem para imprimir - Digite uma palavra!!

   	InputNickname_Loop:
		call InputLetter							; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	   		
		load r0, Letter								; Letra --> r0
		outchar r0, r6
		inc r6

		cmp r0, r1									;comparacao se r0 eh enter(13)
		jeq InputNickname_Fim						; VAi para o fim se Enter!
		
		add r4, r3, r2
		storei r4, r0								; palavra[r2] = Letra

		inc r2
		store PalavraSize, r2						; Atualiza o tamanho da palavra
		cmp r2, r5									; verifica se r2 = 40
		jne InputNickname_Loop						; Se for, sai, senao goto loop!!
				
   InputNickname_Fim:
	; Poe um /0 no final da palavra pra poder imprimir e testar!!
	loadn r0, #0
	add r4, r3, r2
	storei r4, r0									; palavra[r2] = /0

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts		

;--------------------------------------------------------


;********************************************************
;              IMPRIME INSERT YOUR NICKNAME
;********************************************************
PrintInsertString:									; Seleciona uma mensagem para imprimir - Digite uma palavra!!
	push r0
	push r1
	push r2
	
	loadn r0, #410									; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #InsertString							; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0									; Seleciona a COR da Mensagem
	
	call PrintString   								;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	
	pop r2
	pop r1
	pop r0	
	rts

;--------------------------------------------------------


;********************************************************
;                   DIGITE UMA LETRA
;********************************************************
InputLetter:										; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	push r2
	loadn r1, #255									; Se nao digitar nada vem 255
	loadn r2, #0									; Logo que programa a FPGA o inchar vem 0

    InputLetter_Loop:
		inchar r0									; Le o teclado, se nada for digitado = 255
		cmp r0, r1									;compara r0 com 255
		jeq InputLetter_Loop						; Fica lendo ate' que digite uma tecla valida


		cmp r0, r2									;compara r0 com 0
		jeq InputLetter_Loop						; Le novamente pois Logo que programa abre a FPGA o inchar vem 0

	store Letter, r0								; Salva a tecla na variavel global "Letra"
	
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                     VERIFICA OPCAO
;********************************************************
CheckOption:										; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	push r2
	push r3
	push r4
	loadn r4, #255									; Se nao digitar nada vem 255

   CheckOption_Loop:
		inchar r3									; Le o teclado, se nada for digitado = 255
		store Option, r3							; Salva a tecla na variavel global "Letra"
		cmp r3, r4									; compara r3 com 255
		jeq CheckOption_Loop						; Fica lendo ate' que digite uma tecla valida

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                   IMPRIME STRING
;********************************************************	
PrintString:										;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0											; protege o r0 na pilha para preservar seu valor
	push r1											; protege o r1 na pilha para preservar seu valor
	push r2											; protege o r1 na pilha para preservar seu valor
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'									; Criterio de parada

  	PrintString_Loop:	
		loadi r4, r1
		cmp r4, r3									; If (Char == \0)  vai Embora
		jeq PrintString_Exit
		add r4, r2, r4								; Soma a Cor
		outchar r4, r0								; Imprime o caractere na tela
		inc r0										; Incrementa a posicao na tela
		inc r1										; Incrementa o ponteiro da String
		jmp PrintString_Loop
	
   	PrintString_Exit:	
	pop r4											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;--------------------------------------------------------


;********************************************************
;                   IMPRIME STRING2
;********************************************************	
PrintString2:										;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0											; protege o r0 na pilha para preservar seu valor
	push r1											; protege o r1 na pilha para preservar seu valor
	push r2											; protege o r1 na pilha para preservar seu valor
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'									; Criterio de parada
	loadn r5, #' '									; Espaco em Branco

   PrintString2_Loop:	
		loadi r4, r1
		cmp r4, r3									; If (Char == \0)  vai Embora
		jeq PrintString2_Sai
		cmp r4, r5									; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq PrintString2_Skip
		add r4, r2, r4								; Soma a Cor
		outchar r4, r0								; Imprime o caractere na tela
   		storei r6, r4
   PrintString2_Skip:
		inc r0										; Incrementa a posicao na tela
		inc r1										; Incrementa o ponteiro da String
		inc r6
		jmp PrintString2_Loop
	
   PrintString2_Sai:	
	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                 DESENHA TELA COLORIDO
;********************************************************
DrawScreenColorful:
	push r0
	push r1
	push r2
	
	loadn r0, #0									; desenha tela colorido
	loadn r1, #0									; código do primeiro char full prenchido
	loadn r2, #1200									; posicao do final da tela
	
	   DrawScreenColorful_Loop:	
		outchar r1, r0
		inc r0
		cmp r2, r0
		jne DrawScreenColorful_Loop
 
 	pop r2
	pop r1
	pop r0
	rts	

;--------------------------------------------------------


;********************************************************
;                       APAGA TELA
;********************************************************
EraseScreen:
	push r0
	push r1
	
	loadn r0, #1200									; apaga as 1200 posicoes da Tela
	loadn r1, #' '									; com "espaco"
	
	   EraseScreen_Loop:	
		dec r0
		outchar r1, r0
		jnz EraseScreen_Loop
 
	pop r1
	pop r0
	rts	
	
;--------------------------------------------------------


;********************************************************
;                       IMPRIME TELA
;********************************************************	
PrintScreen:		  		  
	push r0											; protege o r0 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	
   PrintScreen_Loop:
		call PrintString
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreen_Loop						; Enquanto r0 < 1200

	pop r5											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;--------------------------------------------------------

;********************************************************
;         IMPRIME TELA2 (DESENHA O CENÁRIO PRINCIAL)
;********************************************************	
PrintScreenScenery: 								;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #Screen0Line0							; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenScenery_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenScenery_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA3 (DESENHA O MENU)
;********************************************************	
PrintScreenMenu: 									;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #StartScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenMenu_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenMenu_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA4 (DESENHA A TELA DE LEVELUP)
;********************************************************	
PrintScreenLevelUp: 								;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #LevelUpScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenLevelUp_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenLevelUp_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA5 (DESENHA A TELA DE WINGAME)
;********************************************************	
PrintScreenWinGame: 								;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #WinGameScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenWinGame_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenWinGame_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA6 (DESENHA A TELA DE GAMEOVER)
;********************************************************	
PrintScreenGameOver: 								;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #GameOverScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenGameOver_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenGameOver_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA7 (DESENHA A TELA DE ENDGAME)
;********************************************************	
PrintScreenEndGame: 								;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #EndGameScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenEndGame_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenEndGame_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;          IMPRIME TELA8 (DESENHA A TELA DE STORY)
;********************************************************	
PrintScreenStory: 									;  Rotina de Impresao de Cenario na Tela Inteira
	push r0											; protege o r3 na pilha para ser usado na subrotina
	push r1											; r1 = endereco onde comeca a primeira linha do Cenario
	push r2											; r2 = cor do Cenario para ser impresso
	push r3											; protege o r3 na pilha para ser usado na subrotina
	push r4											; protege o r4 na pilha para ser usado na subrotina
	push r5											; protege o r5 na pilha para ser usado na subrotina
	push r6											; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  									; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  									; Incremento da posicao da tela!
	loadn r4, #41  									; incremento do ponteiro das linhas da tela
	loadn r5, #1200 								; Limite da tela!
	loadn r6, #StoryScreen0Line0					; Endereco onde comeca a primeira linha do cenario!!
	
    PrintScreenStory_Loop:
		call PrintString2
		add r0, r0, r3  							; incrementa posicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  							; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5									; Compara r0 com 1200
		jne PrintScreenStory_Loop					; Enquanto r0 < 1200

	pop r6											; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;--------------------------------------------------------

;********************************************************
;                       DESENHA CENÁRIO
;********************************************************
DrawScenery:
	push r0
	push r1
	push r2

	call EraseScreen

	loadn r1, #Screen1Line0
	loadn r2, #2048
	call PrintScreenScenery
	
	loadn r1, #Screen2Line0
	loadn r2, #0
	call PrintScreenScenery
	
	loadn r1, #Screen3Line0
	loadn r2, #256
	call PrintScreenScenery
	
	loadn r1, #Screen4Line0
	loadn r2, #1536 
	call PrintScreenScenery
	
	loadn r0, #1161
	loadn r1, #Nickname
	loadn r2, #0
	call PrintString

	loadn r0, #1190
	loadn r1, #2817
	outchar r1, r0

	loadn r0, #1192
	loadn r1, #LevelString
	loadn r2, #2816
	call PrintString

	loadn r0, #1198
	load r1, Level
	loadn r2, #2864 								;soma 2816(cor) com o codigo ascii 0
	add r1, r1, r2
	outchar r1, r0

	pop r2
	pop r1
	pop r0
	rts

;--------------------------------------------------------


;********************************************************
;                       DELAY
;********************************************************		
Delay:
	push r0					   						; Utiliza Push e Pop para nao afetar os Registradores do programa principal
	push r1
	
	loadn r1, #2000   								; a
	
    Delay_volta2:									; Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn r0, #3000									; b
	
    Delay_volta1: 
	dec r0											; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz Delay_volta1	
	dec r1
	jnz Delay_volta2
	
	pop r1
	pop r0
	
	rts												; return

;--------------------------------------------------------


;********************************************************
;             TIME DA ANIMAÇÃO DO LEVEL UP
;********************************************************		
Time:
	push r0											; Utiliza Push e Pop para nao afetar os Registradores do programa principal
	push r1
	
	loadn r1, #6000   ; a
	
    Time_volta2:									; Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn r0, #6000	; b
	
    Time_volta1: 
		dec r0										; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
		jnz Time_volta1	
		dec r1
		jnz Time_volta2
	
	pop r1
	pop r0
	rts												; return

;--------------------------------------------------------


;********************************************************
;                       TELAS
;********************************************************	
; Tela Jogo
Screen0Line0  : string "                                        "
Screen0Line1  : string "                                        "
Screen0Line2  : string "                                        "
Screen0Line3  : string "                                        "
Screen0Line4  : string "                                        "
Screen0Line5  : string "                                        "
Screen0Line6  : string "                                        "
Screen0Line7  : string "                                        "
Screen0Line8  : string "                                        "
Screen0Line9  : string "                                        "
Screen0Line10 : string "                                        "
Screen0Line11 : string "                                        "
Screen0Line12 : string "                                        "
Screen0Line13 : string "                                        "
Screen0Line14 : string "                                        "
Screen0Line15 : string "                                        "
Screen0Line16 : string "                                        "
Screen0Line17 : string "                                        "
Screen0Line18 : string "                                        "
Screen0Line19 : string "                                        "
Screen0Line20 : string "                                        "
Screen0Line21 : string "                                        "
Screen0Line22 : string "                                        "
Screen0Line23 : string "                                        "
Screen0Line24 : string "                                        "
Screen0Line25 : string "                                        "
Screen0Line26 : string "                                        "
Screen0Line27 : string "                                        "
Screen0Line28 : string "                                        "
Screen0Line29 : string "                                        "	

; Desenha a linha de chegada em cinza
Screen1Line0  : string ") ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) "
Screen1Line1  : string " ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )"
Screen1Line2  : string "                                        "
Screen1Line3  : string "                                        "
Screen1Line4  : string "                                        "
Screen1Line5  : string "                                        "
Screen1Line6  : string "                                        "
Screen1Line7  : string "                                        "
Screen1Line8  : string "                                        "
Screen1Line9  : string "                                        "
Screen1Line10 : string "                                        " 
Screen1Line11 : string "                                        "
Screen1Line12 : string "                                        "
Screen1Line13 : string "                                        "
Screen1Line14 : string "                                        "
Screen1Line15 : string "                                        "
Screen1Line16 : string "                                        "
Screen1Line17 : string "                                        "
Screen1Line18 : string "                                        "
Screen1Line19 : string "                                        "
Screen1Line20 : string "                                        "
Screen1Line21 : string "                                        "
Screen1Line22 : string "                                        "
Screen1Line23 : string "                                        "
Screen1Line24 : string "                                        "
Screen1Line25 : string "                                        "
Screen1Line26 : string "                                        "
Screen1Line27 : string "                                        "
Screen1Line28 : string "----------------------------------------"
Screen1Line29 : string "                                        "

; Desenha a linha de chegada em branco
Screen2Line0  : string " ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )"
Screen2Line1  : string ") ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) "
Screen2Line2  : string "                                        "
Screen2Line3  : string "                                        "
Screen2Line4  : string "                                        "
Screen2Line5  : string "                                        "
Screen2Line6  : string "                                        "
Screen2Line7  : string "                                        "
Screen2Line8  : string "                                        "
Screen2Line9  : string "                                        "
Screen2Line10 : string "                                        "
Screen2Line11 : string "                                        "
Screen2Line12 : string "                                        "
Screen2Line13 : string "                                        "
Screen2Line14 : string "                                        "
Screen2Line15 : string "                                        "
Screen2Line16 : string "                                        "
Screen2Line17 : string "                                        "
Screen2Line18 : string "                                        "
Screen2Line19 : string "                                        "
Screen2Line20 : string "                                        "
Screen2Line21 : string "                                        "
Screen2Line22 : string "                                        "
Screen2Line23 : string "                                        "
Screen2Line24 : string "                                        "
Screen2Line25 : string "                                        "
Screen2Line26 : string "                                        "
Screen2Line27 : string "                                        "
Screen2Line28 : string "                                        "
Screen2Line29 : string "                                        "

; Tapete
Screen3Line0  : string "                                        "
Screen3Line1  : string "                                        "
Screen3Line2  : string "                ))))))))))              "
Screen3Line3  : string "                ))))))))))              "
Screen3Line4  : string "                ))))))))))              "
Screen3Line5  : string "                 ))))))))))             "
Screen3Line6  : string "                  ))))))))))            "
Screen3Line7  : string "                 ))))))))))             "
Screen3Line8  : string "                ))))))))))              "
Screen3Line9  : string "               ))))))))))               "
Screen3Line10 : string "              ))))))))))                "
Screen3Line11 : string "             ))))))))))                 "
Screen3Line12 : string "            ))))))))))                  "
Screen3Line13 : string "             ))))))))))                 "
Screen3Line14 : string "              ))))))))))                "
Screen3Line15 : string "               ))))))))))               "
Screen3Line16 : string "                ))))))))))              "
Screen3Line17 : string "                 ))))))))))             "
Screen3Line18 : string "                  ))))))))))            "
Screen3Line19 : string "                 ))))))))))             "
Screen3Line20 : string "                ))))))))))              "
Screen3Line21 : string "               ))))))))))               "
Screen3Line22 : string "              ))))))))))                "
Screen3Line23 : string "             ))))))))))                 "
Screen3Line24 : string "            ))))))))))                  "
Screen3Line25 : string "             ))))))))))                 "
Screen3Line26 : string "              ))))))))))                "
Screen3Line27 : string "               ))))))))))               "
Screen3Line28 : string "                                        "
Screen3Line29 : string "                                        "

; Soldados
Screen4Line0  : string "                                        "
Screen4Line1  : string "                                        "
Screen4Line2  : string "                                        "
Screen4Line3  : string "                                        "
Screen4Line4  : string "  }                                   ~ "
Screen4Line5  : string "                                        "
Screen4Line6  : string "                                        "
Screen4Line7  : string "                                        "
Screen4Line8  : string "                                        "
Screen4Line9  : string "                                        "
Screen4Line10 : string "                                        "
Screen4Line11 : string " }                                   ~  "
Screen4Line12 : string "                                        "
Screen4Line13 : string "                                        "
Screen4Line14 : string "                                        "
Screen4Line15 : string "                                        "
Screen4Line16 : string "                                        "
Screen4Line17 : string "                                        "
Screen4Line18 : string "  }                                   ~ "
Screen4Line19 : string "                                        "
Screen4Line20 : string "                                        "
Screen4Line21 : string "                                        "
Screen4Line22 : string "                                        "
Screen4Line23 : string "                                        "
Screen4Line24 : string "                                        "
Screen4Line25 : string " }                                   ~  "
Screen4Line26 : string "                                        "
Screen4Line27 : string "                                        "
Screen4Line28 : string "                                        "
Screen4Line29 : string "                                        "

; Tela Das histórias
StoryScreen0Line0  : string "                                        "
StoryScreen0Line1  : string "                                        "
StoryScreen0Line2  : string "                                        "
StoryScreen0Line3  : string "                                        "
StoryScreen0Line4  : string "                                        "
StoryScreen0Line5  : string "                                        "
StoryScreen0Line6  : string "                                        "
StoryScreen0Line7  : string "                                        "
StoryScreen0Line8  : string "                                        "
StoryScreen0Line9  : string "                                        "
StoryScreen0Line10 : string "                                        "
StoryScreen0Line11 : string "                                        "
StoryScreen0Line12 : string "                                        "
StoryScreen0Line13 : string "                                        "
StoryScreen0Line14 : string "                                        "
StoryScreen0Line15 : string "                                        "
StoryScreen0Line16 : string "                                        "
StoryScreen0Line17 : string "                                        "
StoryScreen0Line18 : string "                                        "
StoryScreen0Line19 : string "                                        "
StoryScreen0Line20 : string "                                        "
StoryScreen0Line21 : string "                                        "
StoryScreen0Line22 : string "                                        "
StoryScreen0Line23 : string "                                        "
StoryScreen0Line24 : string "                                        "
StoryScreen0Line25 : string "                                        "
StoryScreen0Line26 : string "                                        "
StoryScreen0Line27 : string "                                        "
StoryScreen0Line28 : string "                                        "
StoryScreen0Line29 : string "                                        "	

; Tela 1 do castelo 
StoryScreen1Line0  : string "                                        "
StoryScreen1Line1  : string " In a kingdom rulled by a cruel square, "
StoryScreen1Line2  : string "                                        "
StoryScreen1Line3  : string " there lived a humble square that       "
StoryScreen1Line4  : string "                                        "
StoryScreen1Line5  : string " commited a crime of disobedience       "
StoryScreen1Line6  : string "                                        "
StoryScreen1Line7  : string " against the king. He was then taken to "
StoryScreen1Line8  : string "                                        "
StoryScreen1Line9  : string " the castle, chained, prepared for the  "
StoryScreen1Line10 : string "                                        "
StoryScreen1Line11 : string " worst, for he knew of the wickedness   "
StoryScreen1Line12 : string "                                        "
StoryScreen1Line13 : string " of King.                               "
StoryScreen1Line14 : string "                                        "
StoryScreen1Line15 : string "                                        "
StoryScreen1Line16 : string "                                        "
StoryScreen1Line17 : string "                                        "
StoryScreen1Line18 : string "                                        "
StoryScreen1Line19 : string "                                        "
StoryScreen1Line20 : string "                                        "
StoryScreen1Line21 : string "                                        "
StoryScreen1Line22 : string "                                        "
StoryScreen1Line23 : string "                                        "
StoryScreen1Line24 : string "                                        "
StoryScreen1Line25 : string "                                        "
StoryScreen1Line26 : string "                                        "
StoryScreen1Line27 : string "                                        "
StoryScreen1Line28 : string "                                        "
StoryScreen1Line29 : string "                                        "

StoryScreen2Line0  : string "                                        "
StoryScreen2Line1  : string "                                        "
StoryScreen2Line2  : string "                                        "
StoryScreen2Line3  : string "                                        "
StoryScreen2Line4  : string "                                        "
StoryScreen2Line5  : string "                                        "
StoryScreen2Line6  : string "                                        "
StoryScreen2Line7  : string "                                        "
StoryScreen2Line8  : string "                                        "
StoryScreen2Line9  : string "                                        "
StoryScreen2Line10 : string "                                        "
StoryScreen2Line11 : string "                                        "
StoryScreen2Line12 : string "                                        "
StoryScreen2Line13 : string "                                        "
StoryScreen2Line14 : string "                                        "
StoryScreen2Line15 : string "                          / ]       / ] "
StoryScreen2Line16 : string "                          | |--///--| | "
StoryScreen2Line17 : string "                     / ]__| |       | |_"
StoryScreen2Line18 : string "                     | |  | |       | | "
StoryScreen2Line19 : string "                     | |  | |   )   | | "
StoryScreen2Line20 : string "                     | |  | |  )))  | | "
StoryScreen2Line21 : string "                          | |  )))  | | "
StoryScreen2Line22 : string "                              /  /      "
StoryScreen2Line23 : string "                         ____/  /       "
StoryScreen2Line24 : string "                        /   ___/        "
StoryScreen2Line25 : string "                _______/   /            "
StoryScreen2Line26 : string "               /     _____/             "
StoryScreen2Line27 : string "              /     /                   "
StoryScreen2Line28 : string "             /     /                    "
StoryScreen2Line29 : string "            /     /                     "


; Tela Inicial
StartScreen0Line0  : string "                                        "
StartScreen0Line1  : string "                                        "
StartScreen0Line2  : string "                                        "
StartScreen0Line3  : string "                                        "
StartScreen0Line4  : string "                                        "
StartScreen0Line5  : string "                                        "
StartScreen0Line6  : string "                                        "
StartScreen0Line7  : string "                                        "
StartScreen0Line8  : string "                                        "
StartScreen0Line9  : string "                                        "
StartScreen0Line10 : string "                                        "
StartScreen0Line11 : string "                                        "
StartScreen0Line12 : string "                                        "
StartScreen0Line13 : string "                                        "
StartScreen0Line14 : string "                                        "
StartScreen0Line15 : string "                                        "
StartScreen0Line16 : string "                                        "
StartScreen0Line17 : string "                                        "
StartScreen0Line18 : string "                                        "
StartScreen0Line19 : string "                                        "
StartScreen0Line20 : string "                                        "
StartScreen0Line21 : string "                                        "
StartScreen0Line22 : string "                                        "
StartScreen0Line23 : string "                                        "
StartScreen0Line24 : string "                                        "
StartScreen0Line25 : string "                                        "
StartScreen0Line26 : string "                                        "
StartScreen0Line27 : string "                                        "
StartScreen0Line28 : string "                                        "
StartScreen0Line29 : string "                                        "	


; Tela do menu
StartScreen1Line0  : string "                                        "
StartScreen1Line1  : string " ____     _ _   ___                     "
StartScreen1Line2  : string "|  __|_ _|_| | |  _|___ _ _ ___ ___ ___ "
StartScreen1Line3  : string "|  __| | | | | |__ | . | | | . |  _| -_|"
StartScreen1Line4  : string "|____|]_/|_|_| |___|_  |___|__,|_| |___|"
StartScreen1Line5  : string "                     |_|                "
StartScreen1Line6  : string "                                        "
StartScreen1Line7  : string "                                        "
StartScreen1Line8  : string "                                        "
StartScreen1Line9  : string "                                        "
StartScreen1Line10 : string "                                        "
StartScreen1Line11 : string "                                        "
StartScreen1Line12 : string "              |          |              "
StartScreen1Line13 : string "              |  O]  /O  |              " 
StartScreen1Line14 : string "              |          |              "
StartScreen1Line15 : string "              |    ^     |              "
StartScreen1Line16 : string "              |   ]__/   |              "
StartScreen1Line17 : string "       _______|          |_______       "
StartScreen1Line18 : string "      /       *----------*       ]      "
StartScreen1Line19 : string "     /                            ]     "
StartScreen1Line20 : string "    /                              ]    "
StartScreen1Line21 : string "   /|                              |]   "
StartScreen1Line22 : string "   ]|                              |/   "
StartScreen1Line23 : string "                                        "
StartScreen1Line24 : string "                                        "
StartScreen1Line25 : string "                                        "
StartScreen1Line26 : string "                                        "
StartScreen1Line27 : string "          Press ENTER to play           "
StartScreen1Line28 : string "________________________________________"
StartScreen1Line29 : string "                                        "

; Coroa em amarelo
StartScreen2Line0  : string "                                        "
StartScreen2Line1  : string "                                        "
StartScreen2Line2  : string "                                        "
StartScreen2Line3  : string "                                        "
StartScreen2Line4  : string "                                        "
StartScreen2Line5  : string "                                        "
StartScreen2Line6  : string "                                        "
StartScreen2Line7  : string "                                        "
StartScreen2Line8  : string "              )          )              "
StartScreen2Line9  : string "              ))   ))   ))              "
StartScreen2Line10 : string "              ))))))))))))              "
StartScreen2Line11 : string "              ((((((((((((              "
StartScreen2Line12 : string "                                        "
StartScreen2Line13 : string "                                        " 
StartScreen2Line14 : string "                                        "
StartScreen2Line15 : string "                                        "
StartScreen2Line16 : string "                                        "
StartScreen2Line17 : string "                                        "
StartScreen2Line18 : string "                                        "
StartScreen2Line19 : string "                                        "
StartScreen2Line20 : string "                                        "
StartScreen2Line21 : string "                                        "
StartScreen2Line22 : string "                                        "
StartScreen2Line23 : string "                                        "
StartScreen2Line24 : string "                                        "
StartScreen2Line25 : string "                                        "
StartScreen2Line26 : string "                                        "
StartScreen2Line27 : string "                                        "
StartScreen2Line28 : string "                                        "
StartScreen2Line29 : string "                                        "

; Tela Input Name
StartScreen3Line0  : string "                                        "
StartScreen3Line1  : string "                                        "
StartScreen3Line2  : string "                                        "
StartScreen3Line3  : string "                                        "
StartScreen3Line4  : string "                                        "
StartScreen3Line5  : string "                                        "
StartScreen3Line6  : string "                                        "
StartScreen3Line7  : string "                                        "
StartScreen3Line8  : string "                                        "
StartScreen3Line9  : string "                                        "
StartScreen3Line10 : string "                                        "
StartScreen3Line11 : string "                                        "
StartScreen3Line12 : string "                                        "
StartScreen3Line13 : string "                                        "
StartScreen3Line14 : string "                                        "
StartScreen3Line15 : string "                                        "
StartScreen3Line16 : string "                                        "
StartScreen3Line17 : string "                                        "
StartScreen3Line18 : string "                                        "
StartScreen3Line19 : string "                                        "
StartScreen3Line20 : string "     $((((((((((((((((((((((((((((&     "
StartScreen3Line21 : string "     %                            '     "
StartScreen3Line22 : string "     %                            '     "
StartScreen3Line23 : string "     %                            '     "
StartScreen3Line24 : string "     !############################+     "
StartScreen3Line25 : string "                                        "
StartScreen3Line26 : string "                                        "
StartScreen3Line27 : string "                                        "
StartScreen3Line28 : string "                                        "
StartScreen3Line29 : string "                                        "


; Tela de Level Up animation
LevelUpScreen0Line0  : string "                                        "
LevelUpScreen0Line1  : string "                                        "
LevelUpScreen0Line2  : string "                                        "
LevelUpScreen0Line3  : string "                                        "
LevelUpScreen0Line4  : string "                                        "
LevelUpScreen0Line5  : string "                                        "
LevelUpScreen0Line6  : string "                                        "
LevelUpScreen0Line7  : string "                                        "
LevelUpScreen0Line8  : string "                                        "
LevelUpScreen0Line9  : string "                                        "
LevelUpScreen0Line10 : string "                                        "
LevelUpScreen0Line11 : string "                                        "
LevelUpScreen0Line12 : string "                                        "
LevelUpScreen0Line13 : string "                                        "
LevelUpScreen0Line14 : string "                                        "
LevelUpScreen0Line15 : string "                                        "
LevelUpScreen0Line16 : string "                                        "
LevelUpScreen0Line17 : string "                                        "
LevelUpScreen0Line18 : string "                                        "
LevelUpScreen0Line19 : string "                                        "
LevelUpScreen0Line20 : string "                                        "
LevelUpScreen0Line21 : string "                                        "
LevelUpScreen0Line22 : string "                                        "
LevelUpScreen0Line23 : string "                                        "
LevelUpScreen0Line24 : string "                                        "
LevelUpScreen0Line25 : string "                                        "
LevelUpScreen0Line26 : string "                                        "
LevelUpScreen0Line27 : string "                                        "
LevelUpScreen0Line28 : string "                                        "
LevelUpScreen0Line29 : string "                                        "

; Tela do Level UP
LevelUpScreen1Line0  : string "                                        "
LevelUpScreen1Line1  : string "                                        "
LevelUpScreen1Line2  : string "              He is running             "
LevelUpScreen1Line3  : string "                                        "
LevelUpScreen1Line4  : string "                Catch him               "
LevelUpScreen1Line5  : string "                                        "
LevelUpScreen1Line6  : string "                                        "
LevelUpScreen1Line7  : string "                                        "
LevelUpScreen1Line8  : string "                                        "
LevelUpScreen1Line9  : string "                                        "
LevelUpScreen1Line10 : string "                                        "
LevelUpScreen1Line11 : string "                                        "
LevelUpScreen1Line12 : string "          /                   ]         " 
LevelUpScreen1Line13 : string "         |                     |        "
LevelUpScreen1Line14 : string "         |                     |        "
LevelUpScreen1Line15 : string "          ]   *-----------*   /         "
LevelUpScreen1Line16 : string "           ]  |           |  /          "
LevelUpScreen1Line17 : string "            ] |  O]   /O  | /           "
LevelUpScreen1Line18 : string "             ]|    ^      |/            "
LevelUpScreen1Line19 : string "              |   /--]    |             "
LevelUpScreen1Line20 : string "              |  /____]   |             "
LevelUpScreen1Line21 : string "              |           |             "
LevelUpScreen1Line22 : string "              *-----------*             "
LevelUpScreen1Line23 : string "                                        "
LevelUpScreen1Line24 : string "                                        "
LevelUpScreen1Line25 : string "                                        "
LevelUpScreen1Line26 : string "                                        "
LevelUpScreen1Line27 : string "                                        "
LevelUpScreen1Line28 : string "                                        "
LevelUpScreen1Line29 : string "                                        "

LevelUpScreen2Line0  : string "                                        "
LevelUpScreen2Line1  : string "                                        "
LevelUpScreen2Line2  : string "                                        "
LevelUpScreen2Line3  : string "                                        "
LevelUpScreen2Line4  : string "                                        "
LevelUpScreen2Line5  : string "                                        "
LevelUpScreen2Line6  : string "                                        "
LevelUpScreen2Line7  : string "                                        "
LevelUpScreen2Line8  : string "                                        "
LevelUpScreen2Line9  : string "                                        "
LevelUpScreen2Line10 : string "                                        "
LevelUpScreen2Line11 : string "              )           )             "
LevelUpScreen2Line12 : string "              ))   )))   ))             "
LevelUpScreen2Line13 : string "              )))))))))))))             "
LevelUpScreen2Line14 : string "              )))))))))))))             "
LevelUpScreen2Line15 : string "              (((((((((((((             "
LevelUpScreen2Line16 : string "                                        "
LevelUpScreen2Line17 : string "                                        "
LevelUpScreen2Line18 : string "                                        "
LevelUpScreen2Line19 : string "                                        "
LevelUpScreen2Line20 : string "                                        "
LevelUpScreen2Line21 : string "                                        "
LevelUpScreen2Line22 : string "                                        "
LevelUpScreen2Line23 : string "                                        "
LevelUpScreen2Line24 : string "                                        "
LevelUpScreen2Line25 : string "                                        "
LevelUpScreen2Line26 : string "                                        "
LevelUpScreen2Line27 : string "                                        "
LevelUpScreen2Line28 : string "                                        "
LevelUpScreen2Line29 : string "                                        "


; Tela de Win Game
WinGameScreen0Line0  : string "                                        "
WinGameScreen0Line1  : string "                                        "
WinGameScreen0Line2  : string "                                        "
WinGameScreen0Line3  : string "                                        "
WinGameScreen0Line4  : string "                                        "
WinGameScreen0Line5  : string "                                        "
WinGameScreen0Line6  : string "                                        "
WinGameScreen0Line7  : string "                                        "
WinGameScreen0Line8  : string "                                        "
WinGameScreen0Line9  : string "                                        "
WinGameScreen0Line10 : string "                                        "
WinGameScreen0Line11 : string "                                        "
WinGameScreen0Line12 : string "                                        "
WinGameScreen0Line13 : string "                                        "
WinGameScreen0Line14 : string "                                        "
WinGameScreen0Line15 : string "                                        "
WinGameScreen0Line16 : string "                                        "
WinGameScreen0Line17 : string "                                        "
WinGameScreen0Line18 : string "                                        "
WinGameScreen0Line19 : string "                                        "
WinGameScreen0Line20 : string "                                        "
WinGameScreen0Line21 : string "                                        "
WinGameScreen0Line22 : string "                                        "
WinGameScreen0Line23 : string "                                        "
WinGameScreen0Line24 : string "                                        "
WinGameScreen0Line25 : string "                                        "
WinGameScreen0Line26 : string "                                        "
WinGameScreen0Line27 : string "                                        "
WinGameScreen0Line28 : string "                                        "
WinGameScreen0Line29 : string "                                        "


WinGameScreen1Line0  : string "                                        "
WinGameScreen1Line1  : string "                                        "
WinGameScreen1Line2  : string "  Congratulations, you defeated me.     "
WinGameScreen1Line3  : string "                                        "
WinGameScreen1Line4  : string "  You were luck this time,              "
WinGameScreen1Line5  : string "                                        " 
WinGameScreen1Line6  : string "  but Im sure that                      "
WinGameScreen1Line7  : string "                                        "
WinGameScreen1Line8  : string "  next time will be different           "
WinGameScreen1Line9  : string "                                        "
WinGameScreen1Line10 : string "                                        "
WinGameScreen1Line11 : string "                                        "
WinGameScreen1Line12 : string "                                        "
WinGameScreen1Line13 : string "                                        "
WinGameScreen1Line14 : string "                                        "
WinGameScreen1Line15 : string "                                        "
WinGameScreen1Line16 : string "               /      *-----------*]    " 
WinGameScreen1Line17 : string "              |      /           /| |   "
WinGameScreen1Line18 : string "              |     /           / | |   " 
WinGameScreen1Line19 : string "               ]   *-----------*  |/    "
WinGameScreen1Line20 : string "                ]  |           |  /     "
WinGameScreen1Line21 : string "                 ] |  O]   /O  | /|     "
WinGameScreen1Line22 : string "                  ]|    ^      |/ |     "
WinGameScreen1Line23 : string "                   |   /--]    |  *     "
WinGameScreen1Line24 : string "                   |  /____]   | /      "
WinGameScreen1Line25 : string "                   |           |/       "
WinGameScreen1Line26 : string "                   *-----------*        "
WinGameScreen1Line27 : string "                                        "
WinGameScreen1Line28 : string "                                        "
WinGameScreen1Line29 : string "                                        "

WinGameScreen2Line0  : string "                                        "
WinGameScreen2Line1  : string "                                        "
WinGameScreen2Line2  : string "                                        "
WinGameScreen2Line3  : string "                                        "
WinGameScreen2Line4  : string "                                        "
WinGameScreen2Line5  : string "                                        "
WinGameScreen2Line6  : string "                                        "
WinGameScreen2Line7  : string "                                        "
WinGameScreen2Line8  : string "                                        "
WinGameScreen2Line9  : string "                                        "
WinGameScreen2Line10 : string "                                        "
WinGameScreen2Line11 : string "                                        "
WinGameScreen2Line12 : string "                                        "
WinGameScreen2Line13 : string "                                        "
WinGameScreen2Line14 : string "                                        "
WinGameScreen2Line15 : string "                                        "
WinGameScreen2Line16 : string "                                        " 
WinGameScreen2Line17 : string "                                        "
WinGameScreen2Line18 : string "                                        " 
WinGameScreen2Line19 : string "       )))) %                           "
WinGameScreen2Line20 : string "        ))) %                           "
WinGameScreen2Line21 : string "         )) %                           "
WinGameScreen2Line22 : string "        ))) %                           "
WinGameScreen2Line23 : string "        ))) %                           "
WinGameScreen2Line24 : string "         )) %                           "
WinGameScreen2Line25 : string "        ))) %                           "
WinGameScreen2Line26 : string "       )))) %                           "
WinGameScreen2Line27 : string "                                        "
WinGameScreen2Line28 : string "                                        "
WinGameScreen2Line29 : string "                                        "

WinGameScreen3Line0  : string "                  {                     "
WinGameScreen3Line1  : string "     {                       {          "
WinGameScreen3Line2  : string "                                        "
WinGameScreen3Line3  : string "                                       {"
WinGameScreen3Line4  : string "          {                             "
WinGameScreen3Line5  : string "                       {                "
WinGameScreen3Line6  : string "                              {         "
WinGameScreen3Line7  : string "                                        "
WinGameScreen3Line8  : string "                        {               "
WinGameScreen3Line9  : string "                                        "
WinGameScreen3Line10 : string "      {         {                   {   "
WinGameScreen3Line11 : string "                                        "
WinGameScreen3Line12 : string "                                {       "
WinGameScreen3Line13 : string "                                        "
WinGameScreen3Line14 : string "  {                                     "
WinGameScreen3Line15 : string "                                        "
WinGameScreen3Line16 : string "                                        " 
WinGameScreen3Line17 : string "       {                            {   "
WinGameScreen3Line18 : string "                       {                " 
WinGameScreen3Line19 : string " {                                      "
WinGameScreen3Line20 : string "                             {          "
WinGameScreen3Line21 : string "         {          {                   "
WinGameScreen3Line22 : string "                                        "
WinGameScreen3Line23 : string "                               {        "
WinGameScreen3Line24 : string "              {                         "
WinGameScreen3Line25 : string "                                        "
WinGameScreen3Line26 : string "    {                         {         "
WinGameScreen3Line27 : string "                                        "
WinGameScreen3Line28 : string "                   {                    "
WinGameScreen3Line29 : string "                                        "


; Tela Game Over
GameOverScreen0Line0  : string "                                        "
GameOverScreen0Line1  : string "                                        "
GameOverScreen0Line2  : string "                                        "
GameOverScreen0Line3  : string "                                        "
GameOverScreen0Line4  : string "                                        "
GameOverScreen0Line5  : string "                                        "
GameOverScreen0Line6  : string "                                        "
GameOverScreen0Line7  : string "                                        "
GameOverScreen0Line8  : string "                                        "
GameOverScreen0Line9  : string "                                        "
GameOverScreen0Line10 : string "                                        "
GameOverScreen0Line11 : string "                                        "
GameOverScreen0Line12 : string "                                        "
GameOverScreen0Line13 : string "                                        "
GameOverScreen0Line14 : string "                                        "
GameOverScreen0Line15 : string "                                        "
GameOverScreen0Line16 : string "                                        "
GameOverScreen0Line17 : string "                                        "
GameOverScreen0Line18 : string "                                        "
GameOverScreen0Line19 : string "                                        "
GameOverScreen0Line20 : string "                                        "
GameOverScreen0Line21 : string "                                        "
GameOverScreen0Line22 : string "                                        "
GameOverScreen0Line23 : string "                                        "
GameOverScreen0Line24 : string "                                        "
GameOverScreen0Line25 : string "                                        "
GameOverScreen0Line26 : string "                                        "
GameOverScreen0Line27 : string "                                        "
GameOverScreen0Line28 : string "                                        "
GameOverScreen0Line29 : string "                                        "	


; Desenha o chefão do mal
GameOverScreen1Line0  : string "                             |          "
GameOverScreen1Line1  : string "                             |          "
GameOverScreen1Line2  : string "                             |          "
GameOverScreen1Line3  : string "                             |          "
GameOverScreen1Line4  : string "       *-----------*         |          "
GameOverScreen1Line5  : string "      /           /|         |          "
GameOverScreen1Line6  : string "     /           / |         |          "
GameOverScreen1Line7  : string "    *-----------*  |      }  |   ~      "
GameOverScreen1Line8  : string "    |           |  |         |          " 
GameOverScreen1Line9  : string "    |  O]   /O  |  |  }      )    ~     "
GameOverScreen1Line10 : string "    |    ^      |  |      }        ~    "
GameOverScreen1Line11 : string "    |  ]-----/  |  *  }           ~     "
GameOverScreen1Line12 : string "    |   ]___/   | /                     "
GameOverScreen1Line13 : string "    |           |/                      "  
GameOverScreen1Line14 : string "    *-----------*                       "
GameOverScreen1Line15 : string "                                        "
GameOverScreen1Line16 : string "                                        "
GameOverScreen1Line17 : string "                                        "
GameOverScreen1Line18 : string "                                        "
GameOverScreen1Line19 : string "                                        "
GameOverScreen1Line20 : string "                                        "
GameOverScreen1Line21 : string "                                        " 
GameOverScreen1Line22 : string "                                        "
GameOverScreen1Line23 : string "                                        "
GameOverScreen1Line24 : string "                                        "
GameOverScreen1Line25 : string "                                        "
GameOverScreen1Line26 : string "                                        "
GameOverScreen1Line27 : string "                                        "
GameOverScreen1Line28 : string "  <y/n>                                 "
GameOverScreen1Line29 : string "                                        "


; Desenha frase perguntando se quer jogar novamente
GameOverScreen2Line0  : string "                                        "
GameOverScreen2Line1  : string "                                        "
GameOverScreen2Line2  : string "                                        "
GameOverScreen2Line3  : string "                                        "
GameOverScreen2Line4  : string "                                        "
GameOverScreen2Line5  : string "                                        "
GameOverScreen2Line6  : string "                                        "
GameOverScreen2Line7  : string "                                        " 
GameOverScreen2Line8  : string "                                        "
GameOverScreen2Line9  : string "                                        "
GameOverScreen2Line10 : string "                                        "
GameOverScreen2Line11 : string "                                        "
GameOverScreen2Line11 : string "                                        "  
GameOverScreen2Line12 : string "                                        "
GameOverScreen2Line13 : string "                                        "
GameOverScreen2Line14 : string "                                        "
GameOverScreen2Line15 : string "                                        "
GameOverScreen2Line16 : string "                                        "
GameOverScreen2Line17 : string "                                        "
GameOverScreen2Line18 : string "                                        "
GameOverScreen2Line19 : string "                                        " 
GameOverScreen2Line20 : string "                                        "
GameOverScreen2Line21 : string "                                        "
GameOverScreen2Line22 : string "  You have been captured by the king,   "
GameOverScreen2Line23 : string "                                        "
GameOverScreen2Line24 : string "  do you want to try to escape again?   "
GameOverScreen2Line25 : string "                                        "
GameOverScreen2Line26 : string "                                        "
GameOverScreen2Line27 : string "                                        "
GameOverScreen2Line28 : string "                                        "
GameOverScreen2Line29 : string "                                        "


; Tela End Game
EndGameScreen0Line0  : string "                                        "
EndGameScreen0Line1  : string "                                        "
EndGameScreen0Line2  : string "                                        "
EndGameScreen0Line3  : string "                                        "
EndGameScreen0Line4  : string "                                        "
EndGameScreen0Line5  : string "                                        "
EndGameScreen0Line6  : string "                                        "
EndGameScreen0Line7  : string "                                        "
EndGameScreen0Line8  : string "                                        "
EndGameScreen0Line9  : string "                                        "
EndGameScreen0Line10 : string "                                        "
EndGameScreen0Line11 : string "                                        "
EndGameScreen0Line12 : string "                                        "
EndGameScreen0Line13 : string "                                        "
EndGameScreen0Line14 : string "                                        "
EndGameScreen0Line15 : string "                                        "
EndGameScreen0Line16 : string "                                        "
EndGameScreen0Line17 : string "                                        "
EndGameScreen0Line18 : string "                                        "
EndGameScreen0Line19 : string "                                        "
EndGameScreen0Line20 : string "                                        "
EndGameScreen0Line21 : string "                                        "
EndGameScreen0Line22 : string "                                        "
EndGameScreen0Line23 : string "                                        "
EndGameScreen0Line24 : string "                                        "
EndGameScreen0Line25 : string "                                        "
EndGameScreen0Line26 : string "                                        "
EndGameScreen0Line27 : string "                                        "
EndGameScreen0Line28 : string "                                        "
EndGameScreen0Line29 : string "                                        "	


; Desenha o chefão do mal
EndGameScreen1Line0  : string "                                        "
EndGameScreen1Line1  : string "                                        "
EndGameScreen1Line2  : string "                                        "
EndGameScreen1Line3  : string "                                        "
EndGameScreen1Line4  : string "                                        "
EndGameScreen1Line5  : string "                                        "
EndGameScreen1Line6  : string "                                        "
EndGameScreen1Line7  : string "                                        "
EndGameScreen1Line8  : string "                                        "
EndGameScreen1Line9  : string "                                        "
EndGameScreen1Line10 : string "                                        "
EndGameScreen1Line11 : string "                                        "
EndGameScreen1Line12 : string "                                        "
EndGameScreen1Line13 : string "                         *-----------*  "
EndGameScreen1Line14 : string "                        /           /|  "
EndGameScreen1Line15 : string "                       /           / |  "
EndGameScreen1Line16 : string "                      *-----------*  |  "
EndGameScreen1Line17 : string "                      |           |  |  "
EndGameScreen1Line18 : string "       }              |  O]   /O  |  |  "
EndGameScreen1Line19 : string "           }          |    ^      |  |  "
EndGameScreen1Line20 : string "     }         }      |  ]-----/  |  *  "
EndGameScreen1Line21 : string "                      |   ]___/   | /   "
EndGameScreen1Line22 : string "    }          }      |           |/    "
EndGameScreen1Line23 : string "        }             *-----------*     "
EndGameScreen1Line24 : string "                                        "
EndGameScreen1Line25 : string "                                        "
EndGameScreen1Line26 : string "                                        "
EndGameScreen1Line27 : string "                                        "
EndGameScreen1Line28 : string "                                        "
EndGameScreen1Line29 : string "                                        "


; Desenha a frase de fracassado
EndGameScreen2Line0  : string "                                        "
EndGameScreen2Line1  : string "                                        "
EndGameScreen2Line2  : string "                                        "
EndGameScreen2Line3  : string "       You are weak.                    "
EndGameScreen2Line4  : string "                                        "
EndGameScreen2Line5  : string "       I knew you would gave up,        "
EndGameScreen2Line6  : string "                                        "
EndGameScreen2Line7  : string "                                        "
EndGameScreen2Line8  : string "                                        "
EndGameScreen2Line9  : string "                                        "
EndGameScreen2Line10 : string "                                        "
EndGameScreen2Line11 : string "                                        "
EndGameScreen2Line12 : string "                                        "
EndGameScreen2Line13 : string "                                        "
EndGameScreen2Line14 : string "                                        "
EndGameScreen2Line15 : string "                                        "
EndGameScreen2Line16 : string "                                        "
EndGameScreen2Line17 : string "                                        "
EndGameScreen2Line18 : string "                                        "
EndGameScreen2Line19 : string "                                        "
EndGameScreen2Line20 : string "                                        "
EndGameScreen2Line21 : string "                                        "
EndGameScreen2Line22 : string "                                        "
EndGameScreen2Line23 : string "                                        "
EndGameScreen2Line24 : string "                                        "
EndGameScreen2Line25 : string "                                        "
EndGameScreen2Line26 : string "                                        "
EndGameScreen2Line27 : string "                                        "
EndGameScreen2Line28 : string "                                        "
EndGameScreen2Line29 : string "                                        "