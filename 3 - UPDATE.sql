/*
UPDATE

-- USE DB_VISUAL_RODOPAR_21082018 --> FOR?A O USO DO BANCO DE DADOS
--BEGIN TRANSACTION  --> ABRE UMA TRANSA??O
--COMMIT --> FINALIZA A TRANSA??O QUE FOI ALTERADA
--ROLLBACK  --> CANCELA UMA TRANSA??O ALTERADA
*/


USE DB_VISUAL_RODOPAR_21082018

-- SELECT * FROM TMP_TREINAMENTO_FAST

BEGIN TRANSACTION

UPDATE TMP_TREINAMENTO_FAST SET TMP_DATNAS = '1995-01-01' WHERE TMP_ID = 1

COMMIT

-- OU

ROLLBACK


-- PARA ENCONTRAR A CONFIGURA??O DE UMA TABELA
SP_HELP TMP_TREINAMENTO_FAST



