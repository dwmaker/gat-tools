
angular.module('myApp').controller('versao-netsms-controller', ['$scope','$http',
function($scope, $http)
{
	$scope.progress = false;
	$scope.messages=[];
	
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
							datasource.mensagem = "ok";
							datasource.status = "S";
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
				//alert(JSON.stringify(datasources))
			})
			.catch(reject)
		});
	}
	
	loadData()
	.then((data)=>
	{
		$scope.environments.forEach((environment)=>
		{
			$scope.cenarios.forEach((cenario)=>
			{
				let ds = $scope.getItem({cenarioCode: cenario.code, environmentCode: environment.code}, $scope.datasources)
				let dsprod = $scope.getItem({cenarioCode: cenario.code, environmentCode: "PROD"}, $scope.datasources)
				if(ds.status == "S" && dsprod.status == "S")
				{
				}
			});
		});
		$scope.$apply();
	})
	.catch((err)=>
	{
		
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
	/*
	$scope.datasources={};
	listCenarios({applicationCode: "NETSMS"})
	.then(
	(cenRes)=>
	{
		$scope.cenarios = cenRes.data;
		listEnvironments()
		.then(
		(res1)=>
		{
			$scope.environments = res1.data;
			let count=0
			let total=$scope.environments.length * $scope.cenarios.length
			$scope.cenarios.forEach((cenario)=>
			{
				$scope.environments.forEach((environment)=>
				{
					let datasource = {"environmentCode":environment.code,"cenarioCode":cenario.code};
					listNetsmsVersions({"datasourceCode": 'GA_'+environment.code + '_' + cenario.applicationCode + '_' + cenario.code})
					.then((res3)=>
					{
						if(typeof $scope.datasources[environment.code] === 'undefined') $scope.datasources[environment.code] = {}
						$scope.datasources[environment.code][cenario.code] = res3;
						console.log(res3)
						if(++count == total) $scope.$apply();
					})
					.catch((res3)=>
					{
						if(typeof $scope.datasources[environment.code] === 'undefined') $scope.datasources[environment.code] = {}
						$scope.datasources[environment.code][cenario.code] = res3;
						if(++count == total) $scope.$apply();
					});
				})
			})
			
		})
		.catch(
		(err)=>
		{
			$scope.data = err;
			console.error(err);
		});
	})
	.catch(
	(err)=>
	{
		$scope.messages.push(err);
		
	});
	*/
	
	
	
	
	
	
}]);

