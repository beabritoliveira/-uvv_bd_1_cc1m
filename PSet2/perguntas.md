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

3. select nome_departamento, CONCAT (
    (primeiro_nome), ' ',
    (nome_meio), ' ',
    (ultimo_nome)) as nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade, data_nascimento, salario
    from departamento 
    inner join funcionario on (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+------------------+-------+-----------------+---------+
| nome_departamento | nome             | idade | data_nascimento | salario |
+-------------------+------------------+-------+-----------------+---------+
| Pesquisa          | João B Silva     |    57 | 1965-01-09      |   30.00 |
| Pesquisa          | Fernando T Wong  |    66 | 1955-12-08      |   40.00 |
| Pesquisa          | Joice A Leite    |    49 | 1972-07-31      |   25.00 |
| Pesquisa          | Ronaldo K Lima   |    59 | 1962-09-15      |   38.00 |
| Matriz            | Jorge E Brito    |    84 | 1937-11-10      |   55.00 |
| Administração     | Jennifer S Souza |    80 | 1941-06-20      |   43.00 |
| Administração     | André V Pereira  |    53 | 1969-03-29      |   25.00 |
| Administração     | Alice J Zelaya   |    54 | 1968-01-19      |   25.00 |
+-------------------+------------------+-------+-----------------+---------+


4. select salario,  salario*1.2 as salario_reajustado, CONCAT (
    (primeiro_nome), ' ',
    (nome_meio), ' ',
    (ultimo_nome)) as nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade
    from funcionario
    where salario <35.000
    UNION
    select salario,  salario*1.15 as salario_reajustado, CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade
    from funcionario
    where salario >=35.000;
+---------+--------------------+------------------+-------+
| salario | salario_reajustado | nome             | idade |
+---------+--------------------+------------------+-------+
|   30.00 |            36.0000 | João B Silva     |    57 |
|   25.00 |            30.0000 | Joice A Leite    |    49 |
|   25.00 |            30.0000 | André V Pereira  |    53 |
|   25.00 |            30.0000 | Alice J Zelaya   |    54 |
|   40.00 |            46.0000 | Fernando T Wong  |    66 |
|   38.00 |            43.7000 | Ronaldo K Lima   |    59 |
|   55.00 |            63.2500 | Jorge E Brito    |    84 |
|   43.00 |            49.4500 | Jennifer S Souza |    80 |
+---------+--------------------+------------------+-------+


5. Select primeiro_nome, nome_meio, ultimo_nome, nome_departamento, salario, cpf_gerente
from departamento 
INNER JOIN funcionario on (departamento.numero_departamento=funcionario.numero_departamento);

Select primeiro_nome, nome_meio, ultimo_nome, nome_departamento, salario, cpf_gerente,
from departamento 
inner join funcionario on (departamento.numero_departamento=funcionario.numero_departamento)
ORDER BY nome_departamento DESC
ORDER BY salario ASC;

SELECT salario,
     CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome
    from funcionario
ORDER BY salario DESC, nome_departamento ASC ;

UNION
SELECT nome_departamento, cpf_gerente
from departamento


Select salario, (primeiro_nome + '' + nome_meio + '' + ultimo_nome) as nome
from funcionario
ORDER BY salario DESC
UNION
Select nome_departamento, cpf_gerente
from departamento

para cada departamento, o nome
do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente)

SELECT nome_departamento, CONCAT (
  (primeiro_nome), ' ',
  (nome_meio), ' ',
  (ultimo_nome)) as nome, salario 
  from departamento
  inner join funcionario on (departamento.cpf_gerente=funcionario.cpf) OR (departamento.numero_departamento=funcionario.numero_departamento)
    ;
