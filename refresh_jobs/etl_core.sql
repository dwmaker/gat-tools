declare
/*****************************************************
***   sql_consolida_core.sql
***   Autor: Paulo Ponciano - Spread
***   Data: 27/05/2019
***   Objetivo: 
***     Consolidar o log de acessos de todas as bases cadastradas 
***     em uma única tabela através de DBLink
*****************************************************/
procedure pr_importa_base (p_dblink_name in varchar2, p_rowcount out integer) 
is
begin
execute immediate 'MERGE INTO core.core D ' ||
'USING ' ||
'(' ||
'select ' ||
'cor.OSUSER, ' ||
'cor.USERNAME, ' ||
'cor.MACHINE, ' ||
'cor.BASE, ' ||
'max(cor.NOME_COMPLETO) NOME_COMPLETO, ' ||
'min(cor.DT_INI) DT_INI, ' ||
'max(cor.DT_FIM) DT_FIM, ' ||
'max(cor.PROJETO) PROJETO, ' ||
'max(cor.OBS) OBS, ' ||
'max(cor.APLICACAO) APLICACAO, ' ||
'sum(cor.QTD_ACESSOS) QTD_ACESSOS, ' ||
'max(cor.ULTIMO_ACESSO) ULTIMO_ACESSO ' ||
'from ' ||
'core.core@'|| p_dblink_name ||' cor ' ||
'group by ' ||
'cor.OSUSER, ' ||
'cor.USERNAME, ' ||
'cor.MACHINE, ' ||
'cor.BASE ' ||
'minus ' ||
'select ' ||
't.OSUSER, ' ||
't.USERNAME, ' ||
't.MACHINE, ' ||
't.BASE, ' ||
't.NOME_COMPLETO, ' ||
't.DT_INI, ' ||
't.DT_FIM, ' ||
't.PROJETO, ' ||
't.OBS, ' ||
't.APLICACAO, ' ||
't.QTD_ACESSOS, ' ||
't.ULTIMO_ACESSO ' ||
'from ' ||
'core.core t' ||
') S ON (D.OSUSER = S.OSUSER and D.USERNAME = S.USERNAME and D.MACHINE = S.MACHINE and D.BASE = S.BASE) ' ||
'WHEN MATCHED THEN UPDATE SET ' ||
'd.NOME_COMPLETO = s.NOME_COMPLETO, ' ||
'd.DT_INI = s.DT_INI, ' ||
'd.DT_FIM = s.DT_FIM, ' ||
'd.PROJETO = s.PROJETO, ' ||
'd.OBS = s.OBS, ' ||
'd.APLICACAO = s.APLICACAO, ' ||
'd.QTD_ACESSOS = s.QTD_ACESSOS, ' ||
'd.ULTIMO_ACESSO = s.ULTIMO_ACESSO ' ||
'WHEN NOT MATCHED THEN INSERT ' ||
'(' ||
'd.OSUSER, ' ||
'd.USERNAME, ' ||
'd.MACHINE, ' ||
'd.BASE, ' ||
'd.NOME_COMPLETO, ' ||
'd.DT_INI, ' ||
'd.DT_FIM, ' ||
'd.PROJETO, ' ||
'd.OBS, ' ||
'd.APLICACAO, ' ||
'd.QTD_ACESSOS, ' ||
'd.ULTIMO_ACESSO ' ||
') ' ||
'VALUES ' ||
'( ' ||
's.OSUSER, ' ||
's.USERNAME, ' ||
's.MACHINE, ' ||
's.BASE, ' ||
's.NOME_COMPLETO, ' ||
's.DT_INI, ' ||
's.DT_FIM, ' ||
's.PROJETO, ' ||
's.OBS, ' ||
's.APLICACAO,' ||
's.QTD_ACESSOS, ' ||
's.ULTIMO_ACESSO ' ||
')';
p_rowcount := SQL%ROWCOUNT;
end;
begin

	dbms_output.put_line('=========================================');
	
	dbms_output.put_line('Inicio: ' || to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'));
	for x in (select * from vw_conexao where cd_ambiente != 'PROD' and cd_aplicacao='NETSMS') loop
		declare 
		p_dblink_name varchar2(100) := x.cd_conexao;
		p_rowcount integer := 0; 
		begin
		pr_importa_base(p_dblink_name => p_dblink_name, p_rowcount => p_rowcount);
		commit;
		dbms_output.put_line('=> '||p_dblink_name|| ' - ' || p_rowcount || ' linhas atualizadas');
		
		exception when others THEN 
			dbms_output.put_line('=> '||p_dblink_name|| ' - failed -' || replace(SQLERRM,chr(10),' '));
		end;
		
	end loop;
	commit;
end;
/
