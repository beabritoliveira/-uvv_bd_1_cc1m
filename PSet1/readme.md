# *Descrição dos processos do PSet 1*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### Aluna: Beatriz Brito Oliveira
#### Professor: Abrantes Araujo Silva Filho
#### Monitora: Suellen Miranda Amorim
#### Turma: CC1MB
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## *Modelo/Projeto Elmasri no Power Arquitect* 
* No desenvolvimento do exemplo de banco de dados a utilização do power arquitect se fez essencial para a construção de um projeto que demonstra as caracteristícas do banco com o objetivo de melhor compreensão do que será efetuado no sistema. O que foi efetuado está dentro do arquivo ***modeloElmasri.architect***, que conta com o script de como construir as tabelas (funcionario, departamento, dependente, projeto, trabalha_em, localizacoes_departamento), suas colunas, restriçoes, indices, chaves primarias e únicas, além dos comentários.

## *Script do MariaDB*
* O modelo proposto no livro do Elmasri foi implementado no SGBD MariaDB ou MySQL, em que o código gerado foi adequado para atender as necessidades propostas no trabalho e construir as tabelas e colunas de forma que tivessem em plena função, desse modo, os comandos foram feitos para respeitas as chaves primarias e chaves únicas de cada registros, além de especificar as relações que formam as chaves estrangeiras e que permitem que, assim, o script realize e imponha todas as restrições necessarias para atender as exigências que seriam impostas ao banco de dados. Esta parte do PSet está presente no arquivo ***scriptmariadb.sql***.

## *Script do PostgreSQL*
* No presente trabalho também foi feito o processo do script no SGBD PostgreSQL, em que teve caráter semelhante ao realizado no MariaDB, por apenas sofrer mudanças na sintaxe, em decorrência do conteúdo em si ser o mesmo do efetuado no outro sistema de gerenciamento de banco de dados. Dessa forma o arquivo ***scriptpostgres.sql*** possui as tabelas exigidas no projeto Elmasri, suas colunas (como cpf, salario, local, hora, etc), chaves unicas (das tabelas projeto e departamento) e primárias, chaves estrangeiras, que serviam como relações entre duas tabelas, além dos dados inseridos de acordo com o exigido da implementação pelo modelo.

#### Alguns detalhes nos scripts que precisam de atenção 
* Ao inserir os scripts no terminal é necessário prestar atenção se será exigido as senhas do usuário, se aparecer é necessario preencher como "computacao@raiz", nos dois SGBD a senha é a mesma para o usuário.
