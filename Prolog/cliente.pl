:- use_module(library(csv)).
:- include('mensagens.pl').
:- include('Utilcliente.pl').

escolhaDeOpcaoI(1,Menu):- verificaCliente(Menu).
escolhaDeOpcaoI(2,Menu):- cadastrarCliente(Menu), loginCliente(Menu).

escolhaDeOpcao(0,Menu):- cadastrarCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(1,Menu):- alteraCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(2,Menu):- excluirCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(3,Menu):- listaTodosAssentosDisponiveis(Menu), loginCliente(Menu).
escolhaDeOpcao(4,Menu):- recomendaAssento(Menu), loginCliente(Menu).
escolhaDeOpcao(5,Menu):- realizaCompra(Menu), loginCliente(Menu).
escolhaDeOpcao(8,Menu):- Menu.

acessoCliente(Menu):-
    loginouCadastroCliente,
    read(Opcao),
    escolhaDeOpcaoI(Opcao, Menu),
    halt.

loginCliente(Menu):-
    menuCliente,
    read(Opcao),
    escolhaDeOpcao(Opcao, Menu),
    halt.

verificaCliente(Menu):-
    getCpf,
    read(Cpf),

    lerArquivoCsv('clientes.csv', Resultado),
    contemMember(Cpf, Resultado, Resposta),
    (Resposta -> loginCliente(Menu) ; usuarioInvalido, Menu).

cadastrarCliente(Menu):-
      getCpf,
      read(Cpf),
      
      informeIdade,
      read(Idade),

      lerArquivoCsv('clientes.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> usuarioCadastrado, loginCliente(Menu); write("")),

      cadastraCliente(Cpf, Idade),
      cadastroEfetuado.
    
excluirCliente(Menu):-
    writeln("Informe o seu CPF"),
    read(Cpf),

    lerArquivoCsv('clientes.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, loginDono(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(FuncionariosExc),
    writeln("\nCliente excluido com sucesso!").

alteraCliente(Menu):-
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

listaTodosAssentosDisponiveis(Menu):-
    writeln("\n       -----TODOS OS ASSENTOS DISPONIVEIS NO SISTEMA!-----\n"),
    lerArquivoCsv('assentos.csv',Result),
    writeln(Result).

recomendaAssento(Menu):-
    lerArquivoCsv('assentos_disponiveis.csv',Result),
    writeln("Lhe recomendamos esse assento:")
    member(H,Result),
    /*(H =@= "" -> writeln(""); "Infelizmente nao temos assentos para lhe recomendar", loginCliente(Menu)),*/
    writeln(H).

realizaCompra(Menu):-
    writeln("Digite o seu CPF para o procedimento da compra:"),
    read(Cpf),
    listaAssentos,
    writeln("Você deseja comprar um assento: [1] Econômico [2] Executivo"),
    read(Tipo),
    writeln("Qual assento você deseja?"),
    read(Assento),
    compra(Assento,Tipo,Cpf).

geraAssento([H|T],Saida):- 
    Saida = H.

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
    reescreve1(FuncionariosExc).

compra(Assento,2,Cpf):- 
    lerArquivoCsv('assentos_executivo_disponivel.csv', Result),
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
    limpaCsv('assentos_executivo_disponivel.csv'),
    reescreve2(FuncionariosExc).


    

