module Funcionario where
import Util
import Mensagens
import Data.List
import System.IO
import Control.DeepSeq
import Control.Exception

-- Recebe cpf do funcionário
cpfFuncionario :: IO()
cpfFuncionario = do
    putStrLn "\nInforme seu CPF para fazer o login: "

-- Verifica se o cpf está cadastrado no sistema
verificaFuncionario :: (IO()) -> IO()
verificaFuncionario menu = do 
    cpfFuncionario
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/funcionarios.txt"
    let lista = Data.List.map (Util.split(==',') ) (lines arq)

    if Util.temCadastro cpf lista
        then do {putStrLn"\nBem vindo de volta!\n"; logaFuncionario menu}
    else do
        {Mensagens.usuarioInvalido; menu}

--realiza o login do funcionario
logaFuncionario :: IO() -> IO()
logaFuncionario menu = do
    Mensagens.menuFuncionario

    putStrLn"Opção: "
    op <- Util.lerEntradaString
    if op == "0"
        then do {Mensagens.listaDescontos;logaFuncionario menu}
    else if op == "1"
        then do {listaTodosAssentosDisponiveis menu; logaFuncionario menu}
    else if op == "2"
        then do {realizarCompra menu; logaFuncionario menu}
    else if op == "3"
        then do {cancelaCompras menu; logaFuncionario menu}
    else if op == "4"
        then do {Mensagens.exibirListaClientesCadastrados; logaFuncionario menu}
    else if op == "5"
        then do {excluirCliente2 menu; logaFuncionario menu}
    else if op == "6"
        then do {Funcionario.cadastrarCliente menu; logaFuncionario menu}
    else if op == "7"
        then do {alteraDadoCliente menu;logaFuncionario menu}
    else if op == "8"
        then do {recomendaAssento menu; logaFuncionario menu}
    else if op == "9"
        then do {listaTodosAssentosIndisponiveis menu; logaFuncionario menu}
    else if op == "10"
        then do {listaValores menu; logaFuncionario menu}
    else if op == "11"
        then do {alteraAssento menu; logaFuncionario menu}
    else if op == "12"
        then do menu
    else if op == "*"
        then do {Util.renovaAssentos; logaFuncionario menu}
    else do
        {Mensagens.opcaoInvalida; logaFuncionario menu}

escolheAssento :: IO()
escolheAssento = do
    putStrLn"\nSerá necessário realizar o cadastro ou log in no sistema!\n"
    Mensagens.getCpf
    cpf <- Util.lerEntradaString

    arq <- readFile "arquivos/cpf-assento.txt"
    let lista = Data.List.map (Util.split(==',') ) (lines arq)

    arq2 <- readFile "arquivos/clientes.txt"
    let lista2 = Data.List.map (Util.split(==',') ) (lines arq2)

    if Util.temCadastro cpf lista
        then do Mensagens.usuarioAssentoOcupado
    else if Util.temCadastro cpf lista2
        then do
            putStrLn"\nVocê já está cadastrado, pode continuar.\n"

            putStrLn"\n"
            Util.escolheAssento cpf
            putStrLn""
    else do
        putStrLn"Informe o nome: "
        nome <- Util.lerEntradaString

        let clienteStr = cpf ++ "," ++ nome ++ "," ++ "\n"
        appendFile "arquivos/clientes.txt" clienteStr

        Util.escolheAssento cpf
    putStrLn""

--TALVEZ isso cause um erro (não causa)
getlines :: Handle -> IO [String]
getlines h = hGetContents h >>= return . lines

-- exclusão do cliente
excluirCliente :: IO() -> IO()
excluirCliente menu = do
    putStrLn"Informe o CPF do cliente que deseja excluir: "
    cpf <- Util.lerEntradaString

    arq <- openFile "arquivos/clientes.txt" ReadMode
    xs <- getlines arq
    let lista = Data.List.map (split(==',') ) xs
    putStrLn"\nAtualmente temos os seguintes clientes no sistema: "
    print lista

    if not (Util.temCadastro cpf lista)
        then do {Mensagens.usuarioInvalido}
    else do
        putStrLn""
        let clientesExc = Util.primeiraCliente (Util.opcaoAssento cpf lista)
        Util.escreveCliente ""

        appendFile "arquivos/clientes.txt" clientesExc

        putStrLn"\nCliente excluído com sucesso!\n"



aux :: String -> [String] -> Bool
aux v (x:xs) = v == x


getLinesClientes :: Handle -> IO [String]
getLinesClientes h = hGetContents h >>= return . lines


