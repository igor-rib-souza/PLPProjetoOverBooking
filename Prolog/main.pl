:- (initialization main).
:- include('mensagens.pl').
:- include('Funcionario.pl').

main :-
    writeln("\n--------------------Seja bem vindo ao sistema OVERBOOKING!--------------------\n"),
    menuPrincipal,
    read(Opcao),
    escolheOpcao(Opcao),
    halt.

escolheOpcao(1):- writeln("Entrou na area do cliente"),(main).
escolheOpcao(2):- verificaLoginFunc(main).
escolheOpcao(3):- writeln("Entrou na area da Empresa"),(main).
escolheOpcao(4):- halt.
escolheOpcao(_):- opcaoInvalida, main.