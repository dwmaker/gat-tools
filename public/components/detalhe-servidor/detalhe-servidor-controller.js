angular.module('myApp').controller('detalhe-servidor-controller', ['$scope', 'detalhe',
function($scope, detalhe)
{
	$scope.detalhe = detalhe.data;
}]);

