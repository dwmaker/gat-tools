whenever sqlerror exit failure;
whenever oserror exit failure;
SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
set termout off;
spool "&1";
declare
	TYPE rec_asm_disk IS RECORD (
	host_name        VARCHAR2(64),
	dg_number        NUMBER,
	dg_name          VARCHAR2(30),
	instance_name    VARCHAR2(64),
	db_name          VARCHAR2(8),
	software_version VARCHAR2(60),
	disk_name        VARCHAR2(30),
	disk_path 		 VARCHAR2(256),
	cd_conexao   user_db_links.db_link%type,
	cd_ambiente  varchar2(10),
	cd_sistema   varchar2(10),
	cd_cenario   varchar2(10),
	username     user_db_links.username%type,
	ds_conexao   user_db_links.host%type
	);
	TYPE rec_error IS RECORD (
	cd_conexao   user_db_links.db_link%type,
	cd_ambiente  varchar2(10),
	cd_sistema   varchar2(10),
	cd_cenario   varchar2(10),
	username     user_db_links.username%type,
	ds_conexao   user_db_links.host%type,
	sqlerrm		 varchar2(300)
	);
	TYPE tbl_error IS TABLE of rec_error INDEX BY pls_integer;
	TYPE tbl_asm_disk IS TABLE of rec_asm_disk INDEX BY pls_integer;
	lst_asm_disk tbl_asm_disk ;
	lst_error tbl_error ;
	function new_rec_error(
		cd_conexao   user_db_links.db_link%type,
		cd_ambiente  varchar2,
		cd_sistema   varchar2,
		cd_cenario   varchar2,
		username     user_db_links.username%type,
		ds_conexao   user_db_links.host%type,
		sqlerrm		 varchar2
	) return rec_error
	is
	obj_error rec_error;
	begin
		obj_error.cd_conexao   := cd_conexao   ;
	    obj_error.cd_ambiente  := cd_ambiente  ;
	    obj_error.cd_sistema   := cd_sistema   ;
	    obj_error.cd_cenario   := cd_cenario   ;
	    obj_error.username     := username     ;
	    obj_error.ds_conexao   := ds_conexao   ;

	    obj_error.sqlerrm	   := null;--substr(sqlerrm, 1,100)	   ;
		return obj_error;
	end;
	function new_rec_asm_disk(
		host_name        VARCHAR2,
		dg_number        NUMBER,
		dg_name          VARCHAR2,
		instance_name    VARCHAR2,
		db_name          VARCHAR2,
		software_version VARCHAR2,
		disk_name        VARCHAR2,
		disk_path 		 VARCHAR2
	) return rec_asm_disk
	is
	obj_asm_disk rec_asm_disk;
	begin
		obj_asm_disk.host_name        := host_name        ;
	    obj_asm_disk.dg_number        := dg_number        ;
	    obj_asm_disk.dg_name          := dg_name          ;
	    obj_asm_disk.instance_name    := instance_name    ;
	    obj_asm_disk.db_name          := db_name          ;
	    obj_asm_disk.software_version := software_version ;
	    obj_asm_disk.disk_name        := disk_name        ;
	    obj_asm_disk.disk_path 		 := disk_path 		 ;
		return obj_asm_disk;
	end;
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
	'"dg_number": '        || to_json(v.dg_number)        || ', ' || 
	'"dg_name": '          || to_json(v.dg_name)          || ', ' || 
	'"instance_name": '    || to_json(v.instance_name)    || ', ' || 
	'"db_name": '          || to_json(v.db_name)          || ', ' || 
	'"software_version": ' || to_json(v.software_version) || ', ' || 
	'"disk_name": '        || to_json(v.disk_name)        || ', ' || 
	'"disk_path": '        || to_json(v.disk_path)	      || ', ' || 
	'"cd_conexao": '       || to_json(v.cd_conexao)       || ', ' || 
	'"cd_ambiente": '      || to_json(v.cd_ambiente)      || ', ' || 
	'"cd_sistema": '       || to_json(v.cd_sistema)       || ', ' || 
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
	'"cd_sistema": '       || to_json(v.cd_sistema)       || ', ' || 
	'"cd_cenario": '       || to_json(v.cd_cenario)       || ', ' || 
	'"username": '         || to_json(v.username)         || ', ' || 
	'"ds_conexao": '       || to_json(v.ds_conexao)       || ', ' || 
	'"sqlerrm": '          || to_json(v.sqlerrm)          ||
	'}';
	end;
begin
	begin
		for cnx in
		(
			select * from
			(
				SELECT
				dbl.db_link cd_conexao,
				substr(dbl.db_link, instr(dbl.db_link, '_')+1, instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-instr(dbl.db_link, '_')-1) cd_ambiente,
				case when instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) > 0 then substr( dbl.db_link , instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1 , instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1)
				else substr(dbl.db_link,instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1, instr(dbl.db_link, '.NET', instr(dbl.db_link, '_' )) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1) end AS cd_sistema,
				substr( dbl.db_link ,instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)+1 , instr(dbl.db_link, '.NET', instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)) - instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)-1) AS cd_cenario,
				dbl.username,
				HOST ds_conexao
				FROM   user_db_links dbl
				where dbl.db_link like 'GA^_%.NET' escape '^'
			) where cd_ambiente != 'PROD'
			--and cd_conexao in ('GA_SIT7_NETSMS_SUL.NET', 'GA_SIT7_NETSMS_ABC.NET')
		) loop
			declare
			mycur sys_refcursor;
			begin
				open mycur for '
				select distinct
				(select host_name from v$instance@' || cnx.cd_conexao || ') host_name,
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
						FETCH mycur INTO obj.host_name, obj.dg_number, obj.dg_name, obj.instance_name, obj.db_name, obj.software_version, obj.disk_name, obj.disk_path;
						EXIT WHEN mycur%NOTFOUND;
						obj.cd_conexao := cnx.cd_conexao;
						obj.cd_ambiente := cnx.cd_ambiente;
						obj.cd_sistema := cnx.cd_sistema;
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
					obj.cd_sistema := cnx.cd_sistema;
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
spool off;
exit;
