-- SET SERVEROUTPUT ON FORMAT TRUNCATED;
-- set trimspool on;
-- set linesize 10000;
-- SET feedback off;
-- WHENEVER SQLERROR EXIT FAILURE;
-- WHENEVER OSERROR EXIT FAILURE;
-- declare 
-- 	function to_json(valor varchar2) return varchar2
-- 	is
-- 	begin
-- 	return '"' || valor || '"';
-- 	end;
-- 	
-- 	function to_json(valor number) return varchar2
-- 	is
-- 	begin
-- 	return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
-- 	end;
-- begin
-- 	dbms_output.put_line('[');
-- 	declare rnum integer := 0;
-- 	begin
-- 	for x in 
-- 	(
-- 		select * from 
-- 		(
-- 			select 
-- 			versao,
-- 			dt_atualizacao,
-- 			id_executavel
-- 			from prod_jd.sn_versao 
-- 			where sistema = 'NET SMS'
-- 			order by versao desc
-- 		) 
-- 		where rownum < 10
-- 	) loop
-- 		rnum := rnum + 1;
-- 		dbms_output.put(case when rnum > 1 then ',' end);
-- 		dbms_output.put_line('{');
-- 		dbms_output.put_line('"version": '||to_json(x.versao)||', ');
-- 		dbms_output.put_line('"applyDate": '||'"' || to_char(x.dt_atualizacao,'yyyy-mm-dd') || 'T' ||to_char(x.dt_atualizacao,'hh24:mi:ss')||'.000Z' || '"'||',');
-- 		dbms_output.put_line('"executableId": '|| to_json(x.id_executavel) ||'');
-- 		dbms_output.put_line('}');
-- 	end loop;
-- 	end;
-- 	dbms_output.put_line(']');
-- end;
-- /
exit;
