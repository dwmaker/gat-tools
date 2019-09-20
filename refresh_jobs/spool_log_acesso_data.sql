declare
	type rec_linha is record(
	OSUSER core.core.OSUSER%type,
	USERNAME core.core.USERNAME%type,
	MACHINE core.core.MACHINE%type,
	APLICACAO varchar2(50),
	BASE core.core.BASE%type,
	QTD_ACESSOS core.core.QTD_ACESSOS%type,
	DT_FIM date,
	ULTIMO_ACESSO date,
	DT_INI date
	) ;
	type lst_linha is table of rec_linha index by binary_integer;
	type rec_report is record(
	refresh_date date,
	records lst_linha
	);
	obj_report rec_report;
begin
	begin
		obj_report.refresh_date := sysdate;
		for x in
		(
			select
			OSUSER,
			USERNAME,
			MACHINE,
			trim(APLICACAO) APLICACAO,
			BASE,
			QTD_ACESSOS,
			DT_FIM,
			ULTIMO_ACESSO,
			DT_INI
			from
			core.core
			where ULTIMO_ACESSO >= trunc(sysdate)-30
			order by ULTIMO_ACESSO nulls last
		) loop
			declare
			obj_linha rec_linha;
			begin
				obj_linha.OSUSER := x.OSUSER;
				obj_linha.USERNAME := x.USERNAME;
				obj_linha.MACHINE := x.MACHINE;
				obj_linha.APLICACAO := x.APLICACAO;
				obj_linha.BASE := x.BASE;
				obj_linha.QTD_ACESSOS := x.QTD_ACESSOS;
				obj_linha.DT_FIM := x.DT_FIM;
				obj_linha.ULTIMO_ACESSO := x.ULTIMO_ACESSO;
				obj_linha.DT_INI := x.DT_INI;
				obj_report.records(obj_report.records.count) := obj_linha;
			end;
		end loop;
	end;
	--- RENDERIZAÇÃO ----
	declare
		function to_json(valor varchar2) return clob
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
		function to_json(valor numeric) return clob
		is
		begin
		return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
		end;
		function to_json(valor date) return clob
		is
		begin
		return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
		end;
		function to_json(valor rec_linha) return clob
		is
		begin
		return '{'||
		'"osuser":' || 	to_json(valor.osuser )	|| ','||
		'"login":' || 	to_json(valor.username )	|| ','||
		'"maquina":' || 	to_json(valor.machine )	|| ','||
		'"aplicacao":' || 	to_json(valor.aplicacao )	|| ','||
		'"database":' || 	to_json(valor.base )	|| ','||
		'"qtdAcessos":' || 	to_json(valor.qtd_acessos )	|| ','||
		'"dtInicio":' || 	to_json(valor.dt_ini )	|| ','||
		'"dtFim":' || 	to_json(valor.dt_fim )	|| ','||
		'"ultimoAcesso":' || 	to_json(valor.ultimo_acesso )	|| ''||		
		'}';
		end;
	begin
		dbms_output.put_line('{');
		dbms_output.put_line('	"refreshDate": ' || 	to_json(obj_report.refresh_date)	|| ',');
		dbms_output.put_line('	"records": [');
		if obj_report.records.count > 0then
		for x in obj_report.records.first .. obj_report.records.last loop
			if x > obj_report.records.first then dbms_output.put_line(','); end if;
			dbms_output.put('		');
			dbms_output.put(to_json(obj_report.records(x)));
		end loop;
		end if;
		dbms_output.put_line('');
		dbms_output.put_line('	]');
		dbms_output.put_line('}');
	end;
end;
/