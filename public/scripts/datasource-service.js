angular.module('myApp').service('datasource-service', ['$http', 
function($http)
{
	this.list = async function list(params)
	{
		return await $http({"method":"GET", "url":"/api/v1/datasources", "params": params });
	};
}]);

	
	