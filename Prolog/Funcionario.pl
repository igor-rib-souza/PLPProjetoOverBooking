:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('utilFunc.pl').

verificaLoginFunc(Menu):-
    loginFunc,
    read(Login),

    loginFunc2,
    read(Senha),

    lerArquivoCsv('funcionarios.csv',Resultado),
    contemMember(Senha,Resultado,Resp),
        (Resp -> menuFunc(Menu) ; senhaInvalida, Menu).

menuFunc(Menu):-
        menuFuncionario,
        read(Opcao),
        escolhaDeOpcao(Opcao,Menu),
        halt.


escolhaDeOpcao(0,Menu):- listaDescontos(), menuFunc(Menu).
escolhaDeOpcao(1,Menu):- listaAssentos(), menuFunc(Menu).

/
escolhaDeOpcao(4,Menu):- listaTodosFuncionarios(), menuEmpresa(Menu).
escolhaDeOpcao(6,Menu):- listaValoresDeCadaTipo(), menuEmpresa(Menu).
escolhaDeOpcao(7,Menu):- cadastraDesconto(Menu), menuEmpresa(Menu).
escolhaDeOpcao(9,Menu):- excluirDescontos(Menu), menuEmpresa(Menu).
/
escolhaDeOpcao(_, Menu):- writeln('ok').

listaDescontos():- writeln("\n       -----TODOS OS DESCONTOS DISPONIVEIS NO SISTEMA!-----\n"),
      lerArquivoCsv('descontos.csv',Resultado),
      writeln(Resultado).

listaAssentos():- writeln("\n-----TODOS ASSENTOS ECONOMICOS DISPONIVEIS----\n"),
lerArquivoCsv('assentos_economico_disponiveis.csv',Resultado),
writeln(Resultado),

writeln("\n-----TODOS ASSENTOS EXECUTIVOS DISPONIVEIS----\n"),
lerArquivoCsv('assentos_executivo_disponivel.csv',Exec),
writeln(Exec).