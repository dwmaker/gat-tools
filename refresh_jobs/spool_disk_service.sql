declare
	TYPE rec_asm_disk IS RECORD (
	host_name        VARCHAR2(64),
	creation_date    DATE,
	dg_number        NUMBER,
	dg_name          VARCHAR2(30),
	instance_name    VARCHAR2(64),
	db_name          VARCHAR2(8),
	software_version VARCHAR2(60),
	disk_name        VARCHAR2(30),
	disk_path 		 VARCHAR2(256),
	cd_conexao   user_db_links.db_link%type,
	cd_ambiente  varchar2(10),
	cd_aplicacao   varchar2(10),
	cd_cenario   varchar2(10),
	username     user_db_links.username%type,
	ds_conexao   user_db_links.host%type
	);
	TYPE rec_error IS RECORD (
	cd_conexao   user_db_links.db_link%type,
	cd_ambiente  varchar2(10),
	cd_aplicacao   varchar2(10),
	cd_cenario   varchar2(10),
	username     user_db_links.username%type,
	ds_conexao   user_db_links.host%type,
	sqlerrm		 varchar2(300)
	);
	TYPE tbl_error IS TABLE of rec_error INDEX BY pls_integer;
	TYPE tbl_asm_disk IS TABLE of rec_asm_disk INDEX BY pls_integer;
	lst_asm_disk tbl_asm_disk ;
	lst_error tbl_error ;
	

