angular.module('myApp').service('environment-service', ['$http', 
function($http)
{
	this.list = async function list(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/environments", "params": params });
	};
}]);

	
	