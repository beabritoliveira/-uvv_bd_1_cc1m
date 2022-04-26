CREATE ROLE beatriz WITH
  LOGIN 
PASSWORD 'computacao@raiz'
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
  BYPASSRLS;

CREATE DATABASE uvv
    WITH  OWNER = beatriz
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1
\g

\q 
psql -U beatriz -W
computacao@raiz

CREATE SCHEMA IF NOT EXISTS elmasri  AUTHORIZATION beatriz;

set search_path to elmasri,'beatriz', public  \g

alter user beatriz
set search_path to elmasri, 'beatriz', public \g

CREATE TABLE IF NOT EXISTS elmasri.funcionario
(
    cpf character(11) COLLATE pg_catalog."default" NOT NULL,
    primeiro_nome character varying(15) COLLATE pg_catalog."default" NOT NULL,
    nome_meio character(1) COLLATE pg_catalog."default",
    ultimo_nome character varying(15) COLLATE pg_catalog."default" NOT NULL,
    data_nascimento character varying COLLATE pg_catalog."default",
    endereco character varying(30) COLLATE pg_catalog."default",
    sexo character(1) COLLATE pg_catalog."default",
    salario numeric(10,2),
    cpf_supervisor character(11) COLLATE pg_catalog."default" NOT NULL,
    numero_departamento integer NOT NULL,
    CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
) \g

COMMENT ON TABLE elmasri.funcionario
    IS 'Tabela que armazena as informações dos funcionários.';

COMMENT ON COLUMN elmasri.funcionario.cpf
    IS 'CPF do funcionário. Será a PK da tabela';

COMMENT ON COLUMN elmasri.funcionario.primeiro_nome
    IS 'Primeiro nome do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.nome_meio
    IS 'Inicial do nome do meio.';

COMMENT ON COLUMN elmasri.funcionario.ultimo_nome
    IS 'Sobrenome do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.endereco
    IS 'Endereço do funcionário';

COMMENT ON COLUMN elmasri.funcionario.sexo
    IS 'Sexo do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.salario
    IS 'Salário do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor
    IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';

COMMENT ON COLUMN elmasri.funcionario.numero_departamento
    IS 'Número do departamento do funcionário.';

CREATE TABLE IF NOT EXISTS elmasri.dependente
(
    cpf_funcionario character(11) COLLATE pg_catalog."default" NOT NULL,
    nome_dependente character varying(15) COLLATE pg_catalog."default" NOT NULL,
    sexo character(1) COLLATE pg_catalog."default",
    data_nascimento date,
    parentesco character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
) \g

COMMENT ON TABLE elmasri.dependente
    IS 'Tabela que armazena as informações dos dependentes dos funcionários.';

COMMENT ON COLUMN elmasri.dependente.cpf_funcionario
    IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

COMMENT ON COLUMN elmasri.dependente.nome_dependente
    IS 'Nome do dependente. Faz parte da PK desta tabela.';

COMMENT ON COLUMN elmasri.dependente.sexo
    IS 'Sexo do dependente.';

COMMENT ON COLUMN elmasri.dependente.data_nascimento
    IS 'Data de nascimento do dependente.';

COMMENT ON COLUMN elmasri.dependente.parentesco
    IS 'Descrição do parentesco do dependente com o funcionário.';

CREATE TABLE IF NOT EXISTS elmasri.localizacoes_departamento (
    numero_departamento integer NOT NULL,
    local character varying(15) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
) \g

COMMENT ON TABLE elmasri.localizacoes_departamento
    IS 'Tabela que armazena as possíveis localizações dos departamentos.';

COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento
    IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';

COMMENT ON COLUMN elmasri.localizacoes_departamento.local
    IS 'Localização do departamento. Faz parte da PK desta tabela.';