+-------------------+------------------+---------+
| nome_departamento | nome             | salario |
+-------------------+------------------+---------+
| Matriz            | Jorge E Brito    |   55.00 |
| Administração     | Jennifer S Souza |   43.00 |
| Administração     | André V Pereira  |   25.00 |
| Administração     | Alice J Zelaya   |   25.00 |
| Pesquisa          | João B Silva     |   30.00 |
| Pesquisa          | Fernando T Wong  |   40.00 |
| Pesquisa          | Joice A Leite    |   25.00 |
| Pesquisa          | Ronaldo K Lima   |   38.00 |
+-------------------+------------------+---------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome, salario 
    ->      from departamento 
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf) AND (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+------------------+---------+
| nome_departamento | nome             | salario |
+-------------------+------------------+---------+
| Matriz            | Jorge E Brito    |   55.00 |
| Administração     | Jennifer S Souza |   43.00 |
| Pesquisa          | Fernando T Wong  |   40.00 |
+-------------------+------------------+---------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome, salario 
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf) OR (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+------------------+---------+
| nome_departamento | nome             | salario |
+-------------------+------------------+---------+
| Matriz            | Jorge E Brito    |   55.00 |
| Administração     | Jennifer S Souza |   43.00 |
| Administração     | André V Pereira  |   25.00 |
| Administração     | Alice J Zelaya   |   25.00 |
| Pesquisa          | João B Silva     |   30.00 |
| Pesquisa          | Fernando T Wong  |   40.00 |
| Pesquisa          | Joice A Leite    |   25.00 |
| Pesquisa          | Ronaldo K Lima   |   38.00 |
+-------------------+------------------+---------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf) OR (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+------------------+
| nome_departamento | nomeGerente      |
+-------------------+------------------+
| Matriz            | Jorge E Brito    |
| Administração     | Jennifer S Souza |
| Administração     | André V Pereira  |
| Administração     | Alice J Zelaya   |
| Pesquisa          | João B Silva     |
| Pesquisa          | Fernando T Wong  |
| Pesquisa          | Joice A Leite    |
| Pesquisa          | Ronaldo K Lima   |
+-------------------+------------------+
SELECT salario,
    ->      CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome 
    ->      from funcionario;
+---------+------------------+
| salario | nome             |
+---------+------------------+
|   30.00 | João B Silva     |
|   40.00 | Fernando T Wong  |
|   25.00 | Joice A Leite    |
|   38.00 | Ronaldo K Lima   |
|   55.00 | Jorge E Brito    |
|   43.00 | Jennifer S Souza |
|   25.00 | André V Pereira  |
|   25.00 | Alice J Zelaya   |
+---------+------------------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf);
+-------------------+------------------+
| nome_departamento | nomeGerente      |
+-------------------+------------------+
| Matriz            | Jorge E Brito    |
| Administração     | Jennifer S Souza |
| Pesquisa          | Fernando T Wong  |
+-------------------+------------------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf)
    ->      UNION
    ->  SELECT salario,
    ->      CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome 
    ->      from funcionario;
+-------------------+------------------+
| nome_departamento | nomeGerente      |
+-------------------+------------------+
| Matriz            | Jorge E Brito    |
| Administração     | Jennifer S Souza |
| Pesquisa          | Fernando T Wong  |
| 30.00             | João B Silva     |
| 40.00             | Fernando T Wong  |
| 25.00             | Joice A Leite    |
| 38.00             | Ronaldo K Lima   |
| 55.00             | Jorge E Brito    |
| 43.00             | Jennifer S Souza |
| 25.00             | André V Pereira  |
| 25.00             | Alice J Zelaya   |
+-------------------+------------------+
SELECT salario,
    ->      CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome 
    ->      from funcionario
    -> UNION
    -> SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf);
+-----------------+------------------+
| salario         | nome             |
+-----------------+------------------+
| 30.00           | João B Silva     |
| 40.00           | Fernando T Wong  |
| 25.00           | Joice A Leite    |
| 38.00           | Ronaldo K Lima   |
| 55.00           | Jorge E Brito    |
| 43.00           | Jennifer S Souza |
| 25.00           | André V Pereira  |
| 25.00           | Alice J Zelaya   |
| Matriz          | Jorge E Brito    |
| Administração   | Jennifer S Souza |
| Pesquisa        | Fernando T Wong  |
+-----------------+------------------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf);
+-------------------+------------------+
| nome_departamento | nomeGerente      |
+-------------------+------------------+
| Matriz            | Jorge E Brito    |
| Administração     | Jennifer S Souza |
| Pesquisa          | Fernando T Wong  |
+-------------------+------------------+
SELECT salario,
    ->      CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome 
    ->      from funcionario;
