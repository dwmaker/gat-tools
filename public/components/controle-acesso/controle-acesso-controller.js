
angular.module('myApp').controller('controle-acesso-controller', ['$scope','$http', 'controle-acesso-service',
function($scope, $http, controleAcessoService)
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
	controleAcessoService.getMetadata()
	.then((res)=>{$scope.metadata = res})
	.catch((err)=>{console.error(err)})
	
	controleAcessoService.getAccessControls()
	.then((res1)=>
	{
		$scope.datatable.displaydata = res1;
		$scope.progress = false;
		$scope.$apply()
	})
	.catch(
	(err)=>
	{
		$scope.data = err;
		console.error(err);
	})
}]);

