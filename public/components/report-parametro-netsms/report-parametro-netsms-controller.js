
angular.module('myApp').controller('report-parametro-netsms-controller', ['$scope', 'report-parametro-netsms-service',
function($scope, reportParametroNetsmsService)
{
	reportParametroNetsmsService.reportParametroNetsms()
	.then((data)=>
	{
		$scope.data = data;
		$scope.$apply()
	})
	.catch((err)=>
	{
		$scope.messages.push(err);
	})

}]);

