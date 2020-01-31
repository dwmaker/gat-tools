@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@call :makelist "%~dp0..\public\components\detalhe-servidor\lista_conexao.txt"

@REM GERANDO ARQUIVOS VIRGENS
@for /f "tokens=1,2,3,4,5,6* skip=1 delims=	" %%A in (%~dp0..\public\components\detalhe-servidor\lista_conexao.txt) do @(
  @if not exist "%~dp0..\public\components\detalhe-servidor\%%A.json" (
    @call spool_report_detalhe_servidor.bat "%%A"
	)
)


@REM GERANDO TUDO
@for /f "tokens=1,2,3,4,5,6* skip=1 delims=	" %%A in (%~dp0..\public\components\detalhe-servidor\lista_conexao.txt) do @(
@call spool_report_detalhe_servidor.bat "%%A"
)

@exit /b 0

:makelist
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
@echo @"%~dp0.\spool_txt_lista_conexao.sql"
@echo spool off;
@echo exit;
) | @sqlplus -s -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" 
@IF %ERRORLEVEL% EQU 0 ( 
  @if exist "%~dpnx1" @(del "%~dpnx1")
	@ren "%~dp1~%~nx1" "%~nx1"
) ELSE ( 
  type "%~dp1~%~nx1"
	@exit /b 1
)
@goto :eof




