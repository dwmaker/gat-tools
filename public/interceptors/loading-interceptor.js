angular.module("myApp")
.factory("loading-interceptor", ["$rootScope",
function($rootScope)
{
	if($rootScope.loading == undefined) $rootScope.loading = 0;
	function request(config) {
		if(config.url.indexOf("/api/v1") == -1) return config;		
		$rootScope.loading = 1;
		return config;
	};
	function requestError(rejection) {
		$rootScope.loading = 0;
		return q$.reject(rejection);
	};
	function response(response) {
		if(response.config.url.indexOf("/api/v1") == -1) return response;
		$rootScope.loading = 0;
		return response;
	};
	function responseError(rejection) {
		$rootScope.loading = 0;
		console.error(rejection)
		return $q.reject(rejection);
	}	
	
	return {request, requestError, response, responseError};
}])
.config(["$httpProvider",
function($httpProvider) 
{
	$httpProvider.interceptors.push("loading-interceptor");
}])
;