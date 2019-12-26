declare
	type tab_cd_conexao       is table of vw_conexao.cd_conexao   %type;
	type tab_cd_ambiente      is table of vw_conexao.cd_ambiente  %type;
	type tab_cd_aplicacao     is table of vw_conexao.cd_aplicacao %type;
	type tab_cd_cenario       is table of vw_conexao.cd_cenario   %type;
	type tab_username         is table of vw_conexao.username     %type;
	type tab_ds_conexao       is table of vw_conexao.ds_conexao   %type;
	lst_cd_conexao         tab_cd_conexao   ;
	lst_cd_ambiente        tab_cd_ambiente  ;
	lst_cd_aplicacao       tab_cd_aplicacao ;
	lst_cd_cenario         tab_cd_cenario   ;
	lst_username           tab_username     ;
	lst_ds_conexao         tab_ds_conexao   ;
begin
	select 
	cd_conexao,
	cd_ambiente,
	cd_aplicacao,
	cd_cenario,
	username,
	ds_conexao 
	bulk collect into 
	lst_cd_conexao,
	lst_cd_ambiente,
	lst_cd_aplicacao,
	lst_cd_cenario,
	lst_username,
	lst_ds_conexao 
	from vw_conexao 
	where cd_ambiente not in ('PROD')
	order by 
	cd_ambiente, 
	cd_aplicacao, 
	cd_cenario;
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
	begin
	dbms_output.put_line('{');
	dbms_output.put_line('	"refreshDate": '||to_json(sysdate)||'');
	if lst_cd_conexao.count>0 then
		dbms_output.put_line('	,"records": [');
		for i in lst_cd_conexao.first .. lst_cd_conexao.last loop
			dbms_output.put(
			'		{'||
			'"cd_conexao": '   || to_json(lst_cd_conexao(i))  || ', ' ||
			'"cd_ambiente": '  || to_json(lst_cd_ambiente(i)) || ', ' ||
			'"cd_aplicacao": ' || to_json(lst_cd_aplicacao(i))|| ', ' ||
			'"cd_cenario": '   || to_json(lst_cd_cenario(i))  || ', ' ||
			'"username": '     || to_json(lst_username(i))    || ', ' ||
			'"ds_conexao": '   || to_json(lst_ds_conexao(i))  || ''   ||
			'}');
			dbms_output.put_line(case when i = lst_cd_conexao.last then '' else ',' end);
		end loop;
		dbms_output.put_line('	]');
	end if;
	dbms_output.put_line('}');
	end;
end;
/