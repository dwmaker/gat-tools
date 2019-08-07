angular.module('myApp').service('asm-disk-service', ['$http', 
function($http)
{
	this.list = async function list(param)
	{
		return await $http.get("/api/v1/asmdisks?datasourceCode="+ param.datasourceCode);
	};
}]);
