:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('util.pl').

verificaLoginEmpresa(Menu):-
        loginEmpresa,
        read(Login),

        loginEmpresa02,
        read(Senha),

        lerArquivoCsv('empresa.csv',Resultado),
        contemMember(Senha,Resultado,Resp),
        (Resp -> menuEmpresa(Menu) ; senhaInvalida, Menu).

menuEmpresa(Menu):-
        menuEmpresaa,
        read(Opcao),
        escolhaDeOpcao2(Opcao,Menu),
        halt.

escolhaDeOpcao2(1,Menu):- cadastroDeFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(2,Menu):- alterarFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(3,Menu):- excluirFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(4,Menu):- listaTodosFuncionarios(), menuEmpresa(Menu).
escolhaDeOpcao2(5,Menu):- listaTodosAssentosDisponiveis(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(6,Menu):- listaValoresDeCadaTipo(), menuEmpresa(Menu).
escolhaDeOpcao2(7,Menu):- cadastraDesconto(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(8,Menu):- alterarDesconto(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(9,Menu):- excluirDescontos(Menu), menuEmpresa(Menu).
escolhaDeOpcao2(10,Menu):- main.


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
      (Resultado2 -> writeln(""); usuarioNaoCadastrado, menuEmpresa(Menu)),

      removegg(Cpf,Resultado,Respost),
      remove(Respost,Resultado,FuncionariosExcluidos),

      limpaCsv('funcionarios.csv'),
      reescreveFuncionario(FuncionariosExcluidos),
      funcionarioExcluido.

alterarFuncionario(Menu):-
      writeln("Informe o nome do funcionario que deseja alterar: "),
      read(Cpf),
      lerArquivoCsv('funcionarios.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> writeln(""); usuarioNaoCadastrado, menuEmpresa(Menu)),

      removegg(Cpf,Resultado,Respost),
      remove(Respost,Resultado,FuncionariosExcluidos),

      limpaCsv('funcionarios.csv'),
      reescreveFuncionario(FuncionariosExcluidos),

      writeln("Infome o novo nome do usuario:"),
      read(NovoNome),
      writeln("Infome o novo cpf do usuario:"),
      read(NovoCpf),
      lerArquivoCsv('funcionarios.csv',Resultado3),
      contemMember(NovoCpf, Resultado3, Resultado4),
      (Resultado4 -> usuarioCadastrado, menuEmpresa(Menu) ; write("")),
      cadastrarFuncionario(NovoNome, NovoCpf),
      cadastroAlterado.
      

excluirDescontos(Menu):-
      writeln("Informe o TIPO da poltrona relacionado ao desconto que deseja excluir: "),
      read(Tipo),

      lerArquivoCsv('descontos.csv',Resultadoo),
      contemMember(Tipo, Resultadoo, Resultadoo2),
      (Resultadoo2 -> writeln(""); descontoNaoCadastrado, menuEmpresa(Menu)),

      removegg(Tipo,Resultadoo,Respostt),
      remove(Respostt,Resultadoo,DescontosExcluidos),
      
      limpaCsv('descontos.csv'),
      reescreveDesconto(DescontosExcluidos),
      descontoExcluido.

alterarDesconto(Menu):-
      writeln("Informe o TIPO da poltrona relacionado ao desconto que deseja alterar: "),
      read(Tipo),
      lerArquivoCsv('descontos.csv',Resultado),
      

      removegg(Tipo,Resultado,Respost),
      remove(Respost,Resultado,DescontosExcluidos),

      limpaCsv('descontos.csv'),
      reescreveDesconto(DescontosExcluidos),

      writeln("Infome o novo tipo do desconto:"),
      read(NovoTipo),
      writeln("Infome o novo valor do desconto:"),
      read(NovoValor),
      lerArquivoCsv('descontos.csv',Resultado3),
      contemMember(NovoTipo, Resultado3, Resultado4),
      (Resultado4 -> descontoCadastrado, menuEmpresa(Menu) ; write("")),
      cadastrarDesconto(NovoTipo, NovoValor),
      cadastroAlterado.

listaTodosFuncionarios:-
      writeln("\n       -----TODOS OS FUNCINARIOS ATIVOS NO SISTEMA!-----\n"),
      lerArquivoCsv('funcionarios.csv',Resultado),
      writeln(Resultado).

listaValoresDeCadaTipo:-
      writeln("\n  Atualmente temos os seguintes valores relacionados aos tipos de assentos no sistema:      \n"),
      lerArquivoCsv('valoresDeCadaTipo.csv',Resultado),
      writeln(Resultado).

listaTodosAssentosDisponiveis(Menu):-
    writeln("\n       -----TODOS OS ASSENTOS DISPONIVEIS NO SISTEMA!-----\n"),
    listaAssentos().

listaAssentos():- writeln("\n-----TODOS ASSENTOS ECONOMICOS DISPONIVEIS----\n"),
      lerArquivoCsv('assentos_economico_disponiveis.csv',Resultado),
      writeln(Resultado),
      writeln("\n-----TODOS ASSENTOS EXECUTIVOS DISPONIVEIS----\n"),
      lerArquivoCsv('assentos_executivo_disponiveis.csv',Exec),
      writeln(Exec).