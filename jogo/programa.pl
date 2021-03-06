%
%	FELIPE DIAS MENDES 16.2.8275
%	MAYCON MÜLLER 	   16.2.8511
%
%Start
%inicio(X,Y, Matrix, MatrixResultados).
%inicio(X,Y, Matrix, Resultado) :- procuraLista(X, Matrix, Linha),
%							subtrai(Y, Linha, Resultado), 
%    						imprimeLista(Resultado).

%AREA DE FUNÇÕES QUE FUNCIONAM ----------------------------------------------
%Inicio 
	inicio(X, Y, M):- procuraLista(X, M, Linha),
								subtrai(Y, Linha, E), 
								imprimeLista(E).

%%Retorna os vizinhos(X,Y) de  em uma lista
	elementosVizinhos(X,Y, M, [S,I,D,E]) :- elementoSuperior(X,Y,M,S), 
											elementoInferior(X,Y,M,I),
											elementoDireita(X,Y,M,D),
											elementoEsquerda(X,Y,M,E).

	elementoSuperior(X,Y,M,Elemento) :- N is X-1,
									procuraMatrix(N,Y,M,Elemento).
	elementoInferior(X,Y,M,Elemento)  :- N is X+1,
									procuraMatrix(N,Y,M,Elemento).
	elementoDireita(X,Y,M,Elemento) :- N is Y+1,
									procuraMatrix(X,N,M,Elemento).
	elementoEsquerda(X,Y,M,Elemento) :- N is Y-1,
									procuraMatrix(X,N,M,Elemento).

%Verifica o fim do jogo
	fim(X, Y, M):- elementosVizinhos(X,Y, M, Vizinhos), 
					verificaFim(Vizinhos).

	verificaFim([]).
	verificaFim([X|Xs]):- X =:= -1, 
						verificaFim(Xs).

%Aula 24/05
	procuraLista(0, [X|_], X). %Indice encontrado
	procuraLista(I, [_X|Xs], E):- K is I-1, 
								procuraLista(K, Xs, E). % Decremento do Index e chamada recursiva

%Subtrai -1 de um index
	subtrai(-1, Xs, Xs).
	subtrai(0, [X|Xs], [R|Ys]):- R is X-1, 
								subtrai(-1, Xs, Ys).
	subtrai(I, [X|Xs], [X|Ys]):-  K is I-1, 
								subtrai(K, Xs, Ys).

%Imprime toda Matriz
	imprimeLista([]).
	imprimeLista([X | Y]) :- write(X), 
							nl,
							imprimeLista(Y).

%Função que subtrai 1 de todas as posições de uma matriz ####################
	neo([], []).
	neo([X|Xs], [Y, Ys]) :- smith(X, Y), 
							neo(Xs, Ys).

	smith([], []).
	smith([X|Xs], [Y|Ys]):- Y is X-1,
	 					smith(Xs, Ys).

%AREA DE FUNÇÕES QUE FUNCIONAM ----------------------------------------------

%AREA DE FUNÇÕES EM TESTES  ------------------------------------------------

