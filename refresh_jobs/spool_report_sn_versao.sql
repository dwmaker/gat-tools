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
	c_st_lowerversion char(1) := 'W';
	c_st_outdate char(1) := 'O';
	c_st_disabled char(1) := 'D';
	c_st_upperversion char(1) := 'F';
	c_nr_dias_sla integer := 10;

	TYPE rec_cenario IS RECORD (
	versao	 VARCHAR2(100),
	dt_atualizacao date,
	proxima_versao VARCHAR2(100), 
	dt_proxima_atualizacao date,
	
	host	 VARCHAR2(100),
	sid	 VARCHAR2(100),
	port	 VARCHAR2(100),
	service_name	 VARCHAR2(100),
	dblink VARCHAR2(100),
	status	 char(1),
	tns_name all_db_links.host%type,
	MESSAGE VARCHAR2(1000)
	);

	TYPE dic_cenario IS TABLE OF rec_cenario INDEX BY VARCHAR2(64);

	TYPE lst_cod_cenario IS TABLE OF VARCHAR2(64) INDEX BY pls_integer;
	
	TYPE lst_cod_ambiente IS TABLE OF VARCHAR2(64) INDEX BY pls_integer;

	TYPE rec_ambiente IS RECORD (
	ds_ambiente 		 VARCHAR2(100),
	cenarios dic_cenario
	);

	TYPE dic_ambiente IS TABLE OF rec_ambiente INDEX BY VARCHAR2(64);

	v_ambientes dic_ambiente;
	v_cod_cenarios lst_cod_cenario;
	v_cod_ambientes lst_cod_ambiente;

	
	procedure prc_compara_ambiente
	(
		v_prod in rec_ambiente, 
		v_ambiente in out rec_ambiente
	) is
	
	begin
		
		FOR i IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
			declare
			v_cod_cenario VARCHAR2(64) := v_cod_cenarios(i);
			begin
				if v_ambiente.cenarios(v_cod_cenario).status is null and v_prod.cenarios(v_cod_cenario).status is null then
					if  (v_ambiente.cenarios(v_cod_cenario).versao < v_prod.cenarios(v_cod_cenario).versao) then 
						declare v_nr_dias_obsoleto integer := trunc(v_ambiente.cenarios(v_cod_cenario).dt_proxima_atualizacao) + c_nr_dias_sla - trunc(sysdate);
						begin
							if  v_nr_dias_obsoleto >= 0 then 
								v_ambiente.cenarios(v_cod_cenario).status := c_st_outdate; 
								v_ambiente.cenarios(v_cod_cenario).message := 'Faltam ' || to_char(v_nr_dias_obsoleto, 'fm9990') || ' dias para Obsoleto'; 
							else
								v_ambiente.cenarios(v_cod_cenario).status := c_st_lowerversion; 
								v_ambiente.cenarios(v_cod_cenario).message := 'Obsoleto ha ' || to_char(-v_nr_dias_obsoleto, 'fm9990') || ' dias'; 
							end if;
						end;

					elsif
						(v_ambiente.cenarios(v_cod_cenario).versao > v_prod.cenarios(v_cod_cenario).versao) then 
						v_ambiente.cenarios(v_cod_cenario).status := c_st_upperversion; 
						v_ambiente.cenarios(v_cod_cenario).message := 'Versao superior a de PROD'; 
					end if;
				end if;
			end;
		END LOOP;
	
	end;
