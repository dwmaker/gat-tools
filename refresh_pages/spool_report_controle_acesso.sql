/*****************************************************
***		spool_report_controle_acesso.sql
***		Autor: Paulo Ponciano - Spread
***		Data: 05/07/2019
***		Objetivo:
***			Geração de um relatório consolidado comparando
***			os objetos de controle de acesso
*****************************************************/
set serveroutput on;
set trimspool on;
set linesize 500;
set feedback off;
set termout off;

spool "&1.";
declare

	c_status_sucess char(1) := 'S';
	c_status_error char(1) := 'E';
	c_status_disabled char(1) := 'D';
	c_status_warning char(1) := 'W';
	c_status_conflict char(1) := 'C';
	c_status_invalid char(1) := 'I';
	c_status_notfound char(1) := 'F';

	type rec_ambiente is record
	(
		cd_ambiente varchar2(100),
		ds_ambiente varchar2(100)
	);

	type rec_cenario is record
	(
		cd_aplicacao varchar2(100),
		cd_cenario varchar2(100)
	);

	TYPE lst_mensagem IS TABLE OF VARCHAR2(200) INDEX BY pls_integer;

	type rec_coluna is record
	(
		texto varchar2(100),
		status char(1),
		nm_objeto varchar2(100)
	);

	type lst_coluna is table of rec_coluna index by pls_integer;

	type rec_celula is record
	(
		texto varchar2(100),
		status char(1),
		mensagens lst_mensagem
	);

	type lst_celula is table of rec_celula index by pls_integer;

	type rec_sublinha is record
	(
		celulas lst_celula,
		status char(1)
	);

	type lst_sublinha is table of rec_sublinha index by pls_integer;

	type rec_linha is record
	(
		sublinhas lst_sublinha
	);

	type lst_linha is table of rec_linha index by pls_integer;

	type rec_tabela is record
	(
		linhas lst_linha
	);

	type lst_cenario is table of rec_cenario index by pls_integer;
	type lst_ambiente is table of rec_ambiente index by pls_integer;
	v_lst_ambiente lst_ambiente;
	v_lst_cenario lst_cenario;
	v_lst_coluna lst_coluna;
	v_tabela rec_tabela;

	function new_cenario(
	cd_aplicacao varchar2,
	cd_cenario varchar2 := null
	) return rec_cenario is v_cenario rec_cenario;
	begin
		v_cenario.cd_aplicacao := cd_aplicacao;
		v_cenario.cd_cenario := cd_cenario;
		return v_cenario;
	end new_cenario;

	function new_ambiente(
	cd_ambiente varchar2,
	ds_ambiente varchar2
	) return rec_ambiente is v_ambiente rec_ambiente;
	begin
		v_ambiente.cd_ambiente := cd_ambiente;
		v_ambiente.ds_ambiente := ds_ambiente;
		return v_ambiente;
	end new_ambiente;

	function new_coluna(
	texto varchar2,
	nm_objeto varchar2
	) return rec_coluna is v_coluna rec_coluna;
	begin
		v_coluna.texto := texto;
		v_coluna.nm_objeto := nm_objeto;
		return v_coluna;
	end new_coluna;

