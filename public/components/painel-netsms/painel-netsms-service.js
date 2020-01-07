"use strict";
/// Atenção: Este arquivo é gerado dinamicamente pelos refresh_jobs
angular.module("myApp").service("painel-netsms-service",
["$http",
function($http)
{
	this.get = function get(params)
	{
		function appendTransform(transform) 
		{
			let transformResponse = $http.defaults.transformResponse;
			transformResponse = angular.isArray(transformResponse) ? transformResponse : [transformResponse];
			return transformResponse.concat(transform);
		};
		
		let opt = 
		{
			"method": "GET", 
			"url": "/components/painel-netsms/painel-netsms-data.json", 
			"params": params,
			"transformResponse": appendTransform(function(value) 
			{
				value.refreshDate = new Date(value.refreshDate);
				return value; 
			})
		};
		return  $http(opt)
	};
}]);
