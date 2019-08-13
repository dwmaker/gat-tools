set NLS_LANG=.AL32UTF8
CHCP 1252
set nls_lang=american_america.we8mswin1252

sqlplus -s -l dbanovosms/themask@ddad10g.world "@%~dpn0.sql" "%~dp0..\public\report_controle_acesso.html"
timeout /t 10