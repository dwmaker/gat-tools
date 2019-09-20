@set NLS_LANG=.AL32UTF8
@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@(
@echo whenever sqlerror exit failure;
@echo whenever oserror exit failure;
@echo set serveroutput on;
@echo set timing on;
@echo SET LINESIZE 500;
@echo SET TRIMSPOOL ON;
@echo @"%~dpn0.sql"
@echo set timing off;
@echo exit;
)|sqlplus -S -L "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%"

@IF %ERRORLEVEL% NEQ 0 exit /b 1


@rem @echo spool "%~dp0.\sql_consolida_core.log" append;