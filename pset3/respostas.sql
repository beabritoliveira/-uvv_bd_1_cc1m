SELECT c.codigo_pai, cc.nome, c.codigo, c.nome
FROM classificacao c
LEFT OUTER JOIN classificacao cc on (c.codigo_pai = cc.codigo) 
ORDER BY codigo_pai asc, codigo asc
;


WITH produtos AS (
  SELECT  d.nome as descricao, cl.nome as classificacao, c.nome as especificacao
  FROM classificacao c
 INNER JOIN classificacao cl 
	ON c.codigo_pai=cl.codigo
 INNER JOIN classificacao d
	ON cl.codigo_pai=d.codigo
  WHERE d.codigo_pai IS NULL
)
SELECT * FROM produtos
ORDER BY descricao ASC, classificacao ASC, especificacao ASC;


WITH produtos AS (
  SELECT  d.nome as descricao, cl.nome as classificacao, c.nome as especificacao
  FROM classificacao c
 INNER JOIN classificacao cl 
	ON c.codigo_pai=cl.codigo
 INNER JOIN classificacao d
	ON cl.codigo_pai=d.codigo
  WHERE d.codigo_pai IS NULL
UNION ALL
  SELECT  d.nome as descricao, cl.nome as classificacao, c.nome as especificacao
  FROM classificacao c
 INNER JOIN classificacao cl 
	ON c.codigo_pai=cl.codigo
 INNER JOIN classificacao d
	ON cl.codigo_pai=d.codigo
  WHERE d.codigo_pai IS NOT NULL
)
SELECT * FROM produtos
ORDER BY descricao ASC, classificacao ASC, especificacao ASC;
