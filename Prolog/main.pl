:- (initialization main).
:- include('mensagens.pl').
:- include('cliente.pl').
:- include('Funcionario.pl').
:- include('Empresa.pl').


main :-
    writeln("\n--------------------Seja bem vindo ao sistema OVERBOOKING!--------------------\n"),
    menuPrincipal,
    read(Opcao),
    escolheOpcao(Opcao),
    halt.

escolheOpcao(1):- acessoCliente(main).
escolheOpcao(2):- verificaLoginFunc(main).
escolheOpcao(3):- verificaLoginEmpresa(main).
escolheOpcao(4):- halt.
escolheOpcao(_):- opcaoInvalida, main.