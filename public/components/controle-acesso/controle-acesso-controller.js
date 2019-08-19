
angular.module('myApp').controller('controle-acesso-controller', ['$scope','$http', 'controle-acesso-service',
function($scope, $http, controleAcessoService)
{
	$scope.$watch('progress');
	
	$scope.messages=[];
	$scope.filtro={};
	$scope.list={};
	
	$scope.datatable = {};
	
	$scope.filtrar = function(filtro)
	{
		return function(item)
		{
			let ret = true;
			if(typeof filtro.cd_ambiente !== "undefined") if (!(item.cd_ambiente == filtro.cd_ambiente)) return false;
			if(typeof filtro.cd_sistema  !== "undefined") if (!(item.cd_sistema  == filtro.cd_sistema )) return false;
			if(typeof filtro.cd_cenario  !== "undefined") if (!(item.cd_cenario  == filtro.cd_cenario )) return false;
			return ret;
		};
	}
	
	$scope.progress = 0.01;
	controleAcessoService.getMetadata()
	.then((res)=>{$scope.metadata = res})
	.catch((err)=>{console.error(err)})
	
	
	
	function distinct(arr)
	{
		let saida = [];
		arr.forEach((item)=>
		{
			if(!saida.includes(item)) saida.push(item);
		})
		return saida;
		
	}
	controleAcessoService.getAccessControls()
	.then((res1)=>
	{
		$scope.datatable.displaydata = res1;
		$scope.progress = false;
		
		$scope.list.cd_ambiente = distinct($scope.datatable.displaydata.map((row)=>{return row.cd_ambiente}));
		$scope.list.cd_sistema = distinct($scope.datatable.displaydata.map((row)=>{return row.cd_sistema}));
		$scope.list.cd_cenario = distinct($scope.datatable.displaydata.map((row)=>{return row.cd_cenario}));
		
		$scope.$apply()
	})
	.catch(
	(err)=>
	{
		$scope.data = err;
		console.error(err);
	})
}]);