/*

inicio(X,Y, M):-procuraMatrix(X,Y, M, E), K is Y+1,
       (E =:= 10-> write(chamaUmaFunção); procuraMatrix(X,K,M,P),
       	write(P) ).

%Função que retorna um elemento de uma lista no index I #####################
procuraLista(0, [X|_], E).
procuraLista(I, [X|Xs], E):- K is I-1,
							procuraLista(K, Xs, E).

%Função que retorna um elemento de uma Matriz no index I ####################
procuraMatrix(X, Y, M, E):- procuraLista(X, M, Linha),
							procuraLista(Y, Linha, E). 


%Função de jogada ##########################################################
jogada(c(X,Y), Matrix1, c(X,Y), Matrix2):- 

%Função que movimenta na Matrix ############################################
%Ir pra Direita
move(c(X,Y), c(Z,W)):- Y < ColunaM, W is Y+1, Z=:=X.
%Ir pra Esquerda
move(c(X,Y), c(Z,W)):- Y > ColunaM, W is Y-1, Z=:=X.
%Ir pra Baixo
move(c(X,Y), c(Z,W)):- X < LinhaM, Z is X+1, W=:=Y.
%Ir pra Cima
move(c(X,Y), c(Z,W)):- X > LinhaM, Z is X-1, W=:=Y.


%AREA DE FUNÇÕES EM TESTES  ------------------------------------------------


pertence(X , [X|_]).
pertence(X, [_|Y]):- pertence(X,Y).


ultimo(X,[X]).
ultimo(X, [_|Z]):- ultimo(X,Z).

%impressão de uma lista qualquer
%imprime a cabeça em seguida um new line

imprimeLista([]).
imprimeLista([X | Y]) :-
write(X), nl, imprimeLista(Y).

%não funciona
subtrair([]).
subtrair([X | Y]) :- X is X - 1,
write(X), nl, subtrair(Y).

%Função que pensei de subtrair
sub([],0).
sub([X], A):- A is X-1.
sub([X | Xs], A) :- sub(X, ??), sub(Xs, ??). % Não o que eu passo em -> ??

%exemplo matriz 3*3 ex no swi
%imprimeLista([[1,2,3],[4,5,6],[7,8,9]]).

% ALGUMAS FUNÇÕES DE LISTAS

cons(X,Y,[X|Y]).		%  Constroi (ou decompõe) uma lista.

membro(X,[X|_]).   		%  X é membro de uma lista se X é a 
membro(X,[_|Y]):-		%  cabeça da lista.  Ou então se X é
	membro(X,Y).	%  membro do corpo da lista.

conc([],L,L).      		%  A lista vazia concatenada com qualquer lista resulta
conc([X|L1],L2,[X|L3]):-	%  nesta propria lista.  A concatenação de duas listas
	conc(L1,L2,L3).   	%  não vazias é a cabeça da primeira lista seguida da
			%  concatenação de seu corpo com a segunda lista.
membro1(X,L):-
	conc(_,[X|_],L).	%  membro/2 em função de conc/3.
	
remover(X,[X|C],C).	%  É possível remover um elemento X de uma lista onde
remover(X,[Y|C],[Y|D]):-	%  X é a cabeça.  Se X não é a cabeça da lista, então
	remover(X,C,D).   	%  X deve ser removido do corpo da lista.

inserir(X,L,L1):-		%  inserir/3 em função de remover/3.
	remover(X,L1,L).	%  A inserção é sempre feita na cabeça de L.

membro2(X,L):-     		%  membro/2 em função de remover/3.
	remover(X,L,_).	

inverter([],[]).		%  A inversão de uma lista vazia é a prória lista vazia.
inverter([X|Y],Z):-		%  A inversão de uma lista não-vazia é a inversão de seu
	inverter(Y,Y1),    	%  corpo e a concatenação deste corpo invertido com a
	conc(Y1,[X],Z).    	%  cabeça da lista original.

invert(X,Y):-            		%  invert/2 é uma variante mais eficiente do predicado
	inv([],X,Y).       	%  inverter/2.  Este apresenta complexidade quadrática,
inv(L,[],L).             		%  enquanto que invert/2 possui complexidade linear.
inv(L,[X|Y],Z):-         	%  Esta maior eficiência é obtida com o uso do predicado
	inv([X|L],Y,Z).     	%  auxiliar inv/3.

%%% SUBLISTA Creio que seja importante!!!!!!!!!!!!!!
sublista(S,L):-           	%  S é sublista de L se L pode ser decomposta em duas
	conc(_,L1,L),     	%  listas, uma das quais é L1, e L1 pode ser decomposta
     	conc(S,_,L1).       	%  em outras duas listas, uma das quais é S.

tamanho([],0).           	%  O tamanho de uma lista vazia é zero.  O tamanho de
tamanho([_|R],N):-		%  uma lista não-vazia é obtido acrescentando-se uma
	tamanho(R,N1),     	%  unidade ao tamanho de seu corpo.
	N is N1 + 1.
*/