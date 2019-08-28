CREATE OR REPLACE PACKAGE BODY core.pkg_mapa IS

	FUNCTION lst_mapa(
		obj_filtro rec_filtro
	) RETURN SYS_REFCURSOR
	AS
	my_cursor SYS_REFCURSOR;
	stmt varchar2(4000);
	BEGIN
		stmt := 
		'SELECT 
		tb_mapa.id_mapa       "id",
		tb_mapa.nm_mapa       "nome",
		tb_mapa.ds_mapa       "descricao",
		tb_mapa.nr_versao     "nr_versao",
		tb_mapa.cd_ambiente   "cd_ambiente",
		tb_mapa.tp_mapa       "tp_mapa",
		tb_mapa.id_mapa_template       "id_mapa_template",
		tb_mapa.nm_usuario_criacao   "nmUsuarioCriacao",
		tb_mapa.dt_criacao   "dtCriacao",
		tb_mapa.nm_usuario_alteracao   "nmUsuarioAlteracao",
		tb_mapa.dt_alteracao   "dtAlteracao"
		FROM tb_mapa ';
		if obj_filtro.tp_mapa_in.count > 0 then
		stmt := stmt || 'where ';
		stmt := stmt || 'tb_mapa.tp_mapa in (';
		for i in obj_filtro.tp_mapa_in.first..obj_filtro.tp_mapa_in.last loop
		stmt := stmt || 
		case when i > obj_filtro.tp_mapa_in.first then ',' end || 
		'''' || replace(obj_filtro.tp_mapa_in(i), '''', '''''') || '''';
		end loop;
		stmt := stmt || ') ';
		end if;
        stmt := stmt || ' order by "nome"';
		dbms_output.put_line(stmt);
		OPEN my_cursor FOR stmt;
		
		RETURN my_cursor;
	END lst_mapa;
	
	PROCEDURE del_mapa ( id in tb_mapa.id_mapa%type, nm_usuario_atual tb_mapa.nm_usuario_alteracao%type, dt_atual tb_mapa.dt_alteracao%type) is
    vid tb_mapa.id_mapa%type;
	begin
        select id_mapa into vid from tb_mapa where id_mapa = id;
		delete tb_mapa_usuario usr
		where exists
		(
			select svr.ID_MAPA_SERVIDOR
			from tb_mapa_servidor svr
			where id_mapa = id
			and svr.id_mapa_servidor = usr.id_mapa_servidor
		);
		
        delete tb_mapa_servidor where id_mapa = id;
		
		delete tb_mapa where id_mapa = id;
		
	end;
	
	PROCEDURE mrg_mapa
	(
		id in OUT tb_mapa.id_mapa%type,
		obj_mapa IN rec_mapa, 
		nm_usuario_atual tb_mapa.nm_usuario_alteracao%type, 
		dt_atual tb_mapa.dt_alteracao%type
	)
	IS
	BEGIN
		if id is null then
			insert into tb_mapa
			(
			id_mapa,
			nm_mapa,
			ds_mapa,
			nr_versao,
			cd_ambiente,
			tp_mapa,
			id_mapa_template,
			nm_usuario_criacao,
			dt_criacao
			)
			values
			(
			sq_mapa.nextval,
			obj_mapa.nome,
			obj_mapa.descricao,
			obj_mapa.nr_versao,
			obj_mapa.cd_ambiente,
			obj_mapa.tp_mapa,
			obj_mapa.id_mapa_template,
			nm_usuario_atual,
			dt_atual
			)
			RETURNING id_mapa INTO id;
		else
			declare vid tb_mapa.id_mapa%type;
			begin
			select id_mapa into vid from tb_mapa where id_mapa = id;
			end;
		
			update tb_mapa t set
			t.nm_mapa = obj_mapa.nome,
			t.ds_mapa = obj_mapa.descricao,
			t.nr_versao = obj_mapa.nr_versao,
			t.cd_ambiente = obj_mapa.cd_ambiente,
			t.tp_mapa = obj_mapa.tp_mapa,
			t.id_mapa_template = obj_mapa.id_mapa_template,
			t.nm_usuario_alteracao = nm_usuario_atual,
			t.dt_alteracao = dt_atual
			where
			t.id_mapa = id;
		end if;
		declare vcd_tecnologia tb_mapa_servidor.cd_tecnologia%type := obj_mapa.tecnologias.first;
		begin
		while true loop
			if vcd_tecnologia is null then EXIT; end if;
			declare
			vcd_servidor tb_mapa_servidor.cd_servidor%type := obj_mapa.tecnologias(vcd_tecnologia).first;
			vid_mapa_servidor tb_mapa_servidor.id_mapa_servidor%type;
			begin
			while true loop
				if vcd_servidor is null then EXIT; end if;
				select max(t.id_mapa_servidor) into vid_mapa_servidor 
				from
				tb_mapa_servidor t
				where 
				(t.id_mapa = id and t.cd_tecnologia = vcd_tecnologia and t.cd_servidor = vcd_servidor);
				if vid_mapa_servidor is null then 
					insert into tb_mapa_servidor t
					(
					t.id_mapa_servidor,
					t.id_mapa,
					t.cd_tecnologia,
					t.cd_servidor,
					t.ds_conexao,
					t.nm_usuario_criacao,
					t.dt_criacao
					)
					values
					(
					sq_mapa_servidor.nextval,
					id,
					vcd_tecnologia,
					vcd_servidor,
					obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).conexao,
					nm_usuario_atual,
					dt_atual
					)
					RETURNING t.id_mapa_servidor INTO vid_mapa_servidor;
				else
					update tb_mapa_servidor t set 
					t.ds_conexao = obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).conexao,
					t.nm_usuario_alteracao = nm_usuario_atual,
					t.dt_alteracao = dt_atual
					where
					vid_mapa_servidor = t.id_mapa_servidor;
				end if;
				declare
				vnm_usuario tb_mapa_usuario.nm_usuario%type := obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).usuarios.first;
				vid_mapa_usuario tb_mapa_usuario.id_mapa_usuario%type;
				begin
				while true loop
					if vnm_usuario is null then EXIT; end if;
					
					select max(id_mapa_usuario) INTO vid_mapa_usuario
					from tb_mapa_usuario 
					where
					nm_usuario = vnm_usuario and 
					id_mapa_servidor = vid_mapa_servidor
					;
					if vid_mapa_usuario is null then
						insert into tb_mapa_usuario t
						(
						id_mapa_usuario,
						id_mapa_servidor,
						nm_usuario,
						ds_senha,
						t.nm_usuario_criacao,
						t.dt_criacao
						)
						values
						(
						sq_mapa_usuario.nextval,
						vid_mapa_servidor,
						vnm_usuario,
						obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).usuarios(vnm_usuario),
						nm_usuario_atual,
						dt_atual
						)
						RETURNING id_mapa_usuario INTO vid_mapa_usuario;
					else
						update tb_mapa_usuario t set
						t.ds_senha = obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).usuarios(vnm_usuario),
						t.nm_usuario_alteracao = nm_usuario_atual,
						t.dt_alteracao = dt_atual
						where
						t.id_mapa_usuario = vid_mapa_usuario;
					end if;
					vnm_usuario := obj_mapa.tecnologias(vcd_tecnologia)(vcd_servidor).usuarios.next(vnm_usuario);
				end loop;
				end;
				vcd_servidor := obj_mapa.tecnologias(vcd_tecnologia).next(vcd_servidor);
			end loop;
			end;
			vcd_tecnologia := obj_mapa.tecnologias.next(vcd_tecnologia);
		end loop;
		end;
        
        for usr in (
        select svr.cd_tecnologia, svr.cd_servidor, usr.nm_usuario, usr.id_mapa_usuario 
		from tb_mapa_servidor svr
        join tb_mapa_usuario usr on svr.id_mapa_servidor = usr.id_mapa_servidor
        where id_mapa = id
		)loop
            if obj_mapa.tecnologias.exists(usr.cd_tecnologia) then
                if obj_mapa.tecnologias(usr.cd_tecnologia).exists(usr.cd_servidor) then
                    if obj_mapa.tecnologias(usr.cd_tecnologia)(usr.cd_servidor).usuarios.exists(usr.nm_usuario) then
                      null;
                    else
                        delete tb_mapa_usuario where id_mapa_usuario = usr.id_mapa_usuario;
                end if;
                else
                    delete tb_mapa_usuario where id_mapa_usuario = usr.id_mapa_usuario;
                end if;
            else
                 delete tb_mapa_usuario where id_mapa_usuario = usr.id_mapa_usuario;
            end if;
        end loop;
		
        for svr in (
        select svr.cd_tecnologia, svr.cd_servidor, svr.id_mapa_servidor 
		from tb_mapa_servidor svr
        where id_mapa = id
		)loop
            if obj_mapa.tecnologias.exists(svr.cd_tecnologia) then
                if obj_mapa.tecnologias(svr.cd_tecnologia).exists(svr.cd_servidor) then
					null;
                else
                    delete tb_mapa_servidor where id_mapa_servidor = svr.id_mapa_servidor;
                end if;
            else
                 delete tb_mapa_servidor where id_mapa_servidor = svr.id_mapa_servidor;
            end if;
        end loop;
	END;
	
	function to_json(valor varchar2) return varchar2
	is
	begin
	if valor is null then return 'null' ;end if;
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
	if valor is null then return 'null' ;end if;
	return '' || to_number(valor, 'FM9999999999999990D9999999999999999999') || '';
	end;
	
	function to_json(valor date) return varchar2
	is
	begin
	if valor is null then return 'null' ;end if;
	return '"' || to_char(valor, 'yyyy-mm-dd')|| 'T' || to_char(valor, 'hh24:mi:ss') || '.000Z' || '"';
	end;
	
	function to_json(usuarios tab_usuario) return varchar2 is
	saida varchar2(4000) := '';
	begin
		saida := saida || '{';
		declare nm_usuario tb_mapa_usuario.nm_usuario%type := usuarios.first;
		begin
		while true loop
			if nm_usuario is null then EXIT; end if;
			saida := saida || (case nm_usuario when usuarios.first then '' else ', ' end);
			saida := saida || '"' || nm_usuario || '": ' || to_json(usuarios(nm_usuario));
			nm_usuario := usuarios.next(nm_usuario);
		end loop;
		end;
		saida := saida || '}';
		return saida;
	end;
	
	function to_json(servidor rec_servidor) return varchar2 is
	begin
		return '{' ||
		'"conexao": ' || to_json(servidor.conexao) || ',' ||
		'"usuarios": ' || to_json(servidor.usuarios) ||
		'}';
	end;
	
	function to_json(servidores rec_tecnologia) return varchar2 is
	saida varchar2(4000) := '';
	begin
		saida := saida || '{';
		declare cd_servidor tb_mapa_servidor.cd_servidor%type := servidores.first;
		begin
		while true loop
			if cd_servidor is null then EXIT; end if;
			saida := saida || (case cd_servidor when servidores.first then '' else ', ' end);
			saida := saida || '"' || cd_servidor || '": ' || to_json(servidores(cd_servidor));
			cd_servidor := servidores.next(cd_servidor);
		end loop;
		end;
		saida := saida || '}';
		return saida;
	end;
	
	function to_json(tecnologias tab_tecnologia) return varchar2 is
	saida varchar2(4000) := '';
	begin
		saida := saida || '{';
		declare cd_tecnologia tb_mapa_servidor.cd_tecnologia%type := tecnologias.first;
		begin
		while true loop
			if cd_tecnologia is null then EXIT; end if;
			saida := saida || (case cd_tecnologia when tecnologias.first then '' else ', ' end);
			saida := saida || '"' || cd_tecnologia || '": ' || to_json(tecnologias(cd_tecnologia));
			cd_tecnologia := tecnologias.next(cd_tecnologia);
		end loop;
		end;
		saida := saida || '}';
		return saida;
	end;
	
	function to_json(obj_mapa rec_mapa) return varchar2 is
	saida varchar2(4000) := '';
	begin
		return '{' ||
		'"nome":' || to_json(obj_mapa.nome) || ',' ||
		'"descricao":' || to_json(obj_mapa.descricao) || ',' ||
		'"nr_versao":' || to_json(obj_mapa.nr_versao) || ',' ||
		'"cd_ambiente":' || to_json(obj_mapa.cd_ambiente) || ',' ||
		'"tp_mapa":' || to_json(obj_mapa.tp_mapa) || ',' ||
		'"id_mapa_template":' || to_json(obj_mapa.id_mapa_template) || ',' ||
		'"tecnologias":' || to_json(obj_mapa.tecnologias) ||
		'}';
	end;
	
	FUNCTION get_mapa 
	(
		id IN tb_mapa.id_mapa%type
	) RETURN rec_mapa IS
	obj_mapa rec_mapa;
	BEGIN
		select 
		nm_mapa, 
		ds_mapa, 
		nr_versao, 
		cd_ambiente, 
		tp_mapa,
		id_mapa_template
		into 
		obj_mapa.nome, 
		obj_mapa.descricao, 
        obj_mapa.nr_versao, 
        obj_mapa.cd_ambiente, 
        obj_mapa.tp_mapa,
		obj_mapa.id_mapa_template
        from TB_MAPA 
		where id_mapa=id;
		for srv in (
		select 
        id_mapa_servidor,
		id_mapa,
		cd_tecnologia,
		cd_servidor,
		ds_conexao
		from tb_mapa_servidor
		where id_mapa=id
        order by id_mapa_servidor
		) loop
			obj_mapa.tecnologias(srv.cd_tecnologia)(srv.cd_servidor).conexao := srv.ds_conexao;
			for usr in 
			(
                select
                usr.nm_usuario,
                usr.ds_senha
                from tb_mapa_usuario usr
                where usr.id_mapa_servidor = srv.id_mapa_servidor
                order by id_mapa_usuario
			) loop
			obj_mapa.tecnologias(srv.cd_tecnologia)(srv.cd_servidor).usuarios(usr.nm_usuario) := usr.ds_senha;
			end loop;
		end loop;
		RETURN obj_mapa;
	END;
	
END pkg_mapa;
/
