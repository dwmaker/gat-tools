whenever sqlerror exit failure;
whenever oserror exit failure;
SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
set termout off;
spool "&1.";
declare

	type rec_trigger is record 
	(
	owner        VARCHAR2(30),
	trigger_name        VARCHAR2(30),
	valid          number,
	enabled    number
	);
	
	TYPE tbl_trigger IS TABLE of rec_trigger INDEX BY pls_integer;
	
	TYPE rec_environment IS RECORD (
	cd_conexao   user_db_links.db_link%type,
	cd_ambiente  varchar2(10),
	cd_sistema   varchar2(10),
	cd_cenario   varchar2(10),
	username     user_db_links.username%type,
	ds_conexao   user_db_links.host%type,
	login_triggers tbl_trigger,
	monitora_triggers tbl_trigger,
	sqlerrm		 varchar2(300)
	);
	

	TYPE tbl_environment IS TABLE of rec_environment INDEX BY pls_integer;
	lst_environment tbl_environment ;
	
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
			--and rownum < 10
			--and cd_conexao in ('GA_SIT7_NETSMS_SUL.NET', 'GA_SIT7_NETSMS_ABC.NET')
		) loop
			declare obj_environment rec_environment;
			begin
				obj_environment.cd_conexao := cnx.cd_conexao;
				obj_environment.cd_ambiente := cnx.cd_ambiente;
				obj_environment.cd_sistema := cnx.cd_sistema;
				obj_environment.cd_cenario := cnx.cd_cenario;
				obj_environment.username := cnx.username;
				obj_environment.ds_conexao := cnx.ds_conexao;
				declare mycur sys_refcursor;
				begin
					open mycur for '
					SELECT 
					trg.OWNER, 
					trg.trigger_name, 
					case obj.STATUS when ''VALID'' then 1 else 0 end as valid, 
					case trg.STATUS when ''ENABLED'' then 1 else 0 end as enabled
					FROM 
					ALL_TRIGGERS@' || cnx.cd_conexao || ' trg
					join ALL_OBJECTS@' || cnx.cd_conexao || ' obj on trg.OWNER = obj.OWNER and trg.TRIGGER_NAME = obj.OBJECT_NAME
					WHERE 
					trg.TRIGGER_NAME IN (''TR_MONITORA'',''TR_AUD_MONITORA'', ''TR_LOGON'') 
					and obj.object_type=''TRIGGER''
					ORDER BY trg.TRIGGER_NAME
					';
					LOOP
						declare 
						obj_trigger rec_trigger;
						begin
							FETCH mycur INTO obj_trigger.OWNER, obj_trigger.trigger_name, obj_trigger.valid, obj_trigger.enabled;
							EXIT WHEN mycur%NOTFOUND;
							if obj_trigger.trigger_name in ('TR_LOGON') then
								obj_environment.login_triggers(obj_environment.login_triggers.count) := obj_trigger;
							elsif obj_trigger.trigger_name in('TR_MONITORA', 'TR_AUD_MONITORA') then
								obj_environment.monitora_triggers(obj_environment.monitora_triggers.count) := obj_trigger;
							end if;
						end;
					END LOOP;
					close mycur;
				exception when others then
					obj_environment.sqlerrm := substr(sqlerrm,1,199);
				end;
				lst_environment(lst_environment.count) := obj_environment;
			end;
		end loop;
	end;
	
	--- RENDERIZAÇÃO ----
	declare
		function to_json(valor varchar2) return varchar2
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
		function to_json(valor numeric) return varchar2
		is
		begin
		if valor is null then return 'null'; end if;
		return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
		end;
		function to_json(valor date) return varchar2
		is
		begin
		if valor is null then return 'null'; end if;
		return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
		end;
		
		function to_json(v rec_trigger) return varchar2
		is
		begin
		return 
		'{' ||
		'"owner": '            || to_json(v.OWNER)        || ', ' || 
		'"trigger_name": '     || to_json(v.trigger_name) || ', ' || 
		'"valid": '            || case (v.valid)   when 1 then 'true' else 'false' end || ', ' || 
		'"enabled": '          || case (v.enabled) when 1 then 'true' else 'false' end || ' ' || 	
		'}';
		end;
		
		
		function to_json(v tbl_trigger) return varchar2
		is
		saida varchar2(4000)  := '';
		begin
			saida := saida || '[';
			if v.count > 0  then 
				FOR i IN v.FIRST .. v.LAST LOOP
					saida := saida || case when i = v.first then '' else ',' end || to_json(v(i)) ;
				END LOOP;
			end if;
			saida := saida || ']';
			return saida;
		end;
		
		function to_json(v rec_environment) return varchar2
		is
		begin
		return 
		'{' ||
		'"cd_conexao": '        || to_json(v.cd_conexao)        || ', ' || 
		'"cd_ambiente": '       || to_json(v.cd_ambiente)       || ', ' || 
		'"cd_sistema": '        || to_json(v.cd_sistema)        || ', ' || 
		'"cd_cenario": '        || to_json(v.cd_cenario)        || ', ' || 
		'"username": '          || to_json(v.username)          || ', ' || 
		'"ds_conexao": '        || to_json(v.ds_conexao)        || ', ' || 
		'"login_triggers": '    || to_json(v.login_triggers)    || ', ' || 
		'"monitora_triggers": ' || to_json(v.monitora_triggers) || ', ' || 
		'"sqlerrm": '           || to_json(v.sqlerrm)           ||
		'}';
		end;
		
	begin
		dbms_output.put_line('"use strict";');
		dbms_output.put_line('/// Atenção: Este arquivo é gerado dinamicamente pelos refresh_jobs');
		dbms_output.put_line('angular.module("myApp").service("controle-acesso-service", ');
		dbms_output.put_line('["$http", ');
		dbms_output.put_line('function($http)');
		dbms_output.put_line('{');
		dbms_output.put_line('	this.getMetadata = async function()');
		dbms_output.put_line('	{');
		dbms_output.put_line('		return { "refreshDate": ' || to_json(sysdate) || '};');
		dbms_output.put_line('	}');
		dbms_output.put_line('	this.getAccessControls = async function()');
		dbms_output.put_line('	{');
		dbms_output.put_line('		var list = [];');
		if lst_environment.count>0 then
			FOR i_environment IN lst_environment.FIRST .. lst_environment.LAST LOOP
				dbms_output.put_line('		list.push(' || to_json(lst_environment(i_environment)) ||');');
			END LOOP;
		end if;
		dbms_output.put_line('		return list; ');
		dbms_output.put_line('	}');
		
		dbms_output.put_line('}]);');
	end;
end;
/
spool off;
exit;
