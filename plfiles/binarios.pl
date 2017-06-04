% binarios.pl
% digitos binarios

digito(0).
digito(1).

% restrições para a solução

binarios(N) :-
  N = (A, B, C),
  digito(A),
  digito(B),
  digito(C).