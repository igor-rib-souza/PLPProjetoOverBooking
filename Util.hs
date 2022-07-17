module Util where
import System.IO
import Data.List

headCadastrado :: String -> [String] -> Bool
headCadastrado c (x:xs) = (c == x)

aux :: String -> [String] -> Bool
aux v (x:xs) = (v == x)

escreverHorarioCpf :: String -> IO()
escreverHorarioCpf n = do

    arq <- openFile "arquivos/horario-cpf.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq


wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s

--- FUNÇÕES QUE GERAM STRING NO FORMATO DE ESCRITA DE UM ARQUIVO ---
primeiraHorarioCpf :: [[String]] -> String
primeiraHorarioCpf [] = ""
primeiraHorarioCpf (x:xs) = head x ++ "," ++ (x !! 1) ++ "\n" ++ primeiraHorarioCpf xs


escreveFuncionario :: String -> IO()
escreveFuncionario n = do

    arq <- openFile "arquivos/funcionarios.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq


--- GERA UMA LISTA DE LISTA SEM A LISTA QUE CONTEM O STRING PASSADO COMO PARÂMETRO ---
opcaoVaga :: String -> [[String]] -> [[String]]
opcaoVaga _ [] = []
opcaoVaga v (x:xs) | (aux v x) == True = opcaoVaga v xs
                   | otherwise = x:opcaoVaga v xs

parseToInt2 :: String -> Int
parseToInt2 s = read (s) :: Int

escreveAssento :: String -> IO()
escreveAssento n = do

    arq <- openFile "arquivos/assentos.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveDesconto :: String -> IO()
escreveDesconto n = do

    arq <- openFile "arquivos/descontos.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

temCadastro :: String -> [[String]] -> Bool
temCadastro _ [] = False
temCadastro c (x:xs) | not (headCadastrado c x)  = temCadastro c xs
                   | otherwise = True


getNome :: String -> [[String]] -> String
getNome _ [] = ""
getNome c (x:xs)   | ((headCadastrado c x) == False) = getNome c xs
                   | otherwise = x !! 1

lerEntradaString :: IO String
lerEntradaString = do
    getLine


split     :: (Char -> Bool) -> String -> [String]
split p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : split p s''
                            where (w, s'') = break p s'

temAssento :: String -> [[String]] -> Bool
temAssento _ [] = False
temAssento c (x:xs) | not (headAssentoDisponivel c x) = temAssento c xs
                    | otherwise = True

headAssentoDisponivel :: String -> [String] -> Bool
headAssentoDisponivel _ [] = False
headAssentoDisponivel c (x:xs) = c == x

parseDicToList :: [[String]] -> [String]
parseDicToList [] = []
parseDicToList lista = head (head lista):parseDicToList (tail lista)

escreveCompra :: String -> IO()
escreveCompra n = do
    
    arq <- openFile "arquivos/compra.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveCliente :: String -> IO()
escreveCliente n = do
    
    arq <- openFile "arquivos/clientes.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveAssento1 :: String -> IO()
escreveAssento1 n = do

    arq <- openFile "arquivos/assentos_executivo_disponivel.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveAssento2 :: String -> IO()
escreveAssento2 n = do

    arq <- openFile "arquivos/assentos_economico_disponivel.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

escreveAssento4 :: String -> IO()
escreveAssento4 n = do

    arq <- openFile "arquivos/assentos_disponiveis.txt" WriteMode
    hPutStr arq n
    hFlush arq
    hClose arq

ehCadastrado :: String -> [[String]] -> Bool
ehCadastrado _ [] = False
ehCadastrado c (x:xs) | ((headCadastrado c x) == False) = ehCadastrado c xs
                      | otherwise = True

primeiroAssento :: [[String]] -> String
primeiroAssento [] = ""
primeiroAssento (x:xs) = head x ++ "\n" ++ primeiroAssento xs

primeiroAssento1 :: [String] -> String
primeiroAssento1 [] = ""
primeiroAssento1 (x:xs) = x ++ "\n" ++ primeiroAssento1 xs 