excluirCliente2 :: (IO()) -> IO()
excluirCliente2 menu = do
    arquivo <- readFile  "arquivos/clientes.txt"  
    let listaDeCliente = ((Data.List.map (split(==',') ) (lines arquivo)))
    evaluate (force arquivo)
    putStrLn"\nAtualmente temos os seguintes clientes cadastrados:"
    print(listaDeCliente)

    putStrLn"Informe o CPF do cliente que deseja excluir:"
    cpf <- Util.lerEntradaString 
    print(cpf)
    if not (Util.temCadastro cpf listaDeCliente)
        then do {Mensagens.usuarioInvalido; excluirCliente2 menu}
    else do
        let clientes = Util.primeiraHorarioCpf (Util.opcaoAssento cpf listaDeCliente)
        Util.escreveCliente ""
        appendFile "arquivos/clientes.txt" (clientes)
        Mensagens.clienteExcluido


cadastrarCliente :: (IO()) -> IO()
cadastrarCliente menu = do
    Mensagens.cadastrarNome
    nome <- Util.lerEntradaString

    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    Mensagens.informeIdade
    idade <-Util.lerEntradaString

    arq <- readFile "arquivos/clientes.txt"
    let lista = ((Data.List.map (Util.split(==',') ) (lines arq)))
    evaluate (force arq)

    if Util.temCadastro cpf lista
       then do {Mensagens.usuarioCadastrado}
    else do
        let clienteStr = cpf ++ "," ++ idade ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)
        Mensagens.cadastroEfetuado
        


getLinesAssentos :: Handle -> IO [String]
getLinesAssentos h = hGetContents h >>= return . lines


listaValores:: (IO()) -> IO()
listaValores menu = do
                arquivo <- openFile "arquivos/valoresDeCadaTipo.txt" ReadMode
                linhasAssentos <- getLinesAssentos arquivo
                let listaDeAssentos = ((Data.List.map (split(==',') ) linhasAssentos))
                putStrLn("\nTemos os seguintes valores para nossos assentos:")
                print(listaDeAssentos)

listaTodosAssentosIndisponiveis:: (IO()) -> IO()
listaTodosAssentosIndisponiveis menu = do
                arquivo <- readFile  "arquivos/assentos_indisponiveis.txt"
                let listaDeAssentos = ((Data.List.map (split(==',') ) (lines arquivo)))
                evaluate (force arquivo)
                putStrLn("\nAtualmente os seguintes assentos estão indisponíveis: ")
                print(listaDeAssentos)


listaTodosAssentosDisponiveis:: (IO()) -> IO()
listaTodosAssentosDisponiveis menu = do
                arquivo <- readFile  "arquivos/assentos_economico_disponivel.txt"
                arquivo1 <- readFile "arquivos/assentos_executivo_disponivel.txt"
                
                let listaDeAssentos = ((Data.List.map (split(==',') ) (lines arquivo)))
                let listaDeAssentos1 = ((Data.List.map (split(==',') ) (lines arquivo1)))
                evaluate (force arquivo)
                evaluate (force arquivo1)
                putStrLn("\nAtualmente temos os seguintes assentos econômicos no sistema: ")
                print(listaDeAssentos)
                putStrLn("\nE os seguintes assentos executivos:")
                print(listaDeAssentos1)

recomendaAssento :: (IO()) -> IO()
recomendaAssento menu = do

    arquivo <- readFile "arquivos/assentos_economico_disponivel.txt"

    let lista = (lines arquivo)
    evaluate (force arquivo)
    if listaVazia lista
        then do {print("Infelizmente nao temos assentos para lhe recomendar")}
    else do
        let assento = head lista

        putStrLn("Lhe recomendamos esse assento:")
        print(assento)


alteraDadoCliente :: (IO()) -> IO()
alteraDadoCliente menu = do
    arquivo <- readFile "arquivos/clientes.txt"
    let lista = ((Data.List.map (split(==',') ) (lines arquivo)))
    evaluate (force arquivo)

    putStrLn("\nAtualmente temos os seguintes clientes no sistema: ")
    print(lista)

    putStrLn("Informe o CPF do Cliente que deseja alterar: ")
    cpf <- Util.lerEntradaString

    if not (Util.temCadastro cpf lista)
        then do {Mensagens.usuarioInvalido; excluirCliente2 menu}     
    else do 
        putStrLn("Nova Idade: ")
        idade <- Util.lerEntradaString

        let clientesExc = Util.primeiraHorarioCpf (Util.opcaoVaga cpf lista)
        Util.escreveCliente ""
    
        appendFile "arquivos/clientes.txt" (clientesExc)
        
        let clienteStr = cpf ++ "," ++ idade ++ "\n"
        appendFile "arquivos/clientes.txt" (clienteStr)
        Mensagens.clienteAlterado

        


