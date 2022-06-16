SELECT c.codigo_pai, cc.nome, c.codigo, c.nome
FROM classificacao c
LEFT OUTER JOIN classificacao cc on (c.codigo_pai = cc.codigo) 
ORDER BY codigo_pai asc, codigo asc
;
