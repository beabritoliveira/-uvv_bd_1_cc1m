-- Pergunta 1
select avg(salario) from funcionario;

-- Pergunta 2
select sexo, avg(salario) from funcionario group by sexo;

-- Pergunta 3
select nome_departamento, CONCAT (
    (primeiro_nome), ' ',
    (nome_meio), ' ',
    (ultimo_nome)) as nome, Floor(DATEDIFF(NOW(), data_nascimento) / 365) AS idade, data_nascimento, salario
    from departamento 
    inner join funcionario on (departamento.numero_departamento=funcionario.numero_departamento);
    
-- Pergunta 4
select salario,  salario*1.2 as salario_reajustado, CONCAT (
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
    
-- Pergunta 5

-- Pergunta 6

-- Pergunta 7
SELECT salario,  numero_departamento, CONCAT (
   (primeiro_nome), ' ',
   (nome_meio), ' ',
   (ultimo_nome)) as nome
   from funcionario 
   EXCEPT
SELECT salario,  numero_departamento, CONCAT (
   (primeiro_nome), ' ',
   (nome_meio), ' ', 
   (ultimo_nome)) as nome
  from dependente
  INNER JOIN funcionario on (dependente.cpf_funcionario=funcionario.cpf);
  
-- Pergunta 8
SELECT nome_departamento, nome_projeto, CONCAT (
   (primeiro_nome), ' ',
   (nome_meio), ' ', 
   (ultimo_nome)) as nome, horas
   from projeto
   INNER JOIN funcionario ON (projeto.numero_departamento=funcionario.numero_departamento)
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   GROUP BY nome_departamento, nome_projeto, nome;
   
-- Pergunta 9
SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '1'
   UNION
   SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '2'
   UNION
      SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '3'
   UNION
   SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '10'
   UNION
   SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '20'
   UNION
   SELECT projeto.nome_projeto, departamento.nome_departamento, sum(horas) as horas
   from projeto
   INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
   INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
   where trabalha_em.numero_projeto = '30'
   ;
   
-- Pergunta 10
SELECT nome_departamento, funcionario.numero_departamento, avg(salario) as mediaSalarial
    from funcionario 
    INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
    WHERE funcionario.numero_departamento = '1'
    UNION
    SELECT nome_departamento, funcionario.numero_departamento, avg(salario) as mediaSalarial
    from funcionario 
    INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
    WHERE funcionario.numero_departamento = '4'
    UNION
    SELECT nome_departamento, funcionario.numero_departamento, avg(salario) as mediaSalarial
    from funcionario 
    INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
    WHERE funcionario.numero_departamento = '5';
    
-- Pergunta 11
SELECT distinct nome_projeto, CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome, horas*50 as recebido
     from trabalha_em
     INNER JOIN projeto ON (trabalha_em.numero_projeto=projeto.numero_projeto)
     INNER JOIN funcionario ON (trabalha_em.cpf_funcionario=funcionario.cpf) 
     ORDER BY projeto.numero_projeto asc;
     
-- Pergunta 12
SELECT  CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome, nome_projeto, nome_departamento
     from funcionario 
     INNER JOIN trabalha_em ON (funcionario.cpf=trabalha_em.cpf_funcionario)
     INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
     INNER JOIN projeto ON (projeto.numero_departamento=departamento.numero_departamento)
     WHERE trabalha_em.horas = 0;
     
-- Pergunta 13
SET @dataReferencia = '2022-06-12';
SELECT CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome_dos_presenteados, funcionario.sexo, (
    CASE 
        WHEN 
        MONTH(@dataReferencia) > MONTH(funcionario.data_nascimento) -- *1
        OR
        -- *2
        (
            MONTH(@dataReferencia) = MONTH(funcionario.data_nascimento) 
            AND DAY(@dataReferencia) >= DAY(funcionario.data_nascimento) 
        )
    THEN Floor(DATEDIFF(NOW(), funcionario.data_nascimento) / 365) 
    ELSE Floor(DATEDIFF(NOW(), funcionario.data_nascimento) / 365) -1 END
) as idade
     from funcionario
     UNION
    SELECT CONCAT (
   (nome_dependente), ' ',
   (nome_meio), ' ',
   (ultimo_nome)) as nome_dos_presenteados, dependente.sexo, (
    CASE 
        WHEN 
        MONTH(@dataReferencia) > MONTH(dependente.data_nascimento) -- *1
        OR
        -- *2
        (
            MONTH(@dataReferencia) = MONTH(dependente.data_nascimento) 
            AND DAY(@dataReferencia) >= DAY(funcionario.data_nascimento) 
        )
    THEN Floor(DATEDIFF(NOW(), dependente.data_nascimento) / 365) 
    ELSE Floor(DATEDIFF(NOW(), dependente.data_nascimento) / 365) -1 END
) as idade
   from dependente
   INNER JOIN funcionario ON (dependente.cpf_funcionario=funcionario.cpf)
   ORDER BY idade desc; 

-- Pergunta 14
SELECT funcionario.numero_departamento, nome_departamento, count(cpf) as numFuncionarios
 from funcionario 
 INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
 WHERE funcionario.numero_departamento = '1'
 UNION
SELECT funcionario.numero_departamento, nome_departamento, count(cpf) as numFuncionarios
 from funcionario 
 INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
 WHERE funcionario.numero_departamento = '4'
 UNION
 SELECT funcionario.numero_departamento, nome_departamento, count(cpf) as numFuncionarios
 from funcionario 
 INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento)
 WHERE funcionario.numero_departamento = '5';
 
-- Pergunta 15
SELECT distinct CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome, funcionario.numero_departamento, nome_departamento, nome_projeto
     from projeto 
     INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
     INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
     INNER JOIN funcionario ON (projeto.numero_departamento=funcionario.numero_departamento)
     UNION
SELECT  CONCAT (
     (primeiro_nome), ' ',
     (nome_meio), ' ',
     (ultimo_nome)) as nome, funcionario.numero_departamento, nome_departamento, nome_projeto
     from projeto 
     INNER JOIN departamento ON (projeto.numero_departamento=departamento.numero_departamento)
     INNER JOIN trabalha_em ON (projeto.numero_projeto=trabalha_em.numero_projeto)
     INNER JOIN funcionario ON (projeto.numero_departamento=funcionario.numero_departamento)
     WHERE projeto.nome_projeto is null    
     ORDER BY nome asc;
     
