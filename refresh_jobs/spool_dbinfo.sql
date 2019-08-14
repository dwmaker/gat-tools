
set serveroutput on;
set trimspool on;
set linesize 500;
set feedback off;
set verify off;
spool "&1.";

declare
	c_space varchar2(30) := chr(38)||'nbsp;' || chr(38)||'nbsp;' || chr(38)||'nbsp;' || chr(38)||'nbsp;';
	
	function fn_format_size(valor number) return varchar2 is
	begin
		if valor is null then return '-'; end if;
		if valor > power(1024,4) then return to_char(valor/power(1024,4),'FM999,999,990.00') || ' TB'; end if;
		if valor > power(1024,3) then return to_char(valor/power(1024,3),'FM999,999,990.00') || ' GB'; end if;
		if valor > power(1024,2) then return to_char(valor/power(1024,2),'FM999,999,990.00') || ' MB'; end if;
		if valor > power(1024,1) then return to_char(valor/power(1024,1),'FM999,999,990.00') || ' KB'; end if;
		return to_char(valor,'FM999,999,990.00') || ' Bytes';
	end;
	
	function fn_format_pct(valor number) return varchar2 is
	begin
		if valor is null then return '-'; end if;
		return to_char(valor *100,'FM990.00') || '%';
	end;
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
dbms_output.put_line('		<script src="lib/alasql.min.js"></script>');
dbms_output.put_line('		<script src="lib/xlsx.full.min.js"></script>');
dbms_output.put_line('		<script src="lib/angular-base64/angular-base64.min.js"></script>');
dbms_output.put_line('		<script src="uib/dist/ui-bootstrap-tpls.js"></script>');
dbms_output.put_line('		<script src="uib/dist/ui-bootstrap.js"></script>');
dbms_output.put_line('		<script src="app.module.js"></script>');
dbms_output.put_line('		<script src="scripts/menu-controller.js"></script>');
dbms_output.put_line('		<script src="components/authentication/authentication-service.js"></script>');
dbms_output.put_line('		<script src="components/menu/menu-directive.js"></script>');
dbms_output.put_line('	</head>');
dbms_output.put_line('	<body ng-app="myApp">');
dbms_output.put_line('		<menu></menu>');
dbms_output.put_line('		<main role="main"  style="margin-left: 30px;margin-right: 30px; margin-top: 60px; ">');
dbms_output.put_line('			<div>');
dbms_output.put_line('				<h2>&2.</h2>');
dbms_output.put_line('				<p>Atualizado em '||to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')||'</p>');
dbms_output.put_line('				<h4>PARAMETERS</h4>');
dbms_output.put_line('				<Blockquote>');
for x in (
select name, display_value  from v$parameter
where name in ('sga_max_size', 'shared_pool_size', 'java_pool_size', 'sga_target', 'pga_aggregate_target')
) loop
	dbms_output.put_line('						<b>'||x.name||':</b> <span>'||x.display_value||'</span> <br>');
end loop;
dbms_output.put_line('				</Blockquote>');

dbms_output.put_line('				<table class="table table-bordered table-sm">');
dbms_output.put_line('					<thead  class="thead-dark">');
dbms_output.put_line('						<tr>');
dbms_output.put_line('							<th >Tablespace Name</th>');
dbms_output.put_line('							<th >Total</th>');
dbms_output.put_line('							<th >Utilizado</th>');
dbms_output.put_line('							<th >% Utilizado</th>');
dbms_output.put_line('						</tr>');
dbms_output.put_line('					</thead>');
dbms_output.put_line('						<tr>');
dbms_output.put_line('							<th colspan=4 >PERMANENT</th>');
dbms_output.put_line('						</tr>');
for x in (
 select 
tbs.tablespace_name,
(
    select 
    sum(bytes)
    from dba_data_files df
    where df.tablespace_name = tbs.tablespace_name
) total_space_bytes,
(
    select 
    sum(bytes)
    from dba_segments tu
    where tu.tablespace_name = tbs.tablespace_name
) used_space_bytes
from 
SYS.DBA_TABLESPACES tbs
where 
(
    tbs.contents = 'PERMANENT'
    and tbs.tablespace_name
    in
    (
    select usr.default_tablespace from sys.dba_users usr where usr.username in ('PROD_JD', 'GED', 'NETSALES') and  usr.default_tablespace is not null
    union 
    select usr.tablespace_name from sys.dba_tables usr where usr.owner in ('PROD_JD', 'GED', 'NETSALES') and usr.tablespace_name is not null
    union 
    select usr.tablespace_name  from sys.dba_indexes usr where usr.owner in ('PROD_JD', 'GED', 'NETSALES') and  usr.tablespace_name is not null
    )
)
) loop
    dbms_output.put_line('					<tr>');
	dbms_output.put_line('						<td>'||c_space||''||x.tablespace_name||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.total_space_bytes)||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.used_space_bytes)||'</td>');
	dbms_output.put_line('						<td>');
	dbms_output.put_line('							<div class="progress">');
	dbms_output.put_line('								<div class="progress-bar progress-bar-striped" role="progressbar" style="width: '||fn_format_pct(x.used_space_bytes/x.total_space_bytes)||'" aria-valuenow="'||trunc(x.used_space_bytes/x.total_space_bytes)||'" aria-valuemin="0" aria-valuemax="100">'||fn_format_pct(x.used_space_bytes/x.total_space_bytes)||'</div>');
	dbms_output.put_line('							</div>');
	dbms_output.put_line('						</td>');
	dbms_output.put_line('					</tr>');
