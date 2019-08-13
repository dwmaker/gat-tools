'use strict';
const DatasourceDAO = require("../dao/datasource-dao.js");
const NetsmsparameterDAO = require("../dao/netsmsparameter-dao.js");
const EnvironmentDAO = require("../dao/environment-dao.js");
const CenarioDAO = require("../dao/cenario-dao.js");

let environmentDAO = new EnvironmentDAO;
let cenarioDAO = new CenarioDAO;
let datasourceDAO = new DatasourceDAO;
let service = {};
let parameterCodes = [
'ATIVA_CONSWEB_SERASA', 'ATIVA_ENTREGA_CHIP', 'ATIVA_NOVASCAIXAS', 'ATIVA_SERV_CLARO_SMS', 'AUTENT_OTP_VB', 
'AUTENT_SOA_NETSALES', 'AUTENT_SOA_VB', 'BAIXA_NOVASCAIXAS', 'BLACKLIST_SUPERVRI', 'CASA_AGEND_SERVAVANC', 
'CEN_BASE', 'CHAVE_LINEUP_MPACOT', 'COBRAR_DESAB_PARC', 'COD_CONTA_SAFX07E09', 'COD_CONTA_SAFX43', 'COLETIVO_B_LINK', 
'COLETIVO_P_LINK', 'CV60_CONTAB_JDE_CCL', 'CV60_CONTAB_JDE_FAT', 'CV60_CONTAB_JDE_REC', 'CV60_INICIO_VIGENCIA', 
'DEBUG_COSOLIDACAO', 'DEPTO_ADESAO_SA', 'DEPTO_MUDANCA_SA', 'ENVIA_FAT_NAO_OPT', 'FORMA_NUMERACAO_NF', 'GERAR_SOLIC_220', 
'INFORMAR_MIGRACAO', 'INTEGRACAO_IP_PORTA', 'KILL', 'LD_AGENDAMENTO_CLARO', 'LIB_MAN_TP_AGE_CLARO', 'LIGA_BASE_NMARCADA', 
'LINK_PORTAB_SALES', 'LOCK', 'MSG_INFO_MUDPAC_VTA', 'MWEB_LINK_CNPROTOCOL', 'MWEB_LINK_CSFRANQUIA', 'MWEB_LINK_FICHA_FIN', 
'MWEB_LINK_MENU_PRINC', 'MWEB_LINK_RETENCAO', 'MWEB_LINK_REVERSAO', 'NETCRM_LINK', 'NET_SALES_LINK',  
'NMC_BASE_SESSAO', 'NMC_LOGIN_SIMULTANEO', 'NMC_LOGIN_SMT_LOG', 'OMBUDSMAN_LINK', 'PORTAB_ENDPOINT_ALSB', 'RESTR_BROWSER_NMC', 
'SERVER_AD', 'SMS_LOGIN_SIMULTANEO', 'SOLICWA_NOVASCAIXAS', 'TIPO_OC_42', 'URL_J2EE_SERVIDOR']


function loadNetsmsParameters()
{
	let data = [];
	let errors = [];
	return new Promise(function (resolve, reject)
	{
		datasourceDAO.list({type:"app", applicationCode: "NETSMS"})
		.then((datasources)=>
		{
			let count = 0;
			let total = datasources.length;
			datasources.forEach((ds)=>
			{
				let netsmsparameterDAO = new NetsmsparameterDAO(ds.code);
				netsmsparameterDAO.list({datasourceCode: ds.code})
				.then((parameters)=>
				{
						data = data.concat(parameters
						.filter(parameter => parameterCodes.includes(parameter.code))
						.map((parameter) =>
						{
							return {              
								datasourceCode:     ds.code,              
								environmentCode:    ds.environmentCode,   
								applicationCode:    ds.applicationCode,   
								cenarioCode:        ds.cenarioCode, 
								code:               parameter.code,							
								textValue:          parameter.textValue,       
								numericValue:       parameter.numericValue,      
								textDuplicate:      (parameter.numDistinctText>1)?true:false,   
								numericDuplicate:   (parameter.numDistinctNumeric>1)?true:false,
							}
						}));
					
					if(++count == total) resolve({data, errors});
				})
				.catch((err)=>
				{
					errors = errors.concat(
					{
							datasourceCode:     ds.code,              
							environmentCode:    ds.environmentCode,   
							applicationCode:    ds.applicationCode,   
							cenarioCode:        ds.cenarioCode, 
							message:            err.conteudo,
						}
					);
					if(++count == total) resolve({data, errors});
				});
			})
		})
		.catch(reject);
	}) 
}
function distinct(arr)
{
	let saida=[];
	arr.forEach((val)=>
	{
		if (!saida.includes(val)) saida.push(val)
	})
	return saida;
}

service.reportNetsmsParameters = function ()
{
	return new Promise((resolve, reject)=>
	{
		Promise.all(
		[
			loadNetsmsParameters(),
			environmentDAO.list(),
			cenarioDAO.list({applicationCode: "NETSMS"})
		])
		.then((res)=>
		{	let netsmsparameters = res[0].data;
			let errors = res[0].errors;
			let environments = res[1];
			let cenarios = res[2];
			parameterCodes.forEach((parcode)=>
			{
				environments.map(env => env.code).forEach((envcode)=>
				{
					let filt = netsmsparameters.filter(par => par.environmentCode == envcode && par.code == parcode)
					let textEnvDuplicate = (distinct(filt.map(par2 => par2.textValue)).length==1)
					let numericEnvDuplicate = (distinct(filt.map(par2 => par2.numValue)).length==1)
					filt.forEach((par)=>
					{
						par.textEnvDuplicate = textEnvDuplicate;
						par.numericEnvDuplicate  = numericEnvDuplicate;
					})
				});
				
				cenarios.map(cen => cen.code).forEach((cencode)=>
				{
					let filt = netsmsparameters.filter(par => par.cenarioCode == cencode && par.code == parcode)
					let textCenDuplicate = (distinct(filt.map(par2 => par2.textValue)).length==1)
					let numericCenDuplicate = (distinct(filt.map(par2 => par2.numValue)).length==1)
					filt.forEach((par)=>
					{
						par.textCenDuplicate = textCenDuplicate;
						par.numericCenDuplicate  = numericCenDuplicate;
					})
				})
			})
			
			//pivoteando
			let pivot = [];
			environments.map(env => env.code).forEach((envcode)=>
			{
				parameterCodes.forEach((parcode)=>
				{
					let row = {parameterCode: parcode, environmentCode: envcode}
					cenarios.map(cen => cen.code).forEach((cencode)=>
					{
						let par = netsmsparameters.find(par => par.cenarioCode == cencode && par.code == parcode && par.environmentCode == envcode);
						if (typeof par === "object")
						{
							delete par.environmentCode
							delete par.applicationCode
							delete par.cenarioCode    
							delete par.code
							par.status="L"
							row[cencode] = par
						}
						else
						{
							row[cencode] = {status: "U"}
						}
					});
					pivot.push(row);
				});
			});
			
			errors.forEach((error) =>
			{
				pivot.filter(row => row.environmentCode == error.environmentCode)
				.forEach((row)=>
				{
					row[error.cenarioCode] = error;
				});
				error.status = "E";
				delete error.environmentCode
				delete error.applicationCode
				delete error.cenarioCode    
				delete error.code
			})
			resolve({cenarios, environments, parameterCodes, pivot})
		})
		.catch(reject)
	})
}
//service.reportNetsmsParameters()
//.then((data)=>
//{
//	console.log((data.pivot))
//})
//.catch((err)=>
//{
//	console.error(err)
//})
module.exports = service