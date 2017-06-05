% namora.pl

gosta(ary,eva).
gosta(ivo,ana).
gosta(ivo,eva).
gosta(eva,ary).
gosta(ana,ary).

namora(A,B) :-
	gosta(A,B),
	gosta(B,A).