begin
	begin
		for cnx in
		(
			select * from vw_conexao where cd_ambiente != 'PROD'
			--and cd_conexao in ('GA_SIT7_NETSMS_SUL.NET', 'GA_SIT7_NETSMS_ABC.NET', 'GA_CERT_NETSMS_BH.NET')
		) loop
			declare
			mycur sys_refcursor;
			begin
				open mycur for '
				select distinct
				(select host_name from v$instance@' || cnx.cd_conexao || ') host_name,
				(select created from v$database@' || cnx.cd_conexao || ') creation_date,
				dg.group_number dg_number,
				dg.name dg_name,
				dg.instance_name instance_name,
				dg.db_name db_name,
				dg.SOFTWARE_VERSION software_version,
				dsk.NAME disk_name,
				dsk.PATH disk_path
				from
				v$asm_disk@' || cnx.cd_conexao || ' dsk
				join
				(
					select
					dg.group_number,
					cli.SOFTWARE_VERSION,
					cli.db_name,
					cli.instance_name,
					dg.name
					from
					V$ASM_DISKGROUP@' || cnx.cd_conexao || ' dg
					join V$ASM_CLIENT@' || cnx.cd_conexao || ' cli on dg.group_number = cli.group_number
				) dg on dsk.group_number = dg.group_number
				order by
				host_name,
				dg_number,
				db_name,
				disk_name';
				LOOP
					declare obj rec_asm_disk;
					begin
						FETCH mycur INTO obj.host_name, obj.creation_date, obj.dg_number, obj.dg_name, obj.instance_name, obj.db_name, obj.software_version, obj.disk_name, obj.disk_path;
						EXIT WHEN mycur%NOTFOUND;
						obj.cd_conexao := cnx.cd_conexao;
						obj.cd_ambiente := cnx.cd_ambiente;
						obj.cd_aplicacao := cnx.cd_aplicacao;
						obj.cd_cenario := cnx.cd_cenario;
						obj.username := cnx.username;
						obj.ds_conexao := cnx.ds_conexao;
						lst_asm_disk(lst_asm_disk.count) := obj;
					end;
				END LOOP;
				close mycur;
			exception when others then
				declare obj rec_error;
				begin
					obj.cd_conexao := cnx.cd_conexao;
					obj.cd_ambiente := cnx.cd_ambiente;
					obj.cd_aplicacao := cnx.cd_aplicacao;
					obj.cd_cenario := cnx.cd_cenario;
					obj.username := cnx.username;
					obj.ds_conexao := cnx.ds_conexao;
					obj.sqlerrm := substr(sqlerrm,1,199);
					lst_error(lst_error.count) := obj;
				end;
			end;
		end loop;
	end;
	
	--- RENDERIZAÇÃO ----
	declare
	
	function to_json(valor varchar2) return varchar2
	is
	begin
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
	return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
	end;
	function to_json(valor date) return varchar2
	is
	begin
	return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
	end;
	function to_json(v rec_asm_disk) return varchar2
	is
	begin
	return 
	'{' ||
	'"host_name": '        || to_json(v.host_name)        || ', ' || 
	'"creation_date": '        || to_json(v.creation_date)        || ', ' || 
	'"dg_number": '        || to_json(v.dg_number)        || ', ' || 
	'"dg_name": '          || to_json(v.dg_name)          || ', ' || 
	'"instance_name": '    || to_json(v.instance_name)    || ', ' || 
	'"db_name": '          || to_json(v.db_name)          || ', ' || 
	'"software_version": ' || to_json(v.software_version) || ', ' || 
	'"disk_name": '        || to_json(v.disk_name)        || ', ' || 
	'"disk_path": '        || to_json(v.disk_path)				|| ', ' || 
	'"cd_conexao": '       || to_json(v.cd_conexao)       || ', ' || 
	'"cd_ambiente": '      || to_json(v.cd_ambiente)      || ', ' || 
	'"cd_aplicacao": '     || to_json(v.cd_aplicacao)       || ', ' || 
	'"cd_cenario": '       || to_json(v.cd_cenario)       || ', ' || 
	'"username": '         || to_json(v.username)         || ', ' || 
	'"ds_conexao": '       || to_json(v.ds_conexao)       ||
	'}';
	end;
	function to_json(v rec_error) return varchar2
	is
	begin
	return 
	'{' ||
	'"cd_conexao": '       || to_json(v.cd_conexao)       || ', ' || 
	'"cd_ambiente": '      || to_json(v.cd_ambiente)      || ', ' || 
	'"cd_aplicacao": '     || to_json(v.cd_aplicacao)       || ', ' || 
	'"cd_cenario": '       || to_json(v.cd_cenario)       || ', ' || 
	'"username": '         || to_json(v.username)         || ', ' || 
	'"ds_conexao": '       || to_json(v.ds_conexao)       || ', ' || 
	'"sqlerrm": '          || to_json(v.sqlerrm)          ||
	'}';
	end;
	begin
		dbms_output.put_line('"use strict";');
		dbms_output.put_line('/// Atenção: Este arquivo é gerado dinamicamente pelos refresh_jobs');
		dbms_output.put_line('angular.module("myApp").service("asm-disk-service", ');
		dbms_output.put_line('["$http", ');
		dbms_output.put_line('function($http)');
		dbms_output.put_line('{');
		dbms_output.put_line('	this.getMetadata = function()');
		dbms_output.put_line('	{');
		dbms_output.put_line('		return { "refreshDate": ' || to_json(sysdate) || '};');
		dbms_output.put_line('	}');
		dbms_output.put_line('	this.getAsmDisks = function()');
		dbms_output.put_line('	{');
		dbms_output.put_line('		var disks = [];');
		if lst_asm_disk.count>0 then
			FOR i_asm_disk IN lst_asm_disk.FIRST .. lst_asm_disk.LAST LOOP
				dbms_output.put_line('		disks.push(' || to_json(lst_asm_disk(i_asm_disk)) ||');');
			END LOOP;
		end if;
		if lst_error.count>0 then
			FOR i_error IN lst_error.FIRST .. lst_error.LAST LOOP
				dbms_output.put_line('		disks.push(' || to_json(lst_error(i_error)) ||');');
			END LOOP;
		end if;
		dbms_output.put_line('		return disks; ');
		dbms_output.put_line('	}');
		dbms_output.put_line('}]);');
	end;
end;
/