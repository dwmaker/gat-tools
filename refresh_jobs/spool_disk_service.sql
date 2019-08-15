whenever sqlerror exit failure;
whenever oserror exit failure;


SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
set termout off;



spool "&1" append;
declare

	function to_json(valor varchar2) return varchar2
	is
	begin
	return '"' || valor || '"';
	end;
	
	function to_json(valor numeric) return varchar2
	is
	begin
	return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
	end;
begin
for x in 
(
select distinct
(select host_name from v$instance) host_name,
dg.group_number dg_number,
dg.name dg_name,
dg.instance_name instance_name,
dg.db_name db_name,
dg.SOFTWARE_VERSION software_version,
dsk.NAME disk_name,
dsk.PATH disk_path
from
v$asm_disk dsk 
join 
(
    select 
    dg.group_number, 
    cli.SOFTWARE_VERSION, 
    cli.db_name, 
    cli.instance_name, 
    dg.name 
    from  
    V$ASM_DISKGROUP dg 
    join V$ASM_CLIENT cli on dg.group_number = cli.group_number
) dg on dsk.group_number = dg.group_number
order by
host_name,
dg_number,
db_name,
disk_name
) loop
dbms_output.put('		disks.push({');
dbms_output.put('"host_name": '|| to_json(x.host_name)||',');
dbms_output.put('"dg_number": '|| to_json(x.dg_number)||',');
dbms_output.put('"dg_name": '|| to_json(x.dg_name)||',');
dbms_output.put('"instance_name": ' || to_json(x.instance_name)||',');
dbms_output.put('"db_name": ' || to_json(x.db_name)||',');
dbms_output.put('"software_version": ' || to_json(x.software_version)||',');
dbms_output.put('"disk_name": ' || to_json(x.disk_name)||',');
dbms_output.put('"disk_path": ' || to_json(x.disk_path)||'');
dbms_output.put('})');
dbms_output.put_line(';');
end loop;
exception
    when others then null;
end;
/
spool off;
exit;