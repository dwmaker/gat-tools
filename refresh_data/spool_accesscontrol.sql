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
	
begin
	dbms_output.put_line('[');
	declare rnum integer := 0;
	begin
	for x in 
	(
		SELECT 
		trg.OWNER, 
		trg.TRIGGER_NAME, 
		case obj.STATUS when 'VALID' then 1 else 0 end as VALID, 
		case trg.STATUS when 'ENABLED' then 1 else 0 end as ENABLED
		FROM 
		DBA_TRIGGERS trg
		join DBA_OBJECTS obj on trg.OWNER = obj.OWNER and trg.TRIGGER_NAME = obj.OBJECT_NAME
		WHERE 
		trg.TRIGGER_NAME IN ('TR_MONITORA','TR_AUD_MONITORA', 'TR_LOGON') 
		and obj.object_type='TRIGGER'
		ORDER BY trg.TRIGGER_NAME
	) loop
		rnum := rnum + 1;
		dbms_output.put(case when rnum > 1 then ',' end);
		dbms_output.put_line('{');
		dbms_output.put_line('"owner": '||to_json(x.owner)||', ');
		dbms_output.put_line('"name": '||to_json(x.TRIGGER_NAME)||',');
		dbms_output.put_line('"valid": '|| case x.valid when 1 then 'true' when 0 then 'false' end ||',');
		dbms_output.put_line('"enabled": '|| case x.enabled when 1 then 'true' when 0 then 'false' end ||',');
		dbms_output.put_line('"type": '|| to_json(case x.TRIGGER_NAME when 'TR_LOGON' then 'logon' when 'TR_MONITORA' then 'monitora' when 'TR_AUD_MONITORA' then 'monitora' end ||''));
		dbms_output.put_line('}');
	end loop;
	end;
	dbms_output.put_line(']');
end;
/
exit;