angular.module('myApp').service('netsms-parameter-service', ['$http', 
function($http)
{
	this.list = (datasourceCode) =>
	{
		return $http(
		{
			"method": "GET", 
			"url": `/api/v1/netsms-parameter/${datasourceCode}`, 
			"params": 
			{
			}
		});
	};
}]);
