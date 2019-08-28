set serveroutput on;
DECLARE
	id core.tb_mapa.id_mapa%type;
	mapa1 core.pkg_mapa.rec_mapa;
BEGIN
	mapa1.nome := 'Mapa Legado Certificação';
	mapa1.descricao := 'Mapa Legado Certificação';
	mapa1.nr_versao := '1.0.0';
	mapa1.cd_ambiente := 'CERT';
	mapa1.tp_mapa := 'M';
	mapa1.tecnologias('WEBLOGIC')('WEBLOGIC01').conexao := 'HTTP://LOCALHOST:80';
	mapa1.tecnologias('WEBLOGIC')('WEBLOGIC01').usuarios('WEBLOGIC') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('SIGMA').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('SIGMA').usuarios('OPS$SIGMA') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('FEPP').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('FEPP').usuarios('OPS$FEPP') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('COMBOMULTI').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('COMBOMULTI').usuarios('OPS$COMBOMULTI') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('FIQUELIGADO').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('FIQUELIGADO').usuarios('OPS$FIQUELIGADO') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('WLI').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('WLI').usuarios('OPS$WLI') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('WA').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('WA').usuarios('OPS$WA') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('ATLAS').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('ATLAS').usuarios('OPS$ATLAS') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_BRA').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_BRA').usuarios('PROD_JD') := 'P@ssw0rd';
    mapa1.tecnologias('ORACLEDB')('NETSMS_BRA').usuarios('GED') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SUL').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SUL').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_ISP').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_ISP').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_BH').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_BH').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SOC').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SOC').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SAO').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_SAO').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_ABC').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_ABC').usuarios('PROD_JD') := 'P@ssw0rd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_CTV').conexao := 'asd';
	mapa1.tecnologias('ORACLEDB')('NETSMS_CTV').usuarios('PROD_JD') := 'P@ssw0rd';
	core.pkg_mapa.mrg_mapa(id, mapa1, 'teste', sysdate);
	dbms_output.put_line(id || '=>'|| core.pkg_mapa.to_json(mapa1));
	core.pkg_mapa.mrg_mapa(id, mapa1, 'teste', sysdate);
	core.pkg_mapa.del_mapa(id, 'teste', sysdate);
	
	
    rollback;
END;
/