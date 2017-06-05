% tabela.pl - exibe tabelas-verdade

% conectivos lógicos
:- op(900,fy, '~'). 	% não
:- op(901,yfx,'&'). 	% e
:- op(902,yfx,'^'). 	% ou
:- op(903,yfx,'->'). 	% então

% valor de uma fórmula
val(f ,f).
val(v ,v).
val(~P ,f) :- val(P,v).
val(~P ,v) :- val(P,f).
val(P&Q ,f) :- val(P,f); val(Q,f).
val(P&Q ,v) :- val(P,v), val(Q,v).
val(P^Q ,f) :- val(P,f), val(Q,f).
val(P^Q ,v) :- val(P,v); val(Q,v).
val(P->Q,f) :- val(P,v), val(Q,f).
val(P->Q,v) :- val(P,f); val(Q,v).

% cria uma interpretação
interp([]).
interp([f^I]) :- interp(I).
interp([v^I]) :- interp(I).

% exibe a tabela-verdade para uma fórmula F
tabela(F) :-
	free_variables(F,I),
	forall(
		interp(I), 
		(
			val(F,R),
			format('~n ~w : ~w : ~w',[I,F,R])
		)
	).