begin
	-- MATRIZ CENARIOS
	v_cod_cenarios(0) := 'BRA';
	v_cod_cenarios(1) := 'SUL';
	v_cod_cenarios(2) := 'ISP';
	v_cod_cenarios(3) := 'BH';
	v_cod_cenarios(4) := 'SOC';
	v_cod_cenarios(5) := 'SAO';
	v_cod_cenarios(6) := 'ABC';
	v_cod_cenarios(7) := 'CTV';
	
	-- MATRIZ AMBIENTES
	v_cod_ambientes(v_cod_ambientes.count ):= 'PROD';
	v_cod_ambientes(v_cod_ambientes.count ):= 'CERT';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT1';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT2';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT3';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT4';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT5';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT6';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT7';
	v_cod_ambientes(v_cod_ambientes.count ):= 'SIT8';
	v_cod_ambientes(v_cod_ambientes.count ):= 'STRESS';

	-- Recuperando última versao dos ambientes	
	FOR iamb IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
		declare  v_ambiente rec_ambiente;
		begin
			FOR icen IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
				declare
				v_cenario rec_cenario;
				V_tnsdesc all_db_links.host%type;
				begin
					v_cenario.dblink := 'GA_'|| v_cod_ambientes(iamb) ||'_NETSMS_'||v_cod_cenarios(icen)||'.NET';
					for x in (select host from all_db_links where db_link = v_cenario.dblink) loop
						V_tnsdesc := x.host;
					end loop;
					if V_tnsdesc is null THEN 
						v_cenario.status := c_st_disabled;
						v_cenario.message := 'DBLink nao configurado.';
					ELSE
						v_cenario.HOST := case when instr(replace(upper(V_tnsdesc),' ',''), '(HOST=') = 0 then NULL else substr(replace(upper(V_tnsdesc),' ',''), instr(replace(upper(V_tnsdesc),' ',''), '(HOST=') + length('(HOST='), instr(replace(upper(V_tnsdesc),' ',''),')',  instr(replace(upper(V_tnsdesc),' ',''), '(HOST=') + length('(HOST=')) - (instr(replace(upper(V_tnsdesc),' ',''), '(HOST=') + length('(HOST=')) ) end;
						v_cenario.PORT := case when instr(replace(upper(V_tnsdesc),' ',''), '(PORT=') = 0 then NULL else substr(replace(upper(V_tnsdesc),' ',''), instr(replace(upper(V_tnsdesc),' ',''), '(PORT=') + length('(PORT='), instr(replace(upper(V_tnsdesc),' ',''),')',  instr(replace(upper(V_tnsdesc),' ',''), '(PORT=') + length('(PORT=')) - (instr(replace(upper(V_tnsdesc),' ',''), '(PORT=') + length('(PORT=')) ) end;
						v_cenario.SID := case when instr(replace(upper(V_tnsdesc),' ',''), '(SID=') = 0 then NULL else substr(replace(upper(V_tnsdesc),' ',''), instr(replace(upper(V_tnsdesc),' ',''), '(SID=') + length('(SID='), instr(replace(upper(V_tnsdesc),' ',''),')',  instr(replace(upper(V_tnsdesc),' ',''), '(SID=') + length('(SID=')) - (instr(replace(upper(V_tnsdesc),' ',''), '(SID=') + length('(SID=')) ) end;
						v_cenario.SERVICE_NAME := case when instr(replace(upper(V_tnsdesc),' ',''), '(SERVICE_NAME=') = 0 then NULL else substr(replace(upper(V_tnsdesc),' ',''), instr(replace(upper(V_tnsdesc),' ',''), '(SERVICE_NAME=') + length('(SERVICE_NAME='), instr(replace(upper(V_tnsdesc),' ',''),')',  instr(replace(upper(V_tnsdesc),' ',''), '(SERVICE_NAME=') + length('(SERVICE_NAME=')) - (instr(replace(upper(V_tnsdesc),' ',''), '(SERVICE_NAME=') + length('(SERVICE_NAME=')) ) end;
						BEGIN
							EXECUTE IMMEDIATE 
							'SELECT 
							max(versao) KEEP (DENSE_RANK last ORDER BY versao) versao, 
							max(dt_atualizacao) KEEP (DENSE_RANK last ORDER BY versao) dt_atualizacao 
							FROM prod_jd.sn_versao@'||v_cenario.dblink||''
							INTO v_cenario.versao, v_cenario.dt_atualizacao;
						EXCEPTION WHEN OTHERS THEN
							v_cenario.status := c_st_connerror;
							v_cenario.MESSAGE := substr(SQLERRM,1,1000);
						END;
						
						if v_cenario.versao is null and v_cenario.status is null then 
							v_cenario.status := c_st_connerror;
							v_cenario.MESSAGE := 'Versao nao cadastrada';
						end if;
					end if;
					v_ambiente.cenarios(v_cod_cenarios(icen)) := v_cenario;
					exception when no_data_found then
					null;
				end;
			END LOOP;
			v_ambientes(v_cod_ambientes(iamb)) :=v_ambiente;
		end;
	END LOOP;
	
	-- Recuperando proxima versao do ambiente de producao
	FOR iamb IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
		declare  
		v_cod_ambiente VARCHAR2(64) := v_cod_ambientes(iamb);
		begin
			if v_cod_ambiente != 'PROD' then
				FOR icen IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP	
					declare
					v_cod_cenario VARCHAR2(64) := v_cod_cenarios(icen);
					begin
						if v_ambientes(v_cod_ambiente).cenarios(v_cod_cenario).status is null and v_ambientes('PROD').cenarios(v_cod_cenario).status is null then
						
							BEGIN
								EXECUTE IMMEDIATE 
								'SELECT 
								max(versao) KEEP (DENSE_RANK first ORDER BY versao) proxima_versao, 
								max(dt_atualizacao) KEEP (DENSE_RANK first ORDER BY versao) dt_proxima_atualizacao 
								FROM prod_jd.sn_versao@'||v_ambientes('PROD').cenarios(v_cod_cenario).dblink||'
								where
								versao > :versao
								'
								INTO 
								v_ambientes(v_cod_ambiente).cenarios(v_cod_cenario).proxima_versao, 
								v_ambientes(v_cod_ambiente).cenarios(v_cod_cenario).dt_proxima_atualizacao
								USING 
								v_ambientes(v_cod_ambiente).cenarios(v_cod_cenario).versao;
							END;
						end if;
					end;				
				END LOOP;
			end if;
		end;
	END LOOP;

	
	-- aplicando regra de comparação
	FOR iamb IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
		if v_cod_ambientes(iamb) != 'PROD' then
			prc_compara_ambiente(v_ambientes('PROD'), v_ambientes(v_cod_ambientes(iamb)));
		end if;
	end loop;


	-- Descrição dos ambientes
	v_ambientes('PROD').ds_ambiente := ('Produção');
	v_ambientes('CERT').ds_ambiente := ('Certificação');
	v_ambientes('SIT4').ds_ambiente := ('Teste Integrado - LE');
	v_ambientes('SIT5').ds_ambiente := ('Teste Integrado - LD');
	v_ambientes('SIT6').ds_ambiente := ('UAT');
	v_ambientes('SIT7').ds_ambiente := ('Novo Sap BR');
	
	-- Renderização
	declare
	v_width varchar2(30) := (to_char((100-15)/(v_cod_cenarios.COUNT),'FM990D00', 'NLS_NUMERIC_CHARACTERS = ''.,''')||'%');
	begin
	dbms_output.put_line('<div class="">');
	dbms_output.put_line('	<h2>Versionamento NETSMS (database)</h2>');
	dbms_output.put_line('	<small><i>Atualizado em '|| htf.escape_sc(to_char(sysdate,'yyyy-mm-dd hh24:mi')) ||'</i></small>');
	dbms_output.put_line('	</br>');
	dbms_output.put_line('	<table class="table table-bordered table-sm">');
	dbms_output.put_line('		<thead  class="thead-dark">');
	dbms_output.put_line('			<tr>');
	dbms_output.put_line('				<th style="width: 15%;">Ambiente \ Cenario</th>');
	FOR i IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
		dbms_output.put_line('				<th style="width: '||v_width||';">'||v_cod_cenarios(i)||' <br></th>');
	END LOOP;
	dbms_output.put_line('			</tr>');
	dbms_output.put_line('		</thead>');
	dbms_output.put_line('		<tbody>');
	FOR iamb IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
		declare  v_ambiente rec_ambiente := v_ambientes(v_cod_ambientes(iamb));
		begin
			dbms_output.put_line('			<tr>');
			dbms_output.put_line('				<th title="'||htf.escape_sc(v_ambiente.ds_ambiente)||'">'|| htf.escape_sc(v_cod_ambientes(iamb))||'</th>');
			FOR i IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
				declare v_cenario rec_cenario := v_ambiente.cenarios(v_cod_cenarios(i));
				begin
				dbms_output.put('							<td class="');
				dbms_output.put(
				case v_cenario.status 
				when c_st_lowerversion then 'bg-danger text-white' 
				when c_st_outdate then 'bg-warning text-dark' 
				when c_st_disabled then 'bg-light text-dark' 
				when c_st_connerror then 'bg-secondary text-warning' 
				when c_st_upperversion then 'bg-info text-white' 
				end );
				dbms_output.put(' text-center" ');
				dbms_output.put('title="');
				if v_cenario.dblink is not null then dbms_output.put('DBLink: ' || htf.escape_sc(v_cenario.dblink) || chr(38)||'#13;'); end if;
				if v_cenario.host is not null then dbms_output.put('Host: ' || htf.escape_sc(v_cenario.host) || chr(38)||'#13;'); end if;
				if v_cenario.port is not null then dbms_output.put('Port: ' || htf.escape_sc(v_cenario.port) || chr(38)||'#13;'); end if;
				if v_cenario.sid is not null then dbms_output.put('SID: ' || htf.escape_sc(v_cenario.sid) || chr(38)||'#13;'); end if;
				if v_cenario.service_name is not null then dbms_output.put('Service Name: ' || htf.escape_sc(v_cenario.service_name) || chr(38)||'#13;'); end if;
				if v_cenario.versao is not null then dbms_output.put('Versao: ' ||  htf.escape_sc(v_cenario.versao) || chr(38)||'#13;'); end if;
				if v_cenario.dt_atualizacao is not null then dbms_output.put('Implantacao: ' || to_char(v_cenario.dt_atualizacao, 'yyyy-mm-dd') || chr(38)||'#13;'); end if;
				if v_cenario.proxima_versao is not null then dbms_output.put('Proxima Versao: ' ||  htf.escape_sc(v_cenario.proxima_versao) || chr(38)||'#13;'); end if;
				if v_cenario.dt_proxima_atualizacao is not null then dbms_output.put('Proxima Implantacao: ' || to_char(v_cenario.dt_proxima_atualizacao, 'yyyy-mm-dd') || chr(38)||'#13;'); end if;
				
				if v_cenario.message is not null then dbms_output.put('Message: ' || chr(38)||'#13;' || htf.escape_sc(v_cenario.message) || chr(38)||'#13;'); end if;
				dbms_output.put('">');
				dbms_output.put(htf.escape_sc(
				case 
				when v_cenario.status = c_st_connerror then '!'
				when v_cenario.versao is null then '-'
				else v_cenario.versao
				end
				));
				dbms_output.put_line('</td>');
				end;
			END LOOP;
			dbms_output.put_line('			</tr>');
		end;
	END LOOP;

	dbms_output.put_line('		</tbody>');
	dbms_output.put_line('	</table>');
	dbms_output.put_line('</div>');

	end;
end;
/