exibirAssentos :: IO()
exibirAssentos = do

    putStrLn"-----ASSENTOS DISPONÍVEIS-----\n"
    arq <- readFile "arquivos/assentos.txt"
    let lista = Data.List.map (Util.split(==',') ) (lines arq)

    print (sortLista (parseDicToList (lista)))

escolheAssento :: String  -> IO()
escolheAssento cpf = do


    arq <- readFile "arquivos/assentos.txt"
    -- ok até aqui
    --
    let lista = ((Data.List.map (split(==',') ) (lines arq)))
    -- ok até aqui

    if lista == []
        then do print ("Não há vagas")
    else
        do
            print (parseDicToList lista) --ERRO AQUI
            putStrLn"\nQual assento você deseja? "

            assento <- lerEntradaString
            let lista2 = opcaoAssento assento lista

            putStrLn"\nDeseja realizar upgrade para a classe executiva? [S/N] "
            servicoextra <- Util.lerEntradaString



            let n = primeira (lista2)
            escreveAssento (primeira (lista2))

            let cpvStr = cpf ++ "," ++ assento ++ "\n"
            appendFile "arquivos/cpf-assento.txt" (cpvStr)


            let cpvh = cpf ++ "," ++ "," ++ assento ++ ","  ++ "," ++ servicoextra ++ "\n"

            appendFile "arquivos/horario-cpf.txt"  (cpvh)

            let cpfUltimaVaga = cpf ++ "," ++ assento ++ "\n"
            appendFile "arquivos/recomendarAssentos.txt" (cpfUltimaVaga)

cadastraCliente :: IO()
cadastraCliente = do
    n <- lerEntradaString
    contents <- readFile "arquivos/clientes.txt"
    let newContents = n ++ "," ++ contents
    print newContents
    writeFile "arquivos/clientes.txt" newContents


primeiraCliente :: [[String]] -> String
primeiraCliente [] = ""
primeiraCliente (x:xs) = head x ++ "," ++ (x !! 1) ++ "," ++ (x !! 2) ++ "\n" ++ primeiraCliente xs


opcaoAssento :: String -> [[String]] -> [[String]]
opcaoAssento _ [] = []
opcaoAssento v (x:xs) | (aux v x) == True = opcaoAssento v xs
                   | otherwise = x:opcaoAssento v xs


primeira :: [[String]] -> String
primeira [] = ""
primeira (x:xs) = head x ++ "," ++ "\n" ++ primeira xs

sortLista :: [String] -> [String]
sortLista lista = ordena [] lista

ordena :: [String] -> [String] -> [String]
ordena lista_ordenada [] = lista_ordenada
ordena lista_ordenada listaOriginal = ordena (lista_ordenada++[getMenor listaOriginal]) (removeMenor listaOriginal)

getMenor :: [String] -> String
getMenor [x] = x
getMenor(x:xs) | ( parseToInt2 (x) < parseToInt2 (maxi)) = x
               | otherwise = maxi
             where maxi = getMenor xs

removeMenor :: [String] -> [String]
removeMenor [] = []
removeMenor (x:xs) | (x == getMenor(x:xs)) = xs
                   | otherwise = (x:removeMenor xs)

listaVazia :: [String] -> Bool 
listaVazia [] = True
listaVazia (x:xs) = False

renovaAssentos :: IO ()
renovaAssentos = do
    novosEc <- readFile "arquivos/assentos_economico.txt"
    novosEx <- readFile "arquivos/assentos_executivo.txt"
    novosdisp <- readFile "arquivos/assentos.txt"

    let assentosEc = ((Data.List.map (split(==',') ) (lines novosEc)))
    let assentosEx = ((Data.List.map (split(==',') ) (lines novosEx)))
    let assentosdisp = ((Data.List.map (split(==',') ) (lines novosdisp)))

    writeFile "arquivos/assentos_disponiveis.txt" ""

    writeFile "arquivos/assentos_economico_disponivel.txt" novosEc
    writeFile "arquivos/assentos_executivo_disponivel.txt" novosEx
    writeFile "arquivos/assentos_disponiveis.txt" novosdisp

    writeFile "arquivos/compra.txt" ""

    writeFile "arquivos/assentos_indisponiveis.txt" ""