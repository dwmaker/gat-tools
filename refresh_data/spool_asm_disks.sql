declare
	rnum integer := 0;
	
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
	dbms_output.put_line('[');
	for x in (
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
		rnum := rnum+1;
		if rnum > 1 then dbms_output.put(','); end if;
		dbms_output.put('{');
		dbms_output.put('"hostName": '|| to_json(x.host_name)||',');
		dbms_output.put('"diskgroupNumber": '|| to_json(x.dg_number)||',');
		dbms_output.put('"diskgroupName": '|| to_json(x.dg_name)||',');
		dbms_output.put('"instanceName": ' || to_json(x.instance_name)||',');
		dbms_output.put('"databaseName": ' || to_json(x.db_name)||',');
		dbms_output.put('"softwareVersion": ' || to_json(x.software_version)||',');
		dbms_output.put('"name": ' || to_json(x.disk_name)||',');
		dbms_output.put('"path": ' || to_json(x.disk_path)||'');
		dbms_output.put('}');
		dbms_output.put_line('');
	end loop;
	dbms_output.put_line(']');
end;
/

