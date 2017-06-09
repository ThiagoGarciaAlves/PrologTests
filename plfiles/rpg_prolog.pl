/* Faculdade de Tecnologia de São Paulo */

/* Disciplina: Programação em Lógica */
/* Prof. Dr. Silvio do Lago Pereira */

/* Aluno: Thiago Garcia Alves (RA: 16213851) */

/* RPG Prolog */

/* Digite "start" para iniciar */

:- dynamic currently_in/1, at/2, holding/1, my_strength_is/1, in_battle/1, current_enemy_total_health/1, current_enemy_current_health/1, current_enemy_strength/1, total_health/1, health/1, enemy_name/1, potions/1, current_enemy_bonus/1.

:- retractall(in(_, _)), retractall(currently_in(_)), retractall(holding(_)), retractall(in_battle(_)), retractall(my_strength_is(_)), retractall(current_enemy_total_health(_)), retractall(current_enemy_current_health(_)), retractall(current_enemy_strength(_)), retractall(total_health(_)), retractall(health(_)), retractall(enemy_name(_)), retractall(potions(_)), retractall(current_enemy_bonus(_)).

currently_in(room_f1_a).

in_battle(no).

total_health(10).
health(10).
my_strength_is(5).
potions(3).

enemy_name(nada).
current_enemy_total_health(1).
current_enemy_current_health(1).
current_enemy_strength(1).
current_enemy_bonus(1).

/* 1º andar */
path(room_f1_a, n, room_f2_a).

/* 2º andar */
path(room_f2_a, s, room_f2_b).
path(room_f2_b, n, room_f2_a).
path(room_f2_b, e, room_f2_c).
path(room_f2_c, w, room_f2_b).
path(room_f2_c, s, room_f2_d).
path(room_f2_d, n, room_f2_c).
path(room_f2_d, w, room_f2_e).
path(room_f2_e, e, room_f2_d).
path(room_f2_d, s, room_f2_f).
path(room_f2_f, n, room_f2_d).
path(room_f2_d, e, room_f2_g).
path(room_f2_g, w, room_f2_d).
path(room_f2_g, n, room_f2_h).
path(room_f2_h, s, room_f2_g).
path(room_f2_h, n, room_f2_i).
path(room_f2_i, s, room_f2_h).
path(room_f2_i, n, room_f2_boss).

/* Onde está a chave... */
in(key, room_f2_e).

/* Descrição das salas */
inspect(room_f1_a) :- write('Você está caminhando pela floresta, quando se depara com uma igreja abandonada ao norte.'), nl, write('Nenhuma estrada leva para lá, apenas esse caminho.').

inspect(room_f2_a) :- write('Você entra na igreja.'), nl, nl, write('Uma camada de poeira cobre toda a superficie. Pequenas e horríveis estátuas espalhadas ao redor do salão, olhando para o centro, onde você está, debaixo de um feixe de luz.'), nl, nl, write('De repente, ...uma rachadura? Outra rachadura?? O chão!'), nl, nl, write('Você alcança as tábuas do chão enquanto você é sugado para o poço abaixo. Plumas de poeira sobem da escuridão.'), nl, nl, write('Você se levanta em um grande e vazio quarto, com somente uma direção para ir, uma caverna que leva para baixo... (sul)').

inspect(room_f2_b) :- write('O caminho dobra de norte para leste.'),nl.
inspect(room_f2_c) :- write('O caminho dobra de oeste para sul.'),nl.
inspect(room_f2_d) :- write('Você chega em uma bifurcação. Você pode ir para oeste, sul, leste, ou retornar para o norte.'),nl.
inspect(room_f2_e) :- write('Você está em um beco sem saída. Você pode voltar para o leste.'),nl.
inspect(room_f2_f) :- write('Este é um beco sem saída. Você pode voltar para o norte.'),nl.
inspect(room_f2_g) :- write('O caminho dobra de oeste para norte.'),nl.
inspect(room_f2_h) :- write('O caminho continua do sul para o norte.'),nl.
inspect(room_f2_i) :- write('Há uma porta de metal ao norte. Ela está trancada. Você precisa da chave para passar.'),nl.
inspect(room_f2_boss) :- write('AHH! UM DRAGÃO! Hora de salvar o mundo...'),nl.



/* COMEÇA AQUI */
/* COMEÇA AQUI */
/* COMEÇA AQUI */
start :-
	clrs,
	look,
	menu.

/* Esta regra diz como funciona o look. */
look :-
	in_battle(no),!,
	nl,
	currently_in(Place),
    inspect(Place),
    nl,
    find_objects_at(Place),
    nl.
look :-
	in_battle(yes),!,
    write('Você não pode fazer isso em batalha.'),
    nl.

olhar :- look.

i :-
	in_battle(no),
	holding(HeldItem),
	nl,write('Segurando :'),write(HeldItem),nl,nl.
