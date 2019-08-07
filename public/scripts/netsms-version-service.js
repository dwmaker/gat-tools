angular.module('myApp').service('netsms-version-service', ['$http', 
function($http)
{
	this.list = async function list(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/netsms-version", "params": params });
	};
}]);

	
	