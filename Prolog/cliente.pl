:- use_module(library(csv)).
:- include('mensagens.pl').
:- include('Utilcliente.pl').


escolhaDeOpcao(0,Menu):- cadastrarCliente(Menu), loginCliente(Menu).
escolhaDeOpcao(8,Menu):- Menu.

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
      cadastrarNome,
      read(Nome),

      getCpf,
      read(Cpf),

      lerArquivoCsv('clientes.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> usuarioCadastrado, loginCliente(Menu); write("")),

      cadastraCliente(Nome, Cpf),
      cadastroEfetuado.