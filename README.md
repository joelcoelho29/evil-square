Esse projeto foi desenvolvido para a disciplina de Organização de Computadores

# **Funções Evil Square**
## 1) **Inicialização**

> ### **Main** <br> 
> Responsável pela inicialização de variáveis estáticas e chamada das funções principais. 

> ### **Menu** <br>
> Responsável pela primeira interação com o usuário, requisitando o nome.

> ### **Inicialização de variáveis** <br>
> Responsável pela inicialização de váriáveis a cada chamada de level.

---

## 2) **Lógica principal do jogo**
> ### **Level Up** <br> 
> Responsável pela verificação e chamada dos níveis.

> ### **Movimentação do Good Square** <br> 
> Responsável pela movimentação do Good Square. <br> 
> > Critério de parada:
> - Verificação com a linha de chegada;

> ### **Movimentação dos Evil's Squares** <br> 
> Responsável pela movimentação do Evil Square. <br> 
> > Critério de parada:
> - Verificação de colisão com o Good Square;
<br>
> > Cálculo de movimentação:
> - Movimenta-se na vertical, horizontal ou diagonais.
> - Verificação da posição de acordo com as coordenadas (x, y) do Good Square:
>   - Verificação da linha (Y);
>   - Verificação da coluna (X);

> ### **Game Over** <br> 
> Responsável pela impressão da tela de Game Over, perguntando se o usuário deseja jogar novamente.<br> 
> > Opção 1 (jogar novamente):
> - Volta para a função main;
> > Opção 2 (sair do jogo):
> - Chama a função EndGame;

> ### **End Game** <br> 
> Responsável por exibir as estatísticas da partida.<br> 

---

## **Observações de implementação:**

> ### **Delay** <br> 
> Tal função é responsável por fazer a interação entre o usuário e o jogo. Entretanto, é importante ressaltar que os valores implementados podem variar de ambiente para ambiente.  
> É provável que em sua máquina o jogo não rode corretamente, uma vez que os clocks do seu processador podem rodar em uma frequência superior (ou inferior)  à implementada. <br>
> Logo, é necessário adequá-la para seu computador. <br>
> Para isso, altere a seguinte linha de código:

/SquareZero.asm
<code>

    loadn r1, #2000
	
    Delay_volta2:
	    loadn r0, #3000
</code>

> - Quanto maior o valor, mais devagar as movimentações.

---