CREATE TABLE IF NOT EXISTS elmasri.projeto
(
    numero_projeto integer NOT NULL,
    nome_projeto character varying(15) COLLATE pg_catalog."default" NOT NULL,
    local_projeto character varying(15) COLLATE pg_catalog."default",
    numero_departamento integer NOT NULL,
    CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto),
    CONSTRAINT projeto_un UNIQUE (nome_projeto)
) \g
COMMENT ON TABLE elmasri.projeto
    IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';

COMMENT ON COLUMN elmasri.projeto.numero_projeto
    IS 'Número do projeto. É a PK desta tabela.';

COMMENT ON COLUMN elmasri.projeto.nome_projeto
    IS 'Nome do projeto. Deve ser único.';

COMMENT ON COLUMN elmasri.projeto.local_projeto
    IS 'Localização do projeto.';

COMMENT ON COLUMN elmasri.projeto.numero_departamento
    IS 'Número do departamento. É uma FK para a tabela departamento.';

CREATE TABLE IF NOT EXISTS elmasri.trabalha_em
(
    cpf_funcionario character(11) COLLATE pg_catalog."default" NOT NULL,
    numero_projeto integer NOT NULL,
    horas numeric(3,1) NOT NULL,
    CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
) \g

COMMENT ON TABLE elmasri.trabalha_em
    IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario
    IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto
    IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';

COMMENT ON COLUMN elmasri.trabalha_em.horas
    IS 'Horas trabalhadas pelo funcionário neste projeto.';

CREATE TABLE IF NOT EXISTS elmasri.departamento 
(
    numero_departamento integer NOT NULL,
    nome_departamento character varying(15) COLLATE pg_catalog."default" NOT NULL,
    cpf_gerente character(11) COLLATE pg_catalog."default" NOT NULL,
    data_inicio_gerente character varying COLLATE pg_catalog."default",
    CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
) \g
CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

COMMENT ON TABLE elmasri.departamento
    IS 'Tabela que armazena as informaçoẽs dos departamentos.';

COMMENT ON COLUMN elmasri.departamento.numero_departamento
    IS 'Número do departamento. É a PK desta tabela.';

COMMENT ON COLUMN elmasri.departamento.nome_departamento
    IS 'Nome do departamento. Deve ser único.';

COMMENT ON COLUMN elmasri.departamento.cpf_gerente
    IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';

COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente
    IS 'Data do início do gerente no departamento.';

INSERT INTO elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES 
(‘João’,’B’, ‘Silva’, 12345678966 , 01091965 ,‘Rua da Flor,751,São Paulo/SP’, ‘M’, 30.000, 33344555587, 5
);
INSERT INTO funcionario  (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Jennifer’, ‘S’, ‘Souza’, 98765432168, 19410620, ‘Av Artur Lima,54,Santo André,SP’, ‘F’, 43.000, 88866555576, 4
);
INSERT INTO funcionario  (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Fernando’, ‘T’, ‘Wong’, 33344555587, 19551208, ‘Rua da Lapa, 34, São Paulo, SP’, ‘M’, 40.000, 88866555576, 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
'André', 'V', 'Pereira', 98798798733, 19690329, 'Rua Timbira, 35, São Paulo, SP', 'M', 25.000, 98765432168, 4
);
INSERT INTO funcionario  (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Ronaldo’, ‘K’, ‘Lima’, 66688444476, 19620915, ‘Rua Rebouças,65,Piracicaba,SP’, ‘M’, 38.000, 33344555587, 5
);
INSERT INTO funcionario  (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Joice’, ‘A’, ‘Leite’, 45345345376, 19720731, ‘Av. Lucas Obes,74,São Paulo,SP’, ‘F’, 25.000, 33344555587, 5
);
INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Jorge’, ‘E’, ‘Brito’, 88866555576, 19371110, ‘Rua do Horto,35,São Paulo, SP’, ‘M’, 55.000,’ ‘, 1
);
INSERT INTO funcionario  (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento,endereco, sexo, salario, cpf_supervisor, numero_departamento) VALUES (
‘Alice’, ‘J’, ‘Zelaya’, 99988777767, 19680119, ‘Rua Souza Lima,35,São Paulo,SP’, ‘F’, 25.000, 98765432168, 4
);