realizarCompra :: (IO()) -> IO()
realizarCompra menu = do

    arquivo0 <- readFile "arquivos/clientes.txt"
    let listaDeCliente = ((Data.List.map (split(==',') ) (lines arquivo0)))

    arquivo1 <- readFile "arquivos/assentos_disponiveis.txt"
    let listaDeAssentosDisponiveis = ((Data.List.map (split(==',') ) (lines arquivo1)))

    arquivo2 <- readFile "arquivos/assentos.txt"
    let listaDeTodosAssentos = ((Data.List.map (split(==',') ) (lines arquivo2)))

    arquivo5 <- readFile "arquivos/assentos_executivo_disponivel.txt"
    let listaDeAssentosExecutivoDisponivel =  (Data.List.map (split(==',') )(lines arquivo5))

    arquivo6 <- readFile "arquivos/assentos_economico_disponivel.txt"
    let listaDeAssentosEconomicoDisponivel =  (Data.List.map (split(==',') )(lines arquivo6))

    arquivo7 <- readFile "arquivos/assentos_indisponiveis.txt"

    evaluate (force arquivo0)
    evaluate (force arquivo1)
    evaluate (force arquivo2)
    evaluate (force arquivo5)
    evaluate (force arquivo6)
    evaluate (force arquivo7)

    Mensagens.informeCpf
    cpf <- Util.lerEntradaString

    

    if not (Util.temCadastro cpf listaDeCliente)
        then do {Mensagens.usuarioInvalido; realizarCompra menu}
    else do
        putStrLn("Qual tipo de classe vc deseja? [1]Executivo ou [2]Economico\n")
        tipoClasse <- Util.lerEntradaString
     
        if (tipoClasse == "1")
            then do
                putStrLn("Os assentos disponíveis são: ")
                print(listaDeAssentosExecutivoDisponivel)

                putStrLn("Qual assento você deseja? ")
                tipoAssento <- Util.lerEntradaString

                if not (Util.temAssento tipoAssento listaDeAssentosExecutivoDisponivel)
                    then do {Mensagens.assentoInvalido; realizarCompra menu}
                else do
                    let assentoStr = cpf ++ "," ++ tipoAssento ++ "," ++ "350" ++ "\n"
                    appendFile "arquivos/compra.txt" (assentoStr)
                    appendFile "arquivos/assentos_indisponiveis.txt" (tipoAssento ++ "\n")

                    let aux = Util.primeiroAssento(Util.opcaoVaga tipoAssento listaDeAssentosExecutivoDisponivel)
                    Util.escreveAssento1 ""
                    appendFile "arquivos/assentos_executivo_disponivel.txt" (aux)
        
        else if (tipoClasse == "2")
            then do
                putStrLn("Os assentos disponíveis são: ")
                print(listaDeAssentosEconomicoDisponivel)

                putStrLn("Qual assento você deseja? ")
                tipoAssento <- Util.lerEntradaString

                if not (Util.temAssento tipoAssento listaDeAssentosEconomicoDisponivel)
                    then do {Mensagens.assentoInvalido; realizarCompra menu}
                else do
                    let assentoStr = cpf ++ "," ++ tipoAssento ++ "," ++ "150" ++ "\n"
                    appendFile "arquivos/compra.txt" (assentoStr)
                    appendFile "arquivos/assentos_indisponiveis.txt" (tipoAssento ++ "\n")

                    let aux = Util.primeiroAssento(Util.opcaoVaga tipoAssento listaDeAssentosEconomicoDisponivel)
                    Util.escreveAssento2 ""
                    appendFile "arquivos/assentos_economico_disponivel.txt" (aux)

        else
            Mensagens.opcaoInvalida

