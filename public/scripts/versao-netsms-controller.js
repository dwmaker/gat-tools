
angular.module('myApp').controller('versao-netsms-controller', ['$scope','$http',
function($scope, $http)
{
	$scope.progress = false;
	$scope.messages=[];
	
	const nr_dias_sla = 10;
	
	async function listDatasources(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/datasources", "params": params });
	};
	
	async function listEnvironments(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/environments", "params": params });
	};
	
	async function listCenarios(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/cenarios", "params": params });
	};
	
	async function listNetsmsVersions(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/netsms-version", "params": params });
	};
	
	function loadData()
	{
		return new Promise(
		function(resolve, reject) 
		{
			Promise.all([listDatasources({type: "app", applicationCode: "NETSMS"}), listCenarios({applicationCode: "NETSMS"}), listEnvironments()])
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
						}
						if(count==total) 
						{
							$scope.cenarios = cenarios;
							$scope.environments = environments;
							$scope.datasources = datasources;
							resolve();
						}
					}
					listNetsmsVersions({"datasourceCode": datasource.code}).then(callback).catch(callback)
				})
			})
			.catch(reject)
		});
	}
	
	loadData()
	.then((data)=>
	{
		$scope.cenarios.forEach((cenario)=>
		{
			let dsprod = $scope.getItem({cenarioCode: cenario.code, environmentCode: "PROD"}, $scope.datasources);
			$scope.environments
			.filter((environment)=>
			{
				return environment.code != "PROD"
			})
			.forEach((environment)=>
			{
				let ds = $scope.getItem({cenarioCode: cenario.code, environmentCode: environment.code}, $scope.datasources)
				try
				{
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
				}
				catch(e)
				{
					alert(e.toString())
				}
			});
		});
		$scope.$apply();
	})
	.catch((err)=>
	{
		alert("pau!")
		$scope.$apply();
	})
	
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

