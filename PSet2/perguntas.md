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

3. select nome_departamento, primeiro_nome, nome_meio, ultimo_nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade, data_nascimento, salario
    ->     from departamento 
    ->     inner join funcionario on (departamento.numero_departamento=funcionario.numero_departamento);
+-------------------+---------------+-----------+-------------+-------+-----------------+---------+
| nome_departamento | primeiro_nome | nome_meio | ultimo_nome | idade | data_nascimento | salario |
+-------------------+---------------+-----------+-------------+-------+-----------------+---------+
| Pesquisa          | João          | B         | Silva       |    57 | 1965-01-09      |   30.00 |
| Pesquisa          | Fernando      | T         | Wong        |    66 | 1955-12-08      |   40.00 |
| Pesquisa          | Joice         | A         | Leite       |    49 | 1972-07-31      |   25.00 |
| Pesquisa          | Ronaldo       | K         | Lima        |    59 | 1962-09-15      |   38.00 |
| Matriz            | Jorge         | E         | Brito       |    84 | 1937-11-10      |   55.00 |
| Administração     | Jennifer      | S         | Souza       |    80 | 1941-06-20      |   43.00 |
| Administração     | André         | V         | Pereira     |    53 | 1969-03-29      |   25.00 |
| Administração     | Alice         | J         | Zelaya      |    54 | 1968-01-19      |   25.00 |
+-------------------+---------------+-----------+-------------+-------+-----------------+---------+


4. select salario,  salario*1.2 as reajuste, primeiro_nome, nome_meio, ultimo_nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade
    from funcionario
    where salario <35.000
    UNION
    select salario,  salario*1.15 as reajuste, primeiro_nome, nome_meio, ultimo_nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade
    from funcionario
    where salario >=35.000;
+---------+----------+---------------+-----------+-------------+-------+
| salario | reajuste | primeiro_nome | nome_meio | ultimo_nome | idade |
+---------+----------+---------------+-----------+-------------+-------+
|   30.00 |  36.0000 | João          | B         | Silva       |    57 |
|   25.00 |  30.0000 | Joice         | A         | Leite       |    49 |
|   25.00 |  30.0000 | André         | V         | Pereira     |    53 |
|   25.00 |  30.0000 | Alice         | J         | Zelaya      |    54 |
|   40.00 |  46.0000 | Fernando      | T         | Wong        |    66 |
|   38.00 |  43.7000 | Ronaldo       | K         | Lima        |    59 |
|   55.00 |  63.2500 | Jorge         | E         | Brito       |    84 |
|   43.00 |  49.4500 | Jennifer      | S         | Souza       |    80 |
+---------+----------+---------------+-----------+-------------+-------+


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
ORDER BY salario DESC;

UNION
SELECT nome_departamento, cpf_gerente
from departamento
ORDER BY nome_departamento ASC;

Select salario, (primeiro_nome + '' + nome_meio + '' + ultimo_nome) as nome
from funcionario
ORDER BY salario DESC
UNION
Select nome_departamento, cpf_gerente
from departamento
ORDER BY nome_departamento ASC;

para cada departamento, o nome
do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente)











