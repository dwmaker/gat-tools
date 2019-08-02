
angular.module('myApp').controller('controle-acesso-controller', ['$scope','$http',
function($scope, $http)
{
	$scope.progress = 0.01;
	$scope.messages=[];
	async function listDatasources(obj)
	{
		return await $http.get("/api/v1/datasources?type="+obj.type+"");
	};
	
	async function listAccesscontrols(obj)
	{
		return await $http.get("/api/v1/accesscontrols?datasourceCode="+obj.datasourceCode+"");
	};
	$scope.datatable = {}
	
	$scope.filtrar = function(filter){
		return function(item)
		{
			let ret = true;
			if (!(item.type == filter.type)) ret = false;
			return ret;
		};
	}
		
	listDatasources({type:"app"})
	.then(
	(res1)=>
	{
		$scope.progress = false;

		let count = 0;
		let db = [];
		
		let promises = res1.data.map((row)=>
		{
			let promise = listAccesscontrols({datasourceCode: row.code});
			promise
			.then((res)=> 
			{
				count = count+1;
				$scope.progress = (count / res1.data.length);
				row.accesscontrols = res.data;
				
				if(count >= res1.data.length) 
				{
					//$scope.datatable.apply();
					$scope.datatable.displaydata = res1.data;
					$scope.progress = false;
				}
				$scope.$apply();
			})
			.catch((res)=>
			{
				count = count+1;
				$scope.progress = (count / res1.data.length);
				//$scope.messages[$scope.messages.length] = {"status":"danger", "title": row.code, "text": res.statusText};
				//throw res;
				row.message = res.data["internal-error"];
				if(count >= res1.data.length) 
				{
					//$scope.datatable.apply();
					$scope.datatable.displaydata = res1.data;
					$scope.progress = false;
				}
				$scope.$apply();
			})
			return promise; 
		});
		
		
	})
	.catch(
	(err)=>
	{
		$scope.data = err;
		console.error(err);
	})
}]);

