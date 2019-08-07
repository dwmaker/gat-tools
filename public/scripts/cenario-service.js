angular.module('myApp').service('cenario-service', ['$http', 
function($http)
{
	this.list = async function list(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/cenarios", "params": params });
	};
}]);

	
	