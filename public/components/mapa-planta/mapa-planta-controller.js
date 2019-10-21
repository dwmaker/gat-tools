
angular.module('myApp').controller('mapa-planta-controller', ['$scope','$http', "reqbrowse",
function($scope, $http, reqbrowse)
{
	$scope.browse = reqbrowse.data;
	$scope.orderBy = 'osuser';
	$scope.reverse = false;
	$scope.itemsPerPage = 20;
	
	$scope.currentPage = 1;
	$scope.Math = window.Math;
	
	$scope.ordenar = function(campo)
	{
		if($scope.orderBy == campo) return $scope.reverse = !$scope.reverse;
		$scope.orderBy = campo;
		$scope.reverse = false;
	};

	$scope.exportar = function exportar(data)
	{
		alasql('SELECT * INTO XLSX(?,?) FROM ?',["export.xlsx", {headers: true}, data]);
	};	
	
}]);

