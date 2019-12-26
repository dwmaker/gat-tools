DECLARE
/*****************************************************
***   spool_report_sn_versao.sql
***   Autor: Paulo Ponciano - Spread
***   Data: 28/05/2019
***   Objetivo:
***     Geração de um relatório consolidado comparando a
***     versão das bases NetSms entre ambientes
*****************************************************/
	c_st_connerror char(1) := 'E';
	c_st_disabled char(1) := 'D';
	c_st_loaded char(1) := 'L';
	c_st_success char(1) := 'S';
	c_st_danger char(1) := 'W';
	c_st_warning char(1) := 'O';
	c_st_light char(1) := 'I';
	
	c_st_info char(1) := 'F';
	c_nr_dias_versao_danger integer := 10;
	
	c_nr_dias_clone_warning integer := 360;
	c_nr_dias_clone_danger  integer := 720;

	type rec_axe_cenario is record (
		level0_code VARCHAR2(64),
		level0_colspan integer := 1,
		level0_rowspan integer := 1,
		level1_code VARCHAR2(64),
		level1_colspan integer := 1,
		level1_rowspan integer := 1
		
	);

	type rec_axe_ambiente is record (
		cd_ambiente VARCHAR2(64),
		ds_ambiente VARCHAR2(100)
	);
	
	type rec_axe_metrica is record (
		nome varchar2(100)
	);
	
	TYPE lst_axe_metrica IS TABLE OF rec_axe_metrica INDEX BY pls_integer;
	
	TYPE lst_axe_cenario IS TABLE OF rec_axe_cenario INDEX BY pls_integer;

	TYPE lst_axe_ambiente IS TABLE OF rec_axe_ambiente INDEX BY pls_integer;

	type rec_metrica is record
	(
		status	 char(1),
		MESSAGE VARCHAR2(1000),
		fmt_value  VARCHAR2(100)
	);
	
	type lst_metrica is table of rec_metrica INDEX BY pls_integer;
	
	TYPE rec_servidor IS RECORD
	(
		versao	 VARCHAR2(100),
		dt_atualizacao date,
		cd_conexao vw_conexao.cd_conexao%type,
		ds_conexao vw_conexao.ds_conexao%type,
		metricas lst_metrica,
		status	 char(1),
		MESSAGE VARCHAR2(1000)
	);

	TYPE dic_cenario IS TABLE OF rec_servidor INDEX BY pls_integer;

	TYPE rec_ambiente IS RECORD
	(
		cenarios dic_cenario
	);

	TYPE dic_ambiente IS TABLE OF rec_ambiente INDEX BY pls_integer;

	v_ambientes dic_ambiente;
	v_axe_cenarios lst_axe_cenario;
	v_axe_ambientes lst_axe_ambiente;
	v_axe_metrica lst_axe_metrica;

