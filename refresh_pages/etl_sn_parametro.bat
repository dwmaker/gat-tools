echo %time%
(
@echo set serveroutput on;
@echo exec dbanovosms.pr_etl_parametro;
@echo exit;
) | sqlplus -s -l dbanovosms/themask@ddad10g.world
echo %time%
pause