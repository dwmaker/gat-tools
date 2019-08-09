
angular.module('myApp').controller('versao-netsms-controller', ['$scope', 'cenario-service', 'environment-service', 'api-client-service',
function($scope, cenarioService, environmentService, apiClientService)
{
	//$scope.progress=null;
	$scope.$watch('progress', function(novo, anterior)
	{
		if(typeof  anterior !== 'number' && typeof novo === 'number')
		{	
			/*$("#loadMe").modal({
			  backdrop: "static",
			  keyboard: false,
			  show: true
			});*/
		}
		else if(typeof anterior === 'number' && typeof novo !== 'number')
		{
			/*
			$("#loadMe").modal("hide");
			*/
		}
		 
	});
	$scope.messages=[];
	
	const nr_dias_sla = 10;
	
	function loadData()
	{
		return new Promise(
		function(resolve, reject) 
		{
			Promise.all([apiClientService.DatasourceController.listDatasources("app", "NETSMS"), cenarioService.list({applicationCode: "NETSMS"}), environmentService.list()])
			.then((data)=>
			{
				let datasources = data[0].data;
				let cenarios = data[1].data;
				let environments = data[2].data;
				let count = 0;
				let total = datasources.length;
				datasources.forEach((datasource)=>
				{
					function callback(res)
					{
						count++;
						if(res.status=="200")
						{
							datasource.listVersao = res.data;
							datasource.mensagem = undefined;
							datasource.status = "L";
						}
						else
						{
							datasource.listVersao = undefined;
							datasource.mensagem = res.data["internal-error"];
							datasource.status = "E";
						};
						$scope.progress = count / total;
						if(count==total) 
						{
							
							resolve([cenarios, environments, datasources]);
						}
					}
					apiClientService.NetsmsVersionController.listNetsmsVersion(datasource.code).then(callback).catch(callback)
				})
			})
			.catch(reject)
		});
	}
	
	loadData()
	.then((arr)=>
	{
		let cenarios = arr[0]
		let environments = arr[1]
		let datasources = arr[2]
		cenarios.forEach((cenario)=>
		{
			let dsprod = $scope.getItem({cenarioCode: cenario.code, environmentCode: "PROD"}, datasources);
			environments
			.filter((environment)=>
			{
				return environment.code != "PROD"
			})
			.forEach((environment)=>
			{
				let ds = $scope.getItem({cenarioCode: cenario.code, environmentCode: environment.code}, datasources)
				if(typeof ds === "object" && typeof dsprod === "object") 
				{
					if(ds.status == "L" && dsprod.status=="L")
					{
						if(ds.listVersao[0].version < dsprod.listVersao[0].version)
						{
							let listVersaoProd = dsprod.listVersao.filter((ver)=>{return (ver.version==ds.listVersao[0].version)})
							if(listVersaoProd.length > 0)
							{
								let dtprod = new Date(listVersaoProd[0].applyDate)
								let dt = new Date(Date.now())
								let diffDays = Math.ceil(Math.abs(dt.getTime() - dtprod.getTime()) / (1000 * 60 * 60 * 24)); 
								if(nr_dias_sla <= diffDays)
								{
									ds.status = "W";
									ds.mensagem = "Obsoleto ha " + (diffDays - nr_dias_sla) + " dias";	
								}
								else
								{
									ds.status = "O";
									ds.mensagem = "Atualizar em até " + (nr_dias_sla - diffDays) + " dias";
								}
							}
							else
							{
								ds.status = "O";
								ds.mensagem = "Versão não cadastrada em produção";
							}
						}
						else if(ds.listVersao[0].version > dsprod.listVersao[0].version) 
						{
							ds.status = "F";
							ds.mensagem = "versão superior a de produção";
						}
						else if(ds.listVersao[0].version == dsprod.listVersao[0].version) 
						{
							ds.status = "L"
						}
						else
						{
							alert('Isso não era pra ter acontecido')
						}
					}
				}
			});
		});
		$("#loadMe").modal("hide");
		$scope.cenarios = cenarios;
		$scope.environments = environments;
		$scope.datasources = datasources;
		$scope.progress = null;
		$scope.$apply()
		$("#loadMe").modal("hide");
	})
	.catch((err)=>
	{
		$scope.progress = null;
		$scope.$apply()
		$("#loadMe").modal("hide");
		alert(err);
	});
	
	$scope.getItem = function(filter, list)
	{
		let f1 = list.filter((val)=>
		{
			let ret = true;
			Object.keys(filter).forEach((key)=>
			{
					if(!(val[key] == filter[key])) ret = false;
			});
			return ret;
		});
		if(f1.length == 0) return undefined;
		return f1[0];
	}
}]);

