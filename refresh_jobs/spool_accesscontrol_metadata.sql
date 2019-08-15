SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
WHENEVER SQLERROR EXIT FAILURE;
WHENEVER OSERROR EXIT FAILURE;
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
	
	function to_json(valor date) return varchar2
	is
	begin
	return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
	end;
	
	
	
	
begin
	dbms_output.put_line('{');
	dbms_output.put_line('"refreshDate": '||to_json(sysdate)||' ');
	dbms_output.put_line('}');
end;
/
exit;