i :-
	nl,write('Segurando : --nada--'),nl,nl.



/* Essas regras estabelecem uma repetição para mencionar todos os objetos em sua vizinhança. */

find_objects_at(Place) :-
    in(X, Place),
	nl,
    write('Oh, veja! Um(a) '), write(X), write('!'), nl, !.

find_objects_at(_) :-
	nl,
	write('Não tem nada aqui.'), nl.


/* MENU */
menu :-
	my_strength_is(Str),
	potions(Potions),
	holding(Stuff),
	menuGui,
	total_health(THealth),
	health(CHealth),
	write('Vida:   '), write(CHealth), write('/'), write(THealth),nl,
	write('Força: '), write(Str), nl,
	write('Poções:  '), write(Potions), nl,
	write('Mochila: '), write(Stuff), !.
  
menu :-
	my_strength_is(Str),
	potions(Potions),
	menuGui,
	total_health(THealth),
	health(CHealth),
	write('Vida:   '), write(CHealth), write('/'), write(THealth),nl,
	write('Força: '), write(Str),nl,
	write('Poções:  '), write(Potions), nl,
	write('Mochila: --nada--').
  
m :- menu.  
  
menuGui :-
	nl,
	write('___________________________________'),nl,
	write('         *Digite sua ação*         '),nl,
	write('___________________________________'),nl,
	write('olhar.'),nl,
	write('pegar(item).'),nl,
	write('soltar(item).'),nl,
	write('poção. -ou- p.'),nl,
  	write('menu. -ou- m.'),nl,
	write('sair.'),nl,
	write(' ____________________________ '),nl,
	write('|                            |'),nl,
	write('|          (n)orte           |'),nl,
	write('|      (o)este  (l)este      |'),nl,
	write('|          (s)ul             |'),nl,
	write('|                            |'),nl,
	write('=============================='),nl.

fight :-
	retract(in_battle(_)),
	assert(in_battle(yes)),
	my_strength_is(Str),
	potions(Potions),
	total_health(THealth),
	health(CHealth),
	enemy_name(EName),
	current_enemy_current_health(ECHealth),
	current_enemy_total_health(ETHealth),
	current_enemy_strength(EStrength),
	fightGui,
	write(' *VOCÊ*'),nl,
	write('Vida:   '), write(CHealth), write('/'), write(THealth),nl,
	write('Força: '), write(Str), nl,
	write('Poções:  '), write(Potions),nl,
	nl,
	write('*'), write(EName), write('*'),nl,
	write('Vida:   '), write(ECHealth), write('/'), write(ETHealth),nl,
	write('Força: '), write(EStrength),nl,!.

fightGui :-
	nl,
	write('  |  BATALHA'),nl,
	write('EE|==========>'),nl,
	write('  |'),nl,
	write('			'),nl,
	write('(a)taque.'),nl,
	write('(p)oção.'),nl,
	write('(c)orrer.'),nl,
	write('			'),nl,
	write('  |'),nl,
	write('EE|==========>'),nl,
	write('  |  BATALHA'),nl, nl.


/* Limpa a tela (adiciona 50 linhas) */
clrs :- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
		nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
		nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
		nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
		nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

/* SAIR */
sair :- halt.

/* Essas regras dizem como pegar um item. */
pegar(X) :-
    in_battle(no),
	holding(X),
    write('Você já está segurando isso!'),
    !, nl.

pegar(X) :-
	in_battle(no),
    currently_in(Place),
    in(X, Place),
    retract(in(X, Place)),
    assert(holding(X)),
    write('Pegou.'),
    !, nl.

pegar(_) :-
	in_battle(no),!,
    write('Não há nada aqui.'),
    nl.

pegar(_) :-
	in_battle(yes),!,
    write('Você não pode fazer isso em batalha.'),
    nl.



/* Essas regras dizem como soltar um item. */

soltar(X) :-
	in_battle(no),
	holding(X),
	currently_in(Place),
	retract(holding(X)),
	assert(in(X, Place)),
	write('Soltou.'),
	!, nl.

soltar(_) :-
	in_battle(no),!,
	write('Você não está com isso!'),
	nl.

soltar(_) :-
	in_battle(yes),!,
	write('Você não pode fazer isso em batalha.'),
	nl.


/* Essas regras definem as direções. */
/* Norte */
north :-
	in_battle(no),!,
	go(n).
north :-
	in_battle(yes),!,
        write('Você não pode fazer isso em batalha.'),
        nl.
n :- north.

/* Sul */
south :-
	in_battle(no),!,
	go(s).
south :-
	in_battle(yes),!,
        write('Você não pode fazer isso em batalha.'),
        nl.
s :- south.

/* Leste */
east :-
	in_battle(no),!,
	go(e).
