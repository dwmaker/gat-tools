@set NLS_LANG=.AL32UTF8
@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252

@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
@(
@echo SET SERVEROUTPUT ON FORMAT TRUNCATED;
@echo set trimspool on;
@echo set linesize 10000;
@echo SET feedback off;
@echo WHENEVER SQLERROR EXIT FAILURE
@echo WHENEVER OSERROR EXIT FAILURE
@echo @"%~dp0.\%~n0.sql"
@echo exit;
) | sqlplus -s -l %2 > "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
