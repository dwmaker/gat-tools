DECLARE
/*****************************************************
*** spool_report_sn_versao.sql
*** Autor: Paulo Ponciano - Spread
*** Data: 28/05/2019
*** Objetivo:
*** Geração de um relatório consolidado comparando a
*** versão das bases NetSms entre ambientes
*****************************************************/

	p_dblink_src varchar2(50) := '&1.';

	type rec_conexao is record 
	(
		cd_conexao   vw_conexao.cd_conexao%type,
		cd_ambiente  vw_conexao.cd_ambiente%type,
		cd_aplicacao vw_conexao.cd_aplicacao%type,
		cd_cenario   vw_conexao.cd_cenario%type,
		ds_conexao   vw_conexao.ds_conexao%type		
	);

	type rec_attdif is record 
	(
		att varchar2(100),
		src varchar2(100),
		tgt varchar2(100)
	);
	type lst_attdif is table of rec_attdif index by pls_integer;
	
	
	
	type rec_comp is record 
	(
		owner        all_objects.owner%type,
		object_name  all_objects.object_name%type,
		subobject_name  all_objects.object_name%type,
		object_type  all_objects.object_type%type,
		status  char(1),
		attdifs lst_attdif
	);
	
	type lst_comp is table of rec_comp INDEX BY pls_integer;
	
	v_src_conexao rec_conexao;
	v_tgt_conexao rec_conexao;
	v_lst_comp lst_comp;
	
	function new_attdif
	(
		att varchar2,
		src varchar2,
		tgt varchar2
	) return rec_attdif is 
	v_rec_attdif rec_attdif;
	begin 
		v_rec_attdif.att := att;		
		v_rec_attdif.src := src;		
		v_rec_attdif.tgt := tgt;
		return v_rec_attdif;
	end;
