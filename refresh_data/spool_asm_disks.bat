@CHCP 1252>nul

@call :makefile "%~dp0.\..\data\asmdisk-data-net001ht4sun002b.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001PRDM9K011.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001TT4SUN001.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001PRDM9K013.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001FT4SUN001.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-net001prdm9k010a.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-net001ht4sun002a.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001FT4SUN002.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))"
@call :makefile "%~dp0.\..\data\asmdisk-data-NET001FT4SUN001.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))"
@goto :sucesso

:makefile
@echo * %~nx1 
@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
@sqlplus -s -l %2 "@%~dpn0.sql" > "%~dp1~%~nx1"
@if errorlevel 1 @type "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1