:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('utilEmp.pl').


menuEmpresa(Menu):-
        menuEmpresaa,
        read(Opcao),
        escolhaDeOpcao(Opcao,Menu),
        halt.

escolhaDeOpcao(1,Menu):- cadastroDeFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao(3,Menu):- excluirFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao(7,Menu):- cadastraDesconto(Menu), menuEmpresa(Menu).


cadastroDeFuncionario(Menu):-
      cadastrarNome,
      read(Nome),

      getCpf,
      read(Cpf),

      lerArquivoCsv('funcionarios.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> usuarioCadastrado, menuEmpresa(Menu) ; write("")),

      cadastrarFuncionario(Nome, Cpf),
      cadastroEfetuado.

cadastraDesconto(Menu):-
      cadastrarDesconto,
      read(Tipo),

      getValorDoDesconto,
      read(Valor),

      lerArquivoCsv('descontos.csv',Resultado),
      contemMember(Tipo,Resultado,Resultado2),
      (Resultado2 -> descontoJaCadastrado, menuEmpresa(Menu) ; write("")),

      cadastrarDesconto(Tipo,Valor),
      cadastroEfetuado.


excluirFuncionario(Menu):-
      writeln("Informe o CPF do funcionario que deseja excluir: "),
      read(Cpf),

      lerArquivoCsv('funcionarios.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> writeln(""); usuarioInvalido, menuEmpresa(Menu)),

      removegg(Cpf,Resultado,X),
      removegg(X,Resultado,FuncionariosExcluidos),

      limparCsv('funcionarios.csv'),
      reescreveFuncionario(FuncionariosExcluidos),
      funcionarioExcluido.


