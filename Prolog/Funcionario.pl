:-use_module(library(csv)).
:- include('mensagens.pl').

:-include('util.pl').

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
        escolhaDeOpcao1(Opcao,Menu),
        halt.


escolhaDeOpcao1(0,Menu):- listaDescontos(), menuFunc(Menu).
escolhaDeOpcao1(1,Menu):- listaAssentos(), menuFunc(Menu).
escolhaDeOpcao1(2,Menu):- verificaClienteX(Menu), menuFunc(Menu).
escolhaDeOpcao1(3,Menu):- cancelaCompra(), menuFunc(Menu).
escolhaDeOpcao1(4,Menu):- listaClientes(), menuFunc(Menu).
escolhaDeOpcao1(5,Menu):- excluirCliente(), menuFunc(Menu).
escolhaDeOpcao1(6,Menu):- cadastrarCliente(), menuFunc(Menu).
escolhaDeOpcao1(7,Menu):- alteraCliente(), menuFunc(Menu).
escolhaDeOpcao1(8,Menu):- recomendaAssentoXY(Menu), menuFunc(Menu).
escolhaDeOpcao1(9,Menu):- listaIndisponiveis, menuFunc(Menu).
escolhaDeOpcao1(10,Menu):- listaValores(), menuFunc(Menu).
escolhaDeOpcao1(11,Menu):- alteraAssento(), menuFunc(Menu).
escolhaDeOpcao1(12,Menu):- main.
escolhaDeOpcao1(13, Menu):- restaura(), menuFunc(Menu).
escolhaDeOpcao1(_,Menu):- writeln('OPCAO INVALIDA'), menuFunc(Menu).


listaDescontos():- writeln("\n-----TODOS OS DESCONTOS DISPONIVEIS NO SISTEMA!-----\n"),
      lerArquivoCsv('descontos.csv',Resultado),
      writeln(Resultado).

listaAssentos():- writeln("\n-----TODOS ASSENTOS ECONOMICOS DISPONIVEIS----\n"),
lerArquivoCsv('assentos_economico_disponiveis.csv',Resultado),
writeln(Resultado),

