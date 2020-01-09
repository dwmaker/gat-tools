DECLARE
/*****************************************************
***		spool_report_sn_versao.sql
***		Autor: Paulo Ponciano - Spread
***		Data: 28/05/2019
***		Objetivo:
***			Geração de um relatório consolidado comparando a
***			versão das bases NetSms entre ambientes
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
	c_nr_dias_clone_danger integer := 720;

	type rec_axe_cenario is record (
		level0_code VARCHAR2(64),
		level0_colspan integer := 1,
		level0_rowspan integer := 1,
		level1_code VARCHAR2(64),
		level1_colspan integer := 1,
		level1_rowspan integer := 1

	);

	type rec_axe_ambiente is record (
		level0_code VARCHAR2(64),
		level0_description VARCHAR2(100)
	);

	type rec_legend is record (
		status char(1),
		description VARCHAR2(1000)
	);
	
	type lst_legend IS TABLE OF rec_legend INDEX BY pls_integer;
	
	type rec_axe_metrica is record (
		name varchar2(100),
		legends lst_legend
	);

	TYPE lst_axe_metrica IS TABLE OF rec_axe_metrica INDEX BY pls_integer;

	TYPE lst_axe_cenario IS TABLE OF rec_axe_cenario INDEX BY pls_integer;

	TYPE lst_axe_ambiente IS TABLE OF rec_axe_ambiente INDEX BY pls_integer;

	type rec_metrica is record
	(
		status char(1),
		message VARCHAR2(1000),
		fmt_value VARCHAR2(100)
	);

	type lst_metrica is table of rec_metrica INDEX BY pls_integer;

	TYPE rec_servidor IS RECORD
	(
		--versao VARCHAR2(100),
		--dt_atualizacao date,
		code vw_conexao.cd_conexao%type,
		description vw_conexao.ds_conexao%type,
		metricas lst_metrica,
		status char(1),
		message VARCHAR2(1000)
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
		--where cd_aplicacao = 'NETSMS'
		group by cd_aplicacao, cd_cenario
		order by 
		decode(cd_aplicacao,'NETSMS','ZZZZZZZZZZZZZZ','A'),
		cd_aplicacao, 
		decode(cd_cenario, 'BRA','001','SUL','002','ISP','003','BH', '004','SOC','005','SAO','006','ABC','007','CTV','008','999'), 
		cd_cenario
		) loop
			declare v_axe_cenario rec_axe_cenario;
			begin
				v_axe_cenario.level1_code := x.cd_cenario;
				v_axe_cenario.level0_code := x.cd_aplicacao;
				v_axe_cenarios(v_axe_cenarios.count):= v_axe_cenario;
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
			cd_ambiente level0_code ,
			case cd_ambiente
			when 'PROD' then 'Produção'
			when 'CERT' then 'Certificação'
			when 'SIT4' then 'Teste Integrado - LE'
			when 'SIT5' then 'Teste Integrado - LD'
			when 'SIT6' then 'UAT'
			when 'SIT7' then 'Novo Sap BR'
			end level0_description
			from vw_conexao
			--where cd_ambiente not in ('DEV1', 'DEV4')
			group by cd_ambiente 
			order by 
			decode(cd_ambiente,'PROD','AAAAAAAAAAAAAAAA') nulls last,
			cd_ambiente
		) loop
		declare v_axe_ambiente rec_axe_ambiente;
		begin
			v_axe_ambiente.level0_code := x.level0_code;
			v_axe_ambiente.level0_description := x.level0_description;
			v_axe_ambientes(v_axe_ambientes.count) := v_axe_ambiente;
		end;
		end loop;
	end;

	--- v_axe_metrica
	v_axe_metrica(0).name := 'Versão do Sistema';
	v_axe_metrica(0).legends(0).status := c_st_info;
	v_axe_metrica(0).legends(0).description := 'Versão superior a de produção';
	v_axe_metrica(0).legends(1).status := c_st_warning;
	v_axe_metrica(0).legends(1).description := 'Desatualizado ha menos de '||c_nr_dias_versao_danger||' dias';
	v_axe_metrica(0).legends(2).status := c_st_danger;
	v_axe_metrica(0).legends(2).description := 'Desatualizado ha mais de '||c_nr_dias_versao_danger||' dias';

	
	v_axe_metrica(1).name := 'Data de Clonagem';
	v_axe_metrica(1).legends(0).status := c_st_danger;
	v_axe_metrica(1).legends(0).description := 'Ambiente clonado ha mais de ' || c_nr_dias_clone_danger || ' dias';
	v_axe_metrica(1).legends(1).status := c_st_warning;
	v_axe_metrica(1).legends(1).description := 'Ambiente clonado entre '||c_nr_dias_clone_warning||' e ' || c_nr_dias_clone_danger || ' dias';
	v_axe_metrica(1).legends(2).status := c_st_light;
	v_axe_metrica(1).legends(2).description := 'Ambiente clonado ha menos de '||c_nr_dias_clone_warning||' dias';

	-- Recuperando última versao dos ambientes
	FOR icen IN v_axe_cenarios.FIRST .. v_axe_cenarios.LAST LOOP
		FOR iamb IN v_axe_ambientes.FIRST .. v_axe_ambientes.LAST LOOP
			begin
				select 
				cd_conexao as code,
				username||'@'||ds_conexao as description
				into
				v_ambientes(iamb).cenarios(icen).code,
				v_ambientes(iamb).cenarios(icen).description
				from vw_conexao 
				where
				(cd_ambiente = v_axe_ambientes(iamb).level0_code or (cd_ambiente is null and v_axe_ambientes(iamb).level0_code is null))
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
						from prod_jd.sn_versao@'||v_ambientes(iamb).cenarios(icen).code||''
						INTO versao, dt_atualizacao;
						v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value := versao;
						if v_axe_ambientes(iamb).level0_code not in ('PROD') then 
							if v_ambientes(0).cenarios(icen).metricas(0).fmt_value = v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Versão sincronizada com produção';
							elsif v_ambientes(0).cenarios(icen).metricas(0).fmt_value < v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								v_ambientes(iamb).cenarios(icen).metricas(0).status := c_st_info;
								v_ambientes(iamb).cenarios(icen).metricas(0).message := 'Versão superior a de produção';
							elsif v_ambientes(0).cenarios(icen).metricas(0).fmt_value > v_ambientes(iamb).cenarios(icen).metricas(0).fmt_value then
								declare
								proxima_versao varchar2(100);
								dt_proxima_atualizacao date;
								v_nr_dias_obsoleto integer;
								begin
									EXECUTE IMMEDIATE 
									'SELECT 
									max(versao) KEEP (DENSE_RANK first ORDER BY versao) proxima_versao, 
									max(dt_atualizacao) KEEP (DENSE_RANK first ORDER BY versao) dt_proxima_atualizacao 
									FROM prod_jd.sn_versao@'||v_ambientes(0).cenarios(icen).code||'
									where
									versao > :versao'
									INTO 
									proxima_versao, 
									dt_proxima_atualizacao
									USING 
									versao;
									v_nr_dias_obsoleto := trunc(dt_proxima_atualizacao) + c_nr_dias_versao_danger - trunc(sysdate);
									if v_nr_dias_obsoleto >= 0 then 
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
				if v_axe_ambientes(iamb).level0_code not in ('PROD') then
					declare dt date;
					BEGIN
						EXECUTE IMMEDIATE
						'SELECT
						prior_resetlogs_time
						FROM v$database@'||v_ambientes(iamb).cenarios(icen).code||''
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
				v_ambientes(iamb).cenarios(icen).message := substr(SQLERRM, 1, 1000);
			end;
		END LOOP;
	END LOOP;

	-- Renderização
	declare

		function to_json(valor varchar2) return clob
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

		function to_json(valor numeric) return clob
		is
		begin
		if valor is null then return 'null'; end if;
		return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
		end;

		function to_json(valor date) return clob
		is
		begin
		if valor is null then return 'null'; end if;
		return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
		end;

		function to_json(valor rec_axe_cenario) return clob is 
		begin 
		return 
		'		{'|| chr(10) ||
		'			"levels":'|| chr(10) ||
		'			[' || chr(10) ||
		'				{' || '"code": ' || to_json(valor.level0_code) || ', ' || '"colspan": ' || to_json(valor.level0_colspan) || ', ' || '"rowspan": ' || to_json(valor.level0_rowspan) || '}, ' || chr(10) ||
		'				{' || '"code": ' || to_json(valor.level1_code) || ', "colspan": ' || to_json(valor.level1_colspan) || ', "rowspan": ' || to_json(valor.level1_rowspan) || '}' || chr(10) ||
		'			]' || chr(10) ||
		'		}';
		end;

		function to_json(valor rec_axe_ambiente) return clob is 
		begin 
		return 
		'{"levels": [{"code": ' || to_json(valor.level0_code) || ', "description": ' || to_json(valor.level0_description) || '}' || ']}';
		end;

		function to_json(valor rec_metrica) return clob is 
		begin 
		return 
		'					{' || chr(10) ||
		'						"status": ' || to_json(valor.status) || ',' || chr(10) ||
		'						"message": ' || to_json(valor.message) || ',' || chr(10) ||
		'						"fmt_value": ' || to_json(valor.fmt_value) || '' || chr(10) ||
		'					}';
		end;

		

		function to_json(valor lst_axe_ambiente) return clob is
		saida clob;
		begin 
			saida := chr(10) || '	[' || chr(10);
			if valor.count > 0 then
				for i in valor.first .. valor.last loop
					saida := saida || '		' || to_json(valor(i)) || case i when valor.last then '' else ',' end || chr(10);
				end loop;
			end if;
			saida := saida || '	]';
			return saida; 
		end;

		function to_json(valor lst_metrica) return clob is
		saida clob;
		begin 
			saida := chr(10)|| '				[' || chr(10);
			if valor.count > 0 then
				for i in valor.first .. valor.last loop
					saida := saida || to_json(valor(i)) || case i when valor.last then '' else ',' end || chr(10);
				end loop;
			end if;
			saida := saida || '				]';
			return saida; 
		end;

		function to_json(valor rec_servidor) return clob is 
		begin 
		return 
		'			{' || chr(10) ||
		'				"code": ' || to_json(valor.code) || ',' || chr(10) ||
		'				"description": ' || to_json(valor.description) || ',' || chr(10) ||
		'				"metricas": ' || to_json(valor.metricas) || ',' || chr(10) ||
		'				"status": ' || to_json(valor.status) || ',' || chr(10) ||
		'				"message": ' || to_json(valor.message) || chr(10) ||
		'			}';
		end;

	begin
		dbms_output.put_line('{');
		dbms_output.put_line('	"refreshDate": '|| to_json(sysdate) || ',');
		dbms_output.put_line('	"v_axe_metrica": ');
		dbms_output.put_line('	[');
		if v_axe_metrica.count > 0 then
		for imet in v_axe_metrica.first .. v_axe_metrica.last loop
		dbms_output.put_line('		{');
		dbms_output.put_line('			"name": '||to_json(v_axe_metrica(imet).name) || '' );
		
	
		if v_axe_metrica(imet).legends.count > 0 then
		dbms_output.put_line('			,"legends": ');
		dbms_output.put_line('			[');
		for ileg in v_axe_metrica(imet).legends.first .. v_axe_metrica(imet).legends.last loop
		dbms_output.put_line('				{');
		dbms_output.put_line('					"status": '||to_json(v_axe_metrica(imet).legends(ileg).status) || ',' );
		dbms_output.put_line('					"description": '||to_json(v_axe_metrica(imet).legends(ileg).description) || '' );
		dbms_output.put_line('				}' || case ileg when v_axe_metrica(imet).legends.last then '' else ',' end);
		end loop;
		dbms_output.put_line('			]');
		end if;
	
		
		
		
		dbms_output.put_line('		}' || case imet when v_axe_metrica.last then '' else ',' end);
		end loop;
		end if;
		dbms_output.put_line('	],');
		dbms_output.put_line('	"v_axe_cenarios": '); 
		dbms_output.put_line('	[');
		if v_axe_cenarios.count > 0 then
			for i in v_axe_cenarios.first .. v_axe_cenarios.last loop
				dbms_output.put(to_json(v_axe_cenarios(i)) );
				dbms_output.put_line(case i when v_axe_cenarios.last then '' else ',' end);
			end loop;
		end if;
		dbms_output.put_line('	],');
		dbms_output.put_line('	"v_axe_ambientes": ' || to_json(v_axe_ambientes) || ',');
		dbms_output.put_line('	"v_ambientes": ');
		dbms_output.put_line('	[');
		for iamb in v_ambientes.first .. v_ambientes.last loop
		dbms_output.put_line('		[');
		if v_ambientes(iamb).cenarios.count > 0 then
		for icen in v_ambientes(iamb).cenarios.first .. v_ambientes(iamb).cenarios.last loop
		dbms_output.put(to_json(v_ambientes(iamb).cenarios(icen)));
		dbms_output.put_line(case icen when v_ambientes(iamb).cenarios.last then '' else ',' end);
		end loop;
		end if;
		dbms_output.put('		]');
		dbms_output.put_line( case iamb when v_ambientes.last then '' else ',' end);
		end loop;
		dbms_output.put_line('	]');
		dbms_output.put_line('}');
	end;
end;
/