/*
USO DE V�RIAVEIS E TABELAS TEMPOR�RIAS
*/

DECLARE @PANO INT --> DECLARA��O DE VARI�VEL

SET @PANO = 2018 --> DANDO UM VAOR PARA VARIAVEL

SELECT @PANO --> EXIBINDO O CONTE�DO DA VARI�VEL

-------------------------------------------------------------------------------
-- 1 DECALRADO VARIAVEIS
DECLARE @PANO INT --> DECLARA��O DE VARI�VEL
SET @PANO = 2018 --> DANDO UM VAOR PARA VARIAVEL

-- CRIADO TABELA TEMPOR�RIA
-- O USO # NA FRENTE DA TABELA INFORMA QUE ELA SER� USADA LOCALMENTE


CREATE TABLE #TMP_TESTE_1
(
TID INT,
TNOME VARCHAR(100),
TDATCAD SMALLDATETIME
)


INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2019-01-01')
INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2019-02-01')
INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2019-02-01')
INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2018-03-01')
INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2018-03-01')
INSERT #TMP_TESTE_1 VALUES (1, 'TESTE 1', '2018-03-01')




SELECT * 
FROM #TMP_TESTE_1 T
WHERE YEAR(TDATCAD) = @PANO