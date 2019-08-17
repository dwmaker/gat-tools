@set NLS_LANG=.AL32UTF8
@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@call :makefile "%~dp0..\public\components\asm-disk\asm-disk-service.js"
@goto :sucesso

:makefile
@echo * %~dpnx1 
@if exist "%~dp1~%~nx1" del "%~dp1~%~nx1"
@sqlplus -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" "@%~dpn0.sql" "%~dp1~%~nx1"
@if exist "%~dp1~%~nx1" @(
@del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
)
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1
