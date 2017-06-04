% rotas.pl
%
% Problema: gerar todas as rotas que levam de um aeroporto X a outro Y, até encontrar uma de comprimento M.

% vôos

	vôo(1,a,b). 
	vôo(2,b,c).
	vôo(3,b,d). 
	vôo(4,b,e).
	vôo(5,c,a). 
	vôo(6,d,c).
	vôo(7,d,e). 
	vôo(8,e,b).

% rota

	rota(X,X,[]).
	rota(X,Y,[N|R]) :-
		vôo(N,X,Z),
		rota(Z,Y,R).

% rotas

	rotas(X,Y,M) :-
		length(R,N),
		rota(X,Y,R),
		writeln(R),
		N=M, !.