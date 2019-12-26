angular.module('myApp').controller('detalhe-servidor-controller', ['$scope', 'detalhe', 'lista',
function($scope, detalhe, lista)
{
	$scope.detalhe = detalhe.data;
	$scope.lstAmbiente = lista.data;
}]);

