:-style_check(-discontiguous).
menuPrincipal:-
    writeln("\nEscolha uma opcao para prosseguir"),
    writeln("\n[1] Area do cliente"),
    writeln("\n[2] Area do funcionario"),
    writeln("\n[3] Area da empresa"),
    writeln("\n[4] Sair\n").

opcaoInvalida:-
    writeln("\nERRO: Escolha uma opcao valida\n\n").

mensagemSaida:-
    writeln("\nAté mais!\n").

menuEmpresaa:-
    writeln("\n       -----Menu da Empresa-----"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Cadastrar funcionario"),
    writeln("[2] Alterar funcionario"),
    writeln("[3] Excluir funcionario"),
    writeln("[4] Visualizar funcionarios ativos"),
    writeln("[5] Listar assentos executivos e economicos disponiveis"),
    writeln("[6] Listar valores para cada tipo de assento"),
    writeln("[7] Criar descontos"),
    writeln("[8] Alterar descontos"),
    writeln("[9] Excluir descontos"),
    writeln("[10] Voltar ao menu principal\n").

cadastroEfetuado:-
    writeln("\nCADASTRADO EFETUADO COM SUCESSO!").

cadastroAlterado:-
    writeln("\nCADASTRADO ALTERADO COM SUCESSO!").

cadastrarNome:-
    writeln("\n       -----CADASTRO DE USUÁRIO-----"),
    writeln("\nInforme o nome: ").

cadastrarIdAssento:-
    writeln("\n       -----CADASTRO DE ASSENTO-----"),
    writeln("\nInforme o ID poltrona: ").

getTipo:-
    writeln("Insira o tipo da poltrona: ").

cadastrarDesconto:-
    writeln("\n       -----CADASTRO DE DESCONTO-----"),
    writeln("Insira tipo da poltrona: ").

descontoJaCadastrado:-
    writeln("\nJA POSSUI UM DESCONTO COM ESSE TIPO NO SISTEMA!").

funcionarioExcluido:-
    writeln("\nFUNCIONARIO EXCLUIDO COM SUCESSO!").

assentoExcluido:-
    writeln("\nASSENTO EXCLUIDO COM SUCESSO!").


getValorDoDesconto:-
    writeln("Insira o valor do desconto: ").

tipoJaCadastrado:-
    writeln("\nErro: tipo ja cadastrado!\n").

assentoJaCadastrado:-
    writeln("\nErro: tipo ja cadastrado!\n").


descontoExcluido:-
    writeln("\nAssento EXCLUIDO COM SUCESSO!").

getCpf:-
    writeln("Insira seu CPF: ").

opcaoInvalida:-
    writeln("\nERRO: Escolha uma opcao valida\n\n").

usuarioInvalido:-
    writeln("\nErro: usuario nao cadastrado no sistema.\n").

senhaInvalida:-
    writeln("\nErro: senha nao cadastrada no sistema.\n").
    
usuarioNaoCadastrado:-
    writeln("\nErro: usuario nao cadastrado!\n").

descontoNaoCadastrado:-
    writeln("\nErro: desconto nao cadastrado!\n").

informeCpf:-
    writeln("Informe o CPF: ").

informeIdade:-
    writeln("Informe sua Idade: ").

usuarioCadastrado:-
    writeln("Erro: usuario ja cadastrado!").

menuCliente:-
    writeln("\n       -----Cliente-----"),
    writeln("\nOla, Cliente!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Alterar dados no meu cadastro"),
    writeln("[2] Deletar meu cadastro no sistema"),
    writeln("[3] Exibir lista de assentos disponiveis para compra"),
    writeln("[4] Recomendar assento"),
    writeln("[5] Realizar compra"),
    writeln("[6] Cancela primeira compra"),
    writeln("[7] altera Assento"),
    writeln("[8] Voltar ao menu principal\n").
    
clienteExcluido:-
    writeln("\nCLIENTE EXCLUIDO COM SUCESSO!").

clienteAlterado:-
    writeln("\nCLIENTE ALTERADO COM SUCESSO!").

assentoInvalido:-
    writeln("\nASSENTO INDISPONIVEL\n").

loginouCadastroCliente:-
    writeln("Bem vindo a area dos clientes! digite:"),
    writeln("[1] Se voce ja tem um log in conosco"),
    writeln("[2] Se voce deseja se cadastrar").

menuFuncionario:-
    writeln("-----FUNCIONARIO-----"),
    writeln("\nOlá, funcionArio!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[0] Exibir descontos disponiveis"),
    writeln("[1] Exibir lista de assentos disponiveis"),
    writeln("[2] Escolher assento para um cliente"),
    writeln("[3] Cancelar primeira compra de um cliente"),
    writeln("[4] Exibir clientes cadastrados"),
    writeln("[5] Excluir cliente do sistema"),
    writeln("[6] Cadastrar cliente no sistema"),
    writeln("[7] Alterar dado do cliente"),
    writeln("[8] Recomendar assento"),
    writeln("[9] Exibir assentos indisponiveis"),
    writeln("[10] Exibir valores para cada tipo de assento"),
    writeln("[11] Alterar assento de um cliente"),
    writeln("[12] Voltar ao menu principal"),
    writeln("[13] Restaure o sistema para o estado inicial\n").


usuarioAssentoOcupado:-
    writeln("\nErro: usuario ja esta ocupando um assento.").


loginFunc:-
    writeln("\nInforme seu login para acessar o menu da Funcionario: ").
loginFunc2:-
    writeln("\nInforme sua senha para acessar o menu da Funcionario: ").

usuarioInvalido:-
    writeln("\nErro: usuario nao cadastrado no sistema.\n").

loginEmpresa:-
    writeln("\nInforme seu login para acessar o menu da Empresa: ").
loginEmpresa02:-
    writeln("\nInforme sua senha para acessar o menu da Empresa: ").