end loop;



-- UNDO
dbms_output.put_line('						<tr>');
dbms_output.put_line('							<th colspan=4 >UNDO</th>');
dbms_output.put_line('						</tr>');
for x in (
 select 
tbs.tablespace_name,
(
    select 
    sum(bytes)
    from dba_data_files df
    where df.tablespace_name = tbs.tablespace_name
) total_space_bytes,
(
    select 
    sum(bytes)
    from dba_segments tu
    where tu.tablespace_name = tbs.tablespace_name
) used_space_bytes
from 
SYS.DBA_TABLESPACES tbs
where 
(
    tbs.contents = 'UNDO'
    and tablespace_name in (select value from v$parameter where name in ('undo_tablespace'))
)
) loop
    dbms_output.put_line('					<tr>');
	dbms_output.put_line('						<td>'||c_space||''||x.tablespace_name||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.total_space_bytes)||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.used_space_bytes)||'</td>');
	dbms_output.put_line('						<td>');
	dbms_output.put_line('							<div class="progress">');
	dbms_output.put_line('								<div class="progress-bar progress-bar-striped" role="progressbar" style="width: '||fn_format_pct(x.used_space_bytes/x.total_space_bytes)||'" aria-valuenow="'||trunc(x.used_space_bytes/x.total_space_bytes)||'" aria-valuemin="0" aria-valuemax="100">'||fn_format_pct(x.used_space_bytes/x.total_space_bytes)||'</div>');
	dbms_output.put_line('							</div>');
	dbms_output.put_line('						</td>');
	dbms_output.put_line('					</tr>');
end loop;

-- TEMPORARY
dbms_output.put_line('						<tr>');
dbms_output.put_line('							<th colspan=4 >TEMPORARY</th>');
dbms_output.put_line('						</tr>');
for x in (
select 
tbs.tablespace_name,
(
    select 
    sum(bytes)
    from DBA_TEMP_FILEs df
    where df.tablespace_name = tbs.tablespace_name
) total_space_bytes,
(
    select 
    sum(bytes)
    from dba_segments tu
    where tu.tablespace_name = tbs.tablespace_name
) used_space_bytes
from 
SYS.DBA_TABLESPACES tbs
where 
(
    tbs.contents = 'TEMPORARY'
    and tbs.tablespace_name in ( select usr.temporary_tablespace from sys.dba_users usr where usr.username in ('PROD_JD', 'GED', 'NETSALES') and  usr.default_tablespace is not null )
)
) loop
    dbms_output.put_line('					<tr>');
	dbms_output.put_line('						<td>'||c_space||''||x.tablespace_name||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.total_space_bytes)||'</td>');
	dbms_output.put_line('						<td>'||fn_format_size(x.used_space_bytes)||'</td>');
	dbms_output.put_line('						<td>');
	dbms_output.put_line('							<div class="progress">');
	dbms_output.put_line('								<div class="progress-bar progress-bar-striped" role="progressbar" style="width: '||fn_format_pct(nvl(x.used_space_bytes,0)/x.total_space_bytes)||'" aria-valuenow="'||trunc(nvl(x.used_space_bytes,0)/x.total_space_bytes)||'" aria-valuemin="0" aria-valuemax="100">'||fn_format_pct(x.used_space_bytes/x.total_space_bytes)||'</div>');
	dbms_output.put_line('							</div>');
	dbms_output.put_line('						</td>');
	dbms_output.put_line('					</tr>');
end loop;
dbms_output.put_line('				</table>');
dbms_output.put_line('			</div>');
dbms_output.put_line('		</main>');
dbms_output.put_line('	</body>');
dbms_output.put_line('</html>');

end;
/
exit;

    
   