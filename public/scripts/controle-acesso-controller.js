
angular.module('myApp').controller('controle-acesso-controller', ['$scope','$http', 'api-client-service',
function($scope, $http, apiClientService)
{
	$scope.$watch('progress');
	
	$scope.messages=[];
	
	$scope.datatable = {};
	
	$scope.filtrar = function(filter)
	{
		return function(item)
		{
			let ret = true;
			if (!(item.type == filter.type)) ret = false;
			return ret;
		};
	}
	
	$scope.progress = 0.01;
	
	apiClientService.DatasourceController.listDatasources("app", undefined)
	.then(
	(res1)=>
	{
		$scope.progress = false;
		let count = 0;
		let db = [];
		let promises = res1.data.map((row)=>
		{
			let promise = apiClientService.AccesscontrolController.listAccesscontrols(row.code, null);
			promise
			.then((res)=> 
			{
				count = count+1;
				$scope.progress = (count / res1.data.length);
				row.accesscontrols = res.data;
				if(count >= res1.data.length) 
				{
					$scope.datatable.displaydata = res1.data;
					$scope.progress = false;
				}
			})
			.catch((res)=>
			{
				count = count+1;
				$scope.progress = (count / res1.data.length);
				if(typeof res.data !== 'undefined') {row.message = res.data["internal-error"]}
				if(count >= res1.data.length) 
				{
					$scope.datatable.displaydata = res1.data;
					$scope.progress = false;
				}
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

