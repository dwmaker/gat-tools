set serveroutput on;

declare
	procedure pr_scd_parametro(
		p_dblink_name in core.sn_parametro.dblink_name%type, 
		p_nr_del out integer, 
		p_nr_hst out integer, 
		p_nr_act out integer
		) is
	v_data_atual date := sysdate;
	begin
	
		-- Cria a tabela de trabalho
		begin
			execute immediate
			'create table core.t$sn_parametro ' || chr(13) || 
			'(' || chr(13) || 
			'id_empresa, ' || chr(13) || 
			'nome_parametro, ' || chr(13) || 
			'vlr_parametro, ' || chr(13) || 
			'vlr_parametro_str, ' || chr(13) || 
			'dblink_name, ' || chr(13) || 
			'constraint t$sn_parametro_pk primary key(id_empresa, nome_parametro, dblink_name)' || chr(13) || 
			')' || chr(13) || 
			'NOLOGGING ' || chr(13) || 
			'as select ' || chr(13) || 
			'id_empresa as id_empresa, ' || chr(13) || 
			'nome_parametro as nome_parametro, ' || chr(13) || 
			'vlr_parametro as vlr_parametro, ' || chr(13) || 
			'vlr_parametro_str as vlr_parametro_str, ' || chr(13) || 
			'''' || p_dblink_name || ''' as dblink_name ' || chr(13) || 
			'from prod_jd.sn_parametro@' || p_dblink_name || '';
		end;
		
		-- Registros não encontrados na origem, serão atualizados para "Deleted"
		execute immediate 
		'UPDATE core.sn_parametro T SET ' || chr(13) || 
		'T.st_parametro = ''D'', ' || chr(13) || 
		'T.dt_fim = to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') ' || chr(13) || 
		'WHERE T.st_parametro = ''A'' ' || chr(13) || 
		'AND T.dblink_name = ''' || p_dblink_name || ''' ' || chr(13) || 
		'AND NOT EXISTS ' || chr(13) || 
		'( ' || chr(13) || 
		'	SELECT * ' || chr(13) || 
		'	FROM ' || chr(13) || 
		'	core.t$sn_parametro s ' || chr(13) || 
		'	WHERE ' || chr(13) || 
		'	S.id_empresa = T.id_empresa ' || chr(13) || 
		'	AND S.nome_parametro = T.nome_parametro ' || chr(13) || 
		'	AND T.dblink_name = s.dblink_name ' || chr(13) || 
		')';
		p_nr_del := SQL%ROWCOUNT;
		
		-- Registro encontrados com valores diferentes na origem, serão atualizados para "History"
		execute immediate 
		'update core.sn_parametro s set ' || chr(13) || 
		's.st_parametro = ''H'', ' || chr(13) || 
		's.dt_fim = to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') ' || chr(13) || 
		'WHERE s.st_parametro = ''A'' ' || chr(13) || 
		'AND s.dblink_name = ''' || p_dblink_name || ''' and ' || chr(13) || 
		'EXISTS ' || chr(13) || 
		'( ' || chr(13) || 
		'	SELECT * ' || chr(13) || 
		'	FROM core.t$sn_parametro C ' || chr(13) || 
		'	WHERE C.id_empresa = S.id_empresa ' || chr(13) || 
		'	AND C.nome_parametro = S.nome_parametro ' || chr(13) || 
		'	AND not ' || chr(13) || 
		'	( ' || chr(13) || 
		'		((C.vlr_parametro = S.vlr_parametro) OR (C.vlr_parametro IS NULL AND S.vlr_parametro IS NULL)) ' || chr(13) || 
		'		and ' || chr(13) || 
		'		((C.vlr_parametro_str = S.vlr_parametro_str) OR (C.vlr_parametro_str IS NULL AND S.vlr_parametro_str IS NULL)) ' || chr(13) || 
		'	) ' || chr(13) || 
		')';
		p_nr_hst := SQL%ROWCOUNT;
		
		-- Registros não encontrados no destino, serão inseridos como "Active"
		execute immediate 
		'INSERT INTO core.sn_parametro ' || chr(13) || 
		'( ' || chr(13) || 
		'dblink_name, ' || chr(13) || 
		'id_empresa, ' || chr(13) || 
		'nome_parametro, ' || chr(13) || 
		'vlr_parametro, ' || chr(13) || 
		'vlr_parametro_str, ' || chr(13) || 
		'nr_versao, ' || chr(13) || 
		'st_parametro, ' || chr(13) || 
		'dt_inicio ' || chr(13) || 
		') ' || chr(13) || 
		'SELECT ' || chr(13) || 
		'''' || p_dblink_name || ''' dblink_name, ' || chr(13) || 
		'id_empresa, ' || chr(13) || 
		'nome_parametro, ' || chr(13) || 
		'vlr_parametro, ' || chr(13) || 
		'vlr_parametro_str, ' || chr(13) || 
		'(SELECT NVL(MAX(L.nr_versao),0) + 1 FROM core.sn_parametro L WHERE L.id_empresa = S.id_empresa AND L.nome_parametro = S.nome_parametro AND L.dblink_name = ''' || p_dblink_name || ''') nr_versao, ' || chr(13) || 
		'''A'' st_parametro, ' || chr(13) || 
		'to_date(''' || to_char(v_data_atual,'yyyy-mm-dd hh24:mi:ss') || ''', ''yyyy-mm-dd hh24:mi:ss'') dt_inicio ' || chr(13) || 
		'FROM ' || chr(13) || 
		'( ' || chr(13) || 
		'	SELECT ' || chr(13) || 
		'	id_empresa, ' || chr(13) || 
		'	nome_parametro, ' || chr(13) || 
		'	vlr_parametro, ' || chr(13) || 
		'	vlr_parametro_str ' || chr(13) || 
		'	FROM ' || chr(13) || 
		'	core.t$sn_parametro ' || chr(13) || 
		') S ' || chr(13) || 
		'WHERE NOT EXISTS ' || chr(13) || 
		'( ' || chr(13) || 
		'	SELECT * ' || chr(13) || 
		'	FROM core.sn_parametro C ' || chr(13) || 
		'	WHERE C.st_parametro = ''A'' ' || chr(13) || 
		'	AND C.id_empresa = S.id_empresa ' || chr(13) || 
		'	AND C.nome_parametro = S.nome_parametro ' || chr(13) || 
		'	AND c.dblink_name = ''' || p_dblink_name || ''' ' || chr(13) || 
		')';
		p_nr_act := SQL%ROWCOUNT;
		
		-- Dropa a tabela de trabalho
		begin
			execute immediate
			'drop table core.t$sn_parametro';
		end;

	end pr_scd_parametro;
begin
	-- Dropa a tabela de trabalho
	begin
		execute immediate
		'drop table core.t$sn_parametro';
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
			pr_scd_parametro(p_dblink_name => x.db_link, p_nr_del => v_nr_del, p_nr_hst => v_nr_hst, p_nr_act => v_nr_act);
			dbms_output.put_line('DBLink: ' || x.db_link || '; nrDel: ' || v_nr_del || '; nrUpd: ' || v_nr_hst || '; nrIns:' || (v_nr_act-v_nr_hst));
			commit;
		exception 
			when others then
				dbms_output.put_line('!' || x.db_link || ' -> ' || substr(SQLERRM,1,1000) || '');
				rollback;
		end;
	end loop;
end;
/
exit;