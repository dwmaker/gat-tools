@set nls_lang=american_america.we8mswin1252
@CHCP 1252>nul
@call "%~dp0.\config.bat"


@rem @call :makefile "%~dp0..\public\components\detalhe-servidor\GA_CERT_NETSMS_BRA.NET.json" "GA_CERT_NETSMS_BRA.NET" "GA_PROD_NETSMS_BRA.NET"
@for /f "tokens=1,2,3,4,5,6* delims=	" %%A in (%~dp0..\public\components\detalhe-servidor\lista_conexao.txt) do @(
@call :makefile "%~dp0..\public\components\detalhe-servidor\%%A.json" "%%A"
)
@goto :sucesso

:makefile
@echo * %~dpnx1 
@if exist "%~dp1~%~nx1" del "%~dp1~%~nx1"
@(
@echo whenever sqlerror exit failure;
@echo whenever oserror exit failure;
@echo SET SERVEROUTPUT ON FORMAT TRUNCATED;
@echo set trimspool on;
@echo set linesize 10000;
@echo SET feedback off;
@echo set termout off;
@echo SET VERIFY OFF;
@echo spool "%~dp1~%~nx1";
@echo @"%~dpn0.sql" %2 %3
@echo spool off;
@echo exit;
) | @sqlplus -s -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" 
@if exist "%~dp1~%~nx1" @(
@if exist "%~dpnx1" @(del "%~dpnx1")
@ren "%~dp1~%~nx1" "%~nx1"
)
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1
