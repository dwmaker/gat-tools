create or replace procedure core.pr_imp_mapa
(
    p_nm_mapa_modelo tb_mapa.nm_mapa%type,
    p_cd_ambiente    tb_mapa.cd_ambiente%type,
    p_cd_tecnologia  tb_mapa_servidor.cd_tecnologia%type,
    p_cd_servidor    tb_mapa_servidor.cd_servidor%type,
    p_ds_conexao     tb_mapa_servidor.ds_conexao%type,
    p_usuarios       varchar2
) is 
v_id_mapa_modelo tb_mapa.id_mapa_template%type;
v_id_mapa tb_mapa.id_mapa%type;
v_id_mapa_servidor tb_mapa_servidor.id_mapa_servidor%type;
v_nm_mapa tb_mapa.nm_mapa%type;
begin
    if p_nm_mapa_modelo is null then
        raise_application_error(-20001, 'nm_mapa_modelo não pode estar em branco.');
    end if;
    
    if p_cd_ambiente is null then
        raise_application_error(-20002, 'cd_ambiente não pode estar em branco.');
    end if;
    
    if p_cd_tecnologia is null then
        raise_application_error(-20003, 'cd_tecnologia não pode estar em branco.');
    end if;
    
    if p_cd_servidor is null then
        raise_application_error(-20004, 'cd_servidor não pode estar em branco.');
    end if;
    
    if nullif(p_usuarios,'/') is not null and p_ds_conexao is null then
        raise_application_error(-20004, 'usuarios depende de ds_conexao');
    end if;

    begin
        select id_mapa into v_id_mapa_modelo from tb_mapa where nm_mapa = p_nm_mapa_modelo and tp_mapa = 'T';
    exception
        when no_data_found then raise_application_error(-20001, 'Não encontrado o modelo "'||p_nm_mapa_modelo||'"');
    end;		
    
    
    v_nm_mapa := p_nm_mapa_modelo || ' - ' || p_cd_ambiente;
    begin
        select id_mapa into v_id_mapa from tb_mapa where id_mapa_template = v_id_mapa_modelo and cd_ambiente = p_cd_ambiente and tp_mapa='M';
        exception when no_data_found then
        insert into tb_mapa
        (
            id_mapa,
            cd_ambiente,
            nm_mapa,
            TP_MAPA,
            NM_USUARIO_CRIACAO,
            dt_criacao,
            id_mapa_template
        )
        values
        (
            sq_mapa.nextval,
            p_cd_ambiente,
            v_nm_mapa,
            'M',
            'import',
            sysdate,
            v_id_mapa_modelo
        )
        return 
        id_mapa 
        into 
        v_id_mapa;
    end;
    
    declare 
    v_id_servidor_modelo tb_mapa_servidor.id_mapa_servidor%type;
    begin
    	select id_mapa_servidor into v_id_servidor_modelo from tb_mapa_servidor where id_mapa = v_id_mapa_modelo and cd_tecnologia = p_cd_tecnologia and cd_servidor = p_cd_servidor;
    	exception when no_data_found then
    	dbms_output.put_line('Warning: Não encontrado servidor "'||p_cd_tecnologia||'/'||p_cd_servidor||'" no modelo "'||p_nm_mapa_modelo||'"');
    end;
    
    begin
        select id_mapa_servidor into v_id_mapa_servidor from tb_mapa_servidor where id_mapa = v_id_mapa and cd_tecnologia = p_cd_tecnologia and cd_servidor = p_cd_servidor;
        if p_ds_conexao is null then
            delete tb_mapa_usuario where id_mapa_servidor = v_id_mapa_servidor;
            delete tb_mapa_servidor where id_mapa_servidor = v_id_mapa_servidor;
        else
            update tb_mapa_servidor set ds_conexao = p_ds_conexao where id_mapa_servidor = v_id_mapa_servidor;
        end if;
    exception when no_data_found then 
        if p_ds_conexao is null then
            null;
        else
            insert into tb_mapa_servidor
            (
                id_mapa_servidor,
                id_mapa,
                cd_tecnologia,
                cd_servidor,
                ds_conexao,
                NM_USUARIO_CRIACAO,
                dt_criacao
            )
            values
            (
                sq_mapa_servidor.nextval,
                v_id_mapa,
                p_cd_tecnologia,
                p_cd_servidor,
                p_ds_conexao,
                'import',
                sysdate
            )
            return
            id_mapa_servidor
            into
            v_id_mapa_servidor;
        end if;
    end;
    
    for usr in
    (
        select * from 
        (
            SELECT 
            case INSTR(t.ds_usuario, '/') when 0 then ds_usuario else SUBSTR(t.ds_usuario, 1, INSTR(t.ds_usuario, '/')-1) end AS nm_usuario,
            case INSTR(t.ds_usuario, '/') when 0 then null else SUBSTR(t.ds_usuario, INSTR(t.ds_usuario, '/')+1) end AS ds_senha
            FROM 
            (
            select distinct
            trim(regexp_substr(p_usuarios, '[^,]+', 1, levels.column_value))  as ds_usuario
            from 
            table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(p_usuarios, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
            ) t
        )
        where nm_usuario is not null
    ) loop
        declare 
        v_id_mapa_usuario tb_mapa_usuario.id_mapa_usuario%type;
        begin
            select id_mapa_usuario into v_id_mapa_usuario from tb_mapa_usuario where id_mapa_servidor = v_id_mapa_servidor and nm_usuario = usr.nm_usuario;
        exception when no_data_found then
            insert into tb_mapa_usuario 
            (
            id_mapa_usuario,
            id_mapa_servidor,
            nm_usuario,
            ds_senha,
            nm_usuario_criacao,
            dt_criacao
            )
            values
            (
            sq_mapa_usuario.nextval,
            v_id_mapa_servidor,
            usr.nm_usuario,
            usr.ds_senha,
            'import',
            sysdate
            )
            return
            id_mapa_usuario
            into
            v_id_mapa_usuario;
        end;
    end loop;
end;
/