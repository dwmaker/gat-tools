
angular.module('myApp').controller('painel-netsms-controller', ['$scope', "reqdata", 
function($scope, reqdata)
{
	
	$scope.reqdata = reqdata.data;
}]);