INSERT INTO departamento (numero_departamento,nome_departamento, cpf_gerente, data_inicio_gerente) VALUES (
5, 'Pesquisa', 33344555587, 19880522
);
INSERT INTO departamento (numero_departamento,nome_departamento, cpf_gerente, data_inicio_gerente) VALUES (
4, ‘Administração’, ‘98765432168’, ‘19950101’
);
INSERT INTO departamento (numero_departamento,nome_departamento, cpf_gerente, data_inicio_gerente) VALUES (
1, ‘Matriz’, 88866555576, 19810619
);
INSERT INTO localizacoes_departamento (numero_departamento, local) VALUES (
1, ‘São Paulo’
);
INSERT INTO localizacoes_departamento (numero_departamento, local) VALUES (
4, ‘Mauá’
);
INSERT INTO localizacoes_departamento (numero_departamento, local) VALUES (
5, ‘Santo André’
);
INSERT INTO localizacoes_departamento (numero_departamento, local) VALUES (
5, ‘Itu’
);
INSERT INTO localizacoes_departamento (numero_departamento, local) VALUES (
5, ‘São Paulo’
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘ProdutoX’, 1, ‘Santo André’, 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘ProdutoY’, 2, ‘Itu’, 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘ProdutoZ’, 3, ‘São Paulo’, 5
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘Informatização’, 10, ‘Mauá’, 4
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘Reorganização’, 20, ‘São Paulo’, 1
);
INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES(
‘Novosbenefícios’, 30, ‘Mauá’, 4
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
33344555587, ‘Alicia’, ‘F’, 19860405, ‘Filha’
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
33344555587, ‘Tiago’, ‘M’, 19831025, ‘Filho’
);
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
33344555587, ‘Janaina’, ‘F’, 19580503, ‘Esposa’
); 
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
98765432168, ‘Antonio’, ‘M’, 19420228, ‘Marido’
); 
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
12345678966, ‘Michael’, ‘M’, 19880104, ‘Filho’
); 
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
12345678966, ‘Alicia’, ‘F’, 19881230, ‘Filha’
); 
INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES(
12345678966, ‘Elizabeth’, ‘F’, 19670505, ‘Esposa’
); 
INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, hora) VALUES (
12345678966, 1, 32.5
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
12345678966, 2, 7.5
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
66688444476, 3, 40.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
45345345376, 1, 20.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
45345345376, 2, 20.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
33344555587, 2, 10.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
33344555587, 3, 10.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
33344555587, 10, 10.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
33344555587, 20, 10.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
99988777767, 30, 30.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
99988777767, 10, 10.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
98798798733, 10, 35.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
98798798733, 30, 5.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
98765432168, 30, 20.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
98765432168, 20, 15.0
);
INSERT INTO trabalha_em  (cpf_funcionario, numero_projeto, hora) VALUES (
88866555576, 20, 0
);

alter table funcionario
add constraint check (sexo in('M', 'F'));

alter table 
add constraint dependente check (sexo in('M', 'F'));

alter table funcionario
add constraint CHECK (salario>=0);

alter table trabalha_em
add constraint CHECK (hora>=0);

alter table departamento
add constraint CHECK (numero_departamento>=0);

alter table projeto
add constraint CHECK (numero_projeto>=0);

alter table departamento add foreign key (cpf_gerente) references funcionario (cpf);

alter table projeto add foreign key (numero_departamento) references departamento (numero_departamento);

alter table localizacoes_departamento add foreign key (numero_departamento) references departamento (numero_departamento);

alter table trabalha_em add foreign key (cpf_funcionario) references funcionario (cpf);

alter table trabalha_em add foreign key (numero_projeto) references projeto (numero_projeto);

alter table dependente add foreign key (cpf_funcionario) references funcionario (cpf);

alter table funcionário add foreign key (numero_departamento) references departamento (numero_departamento);

alter table funcionario add foreign key (cpf_supervisor) references funcionario (cpf);
