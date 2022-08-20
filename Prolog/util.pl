:-style_check(-discontiguous).
:-style_check(-singleton).



/* Ler um arquivo csv e retorna uma lista de lista. */
lerArquivoCsv(Arquivo, Lists):-
    atom_concat('./dados/', Arquivo, Path),
    csv_read_file(Path, Rows, []),
    rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
    Row =.. [row|List].

/* Verifica se a variavel "Busca" existe numa lista, retornando true ou false. */
contemMember(_, [], false).
contemMember(Busca, [H|T], R):-
    (member(Busca, H) -> R = true ; contemMember(Busca, T, R)
    ).

/*  Escreve o funcionario no arquivo csv. */
cadastraCliente(Cpf, Idade):-
    open('./dados/clientes.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Idade)),
    close(Fluxo).

/*
Gera a lista que queremos excluir da lista de lista passada como parâmetro.
Exemplo: removegg(111, [[333, Cpf, Idade], [111, Cpf, Idade]]) -> [111, Cpf, Idade]
*/
removegg(_, [], []).
removegg(Cpf, [H|T], C):- (member(Cpf, H) -> C = H; removegg(Cpf, T, C)).

remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X,T,T1).

/*Limpa algum arquivo csv passado como parâmetro.*/
limpaCsv(Arquivo):-
    atom_concat('./dados/', Arquivo, Path),
    open(Path, write, Fluxo),
    write(Fluxo, ''),
    close(Fluxo).

/*Reescreve clientes.csv retirando o cliente excluído.*/
reescreveCliente([]).
reescreveCliente([H|T]):-
    nth0(0, H, Cpf),
    nth0(1, H, Idade),
    cadastraCliente(Cpf, Idade),
    reescreveCliente(T).

cadastraCliente(Cpf, Idade):-
    open('./dados/clientes.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Idade)),
    close(Fluxo).

reescreve1([]).
reescreve1([H|T]):-
   
    nth0(0, H, Assento),
    
    
    cadastra1(Assento),
    
    reescreve1(T).

cadastra1(Assento):-
    open('./dados/assentos_economico_disponiveis.csv', append, Fluxo),
    writeln(Fluxo, (Assento)),
    close(Fluxo).

reescreve2([]).
reescreve2([H|T]):-
   
    nth0(0, H, Assento),
    
    cadastra2(Assento),
    
    reescreve2(T).

cadastra2(Assento):-
    open('./dados/assentos_executivo_disponiveis.csv', append, Fluxo),
    writeln(Fluxo, (Assento)),
    close(Fluxo).


reescreveCompra([]).
reescreveCompra([H|T]):-
   
    nth0(0, H, Cpf),
    nth0(1, H, Assento),
    
    
    cadastraCompra(Cpf, Assento),
    
    reescreveCompra(T).


cadastraCompra(Assento):-
    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Assento)),
    close(Fluxo).

cadastraCompra(Cpf,Assento):-
    open('./dados/compra.csv', append, Fluxo),
    writeln(Fluxo, (Cpf,Assento)),
    close(Fluxo).


/*  Escreve o funcionário no arquivo csv. */
cadastrarFuncionario(Cpf, Nome):-
    open('./dados/funcionarios.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome)),
    close(Fluxo).

/*  Escreve o desconto no arquivo csv. */
cadastrarDesconto(Tipo, Valor):-
    open('./dados/descontos.csv', append, Fluxo),
    writeln(Fluxo, (Tipo, Valor)),
    close(Fluxo).

/*  Reescreve funcionarios.csv sem o funcionario excluído.*/
reescreveFuncionario([]).
reescreveFuncionario([H|T]):-
    nth0(0, H, Cpf), % Indice 0
    nth0(1, H, Nome), % Indice 1
    cadastrarFuncionario(Cpf, Nome),
    reescreveFuncionario(T).

/*  Reescreve descontos.csv sem o desconto excluído.*/
reescreveDesconto([]).
reescreveDesconto([H|T]):-
    nth0(0, H, Tipo), % Indice 0
    nth0(1, H, Valor), % Indice 1
    cadastrarDesconto(Tipo, Valor),
    reescreveDesconto(T).