east :-
	in_battle(yes),!,
        write('Você não pode fazer isso em batalha.'),
        nl.
l :- east.

/* Oeste */
west :-
	in_battle(no),!,
	go(w).
west :-
	in_battle(yes),!,
        write('Você não pode fazer isso em batalha.'),
        nl.
o :- west.


/* Regras sobre lugares */

/* Entrando na sala do mestre com a chave */
go(n) :-
	currently_in(room_f2_i),
	holding(key),
	path(Here, Direction, room_f2_boss),
	retract(currently_in(Here)),
	assert(currently_in(room_f2_boss)),

	/* Cria inimigo (Mestre) */
	retract(current_enemy_total_health(_)),
	assert(current_enemy_total_health(50)),
	retract(current_enemy_current_health(_)),
	assert(current_enemy_current_health(50)),
	retract(current_enemy_strength(_)),
	assert(current_enemy_strength(10)),
	retract(enemy_name(_)),
	assert(enemy_name(dragon)),
	retract(current_enemy_bonus(_)),
	assert(current_enemy_bonus(9)),

	!, nl, clrs, write('[Você foi para *'), write(Direction), write('*.]'), nl,
	look,
	nl, write('Um Imenso Dragão Ataca! AHHH!!!'),nl,
	fight.

/* Não tem a chave da sala do mestre */
go(n) :-
	currently_in(room_f2_i),
	!, nl, write('Você precisa de uma chave para abrir a porta.').

/* Primeiro Monstro - Fácil */
go(Direction) :-
	currently_in(Here),
	path(Here, Direction, room_f2_b),
	retract(currently_in(Here)),
	assert(currently_in(room_f2_b)),

	/* Cria inimigo (Fácil) */
	retract(current_enemy_total_health(_)),
	assert(current_enemy_total_health(7)),
	retract(current_enemy_current_health(_)),
	assert(current_enemy_current_health(7)),
	retract(current_enemy_strength(_)),
	assert(current_enemy_strength(1)),
	retract(enemy_name(_)),
	assert(enemy_name(goblin)),
	retract(current_enemy_bonus(_)),
	assert(current_enemy_bonus(1)),


	!, nl, clrs, write('[Você foi para *'), write(Direction), write('*.]'), nl,
	look,
	nl, write('Um Goblin Ataca!'),nl,
	fight.

/* Segundo Monstro - Fácil */
go(Direction) :-
	currently_in(Here),
	path(Here, Direction, room_f2_d),
	retract(currently_in(Here)),
	assert(currently_in(room_f2_d)),

	/* Set Enemy (Easy) */
	retract(current_enemy_total_health(_)),
	assert(current_enemy_total_health(9)),
	retract(current_enemy_current_health(_)),
	assert(current_enemy_current_health(9)),
	retract(current_enemy_strength(_)),
	assert(current_enemy_strength(2)),
	retract(enemy_name(_)),
	assert(enemy_name(goblin)),
	retract(current_enemy_bonus(_)),
	assert(current_enemy_bonus(1)),

    !, nl, clrs, write('[Você foi para  *'),write(Direction), write('*.]'), nl,
	look,
	nl, write('Um Goblin Ataca!'),nl,
	fight.

/* Third Monster - Hard */
go(Direction) :-
	currently_in(Here),
	path(Here, Direction, room_f2_g),
	retract(currently_in(Here)),
	assert(currently_in(room_f2_g)),

	/* Set Enemy (Easy) */
	retract(current_enemy_total_health(_)),
	assert(current_enemy_total_health(21)),
	retract(current_enemy_current_health(_)),
	assert(current_enemy_current_health(21)),
	retract(current_enemy_strength(_)),
	assert(current_enemy_strength(4)),
	retract(enemy_name(_)),
	assert(enemy_name(ghoul)),
	retract(current_enemy_bonus(_)),
	assert(current_enemy_bonus(3)),

    !, nl, clrs, write('[Você foi para  *'),write(Direction), write('*.]'), nl,
	look,
	nl, write('Um Ghoul Ataca!'),nl,
	fight.

go(Direction) :-
        currently_in(Here),
        path(Here, Direction, There),
        retract(currently_in(Here)),
        assert(currently_in(There)),
        !, nl, clrs, write('[Você foi para  *'),write(Direction), write('*.]'), nl, look, menu.

go(_) :-
    write('Você não pode ir por esse caminho.').


/* COMANDOS DE BATALHA */

/* CORRER */
run :-
	in_battle(yes),!,
	retract(in_battle(yes)),
	assert(in_battle(no)),
	clrs,
	write('Você correu da batalha.'),nl,
	look,
	menu.
run :-
	in_battle(no),!,
	write('Você só pode fazer isso em batalha.'),nl.
c :- run.

