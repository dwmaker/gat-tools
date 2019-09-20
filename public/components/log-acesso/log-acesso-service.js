"use strict";
/// Atenção: Este arquivo é gerado dinamicamente pelos refresh_jobs
angular.module("myApp").service("log-acesso-service",
["$http",
function($http)
{
	
	this.browse = function browse(params)
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
			"url": "/api/v1/log-acesso/log-acesso-data.json", 
			"params": params,
			"transformResponse": appendTransform(function(value) 
			{
				value.refreshDate = new Date(value.refreshDate);
				value.records.forEach((item)=>
				{
					item.dtFim = new Date(item.dtFim);
					item.dtInicio = new Date(item.dtInicio);
					item.ultimoAcesso = new Date(item.ultimoAcesso);
				})
				return value; 
			})
		};
		return  $http(opt)
	};
}]);
