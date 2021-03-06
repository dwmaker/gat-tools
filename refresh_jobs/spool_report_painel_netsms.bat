@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@call :makefile "%~dp0..\public\components\painel-netsms\painel-netsms-data.json"
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
@echo spool "%~dp1~%~nx1";
@echo @"%~dpn0.sql"
@echo spool off;
@echo exit;
) | @sqlplus -s -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" 
@IF %ERRORLEVEL% EQU 0 ( 
  @if exist "%~dpnx1" @(del "%~dpnx1")
	@ren "%~dp1~%~nx1" "%~nx1"
) ELSE ( 
  type "%~dp1~%~nx1"
)
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1

