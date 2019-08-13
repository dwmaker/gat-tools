'use strict';
angular.module('myApp').service('report-parametro-netsms-service', ["$http", function($http)
{
	this.reportParametroNetsms = function()
	{
		return new Promise((resolve, reject) =>
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/report-netsms-parameters",
				params: {},
			};
			$http(opt)
			.then((res)=>
			{
				resolve(res.data)
			})
			.catch((res)=>
			{
				reject(res.data);
			});
		});
	};
}]);