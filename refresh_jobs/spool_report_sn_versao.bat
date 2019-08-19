@set NLS_LANG=.AL32UTF8
@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@call "%~dp0.\config.bat"
@echo * "%~dp0..\public\components\versao-netsms\versao-netsms-view.html"
@sqlplus -l "%GATDB_USR%/%GATDB_PWD%@%GATDB_CNX%" "@%~dpn0.sql" "%~dp0..\public\components\versao-netsms\versao-netsms-view.html"
