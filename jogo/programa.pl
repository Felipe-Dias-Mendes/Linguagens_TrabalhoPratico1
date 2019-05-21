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
