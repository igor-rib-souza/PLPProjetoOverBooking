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

menuEmpresa:-
    writeln("\n       -----Menu da Empresa-----"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Cadastrar funcionário"),
    writeln("[2] Alterar funcionário"),
    writeln("[3] Excluir funcionário"),
    writeln("[4] Visualizar funcionários ativos"),
    writeln("[5] Listar assentos executivos e econômicos disponíveis"),
    writeln("[6] Listar valores para cada tipo de assento"),
    writeln("[7] Criar descontos"),
    writeln("[8] Alterar descontos"),
    writeln("[9] Excluir descontos"),
    writeln("[10] Voltar ao menu principal\n").

cadastroEfetuado:-
    writeln("\nCADASTRADO EFETUADO COM SUCESSO!").

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

    
funcionarioExcluido:-
    writeln("\nFUNCIONÁRIO EXCLUIDO COM SUCESSO!").

assentoExcluido:-
    writeln("\nAssento EXCLUIDO COM SUCESSO!").


getValorDoDesconto:-
    writeln("Insira o valor do desconto: ").

tipoJaCadastrado:-
    writeln("\nErro: tipo já cadastrado!\n").

assentoJaCadastrado:-
    writeln("\nErro: tipo já cadastrado!\n").


descontoExcluido:-
    writeln("\nAssento EXCLUIDO COM SUCESSO!").

getCpf:-
    writeln("Insira seu CPF: ").

opcaoInvalida:-
    writeln("\nERRO: Escolha uma opcao valida\n\n").

usuarioInvalido:-
    writeln("\nErro: usuário não cadastrado no sistema.\n").

usuarioNaoCadastrado:-
    writeln("\nErro: usuário não cadastrado!\n").

informeCpf:-
    writeln("Informe o CPF: ").

informeIdade:-
    writeln("Informe sua Idade: ").

usuarioCadastrado:-
    writeln("Erro: usuário já cadastrado!").

menuCliente:-
    writeln("\n       -----Cliente-----"),
    writeln("\nOlá, Cliente!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Alterar dados no meu cadastro"),
    writeln("[2] Deletar meu cadastro no sistema"),
    writeln("[3] Exibir lista de assentos disponíveis para compra"),
    writeln("[4] Recomendar assento"),
    writeln("[5] Realizar compra"),
    writeln("[6] Cancela todas as compras"),
    writeln("[7] altera Assento"),
    writeln("[8] Voltar ao menu principal\n").
    
clienteExcluido:-
    writeln("\nCLIENTE EXCLUIDO COM SUCESSO!").

clienteAlterado:-
    writeln("\nCLIENTE alterado COM SUCESSO!").

assentoInvalido:-
    writeln("\nASSENTO INDISPONÍVEL\n").

loginouCadastroCliente:-
    writeln("Bem vindo a area dos clientes! digite:"),
    writeln("[1] Se voce ja tem um log in conosco"),
    writeln("[2] Se voce deseja se cadastrar").

menuFuncionario:-
    writeln("-----FUNCIONÁRIO-----"),
    writeln("\nOlá, funcionário!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[0] Exibir descontos disponíveis"),
    writeln("[1] Exibir lista de assentos disponíveis"),
    writeln("[2] Escolher assento para um cliente"),
    writeln("[3] Cancelar compras de um cliente"),
    writeln("[4] Exibir clientes cadastrados"),
    writeln("[5] Excluir cliente do sistema"),
    writeln("[6] Cadastrar cliente no sistema"),
    writeln("[7] Alterar dado do cliente"),
    writeln("[8] Recomendar assento"),
    writeln("[9] Exibir assentos indisponíveis"),
    writeln("[10] Exibir valores para cada tipo de assento"),
    writeln("[11] Alterar assento de um cliente"),
    writeln("[12] Voltar ao menu principal"),
    writeln("[*] Restaure o sistema para o estado inicial\n").


usuarioAssentoOcupado:-
    writeln("\nErro: usuário já está ocupando um assento.").

loginFunc:-
    writeln("\nInforme seu login para acessar o menu da Empresa: ").
loginFunc2:-
    writeln("\nInforme sua senha para acessar o menu da Empresa: ").