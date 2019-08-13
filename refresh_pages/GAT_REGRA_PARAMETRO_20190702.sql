SET DEFINE OFF;
begin
    delete CORE.GAT_REGRA_PARAMETRO ;
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CEN_BASE','STR','EQU','DIF');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COLETIVO_B_LINK','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COLETIVO_P_LINK','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_SOA_VB','STR','EQU','EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_CONSWEB_SERASA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_ENTREGA_CHIP','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_CNPROTOCOL','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_CSFRANQUIA','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_FICHA_FIN','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_MENU_PRINC','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_NOVASCAIXAS','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_SERV_CLARO_SMS','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NETCRM_LINK','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NET_SALES_LINK','NUM','EQU','EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('OMBUDSMAN_LINK','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_OTP_VB','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_SOA_NETSALES','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SERVER_AD','STR',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SERVER_AD','NUM','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('BAIXA_NOVASCAIXAS','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('BLACKLIST_SUPERVRI','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CASA_AGEND_SERVAVANC','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CHAVE_LINEUP_MPACOT','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COBRAR_DESAB_PARC','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COD_CONTA_SAFX07E09','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COD_CONTA_SAFX43','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_CCL','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_FAT','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_REC','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_INICIO_VIGENCIA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEBUG_COSOLIDACAO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEPTO_ADESAO_SA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEPTO_MUDANCA_SA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ENVIA_FAT_NAO_OPT','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('FORMA_NUMERACAO_NF','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('GERAR_SOLIC_220','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('KILL','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LD_AGENDAMENTO_CLARO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LIB_MAN_TP_AGE_CLARO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LIGA_BASE_NMARCADA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LOCK','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MSG_INFO_MUDPAC_VTA','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_BASE_SESSAO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_LOGIN_SIMULTANEO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_LOGIN_SMT_LOG','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('RESTR_BROWSER_NMC','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SMS_LOGIN_SIMULTANEO','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SOLICWA_NOVASCAIXAS','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('TIPO_OC_42','STR',null,null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_CONSWEB_SERASA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_ENTREGA_CHIP','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_NOVASCAIXAS','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ATIVA_SERV_CLARO_SMS','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_OTP_VB','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_SOA_NETSALES','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('AUTENT_SOA_VB','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('BAIXA_NOVASCAIXAS','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COLETIVO_B_LINK','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COLETIVO_P_LINK','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('INFORMAR_MIGRACAO','STR','DIF','EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('INTEGRACAO_IP_PORTA','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LINK_PORTAB_SALES','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_CNPROTOCOL','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_CSFRANQUIA','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_FICHA_FIN','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_MENU_PRINC','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_RETENCAO','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MWEB_LINK_REVERSAO','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NETCRM_LINK','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NET_SALES_LINK','STR','DIF','EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('OMBUDSMAN_LINK','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('PORTAB_ENDPOINT_ALSB','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('URL_J2EE_SERVIDOR','STR','EQU',null);
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('BLACKLIST_SUPERVRI','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CASA_AGEND_SERVAVANC','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CHAVE_LINEUP_MPACOT','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COBRAR_DESAB_PARC','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COD_CONTA_SAFX07E09','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('COD_CONTA_SAFX43','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_CCL','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_FAT','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_CONTAB_JDE_REC','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('CV60_INICIO_VIGENCIA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEBUG_COSOLIDACAO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEPTO_ADESAO_SA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('DEPTO_MUDANCA_SA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('ENVIA_FAT_NAO_OPT','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('FORMA_NUMERACAO_NF','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('GERAR_SOLIC_220','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('KILL','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LD_AGENDAMENTO_CLARO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LIB_MAN_TP_AGE_CLARO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LIGA_BASE_NMARCADA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('LOCK','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('MSG_INFO_MUDPAC_VTA','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_BASE_SESSAO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_LOGIN_SIMULTANEO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('NMC_LOGIN_SMT_LOG','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('RESTR_BROWSER_NMC','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SMS_LOGIN_SIMULTANEO','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('SOLICWA_NOVASCAIXAS','NUM',null,'EQU');
    Insert into CORE.GAT_REGRA_PARAMETRO (NOME_PARAMETRO,TP_PARAMETRO,FC_COMPARA_AMBIENTE,FC_COMPARA_CENARIO) values ('TIPO_OC_42','NUM',null,'EQU');
end;
/