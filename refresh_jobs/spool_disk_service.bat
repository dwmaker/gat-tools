@CHCP 1252>nul

@call :makefile "%~dp0..\public\components\asm-disk\asm-disk-service.js"
pause
@goto :sucesso

:makefile
@echo * %~nx1 
@if exist "%~dp1~%~nx1" del "%~dp1~%~nx1"
sqlplus -s -l "dbanovosms/themask@ddad10g.world" "@%~dpn0.sql" "%~dp1~%~nx1"
@if exist "%~dp1~%~nx1" @(
@del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
)
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1