begin

	begin
	
		-- buscando dados de conexao
		select 
		src.cd_conexao   ,
		src.cd_ambiente  ,
		src.cd_aplicacao ,
		src.cd_cenario   ,
		src.ds_conexao   ,
		tgt.cd_conexao   ,
		tgt.cd_ambiente  ,
		tgt.cd_aplicacao ,
		tgt.cd_cenario   ,
		tgt.ds_conexao   
		into 
		v_src_conexao.cd_conexao   ,
		v_src_conexao.cd_ambiente  ,
		v_src_conexao.cd_aplicacao ,
		v_src_conexao.cd_cenario   ,
		v_src_conexao.ds_conexao   ,
		v_tgt_conexao.cd_conexao   ,
		v_tgt_conexao.cd_ambiente  ,
		v_tgt_conexao.cd_aplicacao ,
		v_tgt_conexao.cd_cenario   ,
		v_tgt_conexao.ds_conexao   
		from 
		vw_conexao src
		left join vw_conexao tgt on tgt.cd_aplicacao = src.cd_aplicacao
		and (tgt.cd_cenario = src.cd_cenario or (tgt.cd_cenario is null and src.cd_cenario is null))
		and tgt.cd_ambiente = 'PROD'
		where 
		src.cd_conexao = p_dblink_src
		;
		
		
		if v_tgt_conexao.cd_conexao is not null then
		
			--- COMPARANDO TABELAS
			declare
			TYPE lst_owner           IS TABLE OF all_tables.owner        %type;    src_lst_owner         lst_owner         ; tgt_lst_owner         lst_owner        ;
			TYPE lst_object_name     IS TABLE OF all_tables.table_name   %type;    src_lst_object_name    lst_object_name    ; tgt_lst_object_name    lst_object_name   ;
			TYPE lst_logging         IS TABLE OF all_tables.logging      %type;    src_lst_logging       lst_logging       ; tgt_lst_logging       lst_logging      ;
			TYPE lst_partitioned     IS TABLE OF all_tables.partitioned  %type;    src_lst_partitioned   lst_partitioned   ; tgt_lst_partitioned   lst_partitioned  ;
			TYPE lst_temporary       IS TABLE OF all_tables.temporary    %type;    src_lst_temporary     lst_temporary     ; tgt_lst_temporary     lst_temporary    ;
			TYPE lst_secondary       IS TABLE OF all_tables.secondary    %type;    src_lst_secondary     lst_secondary     ; tgt_lst_secondary     lst_secondary    ;
			TYPE lst_nested          IS TABLE OF all_tables.nested       %type;    src_lst_nested        lst_nested        ; tgt_lst_nested        lst_nested       ;
			TYPE lst_buffer_pool     IS TABLE OF all_tables.buffer_pool  %type;    src_lst_buffer_pool   lst_buffer_pool   ; tgt_lst_buffer_pool   lst_buffer_pool  ;
			TYPE lst_row_movement    IS TABLE OF all_tables.row_movement %type;    src_lst_row_movement  lst_row_movement  ; tgt_lst_row_movement  lst_row_movement ;
			TYPE lst_cluster_owner   IS TABLE OF all_tables.cluster_owner%type;    src_lst_cluster_owner lst_cluster_owner ; tgt_lst_cluster_owner lst_cluster_owner;
			TYPE lst_compression     IS TABLE OF all_tables.compression  %type;    src_lst_compression   lst_compression   ; tgt_lst_compression   lst_compression  ;
			begin
				execute immediate 'select
				src.owner           src_owner,           tgt.owner           tgt_owner,
				src.table_name      src_object_name,     tgt.table_name      tgt_object_name,
				src.logging         src_logging,         tgt.logging         tgt_logging,
				src.partitioned     src_partitioned,     tgt.partitioned     tgt_partitioned,
				src.temporary       src_temporary,       tgt.temporary       tgt_temporary,
				src.secondary       src_secondary,       tgt.secondary       tgt_secondary,
				src.nested          src_nested,          tgt.nested          tgt_nested,
				src.buffer_pool     src_buffer_pool,     tgt.buffer_pool     tgt_buffer_pool,
				src.row_movement    src_row_movement,    tgt.row_movement    tgt_row_movement,
				src.cluster_owner   src_cluster_owner,   tgt.cluster_owner   tgt_cluster_owner,
				src.compression     src_compression,     tgt.compression     tgt_compression
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
					from all_tables@' || v_src_conexao.cd_conexao || '
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
					from all_tables@' || v_tgt_conexao.cd_conexao || '
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
				order by 
				nvl(src.owner, tgt.owner), 
				nvl(src.table_name, tgt.table_name)
				' bulk collect into
				src_lst_owner         , tgt_lst_owner         ,
				src_lst_object_name    , tgt_lst_object_name    ,
				src_lst_logging       , tgt_lst_logging       ,
				src_lst_partitioned   , tgt_lst_partitioned   ,
				src_lst_temporary     , tgt_lst_temporary     ,
				src_lst_secondary     , tgt_lst_secondary     ,
				src_lst_nested        , tgt_lst_nested        ,
				src_lst_buffer_pool   , tgt_lst_buffer_pool   ,
				src_lst_row_movement  , tgt_lst_row_movement  ,
				src_lst_cluster_owner , tgt_lst_cluster_owner ,
				src_lst_compression   , tgt_lst_compression   
				;
				if src_lst_owner.count > 0 then 
					for i in src_lst_owner.first .. src_lst_owner.last loop
						declare v_comp rec_comp;
						begin
							v_comp.owner := nvl(src_lst_owner(i), tgt_lst_owner(i));
							v_comp.object_name := nvl(src_lst_object_name(i), tgt_lst_object_name(i));
							v_comp.subobject_name := null;
							v_comp.object_type := 'TABLE';
							if src_lst_owner(i) is null then 
								v_comp.status := 'S'; 
							elsif tgt_lst_owner(i) is null then 
								v_comp.status := 'T'; 
							else
								if not (src_lst_logging(i)       = tgt_lst_logging(i)       or (src_lst_logging(i)       = tgt_lst_logging(i)      )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('logging',       src_lst_logging(i), tgt_lst_logging(i)); end if;
								if not (src_lst_partitioned(i)   = tgt_lst_partitioned(i)   or (src_lst_partitioned(i)   = tgt_lst_partitioned(i)  )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('partitioned',   src_lst_partitioned(i), tgt_lst_partitioned(i)); end if;
								if not (src_lst_temporary(i)     = tgt_lst_temporary(i)     or (src_lst_temporary(i)     = tgt_lst_temporary(i)    )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('temporary',     src_lst_temporary(i), tgt_lst_temporary(i)); end if;
								if not (src_lst_secondary(i)     = tgt_lst_secondary(i)     or (src_lst_secondary(i)     = tgt_lst_secondary(i)    )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('secondary',     src_lst_secondary(i), tgt_lst_secondary(i)); end if;
								if not (src_lst_nested(i)        = tgt_lst_nested(i)        or (src_lst_nested(i)        = tgt_lst_nested(i)       )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('nested',        src_lst_nested(i), tgt_lst_nested(i)); end if;
								if not (src_lst_buffer_pool(i)   = tgt_lst_buffer_pool(i)   or (src_lst_buffer_pool(i)   = tgt_lst_buffer_pool(i)  )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('buffer_pool',   src_lst_buffer_pool(i), tgt_lst_buffer_pool(i)); end if;
								if not (src_lst_row_movement(i)  = tgt_lst_row_movement(i)  or (src_lst_row_movement(i)  = tgt_lst_row_movement(i) )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('row_movement',  src_lst_row_movement(i), tgt_lst_row_movement(i)); end if;
								if not (src_lst_cluster_owner(i) = tgt_lst_cluster_owner(i) or (src_lst_cluster_owner(i) = tgt_lst_cluster_owner(i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('cluster_owner', src_lst_cluster_owner(i), tgt_lst_cluster_owner(i)); end if;
								if not (src_lst_compression(i)   = tgt_lst_compression(i)   or (src_lst_compression(i)   = tgt_lst_compression(i)  )) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('compression',   src_lst_compression(i), tgt_lst_compression(i)); end if;
								v_comp.status :=  'D';
							end if;
							v_lst_comp(v_lst_comp.count) := v_comp;	
						end;
					end loop;
				end if;
			end;
			
			--- COMPARANDO COLUNAS
			declare			
			TYPE lst_owner               IS TABLE OF all_tab_columns.owner              %type; src_lst_owner                lst_owner               ; tgt_lst_owner                 lst_owner              ;
			TYPE lst_object_name         IS TABLE OF all_tab_columns.table_name         %type; src_lst_object_name          lst_object_name         ; tgt_lst_object_name           lst_object_name        ;
			TYPE lst_subobject_name      IS TABLE OF all_tab_columns.column_name        %type; src_lst_subobject_name          lst_subobject_name         ; tgt_lst_subobject_name           lst_subobject_name        ;
			TYPE lst_data_type				   IS TABLE OF all_tab_columns.data_type				   %type; src_lst_data_type				     lst_data_type				   ; tgt_lst_data_type				     lst_data_type				  ;
			TYPE lst_data_type_mod		   IS TABLE OF all_tab_columns.data_type_mod		   %type; src_lst_data_type_mod		     lst_data_type_mod		   ; tgt_lst_data_type_mod		     lst_data_type_mod		  ;
			TYPE lst_data_type_owner	   IS TABLE OF all_tab_columns.data_type_owner	   %type; src_lst_data_type_owner	     lst_data_type_owner	   ; tgt_lst_data_type_owner	     lst_data_type_owner	  ;
			TYPE lst_data_length			   IS TABLE OF all_tab_columns.data_length			   %type; src_lst_data_length			     lst_data_length			   ; tgt_lst_data_length			     lst_data_length			  ;
			TYPE lst_data_precision		   IS TABLE OF all_tab_columns.data_precision		 %type; src_lst_data_precision		   lst_data_precision		   ; tgt_lst_data_precision		     lst_data_precision		  ;
			TYPE lst_data_scale				   IS TABLE OF all_tab_columns.data_scale				 %type; src_lst_data_scale				   lst_data_scale				   ; tgt_lst_data_scale				     lst_data_scale				  ;
			TYPE lst_nullable					   IS TABLE OF all_tab_columns.nullable					 %type; src_lst_nullable					   lst_nullable					   ; tgt_lst_nullable					     lst_nullable					  ;
			TYPE lst_character_set_name  IS TABLE OF all_tab_columns.character_set_name %type; src_lst_character_set_name   lst_character_set_name  ; tgt_lst_character_set_name    lst_character_set_name ;
			TYPE lst_char_length			   IS TABLE OF all_tab_columns.char_length			   %type; src_lst_char_length			     lst_char_length			   ; tgt_lst_char_length			     lst_char_length			  ;
			TYPE lst_char_used				   IS TABLE OF all_tab_columns.char_used				   %type; src_lst_char_used				     lst_char_used				   ; tgt_lst_char_used				     lst_char_used				  ;
			begin
				execute immediate '
				select
				src.owner              src_owner              , tgt.owner               tgt_owner               ,
				src.table_name         src_object_name        , tgt.table_name          tgt_object_name         ,
				src.column_name        src_column_name        , tgt.column_name         tgt_column_name         ,
				src.data_type					 src_data_type					, tgt.data_type						tgt_data_type						,
				src.data_type_mod			 src_data_type_mod			, tgt.data_type_mod				tgt_data_type_mod				,
				src.data_type_owner		 src_data_type_owner		, tgt.data_type_owner			tgt_data_type_owner			,
				src.data_length				 src_data_length				, tgt.data_length					tgt_data_length					,
				src.data_precision		 src_data_precision     , tgt.data_precision			tgt_data_precision			,
				src.data_scale				 src_data_scale         , tgt.data_scale					tgt_data_scale					,
				src.nullable					 src_nullable           , tgt.nullable						tgt_nullable						,
				src.character_set_name src_character_set_name , tgt.character_set_name	tgt_character_set_name	,
				src.char_length				 src_char_length				, tgt.char_length					tgt_char_length					,
				src.char_used					 src_char_used					, tgt.char_used						tgt_char_used						
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
					from all_tab_columns@' || v_src_conexao.cd_conexao || '
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
					from all_tab_columns@' || v_tgt_conexao.cd_conexao || '
					where owner in (''PROD_JD'', ''NETSALES'')
				) tgt on src.owner = tgt.owner and src.table_name = tgt.table_name and src.column_name = tgt.column_name
				where
				(
				(src.owner is null and exists (select * from all_tables@' || v_tgt_conexao.cd_conexao || ' where src.owner=owner and src.table_name=table_name))
				or (tgt.owner is null and exists (select * from all_tables@' || v_src_conexao.cd_conexao || ' where tgt.owner=owner and tgt.table_name=table_name))
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
				order by 
				nvl(src.owner, tgt.owner), 
				nvl(src.table_name, tgt.table_name),
				nvl(src.column_name, tgt.column_name)
				' bulk collect into
				src_lst_owner                , tgt_lst_owner              ,
				src_lst_object_name          , tgt_lst_object_name        ,
				src_lst_subobject_name       , tgt_lst_subobject_name     ,
				src_lst_data_type				     , tgt_lst_data_type				  ,
				src_lst_data_type_mod		     , tgt_lst_data_type_mod		  ,
				src_lst_data_type_owner	     , tgt_lst_data_type_owner	  ,
				src_lst_data_length			     , tgt_lst_data_length			  ,
				src_lst_data_precision		   , tgt_lst_data_precision		  ,
				src_lst_data_scale				   , tgt_lst_data_scale				  ,
				src_lst_nullable					   , tgt_lst_nullable					  ,
				src_lst_character_set_name   , tgt_lst_character_set_name ,
				src_lst_char_length			     , tgt_lst_char_length			  ,
				src_lst_char_used				     , tgt_lst_char_used				  
				;
				if src_lst_owner.count > 0 then 
					for i in src_lst_owner.first .. src_lst_owner.last loop
						declare v_comp rec_comp;
						begin
							v_comp.owner := nvl(src_lst_owner(i), tgt_lst_owner(i));
							v_comp.object_name := nvl(src_lst_object_name(i), tgt_lst_object_name(i));
							v_comp.subobject_name := nvl(src_lst_subobject_name(i), tgt_lst_subobject_name(i));
							v_comp.object_type := 'COLUMN';
							if src_lst_owner(i) is null then 
								v_comp.status := 'S'; 
							elsif tgt_lst_owner(i) is null then 
								v_comp.status := 'T'; 
							else
								if not (src_lst_data_type				   (i) = tgt_lst_data_type				  (i) or ( src_lst_data_type				  (i) = tgt_lst_data_type				   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_type'				 , src_lst_data_type				  (i), tgt_lst_data_type				  (i)); end if;
								if not (src_lst_data_type_mod		   (i) = tgt_lst_data_type_mod		  (i) or ( src_lst_data_type_mod		  (i) = tgt_lst_data_type_mod		   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_type_mod'		 , src_lst_data_type_mod		  (i), tgt_lst_data_type_mod		  (i)); end if;
								if not (src_lst_data_type_owner	   (i) = tgt_lst_data_type_owner	  (i) or ( src_lst_data_type_owner	  (i) = tgt_lst_data_type_owner	   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_type_owner'	 , src_lst_data_type_owner	  (i), tgt_lst_data_type_owner	  (i)); end if;
								if not (src_lst_data_length			   (i) = tgt_lst_data_length			  (i) or ( src_lst_data_length			  (i) = tgt_lst_data_length			   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_length'			 , src_lst_data_length			  (i), tgt_lst_data_length			  (i)); end if;
								if not (src_lst_data_precision		 (i) = tgt_lst_data_precision		  (i) or ( src_lst_data_precision		  (i) = tgt_lst_data_precision		 (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_precision'		 , src_lst_data_precision		  (i), tgt_lst_data_precision		  (i)); end if;
								if not (src_lst_data_scale				 (i) = tgt_lst_data_scale				  (i) or ( src_lst_data_scale				  (i) = tgt_lst_data_scale				 (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('data_scale'				 , src_lst_data_scale				  (i), tgt_lst_data_scale				  (i)); end if;
								if not (src_lst_nullable					 (i) = tgt_lst_nullable					  (i) or ( src_lst_nullable					  (i) = tgt_lst_nullable					 (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('nullable'					 , src_lst_nullable					  (i), tgt_lst_nullable					  (i)); end if;
								if not (src_lst_character_set_name (i) = tgt_lst_character_set_name (i) or ( src_lst_character_set_name (i) = tgt_lst_character_set_name (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('character_set_name', src_lst_character_set_name (i), tgt_lst_character_set_name (i)); end if;
								if not (src_lst_char_length			   (i) = tgt_lst_char_length			  (i) or ( src_lst_char_length			  (i) = tgt_lst_char_length			   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('char_length'			 , src_lst_char_length			  (i), tgt_lst_char_length			  (i)); end if;
								if not (src_lst_char_used				   (i) = tgt_lst_char_used				  (i) or ( src_lst_char_used				  (i) = tgt_lst_char_used				   (i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('char_used'				 , src_lst_char_used				  (i), tgt_lst_char_used				  (i)); end if;
								v_comp.status :=  'D';
							end if;
							v_lst_comp(v_lst_comp.count) := v_comp;	
						end;
					end loop;
				end if;
			end;
			
			--- COMPARANDO PROGRAMAVEIS
			declare			
			TYPE lst_owner               IS TABLE OF all_objects.owner               %type; src_lst_owner                lst_owner               ; tgt_lst_owner                 lst_owner              ;
			TYPE lst_object_name         IS TABLE OF all_objects.object_name         %type; src_lst_object_name          lst_object_name         ; tgt_lst_object_name           lst_object_name        ;
			TYPE lst_object_type         IS TABLE OF all_objects.object_type         %type; src_lst_object_type          lst_object_type         ; tgt_lst_object_type           lst_object_type        ;
			TYPE lst_status    				   IS TABLE OF all_objects.status   				   %type; src_lst_status    			     lst_status   				   ; tgt_lst_status   				     lst_status   				  ;
			TYPE lst_fl_ddl_diferente		 IS TABLE OF char(1)                              ; v_lst_fl_ddl_diferente		   lst_fl_ddl_diferente		   ; 
			begin
				execute immediate 
'select 
src_owner, tgt_owner,
src_object_name, tgt_object_name,
src_object_type, tgt_object_type,
src_status, tgt_status,
fl_ddl_diferente
from 
(
select 
src.owner         src_owner, 
tgt.owner         tgt_owner,
src.object_name   src_object_name, 
tgt.object_name   tgt_object_name,
src.object_type   src_object_type,
tgt.object_type   tgt_object_type,
src.status        src_status,
tgt.status        tgt_status,
case when exists
(
select 
1
from 
all_source@' || v_src_conexao.cd_conexao || ' src1 
full outer join all_source@' || v_tgt_conexao.cd_conexao || ' tgt1
on src1.line = tgt1.line
where 
src1.owner=src.owner and 
src1.name=src.object_name and 
src1.type=src.object_type and 
tgt1.owner=tgt.owner and 
tgt1.name=tgt.object_name and 
tgt1.type=tgt.object_type and 
not 
(case when ascii(substr(src1.TEXT,length(src1.TEXT),1))=10 then substr(SRC1.TEXT, 1, length(SRC1.TEXT)-1) else SRC1.TEXT end)
= 
(case when ascii(substr(tgt1.TEXT,length(tgt1.TEXT),1))=10 then substr(TGT1.TEXT, 1, length(TGT1.TEXT)-1) else TGT1.TEXT end)
) then ''S'' else ''N'' end fl_ddl_diferente
from
(
select 
owner,
object_name,
object_type,
status
from 
all_objects@' || v_src_conexao.cd_conexao || ' 
where 
object_type in (''TYPE BODY'', ''PROCEDURE'', ''TYPE'', ''FUNCTION'', ''TRIGGER'', ''PACKAGE BODY'', ''PACKAGE'')
and generated = ''N''
and owner in (''PROD_JD'', ''NETSALES'')
) src full outer join
(
select 
owner,
object_name,
object_type,
status
from 
all_objects@' || v_tgt_conexao.cd_conexao || ' 
where 
object_type in (''TYPE BODY'', ''PROCEDURE'', ''TYPE'', ''FUNCTION'', ''TRIGGER'', ''PACKAGE BODY'', ''PACKAGE'')
and generated = ''N''
and owner in (''PROD_JD'', ''NETSALES'')
) tgt on src.owner = tgt.owner and src.object_name = tgt.object_name  and src.object_type = tgt.object_type
)
where
src_owner is null
or tgt_owner is null
or src_status != tgt_status
or fl_ddl_diferente = ''S''
order by
nvl(src_owner,       tgt_owner),
nvl(src_object_name, tgt_object_name),
nvl(src_object_type, tgt_object_type)'
				bulk collect into
				src_lst_owner             , tgt_lst_owner         ,
				src_lst_object_name       , tgt_lst_object_name   ,
				src_lst_object_type       , tgt_lst_object_type   ,
				src_lst_status    			  ,tgt_lst_status   				,
				v_lst_fl_ddl_diferente		  
				; 
				if src_lst_owner.count > 0 then 
					for i in src_lst_owner.first .. src_lst_owner.last loop
						declare v_comp rec_comp;
						begin
							v_comp.owner := nvl(src_lst_owner(i), tgt_lst_owner(i));
							v_comp.object_name := nvl(src_lst_object_name(i), tgt_lst_object_name(i));
							v_comp.object_type := nvl(src_lst_object_type(i), tgt_lst_object_type(i));
						
							if src_lst_owner(i) is null then 
								v_comp.status := 'S'; 
							elsif tgt_lst_owner(i) is null then 
								v_comp.status := 'T'; 
							else
								if not (src_lst_status(i) = tgt_lst_status(i) or ( src_lst_status(i) = tgt_lst_status(i))) then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('status', src_lst_status(i), tgt_lst_status(i)); end if;
								if v_lst_fl_ddl_diferente(i) = 'S' then v_comp.attdifs(v_comp.attdifs.count) := new_attdif('DDL', '.', '.'); end if;
								
								v_comp.status :=  'D';
							end if;
							v_lst_comp(v_lst_comp.count) := v_comp;	
						end;
					end loop;
				end if;
			end;
		end if;
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
		end to_json;
		
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
		
		
	
		if v_src_conexao.cd_conexao is not null then
			dbms_output.put_line('	,"source":');
			dbms_output.put_line('	{');
			dbms_output.put_line('		"cd_conexao": '  ||to_json(v_src_conexao.cd_conexao)||',');
			dbms_output.put_line('		"cd_ambiente": ' ||to_json(v_src_conexao.cd_ambiente)||',');
			dbms_output.put_line('		"cd_aplicacao": '||to_json(v_src_conexao.cd_aplicacao)||',');
			dbms_output.put_line('		"cd_cenario": '  ||to_json(v_src_conexao.cd_cenario)||',');
			dbms_output.put_line('		"ds_conexao": '  ||to_json(v_src_conexao.ds_conexao)||'');
			dbms_output.put_line('	}');
		end if;
		
		if v_tgt_conexao.cd_conexao is not null then
			dbms_output.put_line('	,"target":');
			dbms_output.put_line('	{');
			dbms_output.put_line('		"cd_conexao": '  ||to_json(v_tgt_conexao.cd_conexao)||',');
			dbms_output.put_line('		"cd_ambiente": ' ||to_json(v_tgt_conexao.cd_ambiente)||',');
			dbms_output.put_line('		"cd_aplicacao": '||to_json(v_tgt_conexao.cd_aplicacao)||',');
			dbms_output.put_line('		"cd_cenario": '  ||to_json(v_tgt_conexao.cd_cenario)||',');
			dbms_output.put_line('		"ds_conexao": '  ||to_json(v_tgt_conexao.ds_conexao)||'');
			dbms_output.put_line('	}');
		end if;
			
		if v_lst_comp.count>0 then
			dbms_output.put_line('	,"compare":');
			dbms_output.put_line('	[');
			for x in v_lst_comp.first .. v_lst_comp.last loop
				dbms_output.put_line('		{');
				dbms_output.put_line('			"owner": '||to_json(v_lst_comp(x).owner));
				dbms_output.put_line('			,"object_name": '||to_json(v_lst_comp(x).object_name));
				dbms_output.put_line('			,"subobject_name": '||to_json(v_lst_comp(x).subobject_name));
				dbms_output.put_line('			,"object_type": '||to_json(v_lst_comp(x).object_type));
				dbms_output.put_line('			,"status": '||to_json(v_lst_comp(x).status));
				if v_lst_comp(x).attdifs.count>0 then
					dbms_output.put_line('			,"difs": ');
					dbms_output.put_line('			[');
					for y in v_lst_comp(x).attdifs.first .. v_lst_comp(x).attdifs.last loop
					dbms_output.put_line('				{"att": '||to_json(v_lst_comp(x).attdifs(y).att)||', "src": '||to_json(v_lst_comp(x).attdifs(y).src)||', "tgt": '||to_json(v_lst_comp(x).attdifs(y).tgt)||'}' || case y when  v_lst_comp(x).attdifs.last then '' else ', ' end);
					end loop;
					dbms_output.put_line('			]');
				end if;
				dbms_output.put_line('		}' || case x when v_lst_comp.last then '' else ', ' end);
			end loop;
			dbms_output.put_line('	]');
		end if;
		/*

		---
		
		
		
		----------------------------------------------
		if v_tgt_conexao.cd_conexao is not null then
			declare
			TYPE lst_owner IS TABLE OF all_objects.owner%type;
			TYPE lst_object_name IS TABLE OF all_objects.object_name%type;
			TYPE lst_object_type IS TABLE OF all_objects.object_type%type;
			TYPE lst_evalution IS TABLE OF varchar2(4000);
			v_lst_owner				lst_owner;
			v_lst_object_name	lst_object_name;
			v_lst_object_type	lst_object_type;
			v_lst_evalution		lst_evalution;
			begin
				execute immediate 'select 
				nvl(src_owner, tgt_owner) owner,
				nvl(src_object_name, tgt_object_name) object_name,
				nvl(src_object_type, tgt_object_type) object_type,
				case when src_owner is null then ''SRC only, '' end ||
				case when tgt_owner is null then ''TGT only, '' end ||
				case when not ((src_status is null and tgt_status is null) or (src_status = tgt_status )) then ''status ('' || src_status || '' -> '' || tgt_status || ''), '' end ||
				case when fl_ddl_diferente = ''S'' then ''DDL_DIFF,'' end ||
				'''' evalution
				from 
				(
					select 
					src.owner         src_owner, 
					tgt.owner         tgt_owner,
					src.object_name   src_object_name, 
					tgt.object_name   tgt_object_name,
					src.object_type   src_object_type,
					tgt.object_type   tgt_object_type,
					src.status        src_status,
					tgt.status        tgt_status,
					case when exists
					(
						select 
						1
						from 
						all_source@' || v_src_conexao.cd_conexao || ' src1 
						full outer join all_source@' || v_tgt_conexao.cd_conexao || ' tgt1
						on src1.line = tgt1.line
						where 
						src1.owner=src.owner and 
						src1.name=src.object_name and 
						src1.type=src.object_type and 
						tgt1.owner=tgt.owner and 
						tgt1.name=tgt.object_name and 
						tgt1.type=tgt.object_type and 
						not (src1.text = tgt1.text)
					) then ''S'' else ''N'' end fl_ddl_diferente
					from
					(
						select 
						owner,
						object_name,
						object_type,
						status
						from 
						all_objects@' || v_src_conexao.cd_conexao || ' 
						where 
						object_type in (''TYPE BODY'', ''PROCEDURE'', ''TYPE'', ''FUNCTION'', ''TRIGGER'', ''PACKAGE BODY'', ''PACKAGE'')
						and generated = ''N''
						and owner in (''PROD_JD'', ''NETSALES'')
					) src full outer join
					(
						select 
						owner,
						object_name,
						object_type,
						status
						from 
						all_objects@' || v_tgt_conexao.cd_conexao || ' 
						where 
						object_type in (''TYPE BODY'', ''PROCEDURE'', ''TYPE'', ''FUNCTION'', ''TRIGGER'', ''PACKAGE BODY'', ''PACKAGE'')
						and generated = ''N''
						and owner in (''PROD_JD'', ''NETSALES'')
					) tgt on src.owner = tgt.owner and src.object_name = tgt.object_name  and src.object_type = tgt.object_type
				)
				where
				src_owner is null
				or tgt_owner is null
				or src_status != tgt_status
				or fl_ddl_diferente = ''S''
				order by
				owner,
				object_name,
				object_type' 
				bulk collect into
				v_lst_owner,
				v_lst_object_name,
				v_lst_object_type,
				v_lst_evalution;
				
				if v_lst_owner.count > 0 then
					dbms_output.put_line('	,"programaveis": [');
					for x in v_lst_owner.first .. v_lst_owner.last loop
						dbms_output.put('		' || case when  x > v_lst_owner.first then ',' end);
						dbms_output.put_line('{' ||
						'"owner": ' || to_json(v_lst_owner(x)) || ',' ||
						'"object_name": ' || to_json(v_lst_object_name(x)) || ',' ||
						'"object_type": ' || to_json(v_lst_object_type(x)) || ',' ||
						'"evalution": ' || to_json(v_lst_evalution(x)) || '' ||
						'}');
					end loop;
					dbms_output.put_line('	]');
				end if;
			end;
		end if;
		*/
		dbms_output.put_line('}');
	end;

end;
/