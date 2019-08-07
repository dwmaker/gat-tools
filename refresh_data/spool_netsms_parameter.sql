SET SERVEROUTPUT ON FORMAT TRUNCATED;
set trimspool on;
set linesize 10000;
SET feedback off;
set tab off;
WHENEVER SQLERROR EXIT FAILURE;
WHENEVER OSERROR EXIT FAILURE;
declare 
	function to_json(valor varchar2) return varchar2
	is
	begin
		if valor is null then return 'null'; end if;
		return '"' || 
		replace(
		replace(
		replace(
		replace(
		replace(
		replace(
		replace(
		replace(
		replace(
		valor
		,chr(92), chr(92) || chr(92))
		,chr(34), chr(92) || chr(34))
		,chr(13), chr(92) || 'r')
		,chr(12), chr(92) || 'f')
		,chr(11), chr(92) || 't')
		,chr(10), chr(92) || 'n')
		,chr(09), chr(92) || 't')
		,chr(08), chr(92) || 'b')
		,'	'   , chr(92) || 't')
		|| '"';
	end;
	
	function to_json(valor number) return varchar2
	is
	begin
	if valor is null then return 'null'; end if;
	return '' || to_char(valor, 'FM9999999999999990D0099999999999999999', 'NLS_NUMERIC_CHARACTERS=''. ''') || '';
	end;
begin
	dbms_output.put_line('[');
	declare rnum integer := 0;
	begin
	for x in 
	(
		select * from
		(
		select 
		nome_parametro, 
		max(vlr_parametro_str) vlr_parametro_str, 
		max(vlr_parametro) vlr_parametro_num,
		count(distinct nvl(vlr_parametro_str,'-nulo-')) qt_vlr_parametro_str, 
		count(distinct nvl(vlr_parametro,'-999')) qt_vlr_parametro_num
		from prod_jd.sn_parametro
		group by nome_parametro
		order by nome_parametro
		)
		where not REGEXP_LIKE(nome_parametro, '^[[:digit:]]+$')
		and nome_parametro not in ('GRUPO_NUMERACAO_NF','OPER_DTCTR','JDE_CODIGO_EMPRESA',
		'SERIE_NOTAFISCAL','SAP_ESTAB_TELECOM','CID_ENDERECO_OPER', 'FQDN_TELEFONE_VOIP', 
		'CONSISTE_FISCAL', 'EXTRACAO_ACTIVIA','SAP_ESTAB_SERVICO','COMODATO_JDE', 'ORDEM_GERACAO', 
		'ORDEM_FECHAMENTO','JDE_SEQUENCE_ARQUIVO')
	) loop
		rnum := rnum + 1;
		dbms_output.put(case when rnum > 1 then ',' end);
		dbms_output.put('{');
		dbms_output.put('"code": '||to_json(x.nome_parametro)||', ');
		dbms_output.put('"textValue": '||to_json(x.vlr_parametro_str)||', ');
		dbms_output.put('"numericValue": '||to_json(x.vlr_parametro_num)||', ');
		dbms_output.put('"numDistinctText": '||to_json(x.qt_vlr_parametro_str)||', ');
		dbms_output.put('"numDistinctNumeric": '|| to_json(x.qt_vlr_parametro_num) ||'');
		dbms_output.put_line('}');
	end loop;
	end;
	dbms_output.put_line(']');
end;
/
exit;
