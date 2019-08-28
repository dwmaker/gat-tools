exit|sqlplus -L "paulo_ponciano/welcome1@(DESCRIPTION=(CONNECT_DATA=(SERVICE_NAME=xe))(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521)))" "@%~dp0.\uninstall.sql"
call :RUN "%~dp0.\install.sql"
call :RUN "%~dp0.\data\TB_MAPA.sql"
call :RUN "%~dp0.\data\TB_MAPA_SERVIDOR.sql"
call :RUN "%~dp0.\data\TB_MAPA_USUARIO.sql"
call :RUN "%~dp0.\programables\pkg_mapa.pks"
call :RUN "%~dp0.\programables\pkg_mapa.pkb"
pause
cls
call :RUN "%~dp0.\teste_LST_MAPA.sql"
goto :SUCESSO

:run
@ECHO *** %~nx1
@(
@echo whenever sqlerror exit failure;
@echo @%1;
)|sqlplus -S -L "paulo_ponciano/welcome1@(DESCRIPTION=(CONNECT_DATA=(SERVICE_NAME=xe))(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521)))"
@if %ERRORLEVEL% equ 0 (
GOTO :EOF
) ELSE (
GOTO :FALHA
)


:SUCESSO
timeout /t 15
exit /b 0

:FALHA
@ECHO FINALIZADO COM ERRO
pause
exit /b 1