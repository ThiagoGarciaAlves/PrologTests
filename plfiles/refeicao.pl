% refeicao.pl
% Quais são todas as possíveis refeições completas que podem ser formadas?

entrada(salada).
entrada(pao).

prato(peixe).
prato(carne).
prato(massa).

sobremesa(sorvete).
sobremesa(pudim).

refeicao(R) :-
	R = (A, B, C),
	entrada(A),
	prato(B),
	sobremesa(C).

refeicoes() :-
	writeln(""),
	writeln("TODAS AS REFEICOES POSSIVEIS:"),
	writeln(""),
	forall(refeicao(R), writeln(R)),
	writeln("").