+---------+------------------+
| salario | nome             |
+---------+------------------+
|   30.00 | João B Silva     |
|   40.00 | Fernando T Wong  |
|   25.00 | Joice A Leite    |
|   38.00 | Ronaldo K Lima   |
|   55.00 | Jorge E Brito    |
|   43.00 | Jennifer S Souza |
|   25.00 | André V Pereira  |
|   25.00 | Alice J Zelaya   |
+---------+------------------+
SELECT nome_departamento, CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nomeGerente
    ->      from departamento
    ->      inner join funcionario on (departamento.cpf_gerente=funcionario.cpf);
+-------------------+------------------+
| nome_departamento | nomeGerente      |
+-------------------+------------------+
| Matriz            | Jorge E Brito    |
| Administração     | Jennifer S Souza |
| Pesquisa          | Fernando T Wong  |
+-------------------+------------------+
SELECT salario,
    ->      CONCAT (
    ->      (primeiro_nome), ' ',
    ->      (nome_meio), ' ',
    ->      (ultimo_nome)) as nome 
    ->      from funcionario;
+---------+------------------+
| salario | nome             |
+---------+------------------+
|   30.00 | João B Silva     |
|   40.00 | Fernando T Wong  |
|   25.00 | Joice A Leite    |
|   38.00 | Ronaldo K Lima   |
|   55.00 | Jorge E Brito    |
|   43.00 | Jennifer S Souza |
|   25.00 | André V Pereira  |
|   25.00 | Alice J Zelaya   |
+---------+------------------+





6. SELECT numero_departamento,
       CONCAT (
   (primeiro_nome), ' ',
   (nome_meio), ' ',
   (ultimo_nome)) as nome, CONCAT (
   (nome_dependente), ' ',
   (nome_meio), ' ',
   (ultimo_nome)) as nomeDependente, Floor(DATEDIFF(NOW(), dependente.data_nascimento) / 365) AS idade, dependente.sexo
  from dependente
  INNER JOIN funcionario ON (dependente.cpf_funcionario=funcionario.cpf); 
+---------------------+------------------+-------------------+-------+------+
| numero_departamento | nome             | nomeDependente    | idade | sexo |
+---------------------+------------------+-------------------+-------+------+
|                   5 | João B Silva     | Alicia B Silva    |    33 | F    |
|                   5 | João B Silva     | Elizabeth B Silva |    55 | F    |
|                   5 | João B Silva     | Michael B Silva   |    34 | M    |
|                   5 | Fernando T Wong  | Alicia T Wong     |    36 | F    |
|                   5 | Fernando T Wong  | Janaina T Wong    |    64 | F    |
|                   5 | Fernando T Wong  | Tiago T Wong      |    38 | M    |
|                   4 | Jennifer S Souza | Antonio S Souza   |    80 | M    |
+---------------------+------------------+-------------------+-------+------+
(o sexo NÃO DEVE aparecer como M ou F, deve aparecer como “Masculino” ou “Feminino”)

7. SELECT salario, numero_departamento,
       CONCAT (
   (primeiro_nome), ' ',
   (nome_meio), ' ',
   (ultimo_nome)) as nome 
  from funcionario
  EXCEPT 
  SELECT cpf_funcionario as cpf, nome_dependente, parentesco
  from dependente
  INNER JOIN funcionario on (dependente.cpf_funcionario=funcionario.cpf);
+---------+---------------------+------------------+
| salario | numero_departamento | nome             |
+---------+---------------------+------------------+
| 30.00   | 5                   | João B Silva     |
| 40.00   | 5                   | Fernando T Wong  |
| 25.00   | 5                   | Joice A Leite    |
| 38.00   | 5                   | Ronaldo K Lima   |
| 55.00   | 1                   | Jorge E Brito    |
| 43.00   | 4                   | Jennifer S Souza |
| 25.00   | 4                   | André V Pereira  |
| 25.00   | 4                   | Alice J Zelaya   |
+---------+---------------------+------------------+


prepare um relatório que mostre, para cada funcionário que NÃO
TEM dependente, seu nome completo, departamento e salário.








