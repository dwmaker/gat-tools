@call :initfile
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DCTV1HP)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-VSMS01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=DBRI1MG)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))"
@call :getdata "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))"
@goto :endfile
C:\git\gat-tools\public\components\asm-disk\asm-disk-service.js
:initfile
@if exist "%~dp0..\public\components\asm-disk\~asm-disk-service.js" @del "%~dp0..\public\components\asm-disk\~asm-disk-service.js"
@type "%~dp0.\template_disk_service_begin.js" >> "%~dp0..\public\components\asm-disk\~asm-disk-service.js"
@goto :eof

:getdata
sqlplus -s -l %1 "@%~dp0.\spool_disk_service.sql" "%~dp0..\public\components\asm-disk\~asm-disk-service.js"
@goto :eof

:endfile
@type "%~dp0.\template_disk_service_end.js" >> "%~dp0..\public\components\asm-disk\~asm-disk-service.js"
@if exist "%~dp0..\public\components\asm-disk\asm-disk-service.js" @del "%~dp0..\public\components\asm-disk\asm-disk-service.js"
@copy "%~dp0..\public\components\asm-disk\~asm-disk-service.js" "%~dp0..\public\components\asm-disk\asm-disk-service.js"
@if exist "%~dp0..\public\components\asm-disk\~asm-disk-service.js" @del "%~dp0..\public\components\asm-disk\~asm-disk-service.js"