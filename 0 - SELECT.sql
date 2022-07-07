



--- SELECT : PERMITE PESQUISAR E VISUALIZAR DADOS DE UMA VIS�O (VIEW), TABELA OU COLUNA
/*
 comando select recupera os dados de uma ou mais tabelas, 
 sendo um dos comandos mais simples e, ao mesmo tempo, 
 mais extenso da SQL devido as suas fun��es, operandos, c
 omandos, sub-comandos e cl�usulas n�o obrigat�rias.
  


*/

-- SELECT EM TODA TABELA: MUITO CUIDADO AO USAR O SELECT * FROM TABELA, POIS VOC� PODE TRAVAR A TABELA OU A BASE DEPENDENDO DO N�MERO DE REGISTROS
SELECT * FROM RODCLI

-- SELECT DE UM �NICO REGISTRO DA TABELA
SELECT TOP 1 * FROM RODCLI

-- SELECT DE UM �NICO REGISTRO DA TABELA, POR�M TRAZENDO AS COLUNAS QUE SE QUER CONSULTAR
SELECT TOP 1 CODCLIFOR, RAZSOC, CODCGC FROM RODCLI

-- SELECT TRAZENDO AS 100 PRIMEIRAS LINHAS DA TABELA
SELECT TOP 100 * FROM RODCLI 

-- SELECT TRAZENDO AS 100 PRIMEIRAS LINHAS DA TABELA, POR�M INCLUIDO UMA CONDI��O WHERE PARA ESPECIFICAR AS LINHAS QUE SER�O CONSULTADAS
SELECT TOP 100 * FROM RODCLI WHERE CODCGR = 1

-- SELECT TRAZENDO AS 100 PRIMEIRAS LINHAS DA TABELA, POR�M USANDO O ORDER BY PARA ESCOLHER A ORDENA��O
SELECT TOP 100 DATINC, CODCLIFOR, RAZSOC
FROM RODCLI 
ORDER BY RODCLI.DATINC DESC

SELECT TOP 100 DATINC, CODCLIFOR, RAZSOC
FROM RODCLI 
ORDER BY RAZSOC ASC

---SELECT PARA TRAZER DADOS DE UMA CONDI��O ENTRE DOIS VALORES

SELECT RODCLI.DATINC, * 
FROM RODCLI
WHERE RODCLI.DATINC BETWEEN '2018-01-01' AND '2018-01-31'

-- SELECT COM AND NA CONDI��O WHERE
SELECT RODCLI.DATINC, * 
FROM RODCLI
WHERE RODCLI.DATINC >='2018-01-01' AND  RODCLI.DATINC <='2018-01-31'

-- SELECT COM OR NA CONDI��O WHERE
SELECT RODCLI.DATINC, * 
FROM RODCLI
WHERE (CONVERT(DATE,RODCLI.DATINC) ='2018-01-01' OR  CONVERT(DATE,RODCLI.DATINC) ='2018-01-03')

--  SELECT COM IN

SELECT TOP 5 * FROM RODCON
WHERE RODCON.CODPAG IN (1,2)
AND RODCON.DATCAD BETWEEN '2018-01-01' AND '2018-01-20'

--- SELECT COM LIKE 

SELECT * FROM RODCLI
WHERE RODCLI.RAZSOC LIKE '%AGROPALMA%'

SELECT * FROM RODCLI
WHERE RODCLI.RAZSOC LIKE 'AGROPALMA%'

SELECT * FROM RODCLI
WHERE RODCLI.RAZSOC LIKE '%AGROPALMA'

-- SELECT COM NOT

SELECT TOP 5 * FROM RODCLI
WHERE NOT RODCLI.RAZSOC LIKE '%AGROPALMA'

--- SELECT ELIMINANDO DUPLICIDADES

SELECT DISTINCT  RODCON.CODCON FROM RODCON
WHERE RODCON.DATCAD BETWEEN '2018-01-01' AND '2018-01-20'


