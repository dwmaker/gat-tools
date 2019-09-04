
/*****************************************************
***	spool_report_sn_parametro.sql
***	Autor: Paulo Ponciano - Spread
***	Data: 27/06/2019
***	Objetivo: Comparar parâmetros do NetSMS entre diferentes ambientes
***
***
*****************************************************/



SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
set termout off;

spool "&1.";

set define off;

declare
TYPE lst_cod_cenario IS TABLE OF core.gat_dblinks.cd_cenario%type INDEX BY pls_integer;
TYPE lst_cod_ambiente IS TABLE OF core.gat_dblinks.cd_ambiente%type INDEX BY pls_integer;

type rec_regra_parametro is record
(
	nome_parametro varchar2(100) ,
	tp_parametro core.gat_regra_parametro.tp_parametro%type,
	fc_compara_ambiente core.gat_regra_parametro.fc_compara_ambiente%type,
	fc_compara_cenario core.gat_regra_parametro.fc_compara_cenario%type
);

TYPE lst_regra_parametro IS TABLE OF rec_regra_parametro INDEX BY pls_integer;

v_cod_cenarios lst_cod_cenario;
v_cod_ambientes lst_cod_ambiente;
v_regra_parametros lst_regra_parametro;

TYPE rec_cenario IS RECORD (
	vlr_parametro VARCHAR2(255) ,
	dt_atualizacao DATE,
	css varchar2(255),
	messages varchar2(200),
	qt_valor integer,
	QT_AMBIENTE_VLR integer,
	QT_cenario_VLR integer,
	QT_AMBIENTE_TOT integer,
	QT_CENARIO_TOT integer
	);

TYPE dic_cenario IS TABLE OF rec_cenario INDEX BY core.gat_dblinks.cd_cenario%type;

TYPE rec_tipo IS RECORD
(
	fc_compara_ambiente core.gat_regra_parametro.fc_compara_ambiente%type,
	fc_compara_cenario core.gat_regra_parametro.fc_compara_cenario%type,
	cenarios dic_cenario
);

TYPE dic_tipo IS TABLE OF rec_tipo INDEX BY VARCHAR2(64);

TYPE rec_parametro IS RECORD
(
	tipos dic_tipo
);

TYPE dic_parametro IS TABLE OF rec_parametro INDEX BY VARCHAR2(150);

TYPE rec_ambiente IS RECORD
(
	parametros dic_parametro
);

TYPE dic_ambiente IS TABLE OF rec_ambiente INDEX by core.gat_dblinks.cd_ambiente%type;