/* ATACAR */
attack :-
	in_battle(yes),!,
	current_enemy_current_health(CECHealth),
	my_strength_is(MyStrength),
	TempEnemyHealth is CECHealth - MyStrength,
	(TempEnemyHealth > 0 ->
	retract(current_enemy_current_health(_)),
	assert(current_enemy_current_health(TempEnemyHealth)),
	nl,
	nl,
	enemy_attack,
	nl,
	write('Você causou '), write(MyStrength), write(' de dano.'), nl,
	nl,nl
	;
	enemy_die,
	true).
attack :-
	in_battle(no),!,
	write('Você só pode fazer isso em batalha.'),nl.
a :- attack.

/* Potion */
potion :-
	potions(0),
	write('Você não tem nenhuma poção.'),nl.

potion :-
	health(CHealth),
	total_health(THealth),
	CHealth =:= THealth,
	write('Você está com a vida completa.'),nl,!.

potion :-
	in_battle(no),!,

	/* Subtract a potion */
	potions(Potions),
	TempPotions is Potions - 1,
	retract(potions(Potions)),
	assert(potions(TempPotions)),

	/* Add 10 health */
	health(CHealth),
	total_health(THealth),
	TempHealth is CHealth + 10,
	(   TempHealth > THealth ->
	retract(health(CHealth)),
	    assert(health(THealth)),
	    true,
	    clrs,
	    look,
	    menu,nl,nl,
	    write('Você tomou uma poção e completou sua vida.'),nl,nl
	;
	retract(health(CHealth)),
	    assert(health(TempHealth)),
	    true,
	    clrs,
	    look,
	    menu,nl,nl,
	    write('Você tomou uma poção e ganhou 10 de vida.'),nl,nl
	).

potion :-
	in_battle(yes),!,

	/* Subtract a potion */
	potions(Potions),
	TempPotions is Potions - 1,
	retract(potions(Potions)),
	assert(potions(TempPotions)),

	/* Add 10 health */
	health(CHealth),
	total_health(THealth),
	TempHealth is CHealth + 10,
	(   TempHealth > THealth ->
	    retract(health(CHealth)),
	    assert(health(THealth)),
	    nl,
	    enemy_attack,
            nl,
	    write('Você tomou uma poção e completou sua vida.'),nl,nl,
	    nl,nl
	;
	    retract(health(CHealth)),
	    assert(health(TempHealth)),
	    nl,
	    enemy_attack,
	    nl,
            write('Você tomou uma poção e ganhou 10 de vida.'),nl,nl,
	    nl,nl,
	    true
	).
p :- potion.
poção :- potion.

/* Enemy Attack */
enemy_attack :-
	health(CHealth),
	enemy_name(EName),
	current_enemy_strength(EStrength),
	TempHealth is CHealth - EStrength,
	(   TempHealth > 0 ->
	    retract(health(_)),
	    assert(health(TempHealth)),
	    clrs,
	    fight,
	    nl,
	    write(EName), write(' atacou e causou '), write(EStrength),
	    write(' de dano.'), nl
	;
	die, true).

enemy_die :-
	current_enemy_bonus(9),!,
	clrs,
	write('O Dragão foi derrotado!'),nl,
	write('A cidade foi salva!'),nl,
	nl,
	write('Obrigado por jogar. Fim.'),nl,
	nl,
	write('Creditos: Thiago G. Alves').

enemy_die :-
	total_health(THealth),
	my_strength_is(Strength),
	potions(Pots),

	enemy_name(EName),
	current_enemy_bonus(CEBonus),

	HealthBonus is CEBonus * 2,
	StrengthBonus is CEBonus,
	PotionBonus is CEBonus,

	NewTotalHealth is THealth + HealthBonus,
	NewStrength is Strength + StrengthBonus,
	NewPotions is Pots + PotionBonus,

	retract(in_battle(_)),
	assert(in_battle(no)),

	retract(total_health(_)),
	assert(total_health(NewTotalHealth)),

	retract(my_strength_is(_)),
	assert(my_strength_is(NewStrength)),

	retract(potions(_)),
	assert(potions(NewPotions)),

	clrs,
	look,
	menu,

	nl,nl,
	write('Você matou o '),write(EName),write('!'),nl,nl,
	write('Você ganhou :'),nl,
	write(HealthBonus),write(' de vida'),nl,
	write(StrengthBonus),write(' de força'),nl,
	write(PotionBonus),write(' poção(ões)'),nl,nl.

die :-
	clrs,
	write('Você MORREU!. Reinicie o jogo e tente novamente.'),nl,nl,
	write('    ___o .--.   '),nl,
	write('   /___| |OO|   '),nl,
	write('  /\'   |_|  |_  '),nl,
	write('       (_    _) '),nl,
	write('       | |   \\  '),nl,
	write('       | |oo_/  '),nl, !, fail.

























