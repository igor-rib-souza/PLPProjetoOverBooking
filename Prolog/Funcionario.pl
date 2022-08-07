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

escolhaDeOpcao(4,Menu):- listaClientes(), menuFunc(Menu).
escolhaDeOpcao(5,Menu):- excluirCliente(), menuFunc(Menu).
escolhaDeOpcao(6,Menu):- cadastrarCliente(), menuFunc(Menu).
escolhaDeOpcao(7,Menu):- alteraCliente(), menuFunc(Menu).
escolhaDeOpcao(8,Menu):- recomendaAssento(), menuFunc(Menu).
escolhaDeOpcao(9,Menu):- listaIndisponiveis, menuFunc(Menu).
escolhaDeOpcao(10,Menu):- listaValores(), menuFunc(Menu).

escolhaDeOpcao(12,Menu):- main.

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

listaClientes():- writeln("\n       -----TODOS OS CLIENTES CADASTRADOS NO SISTEMA!-----\n"),
      lerArquivoCsv('clientes.csv',Clientes),
      writeln(Clientes).

excluirCliente():-
    writeln("Informe o seu CPF"),
    read(Cpf),

    lerArquivoCsv('clientes.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(FuncionariosExc),
    writeln("\nCliente excluido com sucesso!").

cadastrarCliente():-
      getCpf,
      read(Cpf),
      
      informeIdade,
      read(Idade),

      lerArquivoCsv('clientes.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> usuarioCadastrado; write("")),

      cadastraCliente(Cpf, Idade),
      cadastroEfetuado.

alteraCliente():-
    writeln("Informe o seu CPF, para a aleração de seus dados"),
    read(Cpf),

    writeln("Informe sua nova Idade"),
    read(Idade),

    lerArquivoCsv('clientes.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, loginDono(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(FuncionariosExc),

    cadastraCliente(Cpf, Idade),

    clienteAlterado.

recomendaAssento(Menu):-
    lerArquivoCsv('assentos.csv',Result),
    writeln("Lhe recomendamos esse assento:")
    member(H,Result),
    /*(H =@= "" -> writeln(""); "Infelizmente nao temos assentos para lhe recomendar", loginCliente(Menu)),*/
    writeln(H).


listaIndisponiveis():- writeln('ASSENTOS INDISPONIVEIS:'),
lerArquivoCsv('assentos_indisponiveis.csv',Ind),
      writeln(Ind).

listaValores():-lerArquivoCsv('valoresDeCadaTipo.csv',Ind),
      writeln(Ind).