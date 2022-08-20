:- use_module(library(csv)).
:- include('mensagens.pl').
:- include('util.pl').

escolhaDeOpcaoI(1,Menu):- verificaCliente(Menu).
escolhaDeOpcaoI(2,Menu):- cadastrarCliente(Menu), loginCliente(Menu).

escolhaDeOpcao3(0,Menu):- cadastrarCliente(Menu), loginCliente(Menu).
escolhaDeOpcao3(1,Menu):- alteraCliente(Menu), loginCliente(Menu).
escolhaDeOpcao3(2,Menu):- excluirCliente(Menu), loginCliente(Menu).
escolhaDeOpcao3(3,Menu):- listaTodosAssentosDisponiveis(Menu), loginCliente(Menu).
escolhaDeOpcao3(4,Menu):- recomendaAssento(Menu), loginCliente(Menu).
escolhaDeOpcao3(5,Menu):- realizaCompra(Menu), loginCliente(Menu).
escolhaDeOpcao3(6,Menu):- cancelaCompra(Menu), loginCliente(Menu).
escolhaDeOpcao3(7,Menu):- alteraAssento(Menu), loginCliente(Menu).
escolhaDeOpcao3(8,Menu):- Menu.

acessoCliente(Menu):-
    loginouCadastroCliente,
    read(Opcao),
    escolhaDeOpcaoI(Opcao, Menu),
    halt.

loginCliente(Menu):-
    menuCliente,
    read(Opcao),
    escolhaDeOpcao3(Opcao, Menu),
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
    (Resposta -> writeln("") ; usuarioInvalido, loginCliente(Menu)),

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
    (Resposta -> writeln("") ; usuarioInvalido, loginCliente(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(FuncionariosExc),

    cadastraCliente(Cpf, Idade),

    clienteAlterado.

listaTodosAssentosDisponiveis(Menu):-
    writeln("\n       -----TODOS OS ASSENTOS DISPONIVEIS NO SISTEMA!-----\n"),
    listaAssentos().

/*Para recomendar Assento*/
recomendaAssento(Menu):-
    writeln("Voce deseja comprar um assento: [1] Economico [2] Executivo"),
    read(Tipo),
    recomendaAssentoX(Tipo),
    loginCliente(Menu).

recomendaAssentoX(1):-
    lerArquivoCsv('assentos_economico_disponiveis.csv',Result),
    writeln("Lhe recomendamos esse assento:"),
    member(H,Result),
    writeln(H).

recomendaAssentoX(2):-
    lerArquivoCsv('assentos_executivo_disponiveis.csv',Result),
    writeln("Lhe recomendamos esse assento:"),
    member(H,Result),
    writeln(H).

recomendaAssentoX(_):-
    writeln("opcao invalida"),
    recomendaAssento(Menu).

/*Para realizar compra*/
realizaCompra(Menu):-
    writeln("Digite o seu CPF para o procedimento da compra:"),
    read(Cpf),
    listaAssentos,
    writeln("Voce deseja comprar um assento: [1] Economico [2] Executivo"),
    read(Tipo),
    writeln("Informe seu numero de assento"),
    read(Assento),
    compra(Assento,Tipo,Cpf),
    writeln("Compra realizada com sucesso").

listaAssentos():- writeln("\n-----TODOS ASSENTOS ECONOMICOS DISPONIVEIS----\n"),
    lerArquivoCsv('assentos_economico_disponiveis.csv',Resultado),
    writeln(Resultado),
    writeln("\n-----TODOS ASSENTOS EXECUTIVOS DISPONIVEIS----\n"),
    lerArquivoCsv('assentos_executivo_disponiveis.csv',Exec),
    writeln(Exec).

geraAssento([H|T],Saida):- 
    Saida = H.

compra(Assento,1,Cpf):- 
    lerArquivoCsv('assentos_economico_disponiveis.csv', Result),
    contemMember(Assento, Result, Resposta),
    (Resposta -> writeln("") ; writeln('Assento invalido')),
    remove([Assento], Result, AssentosRest),
    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Assento)),
    close(Fluxo),
    open('./dados/assentos_indisponiveis.csv', append, Add),
    writeln(Add, (Assento)),
    close(Add),
    limpaCsv('assentos_economico_disponiveis.csv'),
    reescreve1(AssentosRest).

compra(Assento,2,Cpf):- 
    lerArquivoCsv('assentos_executivo_disponiveis.csv', Result),
    contemMember(Assento, Result, Resposta),
    (Resposta -> writeln("") ; writeln('Assento invalido')),
    remove([Assento], Result, AssentosRest),
    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Assento)),
    close(Fluxo),
    open('./dados/assentos_indisponiveis.csv', append, Add),
    writeln(Add, (Assento)),
    close(Add),
    limpaCsv('assentos_executivo_disponiveis.csv'),
    reescreve2(AssentosRest).

/*Para cancelar compra*/
cancelaCompra(Menu):-
    writeln("Informe o seu CPF"),
    read(Cpf),

    lerArquivoCsv('compra.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; writeln("Nao a compra cadastrada no seu nome"), loginCliente(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, ComprasRest),

    limpaCsv('compra.csv'),

    reescreveCompra(ComprasRest),
    
    writeln("Compra mais antiga cancelada.").

/*Para altera assento*/
alteraAssento(Menu) :-
    listaAssentos,

    writeln("Informe o seu CPF, para a aleracao de seus dados"),
    read(Cpf),

    writeln('Voce deseja comprar um assento: [1] Economico [2] Executivo'),
    read(Tipo),

    writeln("Informe seu novo assento"),
    read(Assento),

    lerArquivoCsv('compra.csv', Result),
    contemMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, loginCliente(Menu)),

    removegg(Cpf, Result, X),
    remove(X, Result, ComprasRest),

    limpaCsv('compra.csv'),

    reescreveCompra(ComprasRest),

    compra(Assento, Tipo, Cpf),

    writeln('Alteracao realizada com sucesso').