begin

	-- MATRIZ APLICACAO/CENARIO
	begin
		for x in (
		select
		cd_aplicacao,
		cd_cenario
		from vw_conexao
		where cd_aplicacao = 'NETSMS'
		group by cd_aplicacao, cd_cenario
		order by 
		decode(cd_aplicacao,'NETSMS','ZZZZZZZZZZZZZZ',cd_aplicacao), 
		decode(cd_cenario, 
		'BRA','001',
		'SUL','002',
		'ISP','003',
		'BH', '004',
		'SOC','005',
		'SAO','006',
		'ABC','007',
		'CTV','008', 
		cd_cenario)
		) loop
			declare v_axe_cenario rec_axe_cenario;
			begin
				v_axe_cenario.level1_code := x.cd_cenario;
				v_axe_cenario.level0_code := x.cd_aplicacao;
				v_axe_cenarios(v_axe_cenarios.count ):= v_axe_cenario;
			end;
		end loop;
	end;
	
	FOR icen IN REVERSE 1 .. v_axe_cenarios.LAST LOOP
		if v_axe_cenarios(icen).level0_code = v_axe_cenarios(icen - 1).level0_code then
			v_axe_cenarios(icen - 1).level0_colspan := v_axe_cenarios(icen - 1).level0_colspan + v_axe_cenarios(icen).level0_colspan;
			v_axe_cenarios(icen).level0_colspan := 0;
		end if;
	end loop;
	
	FOR icen IN v_axe_cenarios.first .. v_axe_cenarios.LAST LOOP
		if v_axe_cenarios(icen).level1_code is null then
			v_axe_cenarios(icen).level0_rowspan := 2;
			v_axe_cenarios(icen).level1_rowspan := 0;
		end if;
	end loop;
	
	-- MATRIZ AMBIENTES
	begin
		for x in
		(
			select
			cd_ambiente ,
			case cd_ambiente
			when 'PROD' then 'Produção'
			when 'CERT' then 'Certificação'
			when 'SIT4' then 'Teste Integrado - LE'
			when 'SIT5' then 'Teste Integrado - LD'
			when 'SIT6' then 'UAT'
			when 'SIT7' then 'Novo Sap BR'
			end ds_ambiente
			from vw_conexao
			where cd_ambiente not in ('DEV1', 'DEV4')
			group by cd_ambiente 
			order by decode(cd_ambiente,'PROD','AAAAAAAAAAAAAAAA',cd_ambiente)
		) loop
		declare v_axe_ambiente rec_axe_ambiente;
		begin
			v_axe_ambiente.cd_ambiente := x.cd_ambiente;
			v_axe_ambiente.ds_ambiente := x.ds_ambiente;
			v_axe_ambientes(v_axe_ambientes.count) := v_axe_ambiente;
		end;
		end loop;
	end;

	--- v_axe_metrica
	v_axe_metrica(0).nome := 'Versão do Sistema';
	v_axe_metrica(1).nome := 'Data de Clonagem';
	
	-- Recuperando última versao dos ambientes
	FOR icen IN v_axe_cenarios.FIRST .. v_axe_cenarios.LAST LOOP
		FOR iamb IN v_axe_ambientes.FIRST .. v_axe_ambientes.LAST LOOP
			begin
				select 
				cd_conexao,
				username||'@'||ds_conexao as ds_conexao
				into
				v_ambientes(iamb).cenarios(icen).cd_conexao,
				v_ambientes(iamb).cenarios(icen).ds_conexao
				from vw_conexao 
				where
				(cd_ambiente = v_axe_ambientes(iamb).cd_ambiente or (cd_ambiente is null and v_axe_ambientes(iamb).cd_ambiente is null))
				and (cd_aplicacao = v_axe_cenarios(icen).level0_code or (cd_aplicacao is null and v_axe_cenarios(icen).level0_code is null))
				and (cd_cenario = v_axe_cenarios(icen).level1_code or (cd_cenario is null and v_axe_cenarios(icen).level1_code is null))
				;
				
				-- metricas(0) - Versão do NETSMS
				if v_axe_cenarios(icen).level0_code = 'NETSMS' then
					declare 
					versao varchar2(100);
					dt_atualizacao date;
					BEGIN
						EXECUTE IMMEDIATE
						'select 
						max(versao) KEEP (DENSE_RANK last ORDER BY versao) versao, 
						max(dt_atualizacao) KEEP (DENSE_RANK last ORDER BY versao) dt_atualizacao
						from prod_jd.sn_versao@'||v_ambientes(iamb).cenarios(icen).cd_conexao||''
						INTO versao, dt_atualizacao;
						v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value := versao;
						if v_axe_ambientes(iamb).cd_ambiente not in ('PROD') then 
							if v_ambientes(0).cenarios(icen).metricas(0).fmt_value = v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Versão sincronizada com produção';
							elsif v_ambientes(0).cenarios(icen).metricas(0).fmt_value < v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_info;
								v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Versão superior a de produção';
							elsif v_ambientes(0).cenarios(icen).metricas(0).fmt_value > v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								declare
								proxima_versao  varchar2(100);
								dt_proxima_atualizacao date;
								v_nr_dias_obsoleto integer;
								begin
									EXECUTE IMMEDIATE 
									'SELECT 
									max(versao) KEEP (DENSE_RANK first ORDER BY versao) proxima_versao, 
									max(dt_atualizacao) KEEP (DENSE_RANK first ORDER BY versao) dt_proxima_atualizacao 
									FROM prod_jd.sn_versao@'||v_ambientes(0).cenarios(icen).cd_conexao||'
									where
									versao > :versao'
									INTO 
									proxima_versao, 
									dt_proxima_atualizacao
									USING 
									versao;
									v_nr_dias_obsoleto := trunc(dt_proxima_atualizacao) + c_nr_dias_versao_danger - trunc(sysdate);
									if  v_nr_dias_obsoleto >= 0 then 
										v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_warning; 
										v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Faltam ' || to_char(v_nr_dias_obsoleto, 'fm9990') || ' dias para Obsoleto'; 
									else
										v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_danger; 
										v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Obsoleto ha ' || to_char(-v_nr_dias_obsoleto, 'fm9990') || ' dias'; 
									end if;
								end;
							end if;
						else
							v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Ambiente produtivo não é criticado'; 
						end if;
					EXCEPTION WHEN OTHERS THEN
						v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_connerror;
						v_ambientes(iamb).cenarios(icen).metricas(0).message := substr(SQLERRM, 1, 1000);
					END;
				else
					v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value := 'n/a';
					v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_light;
					v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Esta aplicação não retém o versionamento';
				end if;
				
				-- metricas(1) - Data de Clonagem
				if v_axe_ambientes(iamb).cd_ambiente not in ('PROD') then
					declare dt date;
					BEGIN
						EXECUTE IMMEDIATE
						'SELECT
						prior_resetlogs_time
						FROM v$database@'||v_ambientes(iamb).cenarios(icen).cd_conexao||''
						INTO dt;
						v_ambientes(iamb).cenarios(icen).metricas(1).fmt_value := to_char(dt, 'Mon/yyyy', 'NLS_DATE_LANGUAGE = portuguese');
						if sysdate - dt > c_nr_dias_clone_danger then
							v_ambientes(iamb).cenarios(icen).metricas(1).message := 'Ambiente clonado ha mais de ' || c_nr_dias_clone_danger || ' dias';
							v_ambientes(iamb).cenarios(icen).metricas(1).status := c_st_danger;
						elsif sysdate - dt > c_nr_dias_clone_warning then
							v_ambientes(iamb).cenarios(icen).metricas(1).status := c_st_warning;
							v_ambientes(iamb).cenarios(icen).metricas(1).message := 'Ambiente clonado entre '||c_nr_dias_clone_warning||' e ' || c_nr_dias_clone_danger || ' dias';
						else
							v_ambientes(iamb).cenarios(icen).metricas(1).status := c_st_light;
							v_ambientes(iamb).cenarios(icen).metricas(1).message := 'Ambiente clonado ha menos de '||c_nr_dias_clone_warning||' dias';
						end if;
					END;
				else
					v_ambientes(iamb).cenarios(icen).metricas(1).fmt_value := 'n/a';
					v_ambientes(iamb).cenarios(icen).metricas(1).status := c_st_light;
					v_ambientes(iamb).cenarios(icen).metricas(1).message := 'Não se aplica';
				end if;
				
				
				
				v_ambientes(iamb).cenarios(icen).status := c_st_loaded;
				
			exception when no_data_found then 
				v_ambientes(iamb).cenarios(icen).status := c_st_disabled;
				v_ambientes(iamb).cenarios(icen).message := 'DBLink nao configurado.';
			WHEN OTHERS THEN
				v_ambientes(iamb).cenarios(icen).status := c_st_connerror;
				v_ambientes(iamb).cenarios(icen).MESSAGE := substr(SQLERRM, 1, 1000);
				
			end;
			
		END LOOP;
	END LOOP;

	-- Renderização
	declare
	v_width varchar2(30) := (to_char((100-8)/(v_axe_cenarios.COUNT),'FM990D00', 'NLS_NUMERIC_CHARACTERS = ''.,''')||'%');
	begin
		dbms_output.put_line('<div class="">');
		dbms_output.put_line('	<h2>Painel NETSMS</h2>');
		dbms_output.put_line('	<small><i>Atualizado em '|| htf.escape_sc(to_char(sysdate,'yyyy-mm-dd hh24:mi')) ||'</i></small>');
		dbms_output.put_line('	</br>');
		for imea in v_axe_metrica.first .. v_axe_metrica.last loop
			dbms_output.put_line('	<h3>'||v_axe_metrica(imea).nome||'</h3>');
			dbms_output.put_line('	<table class="table table-bordered table-sm">');
			dbms_output.put_line('		<thead  class="thead-dark">');
			dbms_output.put_line('			<tr>');
			dbms_output.put_line('				<th style="width: 8%;" rowspan=2>'||htf.escape_sc('Ambiente \ Aplicação')||'</th>');
			FOR i IN v_axe_cenarios.FIRST .. v_axe_cenarios.LAST LOOP
				if v_axe_cenarios(i).level0_colspan > 0 and v_axe_cenarios(i).level0_rowspan > 0 then
				dbms_output.put_line('				<th class="align-middle" style="text-align: center; width: '||v_width||';" colspan="'||v_axe_cenarios(i).level0_colspan||'" rowspan="'||v_axe_cenarios(i).level0_rowspan||'">'||v_axe_cenarios(i).level0_code||' <br></th>');
				end if;
			END LOOP;
			dbms_output.put_line('			</tr>');
			dbms_output.put_line('			<tr>');
			FOR i IN v_axe_cenarios.FIRST .. v_axe_cenarios.LAST LOOP
				if v_axe_cenarios(i).level1_colspan > 0 and v_axe_cenarios(i).level1_rowspan > 0 then
				dbms_output.put_line('				<th class="align-middle" style="width: '||v_width||';" colspan="'||v_axe_cenarios(i).level1_colspan||'" rowspan="'||v_axe_cenarios(i).level1_rowspan||'">'||v_axe_cenarios(i).level1_code||'</th>');
				end if;
			END LOOP;
			dbms_output.put_line('			</tr>');
			dbms_output.put_line('		</thead>');
			dbms_output.put_line('		<tbody>');
			FOR iamb IN v_axe_ambientes.FIRST .. v_axe_ambientes.LAST LOOP
				declare v_ambiente rec_ambiente := v_ambientes(iamb);
				begin
					dbms_output.put_line('			<tr>');
					dbms_output.put_line('				<th title="'||htf.escape_sc(v_axe_ambientes(iamb).ds_ambiente)||'">'|| htf.escape_sc(v_axe_ambientes(iamb).cd_ambiente)||'</th>');
					FOR i IN v_axe_cenarios.FIRST .. v_axe_cenarios.LAST LOOP
						if v_ambiente.cenarios.exists(i) then
							declare
							v_servidor rec_servidor := v_ambiente.cenarios(i);
							begin
							dbms_output.put('				<td style="padding: 0px;" ');
							dbms_output.put('class=" '||
							case v_servidor.status
							when c_st_danger then 'bg-danger text-white'
							when c_st_warning then 'bg-warning text-dark'
							when c_st_disabled then 'bg-light text-dark'
							when c_st_connerror then 'bg-secondary text-warning'
							when c_st_info then 'bg-info text-white'
							end || '" ');
							dbms_output.put('title="');
							if v_servidor.cd_conexao is not null then dbms_output.put('DBLink: ' || htf.escape_sc(v_servidor.cd_conexao) || chr(38)||'#10;'); end if;
							if v_servidor.ds_conexao is not null then dbms_output.put('Conexão: ' || htf.escape_sc(v_servidor.ds_conexao) || chr(38)||'#10;'); end if;
							if v_servidor.versao is not null then dbms_output.put('Versao: ' ||  htf.escape_sc(v_servidor.versao) || chr(38)||'#10;'); end if;
							if v_servidor.dt_atualizacao is not null then dbms_output.put('Implantacao: ' || to_char(v_servidor.dt_atualizacao, 'yyyy-mm-dd') || chr(38)||'#10;'); end if;
							if v_servidor.message is not null then dbms_output.put('Message: ' || chr(38)||'#10;' || replace(htf.escape_sc(v_servidor.message), chr(10), chr(38)||'#10;') || chr(38)||'#10;'); end if;
							if v_servidor.metricas.exists(imea) then dbms_output.put('Analise: ' || chr(38)||'#10;' || replace(htf.escape_sc(v_servidor.metricas(imea).message), chr(10), chr(38)||'#10;') || chr(38)||'#10;'); end if;
							dbms_output.put('">');
							if v_servidor.status = c_st_loaded then
								dbms_output.put('<div class="'|| 
								case v_servidor.metricas(imea).status 
								when c_st_danger then 'bg-danger text-white' 
								when c_st_warning then 'bg-warning text-dark' 
								when c_st_light then 'bg-light text-dark'
								when c_st_info then 'bg-info text-white'
								end ||' text-center" style="padding: 6px">');
								dbms_output.put(htf.escape_sc(v_servidor.metricas(imea).fmt_value));
								dbms_output.put('</div>');
							elsif v_servidor.status = c_st_disabled then
								dbms_output.put('<div style="padding: 6px" class="bg-light text-secondary text-center font-weight-bold" ');
								dbms_output.put('title="');
								if v_servidor.message is not null then dbms_output.put('Message: ' || chr(38)||'#10;' || replace(htf.escape_sc(v_servidor.message), chr(10), chr(38)||'#10;') || chr(38)||'#10;'); end if;
								dbms_output.put('">-</div>');
							elsif v_servidor.status = c_st_connerror then
								dbms_output.put('<div style="padding: 6px" class="bg-secondary text-warning text-center font-weight-bold" ');
								dbms_output.put('title="');
								if v_servidor.cd_conexao is not null then dbms_output.put('cd_conexao: ' || htf.escape_sc(v_servidor.cd_conexao) || chr(38)||'#10;'); end if;
								if v_servidor.ds_conexao is not null then dbms_output.put('ds_conexao: ' || htf.escape_sc(v_servidor.ds_conexao) || chr(38)||'#10;'); end if;
								if v_servidor.message is not null then dbms_output.put('Message: ' || chr(38)||'#10;' || replace(htf.escape_sc(v_servidor.message), chr(10), chr(38)||'#10;') || chr(38)||'#10;'); end if;
								dbms_output.put('">!</div>');
							end if;
							dbms_output.put_line('</td>');
							end;
						end if;
					END LOOP;
					dbms_output.put_line('			</tr>');
				end;
			END LOOP;
			dbms_output.put_line('		</tbody>');
			dbms_output.put_line('	</table>');
			dbms_output.put_line('	<br>');
		end loop;
		dbms_output.put_line('</div>');
	end;
end;
/