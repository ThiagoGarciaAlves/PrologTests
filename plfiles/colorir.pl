% colorir.pl - colore um mapa usando no máximo quatro cores
% cores disponíveis disponíveis

  cor(azul).
  cor(verde).
  cor(amarelo).
  cor(vermelho).

% restrições restrições para a solução solução

  coloracao(A,B,C,D,E) :-
    cor(A), cor(B), cor(C), cor(D), cor(E),
    A\=B, A\=C, A\=D, B\=C, B\=E, C\=D, C\=E, D\=E.
