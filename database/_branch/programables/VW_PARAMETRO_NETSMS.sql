CREATE OR REPLACE VIEW CORE.VW_PARAMETRO_NETSMS AS
select
    nome_parametro,
    tp_parametro,
    cd_ambiente,
    cd_cenario,
    --max(fc_compara_cenario) fc_compara_cenario,
    max(qt_cenario_vlr) qt_cenario_vlr,
    max(qt_cenario_tot) qt_cenario_tot,
    --max(fc_compara_ambiente) fc_compara_ambiente,
    max(qt_ambiente_vlr) qt_ambiente_vlr,
    max(qt_ambiente_tot) qt_ambiente_tot,
    count(distinct vlr_parametro) qt_valor,
    max(vlr_parametro) vlr_parametro
    --case
    --when count(1) > 1 then 'MULTIVALUES'
    --when max(fc_compara_ambiente) = 'EQU' and max(qt_ambiente_vlr) < max(qt_ambiente_tot) then 'AMBIENTE_EQU'
    --when max(fc_compara_ambiente) = 'DIF' and max(qt_ambiente_vlr) > 1 then 'AMBIENTE_DIF'
    --when max(fc_compara_cenario) = 'EQU' and max(qt_cenario_vlr) < max(qt_cenario_tot) then 'CENARIO_EQU'
    --when max(fc_compara_cenario) = 'DIF' and max(qt_cenario_vlr) > 1 then 'CENARIO_DIF'
    --end cd_mensagem
    from
    (
        select distinct
        rgp.nome_parametro,
        rgp.tp_parametro,
        dtb.cd_ambiente,
        dtb.cd_cenario,
        par.vlr_parametro_str vlr_parametro,
        (
            SELECT
            count(distinct dtb2.cd_cenario)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_ambiente = dtb.cd_ambiente
            and par2.nome_parametro = rgp.nome_parametro
            and par2.vlr_parametro_str = par.vlr_parametro_str
        ) qt_cenario_vlr,
        (
            SELECT
            count(distinct dtb2.cd_cenario)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_ambiente = dtb.cd_ambiente
            and par2.nome_parametro = rgp.nome_parametro
        ) qt_cenario_tot,
        (
            SELECT
            count(distinct dtb2.cd_ambiente)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_cenario = dtb.cd_cenario
            and par2.nome_parametro = rgp.nome_parametro
            and par2.vlr_parametro_str = par.vlr_parametro_str
        ) qt_ambiente_vlr,
        (
            SELECT
            count(distinct dtb2.cd_ambiente)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_cenario = dtb.cd_cenario
            and par2.nome_parametro = rgp.nome_parametro
            --and par2.vlr_parametro_str = par.vlr_parametro_str
        ) qt_ambiente_tot
        from
        (
            core.sn_parametro par
            right join dbanovosms.vw_conexao dtb on par.dblink_name = dtb.cd_conexao
            right join core.gat_regra_parametro rgp on rgp.nome_parametro = par.nome_parametro
        )
        where par.st_parametro='A' and dtb.CD_APLICACAO='NETSMS'  and rgp.tp_parametro='STR'

        union

        select
        rgp.nome_parametro,
        rgp.tp_parametro,
        dtb.cd_ambiente,
        dtb.cd_cenario,
        to_char(par.vlr_parametro, 'FM999999999999G990D00', 'NLS_NUMERIC_CHARACTERS = ''.,''') vlr_parametro,
        (
            SELECT
            count(distinct dtb2.cd_cenario)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_ambiente = dtb.cd_ambiente
            and par2.nome_parametro = rgp.nome_parametro
            and par2.vlr_parametro = par.vlr_parametro
        ) qt_cenario_vlr,
        (
            SELECT
            count(distinct dtb2.cd_cenario)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_ambiente = dtb.cd_ambiente
            and par2.nome_parametro = rgp.nome_parametro
        ) qt_cenario_tot,
        (
            SELECT
            count(distinct dtb2.cd_ambiente)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_cenario = dtb.cd_cenario
            and par2.nome_parametro = rgp.nome_parametro
            and par2.vlr_parametro = par.vlr_parametro
        ) qt_ambiente_vlr,
        (
            SELECT
            count(distinct dtb2.cd_ambiente)
            FROM
            core.sn_parametro par2
            join dbanovosms.vw_conexao dtb2 on par2.dblink_name = dtb2.cd_conexao
            where
            par2.st_parametro='A'
            and dtb2.cd_aplicacao = dtb.cd_aplicacao
            and dtb2.cd_cenario = dtb.cd_cenario
            and par2.nome_parametro = rgp.nome_parametro
            --and par2.vlr_parametro = par.vlr_parametro
        ) qt_ambiente_tot
        from
        (
            core.sn_parametro par
            right join dbanovosms.vw_conexao dtb on par.dblink_name = dtb.cd_conexao
            right join core.gat_regra_parametro rgp on rgp.nome_parametro = par.nome_parametro
        )
        where par.st_parametro='A' and dtb.CD_APLICACAO='NETSMS'  and rgp.tp_parametro='NUM'
    )
    group by
    nome_parametro,
    tp_parametro,
    cd_ambiente,
    cd_cenario
;
