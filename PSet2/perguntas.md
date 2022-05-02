1. select avg(salario) from funcionario;
+--------------+
| avg(salario) |
+--------------+
|    35.125000 |
+--------------+

2. select sexo, avg(salario) from funcionario group by sexo;
+------+--------------+
| sexo | avg(salario) |
+------+--------------+
| F    |    31.000000 |
| M    |    37.600000 |
+------+--------------+

3. select nome_departamento, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, salario 
    -> from departamento 
    -> inner join funcionario on (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+---------------+-----------+-------------+-----------------+---------+
| nome_departamento | primeiro_nome | nome_meio | ultimo_nome | data_nascimento | salario |
+-------------------+---------------+-----------+-------------+-----------------+---------+
| Pesquisa          | João          | B         | Silva       | 1965-01-09      |   30.00 |
| Pesquisa          | Fernando      | T         | Wong        | 1955-12-08      |   40.00 |
| Pesquisa          | Joice         | A         | Leite       | 1972-07-31      |   25.00 |
| Pesquisa          | Ronaldo       | K         | Lima        | 1962-09-15      |   38.00 |
| Matriz            | Jorge         | E         | Brito       | 1937-11-10      |   55.00 |
| Administração     | Jennifer      | S         | Souza       | 1941-06-20      |   43.00 |
| Administração     | André         | V         | Pereira     | 1969-03-29      |   25.00 |
| Administração     | Alice         | J         | Zelaya      | 1968-01-19      |   25.00 |
