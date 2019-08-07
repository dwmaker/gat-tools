
angular.module('myApp').controller('parametro-netsms-controller', ['$scope','$http', 'environment-service', 'cenario-service', 'datasource-service', 'netsms-parameter-service', 'api-client-service',
function($scope, $http, environmentService, cenarioService, datasourceService, netsmsParameterService, apiClientService)
{
	$scope.init = function()
	{
		
		let environments;
		let cenarios;
		let datasources;
		
		$scope.$watch('progress', function() 
		{
			$scope.apply();
		});
		
		
		Promise.all([
		environmentService.list({}), 
		cenarioService.list({applicationCode:"NETSMS"}), 
		datasourceService.list({type:"app", applicationCode:"NETSMS"})
		])
		.then((res)=>
		{	
			let environments = res[0].data;
			let cenarios = res[1].data;
			let datasources = res[2].data;
			
			let total = datasources.length;
			let count = 0;
			
			datasources.forEach((datasource)=>
			{
				netsmsParameterService.list(datasource.code)
				.then((res)=>
				{
					onData(res, datasource); 
					
					if(++count == total) onComplete(environments, cenarios, datasources);
				})
				.catch((res)=>
				{
					onData(res, datasource); 
					if(++count == total) onComplete(environments, cenarios, datasources);
				});
			})
			function onData(res, datasource)
			{
				$scope.progress = count / total
				//if(datasource.code=="GA_CERT_NETSMS_BH")alert(datasource.code +" => "+ res.status)
				if([200, 201, 202].includes(res.status))
				{
					datasource.status = "L"
					datasource.data = res.data
				}
				else
				{
					datasource.status = "E"
				}				
			}
			
			function onComplete(environments, cenarios, datasources)
			{
				cenarios.forEach(cen => cen.visivel = true)
				environments.filter($scope.filtrar({"code":["PROD","CERT"]})).forEach(env => env.visivel = true)
				
				let list = [];
				datasources.filter((ds)=>{return Array.isArray(ds.data)}).forEach((ds)=>
				{ds.data.forEach((par)=>{if(!list.includes(par.code)) list.push(par.code)})
				})
				list.sort();
				let parametros = list.map((item)=>{return {code:item, visivel:false}})
				parametros.filter($scope.filtrar({"code":['ATIVA_CONSWEB_SERASA', 'ATIVA_ENTREGA_CHIP', 'ATIVA_NOVASCAIXAS', 'ATIVA_SERV_CLARO_SMS', 'AUTENT_OTP_VB', 
				'AUTENT_SOA_NETSALES', 'AUTENT_SOA_VB', 'BAIXA_NOVASCAIXAS', 'BLACKLIST_SUPERVRI', 'CASA_AGEND_SERVAVANC', 
				'CEN_BASE', 'CHAVE_LINEUP_MPACOT', 'COBRAR_DESAB_PARC', 'COD_CONTA_SAFX07E09', 'COD_CONTA_SAFX43', 'COLETIVO_B_LINK', 
				'COLETIVO_P_LINK', 'CV60_CONTAB_JDE_CCL', 'CV60_CONTAB_JDE_FAT', 'CV60_CONTAB_JDE_REC', 'CV60_INICIO_VIGENCIA', 
				'DEBUG_COSOLIDACAO', 'DEPTO_ADESAO_SA', 'DEPTO_MUDANCA_SA', 'ENVIA_FAT_NAO_OPT', 'FORMA_NUMERACAO_NF', 'GERAR_SOLIC_220', 
				'INFORMAR_MIGRACAO', 'INTEGRACAO_IP_PORTA', 'KILL', 'LD_AGENDAMENTO_CLARO', 'LIB_MAN_TP_AGE_CLARO', 'LIGA_BASE_NMARCADA', 
				'LINK_PORTAB_SALES', 'LOCK', 'MSG_INFO_MUDPAC_VTA', 'MWEB_LINK_CNPROTOCOL', 'MWEB_LINK_CSFRANQUIA', 'MWEB_LINK_FICHA_FIN', 
				'MWEB_LINK_MENU_PRINC', 'MWEB_LINK_RETENCAO', 'MWEB_LINK_REVERSAO', 'NETCRM_LINK', 'NET_SALES_LINK', 'NET_SALES_LINK', 
				'NMC_BASE_SESSAO', 'NMC_LOGIN_SIMULTANEO', 'NMC_LOGIN_SMT_LOG', 'OMBUDSMAN_LINK', 'PORTAB_ENDPOINT_ALSB', 'RESTR_BROWSER_NMC', 
				'SERVER_AD', 'SMS_LOGIN_SIMULTANEO', 'SOLICWA_NOVASCAIXAS', 'TIPO_OC_42', 'URL_J2EE_SERVIDOR']}))
				.forEach(par => par.visivel = true)
				$scope.parametros = parametros;
				$scope.environments = environments;
				$scope.cenarios = cenarios;
				$scope.datasources  = datasources ;
				$scope.txt = {visivel: true};
				$scope.num = {visivel: true};
				$scope.progress = null;
			}
		})
		.catch((res)=>
		{
			throw res;
		});
	};
	
	$scope.filtrar = function(f)
	{
		function comp(p1, p2)
		{
			let v1 = Array.isArray(p1)?p1:[p1];
			let v2 = Array.isArray(p2)?p2:[p2];
			let out=false;
			v1.forEach((i1)=>
			{
				v2.forEach((i2)=>
				{
					if (i1 == i2) out= true;
				})
			});
			return out;
		}
		
		return function(a)
		{
			let val = true;
			Object.keys(f).forEach((p)=>
			{
				let equ = ""
				if (p.substring(0,1)=="!") equ = "!";
				if (p.substring(0,1)=="%") equ = "%";
				let key = p.substring(equ.length);
				if(!(typeof a === 'undefined' || typeof f === 'undefined'))
				{
					let val2 = comp(a[key], f[p]);
					if(equ=="" && !val2) val = false;
					if(equ=="!" && val2) val = false;
					//alert("p:"+p+"\r\na:"+JSON.stringify(a)+"\r\nf:"+JSON.stringify(f)+"\r\nval2:"+val2)
				}
			});
			return val;
		}
	};
}]);