ambientes dic_ambiente;
begin
	-- MATRIZ CENARIOS
	v_cod_cenarios(v_cod_cenarios.count) := 'BRA';
	v_cod_cenarios(v_cod_cenarios.count) := 'SUL';
	v_cod_cenarios(v_cod_cenarios.count) := 'ISP';
	v_cod_cenarios(v_cod_cenarios.count) := 'BH';
	v_cod_cenarios(v_cod_cenarios.count) := 'SOC';
	v_cod_cenarios(v_cod_cenarios.count) := 'SAO';
	v_cod_cenarios(v_cod_cenarios.count) := 'ABC';
	v_cod_cenarios(v_cod_cenarios.count) := 'CTV';

	-- MATRIZ AMBIENTES
	v_cod_ambientes(v_cod_ambientes.count) := 'PROD';
	v_cod_ambientes(v_cod_ambientes.count) := 'CERT';
	v_cod_ambientes(v_cod_ambientes.count) := 'DEV1';
	v_cod_ambientes(v_cod_ambientes.count) := 'DEV3';
	v_cod_ambientes(v_cod_ambientes.count) := 'DEV4';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT1';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT2';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT3';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT4';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT5';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT6';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT7';
	v_cod_ambientes(v_cod_ambientes.count) := 'SIT8';
	v_cod_ambientes(v_cod_ambientes.count) := 'UAT';

	-- MATRIZ PARAMETROS
	for x in
	(
	SELECT
	x.NOME_PARAMETRO,
	x.TP_PARAMETRO,
	x.FC_COMPARA_AMBIENTE,
	x.FC_COMPARA_CENARIO
	FROM CORE.gat_regra_parametro X
	ORDER BY
	X.nome_parametro,
	X.tp_parametro
	) loop
		declare v_regra_parametro rec_regra_parametro;
		begin
		v_regra_parametro.NOME_PARAMETRO := x.NOME_PARAMETRO;
		v_regra_parametro.TP_PARAMETRO := x.TP_PARAMETRO;
		v_regra_parametro.FC_COMPARA_AMBIENTE := x.FC_COMPARA_AMBIENTE;
		v_regra_parametro.FC_COMPARA_CENARIO := x.FC_COMPARA_CENARIO;
		v_regra_parametros(v_regra_parametros.count) := v_regra_parametro;
		end;
	end loop;

	for x in
	(
	select distinct par.ds_endereco
	from
	core.sn_parametro_endpoint par
	where par.st_parametro='A'
	) loop
		declare v_regra_parametro rec_regra_parametro;
		begin
		v_regra_parametro.NOME_PARAMETRO := x.ds_endereco;
		v_regra_parametro.TP_PARAMETRO := 'EDP';
		v_regra_parametro.FC_COMPARA_AMBIENTE := null;
		v_regra_parametro.FC_COMPARA_CENARIO := 'EQU';
		v_regra_parametros(v_regra_parametros.count) := v_regra_parametro;
		end;
	end loop;

	-- INICIALIZANDO MATRIZ 3D
	FOR i_ambiente IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
	declare cd_ambiente varchar2(20) := v_cod_ambientes(i_ambiente);
	begin

		FOR i_cenario IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
			declare cd_cenario varchar2(20) := v_cod_cenarios(i_cenario);
			begin
				FOR i_regra_parametro IN v_regra_parametros.FIRST .. v_regra_parametros.LAST LOOP
					declare
					v_regra_parametro rec_regra_parametro := v_regra_parametros(i_regra_parametro);
					nome_parametro varchar2(150) := v_regra_parametro.nome_parametro;
					tp_parametro varchar2(64) := v_regra_parametro.tp_parametro;
					cenario rec_cenario;
					begin
						ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro).fc_compara_ambiente := v_regra_parametro.fc_compara_ambiente;
						ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro).fc_compara_cenario := v_regra_parametro.fc_compara_cenario;
						ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro).cenarios(cd_cenario) := cenario;
					end;
				end loop;
			end;
		end loop;
	end;
	end loop;

	-- POPULANDO MATRIZ 3D
	for x in
	(
		SELECT
		x.qt_cenario_vlr,
		x.qt_cenario_tot,
		x.qt_ambiente_vlr,
		x.qt_ambiente_tot,
		x.qt_valor,
		x.vlr_parametro,
		x.nome_parametro,
		x.tp_parametro,
		x.cd_ambiente,
		x.cd_cenario
		FROM
		core.vw_parametro_netsms x
	) loop
	declare cenario rec_cenario;
	begin
		cenario := ambientes(x.cd_ambiente).parametros(x.nome_parametro).tipos(x.tp_parametro).cenarios(x.cd_cenario);
		cenario.vlr_parametro := x.vlr_parametro;
		cenario.qt_valor := x.qt_valor;
		cenario.qt_ambiente_vlr := x.qt_ambiente_vlr;
		cenario.qt_cenario_vlr := x.qt_cenario_vlr;
		cenario.qt_ambiente_tot := x.qt_ambiente_tot;
		cenario.qt_cenario_tot := x.qt_cenario_tot;
		ambientes(x.cd_ambiente).parametros(x.nome_parametro).tipos(x.tp_parametro).cenarios(x.cd_cenario) := cenario;
	END;
	end loop;

	-- Endpoints (EDP)
	for x in
	(
		with
		params as
		(
			select
			par.ds_endereco nome_parametro,
			dtb.cd_ambiente,
			dtb.cd_cenario,
			cd_aplicacao,
			max(par.tp_protocolo || '://' || par.nm_host || ':' || par.nr_porta) vlr_parametro,
			count(distinct par.tp_protocolo || '://' || par.nm_host || ':' || par.nr_porta) qt_valor
			from
			core.sn_parametro_endpoint par
			join core.gat_dblinks dtb on par.dblink_name = dtb.nm_dblink
			where par.st_parametro='A' and dtb.CD_APLICACAO='NETSMS'
			group by
			par.ds_endereco ,
			dtb.cd_ambiente,
			dtb.cd_cenario,
			dtb.cd_aplicacao
		)
		select
		nome_parametro,
		cd_ambiente,
		cd_cenario,
		vlr_parametro,
		( SELECT count(distinct p2.cd_cenario) FROM params p2 where p1.cd_aplicacao = p2.cd_aplicacao and p1.cd_ambiente = p2.cd_ambiente and p1.nome_parametro = p2.nome_parametro and p1.vlr_parametro = p2.vlr_parametro ) qt_cenario_vlr,
		( SELECT count(distinct p2.cd_cenario) FROM params p2 where p1.cd_aplicacao = p2.cd_aplicacao and p1.cd_ambiente = p2.cd_ambiente and p1.nome_parametro = p2.nome_parametro ) qt_cenario_tot,
		( SELECT count(distinct p2.cd_ambiente) FROM params p2 where p1.cd_aplicacao = p2.cd_aplicacao and p1.cd_cenario = p2.cd_cenario and p1.nome_parametro = p2.nome_parametro and p1.vlr_parametro = p2.vlr_parametro ) qt_ambiente_vlr,
		( SELECT count(distinct p2.cd_ambiente) FROM params p2 where p1.cd_aplicacao = p2.cd_aplicacao and p1.cd_cenario = p2.cd_cenario and p1.nome_parametro = p2.nome_parametro ) qt_ambiente_tot,
		qt_valor
		from params p1
	) loop
	declare cenario rec_cenario;
	begin
		cenario := ambientes(x.cd_ambiente).parametros(x.nome_parametro).tipos('EDP').cenarios(x.cd_cenario);
		cenario.vlr_parametro := x.vlr_parametro;
		cenario.qt_valor := x.qt_valor;
		cenario.qt_ambiente_vlr := x.qt_ambiente_vlr;
		cenario.qt_cenario_vlr := x.qt_cenario_vlr;
		cenario.qt_ambiente_tot := x.qt_ambiente_tot;
		cenario.qt_cenario_tot := x.qt_cenario_tot;
		ambientes(x.cd_ambiente).parametros(x.nome_parametro).tipos('EDP').cenarios(x.cd_cenario) := cenario;
	END;
	end loop;

	-- APLICANDO REGRAS DE NEGOCIO
	begin
		FOR i_ambiente IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
			declare cd_ambiente varchar2(20) := v_cod_ambientes(i_ambiente);
			begin
			FOR i_parametro IN v_regra_parametros.FIRST .. v_regra_parametros.LAST LOOP
				declare
				nome_parametro varchar2(99) := v_regra_parametros(i_parametro).nome_parametro;
				tp_parametro varchar2(99) := v_regra_parametros(i_parametro).tp_parametro;
				begin

					FOR i_cenario IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
						declare

						cd_cenario VARCHAR2(64) := v_cod_cenarios(i_cenario);
						cenario rec_cenario;
						tipo rec_tipo;
						begin
							tipo := ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro);

							cenario := ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro).cenarios(cd_cenario);

							if cenario.qt_valor > 1 then
							cenario.css := cenario.css || 'role_singlevalue ' ;
							cenario.messages := cenario.messages || chr(13) ||'Existem mais de um valor para este parametro';
							end if;

							if tipo.fc_compara_ambiente = 'EQU' and cenario.qt_ambiente_vlr < cenario.qt_ambiente_tot then
							cenario.css := cenario.css ||'role_ambiente_equ ';
							cenario.messages := cenario.messages || chr(13) ||'O valor deve ser igual entre os ambientes (vertical)';
							end if;

							if tipo.fc_compara_ambiente = 'DIF' and cenario.qt_ambiente_vlr > 1 then
							cenario.css := cenario.css ||'role_ambiente_dif ';
							cenario.messages := cenario.messages || chr(13) ||'O valor deve ser diferente entre os ambientes (vertical)';
							end if;

							if tipo.fc_compara_cenario = 'EQU' and cenario.qt_cenario_vlr < cenario.qt_cenario_tot then
							cenario.css := cenario.css ||'role_cenario_equ ';
							cenario.messages := cenario.messages || chr(13) ||'O valor deve ser igual entre os cenários (horizontal)';
							end if;

							if tipo.fc_compara_cenario = 'DIF' and cenario.qt_cenario_vlr > 1 then
							cenario.css := cenario.css ||'role_cenario_dif ';
							cenario.messages := cenario.messages || chr(13) ||'O valor deve ser diferente entre os cenários (horizontal)';
							end if;

							ambientes(cd_ambiente).parametros(nome_parametro).tipos(tp_parametro).cenarios(cd_cenario) := cenario;
						end;
					END LOOP;
				end;
			END LOOP;
			end;
		END LOOP;
	end;

	-- Renderização
	declare
	v_width varchar2(30) := (to_char((100-22)/(v_cod_cenarios.COUNT),'FM990D00', 'NLS_NUMERIC_CHARACTERS = ''.,''')||'%');
	begin
		dbms_output.put_line('<!doctype html>');
		dbms_output.put_line('<html lang="pt-br">');
		dbms_output.put_line('	<head>');
		dbms_output.put_line('		<meta charset="utf-8">');
		dbms_output.put_line('		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
		dbms_output.put_line('		<title>GAT - Gestao de Ambiente</title>');
		dbms_output.put_line('		<base href="/">');
		dbms_output.put_line('		<link rel="stylesheet" href="lib/css/bootstrap.min.css" >');
		dbms_output.put_line('		<link rel="stylesheet" href="uib/dist/ui-bootstrap-csp.css">');
		dbms_output.put_line('		<link rel="stylesheet" href="lib/css/all.css">');
		dbms_output.put_line('		<script src="lib/jquery.min.js"></script>');
		dbms_output.put_line('		<script src="lib/js/bootstrap.min.js" ></script>');
		dbms_output.put_line('		<script src="lib/angular.min.js"></script>');
		dbms_output.put_line('		<script src="lib/angular-route.min.js"></script>');
		dbms_output.put_line('		<script src="lib/angular-base64/angular-base64.min.js"></script>');
		dbms_output.put_line('		<script src="lib/angular-cookies/angular-cookies.min.js"></script>');
		dbms_output.put_line('		<script src="lib/angular-locale-pt-br/angular-locale_pt-br.js"></script>');
		dbms_output.put_line('		<script src="lib/alasql.min.js"></script>');
		dbms_output.put_line('		<script src="lib/xlsx.full.min.js"></script>');
		dbms_output.put_line('		<script src="uib/dist/ui-bootstrap-tpls.js"></script>');
		dbms_output.put_line('		<script src="uib/dist/ui-bootstrap.js"></script>');
		dbms_output.put_line('		<script src="lib/angularjs-unique-filter/src/unique.js"></script>');
		dbms_output.put_line('		<script src="app.module.js"></script>');
		dbms_output.put_line('		<script src="components/menu/menu-directive.js"></script>');
		dbms_output.put_line('		<script src="components/menu/menu-controller.js"></script>');
		dbms_output.put_line('		<script src="components/authentication/authentication-service.js"></script>');
		dbms_output.put_line('		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css"/>');
		dbms_output.put_line('		<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"></script>');
		dbms_output.put_line('		<style>');
		dbms_output.put_line('.ellipsis {overflow: hidden; white-space: nowrap; text-overflow: ellipsis;}');
		dbms_output.put_line('.nowrap { white-space:nowrap; }');
		dbms_output.put_line('.role_cenario_equ {background-color: #4BACC6} ');
		dbms_output.put_line('.role_cenario_dif {background-color: #F79646} ');
		dbms_output.put_line('.role_ambiente_equ {background-color: #C0504D}');
		dbms_output.put_line('.role_ambiente_dif {background-color: #8064A2}');
		dbms_output.put_line('.role_singlevalue {background-color: #FFC000} ');
		dbms_output.put_line('.AMB_PROD {font-weight: bold; border-color: black} ');
		dbms_output.put_line('		</style>');
		dbms_output.put_line('		<script>');
		dbms_output.put_line('$(document).ready(function() {');
		dbms_output.put_line('// Setup - add a text input to each footer cell');
		dbms_output.put_line('$(''#example thead tr'').clone(true).appendTo( ''#example thead'' );');
		dbms_output.put_line('$(''#example thead tr:eq(1) th'').each( function (i) {');
		dbms_output.put_line('	var title = $(this).text();');
		dbms_output.put_line('	$(this).html( ''<input type="text" placeholder="Search ''+title+''" />'' );');
		dbms_output.put_line('		$( ''input'', this ).on( ''keyup change'', function () {');
		dbms_output.put_line('		if ( table.column(i).search() !== this.value ) {');
		dbms_output.put_line('			table');
		dbms_output.put_line('				.column(i)');
		dbms_output.put_line('				.search( this.value )');
		dbms_output.put_line('				.draw();');
		dbms_output.put_line('		}');
		dbms_output.put_line('	} );');
		dbms_output.put_line('} );');
		dbms_output.put_line('');
		dbms_output.put_line('var table = $(''#example'').DataTable( {');
		dbms_output.put_line('	autoWidth: true,');
		dbms_output.put_line('	orderCellsTop: true,');
		dbms_output.put_line('} );');
		dbms_output.put_line('} );');
		dbms_output.put_line('		</script>');
		dbms_output.put_line('	</head>');
		dbms_output.put_line('	<body ng-app="myApp">');
		dbms_output.put_line('	<menu></menu>');
		dbms_output.put_line('		<main role="main" style="margin-left: 30px;margin-right: 30px; margin-top: 60px; ">');
		dbms_output.put_line('			<div class="">');
		dbms_output.put_line('				<h2>Parametros NETSMS (database)</h2>');
		dbms_output.put_line('				<small><i>Atualizado em '||htf.escape_sc(to_char(sysdate,'yyyy-mm-dd hh24:mi'))||'.</i></small>');
		dbms_output.put_line('				</br>');
		dbms_output.put_line('				<!-- begin content -->');
		dbms_output.put_line('				<table class="table table-bordered table-sm table-striped" id="example">');
		dbms_output.put_line('					<thead class="thead-dark">');
		dbms_output.put_line('						<tr>');
		dbms_output.put_line('							<th >Ambiente</th>');
		dbms_output.put_line('							<th >Parametro</th>');
		dbms_output.put_line('							<th >Tipo</th>');
		FOR i_cenario IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
			dbms_output.put_line('							<th >'||v_cod_cenarios(i_cenario)||'</th>');
		END LOOP;
		dbms_output.put_line('						</tr>');
		dbms_output.put_line('					</thead>');
		dbms_output.put_line('					<tbody id="myTable" >');
		FOR i_ambiente IN v_cod_ambientes.FIRST .. v_cod_ambientes.LAST LOOP
			declare
			ambiente rec_ambiente := ambientes(v_cod_ambientes(i_ambiente));
			begin
			FOR i_parametro IN v_regra_parametros.FIRST .. v_regra_parametros.LAST LOOP
				declare
				parametro rec_parametro;
				tipo rec_tipo ;
				begin
					IF ambiente.parametros.EXISTS(v_regra_parametros(i_parametro).nome_parametro) THEN parametro := ambiente.parametros(v_regra_parametros(i_parametro).nome_parametro); END IF;
					IF parametro.tipos.EXISTS(v_regra_parametros(i_parametro).tp_parametro) THEN TIPO := parametro.tipos(v_regra_parametros(i_parametro).tp_parametro); END IF;
					dbms_output.put_line('						<tr class="AMB_'||v_cod_ambientes(i_ambiente)||'">');
					dbms_output.put_line('							<th >'|| v_cod_ambientes(i_ambiente) ||'</th>');

					dbms_output.put('							<th ');
					dbms_output.put('title="');
					if tipo.fc_compara_ambiente is not null then dbms_output.put('Compara Ambiente: ' || tipo.fc_compara_ambiente || ' ' || chr(38)||'#13;'); end if;
					if tipo.fc_compara_cenario is not null then dbms_output.put('Compara Cenario: ' || tipo.fc_compara_cenario || ' ' || chr(38)||'#13;'); end if;
					dbms_output.put('" ');
					dbms_output.put('>'||v_regra_parametros(i_parametro).nome_parametro);
					
					dbms_output.put_line('</th>');
					dbms_output.put('							<th ');
					dbms_output.put('title="');
					if tipo.fc_compara_ambiente is not null then dbms_output.put('Compara Ambiente: ' || tipo.fc_compara_ambiente || ' ' || chr(38)||'#13;'); end if;
					if tipo.fc_compara_cenario is not null then dbms_output.put('Compara Cenario: ' || tipo.fc_compara_cenario || ' ' || chr(38)||'#13;'); end if;
					dbms_output.put('" ');

					dbms_output.put('>'||v_regra_parametros(i_parametro).tp_parametro ||'</th>');
					dbms_output.put_line('');
					FOR i_cenario IN v_cod_cenarios.FIRST .. v_cod_cenarios.LAST LOOP
						declare
						cenario rec_cenario;
						begin
							IF tipo.cenarios.EXISTS(v_cod_cenarios(i_cenario)) THEN CENARIO := tipo.cenarios(v_cod_cenarios(i_cenario)); END IF;
							dbms_output.put('							<td ');
							dbms_output.put('class="ellipsis '||cenario.css||'" ');
							dbms_output.put('title="');
							dbms_output.put('Ambiente: '|| v_cod_ambientes(i_ambiente) || chr(38)||'#13;');
							dbms_output.put('Cenario: '|| v_cod_cenarios(i_cenario) || chr(38)||'#13;');
							dbms_output.put('Parametro: '|| v_regra_parametros(i_parametro).nome_parametro || ' ('||v_regra_parametros(i_parametro).tp_parametro||')' || chr(38)||'#13;');
							dbms_output.put(replace(cenario.messages,chr(13), chr(38)||'#13;') || chr(38)||'#13;');
							dbms_output.put('" ');
							dbms_output.put('>');
							dbms_output.put(cenario.vlr_parametro);
							dbms_output.put('</td>');
						end;
						dbms_output.put_line('');
					END LOOP;
					dbms_output.put_line('						</tr>');
				end;
			END LOOP;
			end;
		END LOOP;
		dbms_output.put_line('					</tbody>');
		dbms_output.put_line('				</table>');
		dbms_output.put_line('				<!-- end content -->');
		dbms_output.put_line('			</div>');
		dbms_output.put_line('		</main>');
		dbms_output.put_line('	</body>');
		dbms_output.put_line('</html>');
	end;
end ;
/

spool off;
exit;