begin

	v_lst_coluna(v_lst_coluna.count) := new_coluna(texto => 'Logon', nm_objeto => 'TR_LOGON');
	v_lst_coluna(v_lst_coluna.count) := new_coluna(texto => 'Monitora', nm_objeto => 'TR_MONITORA');

	-- MATRIZ CENARIOS
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'BRA');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'SUL');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'ISP');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'BH');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'SOC');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'SAO');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'ABC');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'NETSMS', cd_cenario => 'CTV');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'ATLAS');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'SIGMA');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'FEPP');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'COMBOMULTI');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'FIQUELIGADO');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'WLI');
	v_lst_cenario(v_lst_cenario.count) := new_cenario(cd_aplicacao => 'WA');

	-- MATRIZ AMBIENTES
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'CERT', ds_ambiente => 'Certificação');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'DEV1', ds_ambiente => 'DEV1');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'DEV3', ds_ambiente => 'DEV3');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'DEV4', ds_ambiente => 'DEV4');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT1', ds_ambiente => 'SIT1');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT2', ds_ambiente => 'SIT2');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT3', ds_ambiente => 'SIT3');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT4', ds_ambiente => 'Teste Integrado - LE');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT5', ds_ambiente => 'Teste Integrado - LD');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT6', ds_ambiente => 'Stress Test');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT7', ds_ambiente => 'Novo Sap BR');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'SIT8', ds_ambiente => 'SIT8');
	v_lst_ambiente(v_lst_ambiente.count):= new_ambiente(cd_ambiente => 'UAT' , ds_ambiente => 'UAT' );

	FOR iamb IN v_lst_ambiente.FIRST .. v_lst_ambiente.LAST LOOP
		declare
		v_ambiente rec_ambiente := v_lst_ambiente(iamb);
		begin
			FOR icen IN v_lst_cenario.FIRST .. v_lst_cenario.LAST LOOP
				declare
				v_cenario rec_cenario := v_lst_cenario(icen);
				v_dblink varchar2(30);
				v_host all_db_links.host%type;
				v_nr_count integer;
				begin
					v_dblink := 'GA_' || v_ambiente.cd_ambiente || '_' || v_cenario.cd_aplicacao || nullif('_' || v_cenario.cd_cenario, '_') || '.NET';
					select
					MAX(replace(replace(HOST, '=', ' = '), '  ', ' ')) HOST,
					COUNT(1) NR_COUNT
					into
					v_host,
					v_nr_count
					from all_db_links
					where db_link = v_dblink
					AND owner IN ('PUBLIC', USER);
					for icol in v_lst_coluna.first .. v_lst_coluna.last loop
						declare v_celula rec_celula;
						begin
							begin
							v_celula := v_tabela.linhas(iamb).sublinhas(icen).celulas(icol);
							exception when no_data_found then null;
							end;
							v_celula.mensagens(v_celula.mensagens.count) := 'DBLink: ' || v_dblink;
							v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
						end;
					end loop;

					if v_nr_count = 1 then
						for icol in v_lst_coluna.first .. v_lst_coluna.last loop
							declare v_celula rec_celula;
							begin
								v_celula := v_tabela.linhas(iamb).sublinhas(icen).celulas(icol);
								v_celula.mensagens(v_celula.mensagens.count) := 'Host: ' || v_host;
								declare
								v_owner all_triggers.owner%type;
								v_trigger_name all_triggers.trigger_name%type;
								v_obj_status all_objects.status%type;
								v_trg_status all_triggers.status%type;
								v_qt_triggers integer;
								begin
									execute immediate
									'select ' || chr(10) || 
									'(trg.owner) owner,' || chr(10) || 
									'(trg.trigger_name) trigger_name,' || chr(10) || 
									'(obj.status) obj_status,' || chr(10) || 
									'(trg.status) trg_status' || chr(10) || 
									'from ' || chr(10) || 
									'all_triggers@' || v_dblink || ' trg ' || chr(10) || 
									'join all_objects@' || v_dblink || ' obj on obj.owner = trg.owner and obj.object_name = trg.trigger_name' || chr(10) || 
									'WHERE ' || chr(10) || 
									'obj.object_name IN (:1) ' || chr(10) || 
									'and obj.object_type= ''TRIGGER'''
									into v_owner, v_trigger_name, v_obj_status, v_trg_status
									using v_lst_coluna(icol).nm_objeto;
									v_celula.texto := v_owner || '.' || v_trigger_name;
									if v_obj_status != 'VALID' then
										v_celula.status := c_status_invalid;
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: Trigger inválida';
									elsif v_trg_status != 'ENABLED' then
										v_celula.status := c_status_warning;
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: Trigger desabilitada';
									else
										v_celula.status := c_status_sucess;
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: Trigger operante';
									end if;
									v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
								exception
									when NO_DATA_FOUND then
										v_celula.status := c_status_notfound;
										v_celula.texto := '(não encontrada)';
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: Trigger não encontrada';
										v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
									when TOO_MANY_ROWS then
										v_celula.status := c_status_conflict;
										v_celula.texto := '(em conflito)';
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: Nome em conflito';
										v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
									when others then
										v_celula.texto := '(outros)';
										v_celula.status := c_status_error;
										v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: ' || sqlerrm;
										v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
								end;
							end;
						end loop;
					elsif v_nr_count = 0 then
						v_tabela.linhas(iamb).sublinhas(icen).status := c_status_disabled;
						for icol in v_lst_coluna.first .. v_lst_coluna.last loop
							declare v_celula rec_celula;
							begin
								begin
								v_celula := v_tabela.linhas(iamb).sublinhas(icen).celulas(icol);
								exception
									when no_data_found then null;
								end;
								v_celula.mensagens(v_celula.mensagens.count) := 'Mensagem: DBLink não configurado';
								v_tabela.linhas(iamb).sublinhas(icen).celulas(icol) := v_celula;
							end;
						end loop;
					end if;

				end;
			end loop;
		end;
	end loop;

	-- Renderização
	begin
	dbms_output.put_line('<!doctype html>');
	dbms_output.put_line('<html lang="pt-br">');
	dbms_output.put_line('	<head>');
	dbms_output.put_line('		<meta charset="utf-8">');
	dbms_output.put_line('		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
	dbms_output.put_line('		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">');
	dbms_output.put_line('		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">');
	dbms_output.put_line('		<style>');
	dbms_output.put_line('.first_cenario{border-top-color: #000; border-top-width: 2px; border-top-style: solid;}');
	dbms_output.put_line('.last_cenario{border-bottom-color: #000; border-bottom-width: 2px; border-bottom-style: solid;}');
	dbms_output.put_line('		</style>');
	dbms_output.put_line('		<title>GAT - Gestao de Ambiente</title>');
	dbms_output.put_line('	</head>');
	dbms_output.put_line('	<body>');
	dbms_output.put_line('		<main role="main" class="container">');
	dbms_output.put_line('			<div class="">');
	dbms_output.put_line('				<h2>Controle de Acessos</h2>');
	dbms_output.put_line('				<small><i>Atualizado em ' || htf.escape_sc(to_char(sysdate,'yyyy-mm-dd hh24:mi')) || '</i></small>');
	dbms_output.put_line('				</br>');
	dbms_output.put_line('				<table class="table table-bordered table-sm">');
	dbms_output.put_line('					<thead class="thead-dark">');
	dbms_output.put_line('						<tr>');
	dbms_output.put_line('							<th>Ambiente</th>');
	dbms_output.put_line('							<th>Aplicação</th>');
	dbms_output.put_line('							<th>Cenário</th>');
	for icol in v_lst_coluna.first .. v_lst_coluna.last loop
		dbms_output.put_line('							<th>' || v_lst_coluna(icol).texto || '</th>');
	end loop;
	dbms_output.put_line('						</tr>');
	dbms_output.put_line('					</thead>');
	dbms_output.put_line('					<tbody>');
	FOR iamb IN v_lst_ambiente.FIRST .. v_lst_ambiente.LAST LOOP
		declare
		v_ambiente rec_ambiente := v_lst_ambiente(iamb);
		v_linha rec_linha;
		begin
			if v_tabela.linhas.exists(iamb) then v_linha := v_tabela.linhas(iamb); end if;
			FOR icen IN v_lst_cenario.FIRST .. v_lst_cenario.LAST LOOP
				declare
				v_cenario rec_cenario := v_lst_cenario(icen);
				v_sublinha rec_sublinha;
				begin
				if v_linha.sublinhas.exists(icen) then v_sublinha := v_linha.sublinhas(icen); end if;
				dbms_output.put('						<tr ');
				dbms_output.put('class="');
				dbms_output.put(
				case v_sublinha.status
				when c_status_disabled then 'bg-secondary text-white '
				end );
				dbms_output.put(
				case icen
				when v_lst_cenario.FIRST then 'first_cenario '
				when v_lst_cenario.last then 'last_cenario '
				end
				);
				dbms_output.put('" ');
				dbms_output.put_line('>');
				dbms_output.put_line('							<td title="' || htf.escape_sc(v_ambiente.ds_ambiente) || '">' || htf.escape_sc(v_ambiente.cd_ambiente) || '</td>');
				dbms_output.put_line('							<td title="' || htf.escape_sc(v_cenario.cd_aplicacao) || '">' || htf.escape_sc(v_cenario.cd_aplicacao) || '</td>');
				dbms_output.put_line('							<td title="' || htf.escape_sc(v_cenario.cd_cenario) || '">' || htf.escape_sc(nvl(v_cenario.cd_cenario, '-')) || '</td>');
				for icol in v_lst_coluna.first .. v_lst_coluna.last loop
					declare
					v_celula rec_celula;
					begin
						if v_sublinha.celulas.exists(icol) then v_celula := v_sublinha.celulas(icol); end if;
						dbms_output.put('							<td class="text-nowrap" ');
						dbms_output.put('title="');
						if v_celula.mensagens.count >0 then
							for imsg in v_celula.mensagens.first .. v_celula.mensagens.last loop
								dbms_output.put(replace(v_celula.mensagens(imsg), '"', chr(38) || 'quot;') || chr(38) || '#13;');
							end loop;
						end if;
						dbms_output.put('">');
						dbms_output.put_line('								<li class="fas ' || 
						case v_celula.status
						when c_status_sucess   then 'fa-check-circle       text-success'
						when c_status_warning  then 'fa-exclamation-circle text-warning'
						when c_status_error    then 'fa-times-circle       text-danger'
						when c_status_notfound then 'fa-times-circle       text-danger'
						when c_status_invalid  then 'fa-times-circle       text-danger'				
						when c_status_conflict then 'fa-times-circle       text-danger'				
						when c_status_disabled then 'fa-power-off-circle   text-secondary'
						
						end || '"></li> ' || v_celula.texto || '');
						dbms_output.put_line('							</td>');
					end;
				end loop;
				dbms_output.put_line('						</tr>');
				end;
			END LOOP;
		end;
	END LOOP;
	dbms_output.put_line('					</tbody>');
	dbms_output.put_line('				</table>');
	dbms_output.put_line('			</div>');
	dbms_output.put_line('		</main>');
	dbms_output.put_line('		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>');
	dbms_output.put_line('		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>');
	dbms_output.put_line('		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>');
	dbms_output.put_line('	</body>');
	dbms_output.put_line('</html>');
	end;
end;
/
spool off;
exit;