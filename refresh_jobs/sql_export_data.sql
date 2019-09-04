WHENEVER OSERROR EXIT FAILURE;
WHENEVER SQLERROR EXIT FAILURE;

set serveroutput on size unlimited;
SET ECHO OFF;
SET PAGES 999;
SET LONG 999999;
SET HEADING ON;
SET verify off;
SET feedback off;
set linesize 10000;
SET MARKUP HTML OFF;
set trimspool on;
SET TERMOUT OFF;

declare
P_src_owner all_tables.owner%type :='&1';
P_src_table_name all_tables.table_name%type := '&2';
v_tgt_owner all_tables.owner%type :='&3';
v_tgt_table_name all_tables.table_name%type := '&4';
v_sql_source_statement varchar2(4000);
v_source_cursor_id int;
begin
	BEGIN 
	IF v_tgt_table_name IS NULL THEN v_tgt_table_name := P_src_table_name; END IF;
	END;
	-- monta query
	begin	

	SELECT 
	'select ' || chr(10) || 
	(
	select 
	LISTAGG('src.' || all_tab_columns.column_name|| '', ', ') WITHIN GROUP (ORDER BY all_tab_columns.COLUMN_ID)
	from all_tab_columns
	where
	all_tab_columns.owner = ALL_TABLES.owner
	AND all_tab_columns.TABLE_NAME = ALL_TABLES.TABLE_NAME
	) || chr(10) || 
	'from ' || chr(10) || 
	ALL_TABLES.OWNER || '.' || ALL_TABLES.TABLE_NAME  || ' src ' || chr(10) || 
	'order by ' || chr(10) || 
	NVL((
	select 
	LISTAGG('src.' || all_cons_columns.column_name|| ' asc', ', ') WITHIN GROUP (ORDER BY all_cons_columns.position)
	from all_constraints
	join all_cons_columns on all_constraints.owner = all_cons_columns.owner and all_constraints.constraint_name = all_cons_columns.constraint_name
	where
	all_constraints.constraint_type='P'
	AND all_constraints.owner = ALL_TABLES.owner
	AND all_constraints.TABLE_NAME = ALL_TABLES.TABLE_NAME
	),'1') as sql_source_statement
	into v_sql_source_statement
	FROM 
	ALL_TABLES
	WHERE ALL_TABLES.owner = P_src_owner AND ALL_TABLES.TABLE_NAME = P_src_table_name;
	end;

	v_source_cursor_id := dbms_sql.open_cursor;

	-----------------------------dbms_output.put(v_sql_source_statement);


	declare
	v_source_cursor_id int;
	v_source_column_count int;
	v_source_describe dbms_sql.desc_tab;
	v_source_return int;
	v_num_records_source BINARY_INTEGER;
	type rec_column is RECORD
	(
	Varchar2_Table dbms_sql.Varchar2_Table,
	Number_Table	dbms_sql.Number_Table,
	Date_Table dbms_sql.Date_Table,
	Clob_Table	dbms_sql.Clob_Table,
	Blob_Table	dbms_sql.Blob_Table
	);

	type tab_column is table of rec_column INDEX BY BINARY_INTEGER;
	v_source_columns tab_column;
	begin
		v_source_cursor_id := dbms_sql.open_cursor;
		dbms_sql.parse(v_source_cursor_id,v_sql_source_statement,dbms_sql.native);
		dbms_sql.describe_columns(v_source_cursor_id,v_source_column_count,v_source_describe);

		if v_source_column_count is not null then
			for i_src_column in 1..v_source_column_count loop
				if v_source_describe(i_src_column).col_type = 001 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as varchar2) , v_source_describe(i_src_column).col_max_len);
				elsif v_source_describe(i_src_column).col_type = 096 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as CHAR) , v_source_describe(i_src_column).col_max_len);
				elsif v_source_describe(i_src_column).col_type = 002 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as number) );
				elsif v_source_describe(i_src_column).col_type = 012 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as date) );
				elsif v_source_describe(i_src_column).col_type = 112 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as clob) );
				elsif v_source_describe(i_src_column).col_type = 113 then
				dbms_sql.define_column(v_source_cursor_id, i_src_column, cast(null as blob) );
				else
				raise_application_error(-20123, 'Não foi possivel transferir a coluna '|| v_source_describe(i_src_column).col_name||'');
				end if;
			end loop;
		end if;


		begin
			dbms_output.put_line('set feedback off');
			dbms_output.put_line('set define off');
			dbms_output.put_line('begin ');
			dbms_output.put_line('delete ' || nullif(v_tgt_owner || '.','.') || v_tgt_table_name||'; ');
			v_source_return := dbms_sql.execute(v_source_cursor_id);
			v_num_records_source := 0;
			while (dbms_sql.fetch_rows(v_source_cursor_id)>0) loop
			dbms_output.put('insert into ');
			dbms_output.put(nullif(v_tgt_owner || '.','.') || v_tgt_table_name||' ');
			dbms_output.put('(');
			for i_src_column in 1..v_source_column_count loop
			dbms_output.put(v_source_describe(i_src_column).col_name || case i_src_column when v_source_column_count then '' else ', ' end);
			end loop;
			dbms_output.put(') values (');
			for i_src_column in 1..v_source_column_count loop
			if v_source_describe(i_src_column).col_type = 001 then
			declare 
			v_tgt_value varchar2(32767);
			begin
			dbms_sql.column_value(v_source_cursor_id, i_src_column, v_tgt_value);
			dbms_output.put(case when v_tgt_value is null then 'null' else ''''||replace(v_tgt_value,'''','''''')||'''' end);
			end;
			elsif v_source_describe(i_src_column).col_type = 096 then
			declare 
			v_tgt_value varchar2(32767);
			begin
			dbms_sql.column_value(v_source_cursor_id, i_src_column, v_tgt_value);
			dbms_output.put(case when v_tgt_value is null then 'null' else ''''||replace(v_tgt_value,'''','''''')||'''' end);
			end;
			elsif v_source_describe(i_src_column).col_type = 002 then
			declare 
			v_tgt_value number;
			begin
			dbms_sql.column_value(v_source_cursor_id, i_src_column, v_tgt_value);
			dbms_output.put(case when v_tgt_value is null then 'null' else to_char(v_tgt_value) end);
			end;
			elsif v_source_describe(i_src_column).col_type = 012 then
			declare 
			v_tgt_value date;
			begin
			dbms_sql.column_value(v_source_cursor_id, i_src_column, v_tgt_value);
			dbms_output.put(case when v_tgt_value is null then 'null' else 'to_date('''|| to_char(v_tgt_value, 'yyyy-mm-dd hh24:mi:ss') ||''', ''yyyy-mm-dd hh24:mi:ss'')'end);
			end;
			elsif v_source_describe(i_src_column).col_type = 112 then
			dbms_sql.column_value(v_source_cursor_id, i_src_column, v_source_columns(i_src_column).Clob_Table(v_num_records_source) );
			else
			raise_application_error(-20123, 'Não foi possivel transferir a coluna '|| v_source_describe(i_src_column).col_name||'');
			end if;
			dbms_output.put(case i_src_column when v_source_column_count then '' else ', ' end);
			end loop;
			dbms_output.put_line(');');
			v_num_records_source := v_num_records_source + 1;
			end loop;
		end;
		dbms_output.put_line('end;');
		dbms_output.put_line('/');
		if dbms_sql.is_open(v_source_cursor_id) then dbms_sql.close_cursor(v_source_cursor_id); end if;
	end;
end;
/

