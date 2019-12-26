DECLARE
/*****************************************************
*** spool_report_sn_versao.sql
*** Autor: Paulo Ponciano - Spread
*** Data: 28/05/2019
*** Objetivo:
*** Geração de um relatório consolidado comparando a
*** versão das bases NetSms entre ambientes
*****************************************************/

v_dblink_src varchar2(50) := '&1.';
v_dblink_tgt varchar2(50);

begin

	begin
		select 
		tgt.cd_conexao 
		into v_dblink_tgt
		from vw_conexao src, vw_conexao tgt
		where 
		src.cd_conexao = v_dblink_src
		and tgt.cd_aplicacao = src.cd_aplicacao
		and (tgt.cd_cenario = src.cd_cenario or (tgt.cd_cenario is null and src.cd_cenario is null))
		and tgt.cd_ambiente = 'PROD'
		;
	exception when no_data_found then 
		null;
	end;

	-- Renderização
	declare
		function to_json(valor varchar2) return varchar2
		is
		begin
		if valor is null then return 'null'; end if;
		return '"' ||
		replace(
		replace(
		replace(
		valor
		, '\', '\' || '\')
		, chr(10), '\r')
		, chr(13), '\n')
		 || '"';
		end;
		function to_json(valor numeric) return varchar2
		is
		begin
		if valor is null then return 'null'; end if;
		return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
		end;
		function to_json(valor date) return varchar2
		is
		begin
		if valor is null then return 'null'; end if;
		return '"' || to_char(valor, 'yyyy-mm-dd') || 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
		end;

	begin
		dbms_output.put_line('{');
		dbms_output.put_line('	"refreshDate": '||to_json(sysdate)||'');
		for x in 
		(
		select 
		cd_conexao,
		cd_ambiente,
		cd_aplicacao,
		cd_cenario,
		username ||'@'|| ds_conexao ds_conexao
		from vw_conexao
		where cd_conexao = v_dblink_src
		) loop
			dbms_output.put_line('	,"source":');
			dbms_output.put_line('	{');
			dbms_output.put_line('		"cd_conexao": '||to_json(x.cd_conexao)||',');
			dbms_output.put_line('		"cd_ambiente": '||to_json(x.cd_ambiente)||',');
			dbms_output.put_line('		"cd_aplicacao": '||to_json(x.cd_aplicacao)||',');
			dbms_output.put_line('		"cd_cenario": '||to_json(x.cd_cenario)||',');
			dbms_output.put_line('		"ds_conexao": '||to_json(x.ds_conexao)||'');
			dbms_output.put_line('	}');
		end loop;
		-----------------------------
		if v_dblink_tgt is not null then
			for x in 
			(
			select 
			cd_conexao,
			cd_ambiente,
			cd_aplicacao,
			cd_cenario,
			username ||'@'|| ds_conexao ds_conexao
			from vw_conexao
			where cd_conexao = v_dblink_tgt
			) loop
				dbms_output.put_line('	,"target":');
				dbms_output.put_line('	{');
				dbms_output.put_line('		"cd_conexao": '||to_json(x.cd_conexao)||',');
				dbms_output.put_line('		"cd_ambiente": '||to_json(x.cd_ambiente)||',');
				dbms_output.put_line('		"cd_aplicacao": '||to_json(x.cd_aplicacao)||',');
				dbms_output.put_line('		"cd_cenario": '||to_json(x.cd_cenario)||',');
				dbms_output.put_line('		"ds_conexao": '||to_json(x.ds_conexao)||'');
				dbms_output.put_line('	}');
			end loop;
		end if;


		---
		if v_dblink_tgt is not null then
			declare
			TYPE lst_owner IS TABLE OF all_tables.owner%type;
			TYPE lst_table_name IS TABLE OF all_tables.table_name%type;
			TYPE lst_evalution IS TABLE OF varchar2(4000);
			v_lst_owner lst_owner;
			v_lst_table_name lst_table_name;
			v_lst_evalution lst_evalution;
			begin
				execute immediate 'select
				nvl(src.owner , tgt.owner) owner ,
				nvl(src.table_name , tgt.table_name ) table_name ,
				case when src.owner is null then ''SRC only, '' end ||
				case when tgt.owner is null then ''TGT only, '' end ||
				case when not ((src.logging is null and tgt.logging is null) or (src.logging = tgt.logging )) then ''logging ('' || src.logging || '' -> '' || tgt.logging || ''), '' end ||
				case when not ((src.partitioned is null and tgt.partitioned is null) or (src.partitioned = tgt.partitioned )) then ''partitioned ('' || src.partitioned || '' -> '' || tgt.partitioned || ''), '' end ||
				case when not ((src.temporary is null and tgt.temporary is null) or (src.temporary = tgt.temporary )) then ''temporary ('' || src.temporary || '' -> '' || tgt.temporary || ''), '' end ||
				case when not ((src.secondary is null and tgt.secondary is null) or (src.secondary = tgt.secondary )) then ''secondary ('' || src.secondary || '' -> '' || tgt.secondary || ''), '' end ||
				case when not ((src.nested is null and tgt.nested is null) or (src.nested = tgt.nested )) then ''nested ('' || src.nested || '' -> '' || tgt.nested || ''), '' end ||
				case when not ((src.buffer_pool is null and tgt.buffer_pool is null) or (src.buffer_pool = tgt.buffer_pool )) then ''buffer_pool ('' || src.buffer_pool || '' -> '' || tgt.buffer_pool || ''), '' end ||
				case when not ((src.row_movement is null and tgt.row_movement is null) or (src.row_movement = tgt.row_movement )) then ''row_movement ('' || src.row_movement || '' -> '' || tgt.row_movement || ''), '' end ||
				case when not ((src.cluster_owner is null and tgt.cluster_owner is null) or (src.cluster_owner = tgt.cluster_owner)) then ''cluster_owner ('' || src.cluster_owner || '' -> '' || tgt.cluster_owner || ''), '' end ||
				case when not ((src.compression is null and tgt.compression is null) or (src.compression = tgt.compression )) then ''compression ('' || src.compression || '' -> '' || tgt.compression || ''), '' end ||
				'''' evalution
				from
				(
					select
					owner,
					table_name,
					logging,
					partitioned,
					temporary,
					secondary,
					nested,
					buffer_pool,
					row_movement,
					cluster_owner,
					compression
					from all_tables@' || v_dblink_src || '
					where owner in (''PROD_JD'', ''NETSALES'')
					and not (owner=''PROD_JD'' and REGEXP_LIKE(table_name, ''^CMP[[:digit:]]\$[[:digit:]]{4,8}$''))
				) src
				full outer join
				(
					select
					owner,
					table_name,
					logging,
					partitioned,
					temporary,
					secondary,
					nested,
					buffer_pool,
					row_movement,
					cluster_owner,
					compression
					from all_tables@' || v_dblink_tgt || '
					where owner in (''PROD_JD'', ''NETSALES'')
					and not (owner=''PROD_JD'' and REGEXP_LIKE(table_name, ''^CMP[[:digit:]]\$[[:digit:]]{4,8}$''))
				) tgt on src.owner = tgt.owner and src.table_name = tgt.table_name
				where
				(
				src.owner is null
				or tgt.owner is null
				or not ((src.logging is null and tgt.logging is null ) or (src.logging = tgt.logging ))
				or not ((src.partitioned is null and tgt.partitioned is null ) or (src.partitioned = tgt.partitioned ))
				or not ((src.temporary is null and tgt.temporary is null ) or (src.temporary = tgt.temporary ))
				or not ((src.secondary is null and tgt.secondary is null ) or (src.secondary = tgt.secondary ))
				or not ((src.nested is null and tgt.nested is null ) or (src.nested = tgt.nested ))
				or not ((src.buffer_pool is null and tgt.buffer_pool is null ) or (src.buffer_pool = tgt.buffer_pool ))
				or not ((src.row_movement is null and tgt.row_movement is null ) or (src.row_movement = tgt.row_movement ))
				or not ((src.cluster_owner is null and tgt.cluster_owner is null ) or (src.cluster_owner = tgt.cluster_owner ))
				or not ((src.compression is null and tgt.compression is null ) or (src.compression = tgt.compression ))
				)
				order by owner, table_name
				' bulk collect into
				v_lst_owner,
				v_lst_table_name,
				v_lst_evalution;
				dbms_output.put_line('	,"tabelas": [');
				for x in v_lst_owner.first .. v_lst_owner.last loop
					dbms_output.put('		' || case when  x > v_lst_owner.first then ',' end);
					dbms_output.put_line(
					'{' ||
					'"owner": ' || to_json(v_lst_owner(x)) || ',' ||
					'"table_name": ' || to_json(v_lst_table_name(x)) || ',' ||
					'"evalution": ' || to_json(v_lst_evalution(x)) || '' ||
					'}');
				end loop;
				dbms_output.put_line('	]');
			end;
		end if;

		if v_dblink_tgt is not null then
			declare
			TYPE lst_owner IS TABLE OF all_tab_columns.owner%type;
			TYPE lst_table_name IS TABLE OF all_tab_columns.table_name%type;
			TYPE lst_column_name IS TABLE OF all_tab_columns.column_name%type;
			TYPE lst_evalution IS TABLE OF varchar2(4000);
			v_lst_owner				lst_owner;
			v_lst_table_name	lst_table_name;
			v_lst_column_name	lst_column_name;
			v_lst_evalution		lst_evalution;
			begin
				execute immediate '
				select
				nvl(src.owner , tgt.owner) owner ,
				nvl(src.table_name , tgt.table_name ) table_name ,
				nvl(src.table_name , tgt.table_name ) column_name ,
				case when src.owner is null then ''SRC only, '' end ||
				case when tgt.owner is null then ''TGT only, '' end ||
				case when not ((src.data_type						is null and tgt.data_type						is null) or (src.data_type					= tgt.data_type						)) then ''data_type ('' || src.data_type || '' -> '' || tgt.data_type || ''), '' end ||
				case when not ((src.data_type_mod				is null and tgt.data_type_mod				is null) or (src.data_type_mod			= tgt.data_type_mod				)) then ''data_type_mod ('' || src.data_type_mod || '' -> '' || tgt.data_type_mod || ''), '' end ||
				case when not ((src.data_type_owner			is null and tgt.data_type_owner			is null) or (src.data_type_owner		= tgt.data_type_owner			)) then ''data_type_owner ('' || src.data_type_owner || '' -> '' || tgt.data_type_owner || ''), '' end ||
				case when not ((src.data_length					is null and tgt.data_length					is null) or (src.data_length = tgt.data_length					)) then ''data_length ('' || src.data_length || '' -> '' || tgt.data_length || ''), '' end ||
				case when not ((src.data_precision			is null and tgt.data_precision			is null) or (src.data_precision = tgt.data_precision			)) then ''data_precision ('' || src.data_precision || '' -> '' || tgt.data_precision || ''), '' end ||
				case when not ((src.data_scale					is null and tgt.data_scale					is null) or (src.data_scale = tgt.data_scale					)) then ''data_scale ('' || src.data_scale || '' -> '' || tgt.data_scale || ''), '' end ||
				case when not ((src.nullable						is null and tgt.nullable						is null) or (src.nullable = tgt.nullable						)) then ''nullable ('' || src.nullable || '' -> '' || tgt.nullable || ''), '' end ||
				case when not ((src.character_set_name	is null and tgt.character_set_name	is null) or (src.character_set_name	= tgt.character_set_name	)) then ''character_set_name ('' || src.character_set_name || '' -> '' || tgt.character_set_name || ''), '' end ||
				case when not ((src.char_length					is null and tgt.char_length					is null) or (src.char_length				= tgt.char_length					)) then ''char_length ('' || src.char_length || '' -> '' || tgt.char_length || ''), '' end ||
				case when not ((src.char_used						is null and tgt.char_used						is null) or (src.char_used					= tgt.char_used						)) then ''char_used ('' || src.char_used || '' -> '' || tgt.char_used || ''), '' end ||
				'''' evalution
				from
				(
					select
					owner ,
					table_name ,
					column_name ,
					data_type ,
					data_type_mod ,
					data_type_owner ,
					data_length ,
					data_precision ,
					data_scale ,
					nullable ,
					character_set_name ,
					char_length ,
					char_used
					from all_tab_columns@' || v_dblink_src || '
					where owner in (''PROD_JD'', ''NETSALES'')
				) src
				full outer join
				(
					select
					owner ,
					table_name ,
					column_name ,
					data_type ,
					data_type_mod ,
					data_type_owner ,
					data_length ,
					data_precision ,
					data_scale ,
					nullable ,
					character_set_name ,
					char_length ,
					char_used
					from all_tab_columns@' || v_dblink_tgt || '
					where owner in (''PROD_JD'', ''NETSALES'')
				) tgt on src.owner = tgt.owner and src.table_name = tgt.table_name and src.column_name = tgt.column_name
				where
				(
				(src.owner is null and exists (select * from all_tables@' || v_dblink_tgt || ' where src.owner=owner and src.table_name=table_name))
				or (tgt.owner is null and exists (select * from all_tables@' || v_dblink_src || ' where tgt.owner=owner and tgt.table_name=table_name))
				or not ((src.data_type is null and tgt.data_type is null ) or (src.data_type = tgt.data_type ))
				or not ((src.data_type_mod is null and tgt.data_type_mod is null ) or (src.data_type_mod = tgt.data_type_mod ))
				or not ((src.data_type_owner is null and tgt.data_type_owner is null ) or (src.data_type_owner = tgt.data_type_owner ))
				or not ((src.data_length is null and tgt.data_length is null ) or (src.data_length = tgt.data_length ))
				or not ((src.data_precision is null and tgt.data_precision is null ) or (src.data_precision = tgt.data_precision ))
				or not ((src.data_scale is null and tgt.data_scale is null ) or (src.data_scale = tgt.data_scale ))
				or not ((src.nullable is null and tgt.nullable is null ) or (src.nullable = tgt.nullable ))
				or not ((src.character_set_name is null and tgt.character_set_name is null ) or (src.character_set_name = tgt.character_set_name ))
				or not ((src.char_length is null and tgt.char_length is null ) or (src.char_length = tgt.char_length ))
				or not ((src.char_used is null and tgt.char_used is null ) or (src.char_used = tgt.char_used ))
				)
				order by owner, table_name, column_name
				' bulk collect into
				v_lst_owner,
				v_lst_table_name,
				v_lst_column_name,
				v_lst_evalution;
				
				if v_lst_owner.count > 0 then
					dbms_output.put_line('	,"colunas": [');
					for x in v_lst_owner.first .. v_lst_owner.last loop
						dbms_output.put('		' || case when  x > v_lst_owner.first then ',' end);
						dbms_output.put_line('{' ||
						'"owner": ' || to_json(v_lst_owner(x)) || ',' ||
						'"table_name": ' || to_json(v_lst_table_name(x)) || ',' ||
						'"column_name": ' || to_json(v_lst_column_name(x)) || ',' ||
						'"evalution": ' || to_json(v_lst_evalution(x)) || '' ||
						'}');
					end loop;
					dbms_output.put_line('	]');
				end if;
			end;
		end if;
		
		dbms_output.put_line('}');
	end;

end;
/