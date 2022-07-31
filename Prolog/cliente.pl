:- use_module(library(csv)).
:- include('mensagens.pl').
:- include('Utilcliente.pl').

escolhaDeOpcaoI(1,Menu):- verificaCliente(Menu).
escolhaDeOpcaoI(2,Menu):- cadastrarCliente(Menu), loginCliente(Menu).

escolhaDeOpcao(0,Menu):- cadastrarCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(1,Menu):- alteraCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(2,Menu):- excluirCliente(Menu), loginCliente(Menu).
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

    

