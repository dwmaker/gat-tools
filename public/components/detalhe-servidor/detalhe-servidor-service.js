"use strict";
angular.module("myApp").service("detalhe-servidor-service",
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
			"url": "/components/detalhe-servidor/"+params.dblink+".json", 
			"params": {},
			"transformResponse": appendTransform(function(value) 
			{
				value.refreshDate = new Date(value.refreshDate);
				/*value.records.forEach((item)=>
				{
					item.dtFim = new Date(item.dtFim);
					item.dtInicio = new Date(item.dtInicio);
					item.ultimoAcesso = new Date(item.ultimoAcesso);
				})*/
				return value; 
			})
		};
		return  $http(opt)
	};
	
	
}]);
