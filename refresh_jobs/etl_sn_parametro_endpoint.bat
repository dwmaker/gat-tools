@set NLS_LANG=.AL32UTF8
@CHCP 1252 1>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@sqlplus -s -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" "@%~dp0.\etl_sn_parametro_endpoint.sql"
