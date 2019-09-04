call :sql_export_data TB_MAPA "%~dp0.\..\database\_branch\data\TB_MAPA.sql"
call :sql_export_data TB_MAPA_SERVIDOR "%~dp0.\..\database\_branch\data\TB_MAPA_SERVIDOR.sql"
call :sql_export_data TB_MAPA_USUARIO "%~dp0.\..\database\_branch\data\TB_MAPA_USUARIO.sql"

pause
goto :eof

:sql_export_data

@(
@echo SPOOL %2
@echo @"%~dp0.\sql_export_data.sql" CORE %1 CORE %1
)|sqlplus -S -L core/welcome1@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(service_name=xe)))
@goto :eof

pause