alteraAssento :: (IO()) -> IO()
alteraAssento menu = do
    putStrLn("Digite o cpf do cliente para verificarmos os assentos do mesmo: ")
    cpf <- Util.lerEntradaString
    arquivo <- readFile "arquivos/compra.txt"
    let listaDeCompra= ((Data.List.map (split(==',') ) (lines arquivo)))
    evaluate (force arquivo)

    putStrLn("\nAtualmente temos os seguintes compras no sistema: ")
    print(listaDeCompra)

    if not (Util.temCadastro cpf listaDeCompra)
        then do {Mensagens.usuarioInvalido; alteraAssento menu}     
    else do 
        let clientesExc = Util.primeiraHorarioCpf (Util.opcaoVaga cpf listaDeCompra)
        Util.escreveCompra ""
        
        appendFile "arquivos/compra.txt" (clientesExc)

    putStrLn("seu novo assento sera:")

    arquivo <- openFile "arquivos/clientes.txt" ReadMode
    linhasCliente <- getLinesClientes arquivo

    arquivo1 <- readFile "arquivos/assentos_disponiveis.txt"
    let listaDeAssentosDisponiveis = ((Data.List.map (split(==',') ) (lines arquivo1)))

    arquivo2 <- readFile "arquivos/assentos.txt"
    let listaDeTodosAssentos = ((Data.List.map (split(==',') ) (lines arquivo2)))

    arquivo5 <- readFile "arquivos/assentos_executivo_disponivel.txt"
    let listaDeAssentosExecutivoDisponivel =  (Data.List.map (split(==',') )(lines arquivo5))

    arquivo6 <- readFile "arquivos/assentos_economico_disponivel.txt"
    let listaDeAssentosEconomicoDisponivel =  (Data.List.map (split(==',') )(lines arquivo6))

    evaluate (force arquivo1)
    evaluate (force arquivo2)
    evaluate (force arquivo5)
    evaluate (force arquivo6)

    let listaDeCliente = ((Data.List.map (split(==',') ) (linhasCliente)))

    if not (Util.temCadastro cpf listaDeCliente)
        then do {Mensagens.usuarioInvalido; realizarCompra menu}
    else do
        putStrLn("Qual tipo do seu novo assento? [1]Executivo ou [2]Economico\n")
        tipoClasse <- Util.lerEntradaString
     
        if (tipoClasse == "1")
            then do
                putStrLn("Os assentos disponíveis são: ")
                print(listaDeAssentosExecutivoDisponivel)

                putStrLn("Qual assento você deseja? ")
                tipoAssento <- Util.lerEntradaString

                if not (Util.temAssento tipoAssento listaDeAssentosExecutivoDisponivel)
                    then do {Mensagens.assentoInvalido; alteraAssento menu}
                else do
                    let assentoStr = cpf ++ "," ++ tipoAssento ++ "," ++ "125" ++ "\n"
                    appendFile "arquivos/compra.txt" (assentoStr)

                    let aux = Util.primeiroAssento(Util.opcaoVaga tipoAssento listaDeAssentosExecutivoDisponivel)
                    Util.escreveAssento1 ""
                    appendFile "arquivos/assentos_executivo_disponivel.txt" (aux)
        else if (tipoClasse == "2")
            then do
                putStrLn("Os assentos disponíveis são: ")
                print(listaDeAssentosEconomicoDisponivel)

                putStrLn("Qual assento você deseja? ")
                tipoAssento <- Util.lerEntradaString

                if not (Util.temAssento tipoAssento listaDeAssentosEconomicoDisponivel)
                    then do {Mensagens.assentoInvalido; alteraAssento menu}
                else do
                    let assentoStr = cpf ++ "," ++ tipoAssento ++ "," ++ "50" ++ "\n"
                    appendFile "arquivos/compra.txt" (assentoStr)

                    let aux = Util.primeiroAssento(Util.opcaoVaga tipoAssento listaDeAssentosEconomicoDisponivel)
                    Util.escreveAssento2 ""
                    appendFile "arquivos/assentos_economico_disponivel.txt" (aux)    

        else
            Mensagens.opcaoInvalida

cancelaCompras :: (IO()) -> IO()
cancelaCompras menu = do
    arquivo <- readFile "arquivos/compra.txt"
    let listaDeCompra= ((Data.List.map (split(==',') ) (lines arquivo)))
    evaluate (force arquivo)
    putStr("\nAtualmente temos os seguintes compras no sistema: ")
    print(listaDeCompra)

    putStrLn("\nDigite o CPF do cliente ao qual deseja cancelar as compras: ")
    cpf <- Util.lerEntradaString

    if not (Util.temCadastro cpf listaDeCompra)
        then do {Mensagens.usuarioInvalido; cancelaCompras menu}     
    else do 
        let clientesExc = Util.primeiraHorarioCpf (Util.opcaoVaga cpf listaDeCompra)
        Util.escreveCompra ""
        
        appendFile "arquivos/compra.txt" (clientesExc)
        putStrLn("Compras canceladas com sucesso")