set serveroutput on;
set trimspool on;
set linesize 5000;
set feedback off;

declare
	procedure pr_scd_parametro_endpoint(
		p_dblink_name in core.sn_parametro_endpoint.dblink_name%type, 
		p_nr_del out integer, 
		p_nr_hst out integer, 
		p_nr_act out integer
		) is
	v_data_atual date := sysdate;
	begin
	
		-- Cria a tabela de trabalho
		declare sqlcmd varchar2(4000) :=
		'create table t$sn_parametro_endpoint ' || chr(10) || chr(13) || 
		'(' || chr(10) || chr(13) || 
		'ID_PARAMETRO_ENDPOINT, ' || chr(10) || chr(13) || 
		'TP_PROTOCOLO, ' || chr(10) || chr(13) || 
		'NM_HOST, ' || chr(10) || chr(13) || 
		'ID_SERVICO_SOA, ' || chr(10) || chr(13) || 
		'DS_ENDERECO, ' || chr(10) || chr(13) || 
		'nm_origem, ' || chr(10) || chr(13) || 
		'NR_VERSAO, ' || chr(10) || chr(13) || 
		'cid_contrato, ' || chr(10) || chr(13) || 
		'nr_porta, ' || chr(10) || chr(13) || 
		'dblink_name, ' || chr(10) || chr(13) || 
		'constraint t$sn_parametro_endpoint_pk primary key(ID_PARAMETRO_ENDPOINT, dblink_name)' || chr(10) || chr(13) || 
		')' || chr(10) || chr(13) || 
		'NOLOGGING ' || chr(10) || chr(13) || 
		'as select ' || chr(10) || chr(13) || 
		'ID_PARAMETRO_ENDPOINT, ' || chr(10) || chr(13) || 
		'TP_PROTOCOLO, ' || chr(10) || chr(13) || 
		'NM_HOST, ' || chr(10) || chr(13) || 
		'ID_SERVICO_SOA, ' || chr(10) || chr(13) || 
		'DS_ENDERECO, ' || chr(10) || chr(13) || 
		'nm_origem, ' || chr(10) || chr(13) || 
		'NR_VERSAO, ' || chr(10) || chr(13) || 
		'cid_contrato, ' || chr(10) || chr(13) || 
		'nr_porta, ' || chr(10) || chr(13) || 
		'''' || p_dblink_name || ''' as dblink_name ' || chr(10) || chr(13) || 
		'from prod_jd.sn_parametro_endpoint@' || p_dblink_name || '';
		begin
			execute immediate sqlcmd;
		end;
		
		-- Registros não encontrados na origem, serão atualizados para "Deleted"
		declare sqlcmd varchar2(4000) :=
		'UPDATE core.sn_parametro_endpoint T SET ' || chr(10) || chr(13) || 
		'T.st_parametro = ''D'', ' || chr(10) || chr(13) || 
		'T.dt_fim = to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') ' || chr(10) || chr(13) || 
		'WHERE T.st_parametro = ''A'' ' || chr(10) || chr(13) || 
		'AND T.dblink_name = ''' || p_dblink_name || ''' ' || chr(10) || chr(13) || 
		'AND NOT EXISTS ' || chr(10) || chr(13) || 
		'( ' || chr(10) || chr(13) || 
		'	SELECT * ' || chr(10) || chr(13) || 
		'	FROM ' || chr(10) || chr(13) || 
		'	t$sn_parametro_endpoint s ' || chr(10) || chr(13) || 
		'	WHERE ' || chr(10) || chr(13) || 
		'	S.ID_PARAMETRO_ENDPOINT = T.ID_PARAMETRO_ENDPOINT ' || chr(10) || chr(13) || 
		'	AND T.dblink_name = s.dblink_name ' || chr(10) || chr(13) || 
		')';
		begin
			execute immediate sqlcmd;
			p_nr_del := SQL%ROWCOUNT;
		end;
		
		-- Registro encontrados com valores diferentes na origem, serão atualizados para "History"
		declare sqlcmd varchar2(4000) :=
		'update core.sn_parametro_endpoint s set ' || chr(10) || chr(13) || 
		's.st_parametro = ''H'', ' || chr(10) || chr(13) || 
		's.dt_fim = to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') ' || chr(10) || chr(13) || 
		'WHERE s.st_parametro = ''A'' ' || chr(10) || chr(13) || 
		'AND s.dblink_name = ''' || p_dblink_name || ''' and ' || chr(10) || chr(13) || 
		'EXISTS ' || chr(10) || chr(13) || 
		'( ' || chr(10) || chr(13) || 
		'	SELECT * ' || chr(10) || chr(13) || 
		'	FROM t$sn_parametro_endpoint C ' || chr(10) || chr(13) || 
		'	WHERE C.ID_PARAMETRO_ENDPOINT = S.ID_PARAMETRO_ENDPOINT ' || chr(10) || chr(13) || 
		'	AND not ' || chr(10) || chr(13) || 
		'	( ' || chr(10) || chr(13) || 
		'		((C.TP_PROTOCOLO = S.TP_PROTOCOLO and C.TP_PROTOCOLO is not null and  S.TP_PROTOCOLO is not null) OR (C.TP_PROTOCOLO IS NULL AND S.TP_PROTOCOLO IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.NM_HOST = S.NM_HOST and C.NM_HOST is not null and S.NM_HOST is not null) OR (C.NM_HOST IS NULL AND S.NM_HOST IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.id_servico_soa = S.id_servico_soa and C.id_servico_soa is not null and S.id_servico_soa is not null) OR (C.id_servico_soa IS NULL AND S.id_servico_soa IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.ds_endereco = S.ds_endereco and C.ds_endereco is not null and S.ds_endereco is not null) OR (C.ds_endereco IS NULL AND S.ds_endereco IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.nm_origem = S.nm_origem and C.nm_origem is not null and S.nm_origem is not null) OR (C.nm_origem IS NULL AND S.nm_origem IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.nr_versao = S.nr_versao and C.nr_versao is not null and S.nr_versao is not null) OR (C.nr_versao IS NULL AND S.nr_versao IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.cid_contrato = S.cid_contrato and C.cid_contrato is not null and S.cid_contrato is not null) OR (C.cid_contrato IS NULL AND S.cid_contrato IS NULL)) ' || chr(10) || chr(13) || 
		'		and ' || chr(10) || chr(13) || 
		'		((C.nr_porta = S.nr_porta and C.nr_porta is not null and S.nr_porta is not null) OR (C.nr_porta IS NULL AND S.nr_porta IS NULL)) ' || chr(10) || chr(13) || 
		'	) ' || chr(10) || chr(13) || 
		')';
		begin
			execute immediate sqlcmd;
			p_nr_hst := SQL%ROWCOUNT;
		end;
		
		-- Registros não encontrados no destino, serão inseridos como "Active"
		declare sqlcmd varchar2(4000) :=
		'INSERT INTO core.sn_parametro_endpoint ' || chr(10) || chr(13) || 
		'( ' || chr(10) || chr(13) || 
		'dblink_name, ' || chr(10) || chr(13) || 
		'ID_PARAMETRO_ENDPOINT, ' || chr(10) || chr(13) || 
		'TP_PROTOCOLO, ' || chr(10) || chr(13) || 
		'NM_HOST, ' || chr(10) || chr(13) || 
		'id_servico_soa, ' || chr(10) || chr(13) || 
		'ds_endereco, ' || chr(10) || chr(13) || 
		'NM_ORIGEM, ' || chr(10) || chr(13) || 
		'nr_versao, ' || chr(10) || chr(13) || 
		'cid_contrato, ' || chr(10) || chr(13) || 
		'nr_porta, ' || chr(10) || chr(13) || 
		'nr_scd_versao, ' || chr(10) || chr(13) || 
		'st_parametro, ' || chr(10) || chr(13) || 
		'dt_inicio ' || chr(10) || chr(13) || 
		') ' || chr(10) || chr(13) || 
		'SELECT ' || chr(10) || chr(13) || 
		'''' || p_dblink_name || ''' dblink_name, ' || chr(10) || chr(13) || 
		'ID_PARAMETRO_ENDPOINT, ' || chr(10) || chr(13) || 
		'TP_PROTOCOLO, ' || chr(10) || chr(13) || 
		'NM_HOST, ' || chr(10) || chr(13) || 
		'id_servico_soa, ' || chr(10) || chr(13) || 
		'ds_endereco, ' || chr(10) || chr(13) || 
		'NM_ORIGEM, ' || chr(10) || chr(13) || 
		'nr_versao, ' || chr(10) || chr(13) || 
		'cid_contrato, ' || chr(10) || chr(13) || 
		'nr_porta, ' || chr(10) || chr(13) || 
		'(SELECT NVL(MAX(L.nr_scd_versao),0) + 1 FROM core.sn_parametro_endpoint L WHERE L.ID_PARAMETRO_ENDPOINT = S.ID_PARAMETRO_ENDPOINT AND L.dblink_name = ''' || p_dblink_name || ''') nr_scd_versao, ' || chr(10) || chr(13) || 
		'''A'' st_parametro, ' || chr(10) || chr(13) || 
		'to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') dt_inicio ' || chr(10) || chr(13) || 
		'FROM ' || chr(10) || chr(13) || 
		'( ' || chr(10) || chr(13) || 
		'	SELECT ' || chr(10) || chr(13) || 
		'	ID_PARAMETRO_ENDPOINT, ' || chr(10) || chr(13) || 
		'	TP_PROTOCOLO, ' || chr(10) || chr(13) || 
		'	NM_HOST, ' || chr(10) || chr(13) || 
		'	id_servico_soa, ' || chr(10) || chr(13) || 
		'	ds_endereco, ' || chr(10) || chr(13) || 
		'	NM_ORIGEM, ' || chr(10) || chr(13) || 
		'	nr_versao, ' || chr(10) || chr(13) || 
		'	cid_contrato, ' || chr(10) || chr(13) || 
		'	nr_porta ' || chr(10) || chr(13) || 
		'	FROM ' || chr(10) || chr(13) || 
		'	t$sn_parametro_endpoint ' || chr(10) || chr(13) || 
		') S ' || chr(10) || chr(13) || 
		'WHERE NOT EXISTS ' || chr(10) || chr(13) || 
		'( ' || chr(10) || chr(13) || 
		'	SELECT * ' || chr(10) || chr(13) || 
		'	FROM core.sn_parametro_endpoint C ' || chr(10) || chr(13) || 
		'	WHERE C.st_parametro = ''A'' ' || chr(10) || chr(13) || 
		'	AND C.ID_PARAMETRO_ENDPOINT = S.ID_PARAMETRO_ENDPOINT ' || chr(10) || chr(13) || 
		'	AND c.dblink_name = ''' || p_dblink_name || ''' ' || chr(10) || chr(13) || 
		')';
		begin
			execute immediate sqlcmd;
			p_nr_act := SQL%ROWCOUNT;
		end;
		
		-- Dropa a tabela de trabalho
		declare sqlcmd varchar2(4000) :=
		'drop table t$sn_parametro_endpoint';
		begin
			execute immediate sqlcmd;
		end;

	end pr_scd_parametro_endpoint;
begin
	-- Dropa a tabela de trabalho
	begin
		execute immediate
		'drop table t$sn_parametro_endpoint';
	exception 
		when others then 
			null;
	end;
	
	for x in (select db_link from all_db_links where owner = user and DB_LINK like 'GA_%_NETSMS_%.NET' order by db_link desc) loop
		declare
		v_nr_del integer; 
		v_nr_hst integer; 
		v_nr_act integer; 
		begin
			pr_scd_parametro_endpoint(p_dblink_name => x.db_link, p_nr_del => v_nr_del, p_nr_hst => v_nr_hst, p_nr_act => v_nr_act);
			commit;
			if  v_nr_del > 0 or v_nr_hst >0 or v_nr_act>0 then
				dbms_output.put_line('DBLink: ' || x.db_link || '; nrDel: ' || v_nr_del || '; nrUpd: ' || v_nr_hst || '; nrIns:' || (v_nr_act-v_nr_hst));
			end if;
			
		exception 
			when others then
				dbms_output.put_line('!' || x.db_link || ' -> ' || substr(SQLERRM,1,1000) || '');
				rollback;
		end;
	end loop;
end;
/
exit;