
  
ALTER PROCEDURE [dbo].[SP_CONTRATO_FORNEC_PENDENTES_NF]  
AS  
BEGIN  
    /*CRIAR TABELA TEMPORÁRIA*/  
    CREATE TABLE #TEMP  
    (  
	TCONTR INT,  
	TCODCLIFOR INT,  
    TNOMEAB VARCHAR(30),  
    TSERIE VARCHAR (3),  
    TDOC VARCHAR (20),  
    TTIPDOC VARCHAR (4),  
    TCODFIL INT,  
    TSITUAC VARCHAR(1),  
    TVALOR VARCHAR (10),  
    TVENC VARCHAR (11),  
    TDIAS INT  
   /* TRESPONS VARCHAR (20),  
    TEMAIL VARCHAR (100)*/  
    );  
     
  /*SCRIPT PARA SELECIONAR AS PARCELAS*/  
    INSERT INTO #TEMP  
      
    SELECT DISTINCT
        PAGCON."CODIGO" AS CONTRATO,
        PAGDOCI."CODCLIFOR",
        RODCLI."NOMEAB",
        PAGDOCI."SERIE",
        PAGDOCI."NUMDOC",
        PAGDOC."TIPDOC",
        PAGDOC."CODFIL",
        PAGDOCI."SITUAC",
        PAGDOCI.VLRPAR,
        RIGHT('00' + CAST(DAY(PAGDOCI.DATVEN) AS VARCHAR), 2) + '/'
        + RIGHT('00' + CAST(MONTH(PAGDOCI.DATVEN) AS VARCHAR), 2) + '/'
        + CAST(YEAR(PAGDOCI.DATVEN) AS VARCHAR) AS DATAVEN,
        DATEDIFF(dd, GETDATE(), datven) AS DIAS
FROM    ( dbo.PAGCON PAGCON
          LEFT OUTER JOIN dbo.PAGDOC PAGDOC ON PAGCON."CODCLIFOR" = PAGDOC."CODCLIFOR"
                                               AND PAGCON."CODIGO" = PAGDOC."NUMCTF"
        )
        LEFT OUTER JOIN dbo.PAGDOCI PAGDOCI ON PAGDOC."CODCLIFOR" = PAGDOCI."CODCLIFOR"
                                               AND PAGDOC."SERIE" = PAGDOCI."SERIE"
                                               AND PAGDOC."NUMDOC" = PAGDOCI."NUMDOC"
        LEFT OUTER JOIN dbo.RODCLI RODCLI ON PAGDOCI."CODCLIFOR" = RODCLI."CODCLIFOR"
WHERE   PAGDOCI."SITUAC" = 'D'
        AND DATEDIFF(dd, GETDATE(), datven) BETWEEN '0' AND '16'  
        
--------------------------------- INICIO DA CRIAÇÃO DO ROBÔ --------------------------------------------    
	IF EXISTS (SELECT TOP 1 * FROM #TEMP)  --> AQUI ESTÁ INFORMANDO QUE PRECISA TER UM DADO PARA OS DEMAIS COMANDO SEREM EXECUTADOS
    
	BEGIN  
	  /*DECLARAÇÃO DE VARIÁVEIS PARA TABELA HTML*/  
	  DECLARE @tableHTML VARCHAR(MAX) ;  
	  DECLARE @readertableHTML VARCHAR(MAX) ;  
	  DECLARE @detailstableHTML VARCHAR(MAX) ;  
	  DECLARE @email_set VARCHAR(200) ;  
      --- "SETANDO" DADO PARA VARIAVEL. NESSE CASO VAZIO
	  SET @detailstableHTML = ''  
   
	  --- "SETANDO" INFORMAÇÕES DOS E-MAILS QUE RECEBERÃO O E-MAIL
	  SET @email_set = (SELECT STUFF((SELECT EMAIL+';' FROM RODOPE WHERE LOGIN IN ('CLAUDIA.CARMO') AND ATIVO = 'S' FOR XML PATH ('')),1,0,''))
  
	
	  SET @readertableHTML =  
	  N'<table border="0" width = "100%">' +  
	  N'<tr>' +  
	  N'<td width="20%"></td>' +  
	  N'<td width="60%" align="center"><font face="arial" size="2"><b>Contrato de Fornecedores Pendentes de NF</b></font></td>' +  
	  N'<td width="20%"></td>' +  
	  N'</tr>' +  
	  N'</table>';  
  
	  SET @detailstableHTML =    
	  N'<table border="0" cellpadding="0" cellspacing="0" width = "100%">' +  
	  N'<tr>' +  
	  N'<td width="100%">&nbsp;</td>' +  
	  N'</tr>' +  
	  N'</table>' +  
	  N'<table border="1" cellpadding="0" cellspacing="0" width = "100%">' +  
	  N'<tr>' +  
			N'<th width="10%" align="left" border="1"><font face="arial" size="2">CONTRATO&nbsp;</font></th>' +  /* CRIAÇÃO DO NOME DAS COLUNAS DA TABELA*/
	  N'<th width="10%" align="left" border="1"><font face="arial" size="2">CÓDIGO FORN&nbsp;</font></th>' +  
	  N'<th width="10%" align="left" border="1"><font face="arial" size="2">FORNECEDOR&nbsp;</font></th>' +  
	  N'<th width="10%" align="left" border="1"><font face="arial" size="2">SÉRIE&nbsp;</font></th>' +     
			N'<th width="10%" align="left" border="1"><font face="arial" size="2">DOCUMENTO&nbsp;</font></th>' +  
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">TIPO DOC&nbsp;</font></th>' +    
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">FILIAL&nbsp;</font></th>' +     
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">SITUAC&nbsp;</font></th>' +    
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">VALOR R$&nbsp;</font></th>' +    
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">VENCIMENTO&nbsp;</font></th>' +   
	  N'<th width="15%" align="left" border="1"><font face="arial" size="2">DIAS P/VENC&nbsp;</font></th>' +   
    
	  N'</tr>' +  
	  N'<tr>' +  

	  --- SELECT DA TABELA TEMPORÁRIA CRIADA ACIMA
	  CAST ( ( 
		SELECT td = TCONTR, '',
			   td = TCODCLIFOR, '',
			   td = TNOMEAB, '',
			   td = TSERIE, '',
			   td = TDOC, '',
			   td = TTIPDOC, '',
			   td = TCODFIL, '',
			   td = TSITUAC, '',
			   td = TVALOR, '',
			   td = TVENC, '',
			   td = TDIAS, ''FROM #TEMP   
		  FOR XML PATH('tr'), TYPE   
	  ) AS VARCHAR(MAX) ) +  
	  N'</table>' ;  
  
	  /*SCRIPT PARA ENVIO DO E-MAIL*/  
	  SET @tableHTML = @readertableHTML + @detailstableHTML  
	  EXEC msdb.dbo.sp_send_dbmail  
	  @profile_name = 'Envio de Email Automatizado',  
	  @recipients = @email_set,  
	  @body = @tableHTML,  
	  @body_format = 'HTML',  
	  @subject = 'Contratos Pendentes de NF'      --> NOME DO SUJECT QUE VAI APARECER NOS E-MAILS
	 END  
	END  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

GO