writeln("\n-----TODOS ASSENTOS EXECUTIVOS DISPONIVEIS----\n"),
lerArquivoCsv('assentos_executivo_disponiveis.csv',Exec),
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
    writeln("Informe o seu CPF, para a aleracao de seus dados"),
    read(Cpf),

    writeln("Informe sua nova Idade"),
    read(Idade),

    lerArquivoCsv('clientes.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, menuFunc(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(FuncionariosExc),

    cadastraCliente(Cpf, Idade),

    clienteAlterado.

alteraAssento() :-
    listaAssentos,

    writeln("Informe o seu CPF, para a alteracao de seus dados"),
    read(Cpf),

    writeln('Você deseja comprar um assento: [1] Economico [2] Executivo'),
    read(Tipo),

    writeln("Informe seu novo assento"),
    read(Assento),

    lerArquivoCsv('compra.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, menuFunc(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('compra.csv'),

    reescreveCompra(FuncionariosExc),

    compra(Assento, Tipo, Cpf),

    writeln('Alteracao realizada com sucesso').


/*Para recomendar Assento*/
recomendaAssentoXY(Menu):-
    writeln("Voce deseja comprar um assento: [1] Economico [2] Executivo"),
    read(Tipo),
    recomendaAssentoY(Tipo),
    menuFunc(Menu).

recomendaAssentoY(1):-
    lerArquivoCsv('assentos_economico_disponiveis.csv',Result),
    writeln("Lhe recomendamos esse assento:"),
    member(H,Result),
    writeln(H).

recomendaAssentoY(2):-
    lerArquivoCsv('assentos_executivo_disponiveis.csv',Result),
    writeln("Lhe recomendamos esse assento:"),
    member(H,Result),
    writeln(H).

recomendaAssentoY(_):-
    writeln("opcao invalida"),
    recomendaAssentoXY(Menu).


listaIndisponiveis():- writeln('ASSENTOS INDISPONIVEIS:'),
lerArquivoCsv('assentos_indisponiveis.csv',Ind),
      writeln(Ind).

listaValores():-lerArquivoCsv('valoresDeCadaTipo.csv',Ind),
      writeln(Ind).



verificaClienteX(Menu):-
    writeln("Insira o cpf do cliente"),
    read(Cpf),

    lerArquivoCsv('clientes.csv', Resultado),
    contemMember(Cpf, Resultado, Resposta),
    (Resposta -> realizaCompraX(Cpf); usuarioInvalido, menuFunc(Menu)).

verificaAssento(Assento,1,Cpf):-
    lerArquivoCsv('assentos_economico_disponiveis.csv',Resultado),
    contemMember(Assento, Resultado, Resposta),
    (Resposta -> compra(Assento,1,Cpf);writeln("Assento indisponivel")).


verificaAssento(Assento,2,Cpf):-
    lerArquivoCsv('assentos_executivo_disponiveis.csv',Resultado),
    contemMember(Assento, Resultado, Resposta),
    (Resposta -> compra(Assento,1,Cpf);writeln("Assento indisponivel")).   

realizaCompraX(Cpf):-
    listaAssentos,
    writeln("Você deseja comprar um assento: [1] Economico [2] Executivo"),
    read(Tipo),
    writeln("Qual assento você deseja?"),
    read(Assento),
    compra(Assento,Tipo,Cpf).

geraAssento([H|T],Saida):- Saida = H.

compra(Assento,1,Cpf):- 
    
    lerArquivoCsv('assentos_economico_disponiveis.csv', Result),
    contemMember(Assento, Result, Resposta),
    (Resposta -> writeln("") ; writeln('Assento invalido')),

    removegg(Assento, Result, X),
    remove(X, Result, FuncionariosExc),

    geraAssento(X, Saida),


    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Saida)),
    close(Fluxo),

    limpaCsv('assentos_economico_disponiveis.csv'),

    reescreve1(FuncionariosExc),
    
    open('./dados/assentos_indisponiveis.csv', append, Fluxo2),
    writeln(Fluxo2, (Saida)),
    close(Fluxo2).

compra(Assento,2,Cpf):- 

    lerArquivoCsv('assentos_executivo_disponiveis.csv', Result),
    contemMember(Assento, Result, Resposta),
    (Resposta -> writeln("") ; writeln('Assento invalido')),

    removegg(Assento, Result, X),
    remove(X, Result, FuncionariosExc),

    geraAssento(X, Saida),


    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Saida)),
    close(Fluxo),

    open('./dados/assentos_indisponiveis.csv', append, Add),
    writeln(Add, (Saida)),
    close(Add),

    limpaCsv('assentos_executivo_disponiveis.csv'),

    reescreve2(FuncionariosExc).



excluirAssento(Assento):-
    writeln("Assento"),
    read(Cpf),

    lerArquivoCsv('assentos_economico_disponiveis.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('assentos_economico_disponiveis.csv'),

    reescreve(FuncionariosExc).

restaura():-
    limpaCsv("compra.csv"),
    limpaCsv("assentos_indisponiveis.csv"),
    limpaCsv("assentos_executivo_disponiveis.csv"),
    limpaCsv("assentos_economico_disponiveis.csv"),

    lerArquivoCsv('assentos_economico.csv', Eco),
    reescreve1(Eco),
    lerArquivoCsv('assentos_executivo.csv', Exe),
    reescreve2(Exe).


cancelaCompra():-
    writeln("Informe o seu CPF"),
    read(Cpf),

    lerArquivoCsv('compra.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; writeln("Nao existe compra cadastrada no seu nome"), menuFunc(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, ComprasRest),

    limpaCsv('compra.csv'),

    reescreveCompra(ComprasRest),
    
    writeln("Compra mais antiga cancelada.").