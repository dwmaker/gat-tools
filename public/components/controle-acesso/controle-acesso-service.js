"use strict";
/// Atenção: Este arquivo é gerado dinamicamente pelos refresh_jobs
angular.module("myApp").service("controle-acesso-service",
["$http",
function($http)
{
	this.getMetadata = async function()
	{
		return { "refreshDate": "2019-09-24T13:33:25.000Z"};
	}
	this.getAccessControls = async function()
	{
		var list = [];
		list.push({"cd_conexao": "GA_CERT_CBM.NET", "cd_ambiente": "CERT", "cd_sistema": "CBM", "cd_cenario": null, "username": "CONSULTA_DICIONARIO", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.28.74)(PORT=1521))(CONNECT_DATA=(SID=BCMCER01)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12170: TNS:Connect timeout occurred"});
		list.push({"cd_conexao": "GA_CERT_FEPP.NET", "cd_ambiente": "CERT", "cd_sistema": "FEPP", "cd_cenario": null, "username": "CONSULTA_DICIONARIO", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.45)(PORT=1522))(CONNECT_DATA=(SID=HSATP01)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_ABC.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhbrin1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_BH.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_BRA.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "BRA", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhdb09n1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_ISP.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_SAO.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "SAO", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhspon1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_SOC.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "SOC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_SUL.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsuln1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_WA.NET", "cd_ambiente": "CERT", "cd_sistema": "WA", "cd_cenario": null, "username": "CONSULTA_DICIONARIO", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=WAFAB)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV1_NETSMS_ABC.NET", "cd_ambiente": "DEV1", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRIHP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV1_NETSMS_BH.NET", "cd_ambiente": "DEV1", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHHP)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12545: Connect failed because target host or object does not exist"});
		list.push({"cd_conexao": "GA_DEV1_NETSMS_ISP.NET", "cd_ambiente": "DEV1", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPHP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV4_NETSMS_ABC.NET", "cd_ambiente": "DEV4", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDABC13F)(SERVER=DEDICATED)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV4_NETSMS_BH.NET", "cd_ambiente": "DEV4", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDBH13F)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12505: TNS:listener does not currently know of SID given in connect descriptor"});
		list.push({"cd_conexao": "GA_DEV4_NETSMS_ISP.NET", "cd_ambiente": "DEV4", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=MUCISP01)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": false }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV4_NETSMS_SUL.NET", "cd_ambiente": "DEV4", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SERVICE_NAME=DDSUL11F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT1_NETSMS_ABC.NET", "cd_ambiente": "SIT1", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRIHP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT1_NETSMS_BH.NET", "cd_ambiente": "SIT1", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SBHHP)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12545: Connect failed because target host or object does not exist"});
		list.push({"cd_conexao": "GA_SIT1_NETSMS_ISP.NET", "cd_ambiente": "SIT1", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT2_NETSMS_ABC.NET", "cd_ambiente": "SIT2", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRISP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT2_NETSMS_BH.NET", "cd_ambiente": "SIT2", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBHSP)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12545: Connect failed because target host or object does not exist"});
		list.push({"cd_conexao": "GA_SIT2_NETSMS_ISP.NET", "cd_ambiente": "SIT2", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISPSP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT3_NETSMS_ABC.NET", "cd_ambiente": "SIT3", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRI3SP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT3_NETSMS_BH.NET", "cd_ambiente": "SIT3", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBH3SP)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12545: Connect failed because target host or object does not exist"});
		list.push({"cd_conexao": "GA_SIT3_NETSMS_CTV.NET", "cd_ambiente": "SIT3", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SCTV1MG)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_DEV1_NETSMS_CTV.NET", "cd_ambiente": "DEV1", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DCTV1HP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_SMP.NET", "cd_ambiente": "CERT", "cd_sistema": "SMP", "cd_cenario": null, "username": "CONSULTA_DICIONARIO", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=SMPALPHA)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_NETSMS_CTV.NET", "cd_ambiente": "CERT", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_CPI.NET", "cd_ambiente": "CERT", "cd_sistema": "CPI", "cd_cenario": null, "username": "CONSULTA_DICIONARIO", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1522))(CONNECT_DATA=(SID=HHCPI01)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": null});
		list.push({"cd_conexao": "GA_CERT_ATLAS.NET", "cd_ambiente": "CERT", "cd_sistema": "ATLAS", "cd_cenario": null, "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=HHATL01)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT3_NETSMS_ISP.NET", "cd_ambiente": "SIT3", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISP3SP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT4_NETSMS_BH.NET", "cd_ambiente": "SIT4", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBHPV1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT4_NETSMS_BRA.NET", "cd_ambiente": "SIT4", "cd_sistema": "NETSMS", "cd_cenario": "BRA", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBRA03F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT4_NETSMS_CTV.NET", "cd_ambiente": "SIT4", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLE2)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT4_NETSMS_ISP.NET", "cd_ambiente": "SIT4", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIISP02F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT4_NETSMS_SUL.NET", "cd_ambiente": "SIT4", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISUL66F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_ABC.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIABC02F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_BH.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBH03F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_CTV.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLD1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_SAO.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "SAO", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISP03F)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_SOC.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "SOC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=BIGT)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT5_NETSMS_SUL.NET", "cd_ambiente": "SIT5", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISULPV1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT6_NETSMS_ABC.NET", "cd_ambiente": "SIT6", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBRI)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT6_NETSMS_BH.NET", "cd_ambiente": "SIT6", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBH)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT6_NETSMS_CTV.NET", "cd_ambiente": "SIT6", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATCTV)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT6_NETSMS_ISP.NET", "cd_ambiente": "SIT6", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVISP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_ABC.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRISAMX)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_BH.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BHSAMX)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12505: TNS:listener does not currently know of SID given in connect descriptor"});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_BRA.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "BRA", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12505: TNS:listener does not currently know of SID given in connect descriptor"});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_CTV.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "CTV", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=dbri1ctv)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_ISP.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=ISPSAMX)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_SAO.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "SAO", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SPOSAMX)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_SOC.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "SOC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT7_NETSMS_SUL.NET", "cd_ambiente": "SIT7", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT8_NETSMS_ABC.NET", "cd_ambiente": "SIT8", "cd_sistema": "NETSMS", "cd_cenario": "ABC", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRISP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT8_NETSMS_BH.NET", "cd_ambiente": "SIT8", "cd_sistema": "NETSMS", "cd_cenario": "BH", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHSP)))", "login_triggers": [], "monitora_triggers": [], "sqlerrm": "ORA-12545: Connect failed because target host or object does not exist"});
		list.push({"cd_conexao": "GA_SIT8_NETSMS_BRA.NET", "cd_ambiente": "SIT8", "cd_sistema": "NETSMS", "cd_cenario": "BRA", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_SIT8_NETSMS_ISP.NET", "cd_ambiente": "SIT8", "cd_sistema": "NETSMS", "cd_cenario": "ISP", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPSP)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": false }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		list.push({"cd_conexao": "GA_STRESS_NETSMS_SUL.NET", "cd_ambiente": "STRESS", "cd_sistema": "NETSMS", "cd_cenario": "SUL", "username": "CORE", "ds_conexao": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))", "login_triggers": [{"owner": "CORE", "trigger_name": "TR_LOGON", "valid": true, "enabled": true }], "monitora_triggers": [{"owner": "CORE", "trigger_name": "TR_MONITORA", "valid": true, "enabled": true }], "sqlerrm": null});
		return list;
	}
}]);
