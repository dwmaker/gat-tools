'use strict';
// @CodeGeneratorOverwrite: enabled
/**
* @class api-client-service
* @memberOf angular_module.???
* @description 
*/
angular.module("myApp").service("api-client-service", ["$http", 
function($http)
{
	
	this.DatasourceController = 
	{
		listDatasources: function(type, applicationCode)
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/datasources",
				params: {type, applicationCode}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}
			};
			return $http(opt);
		},
	};

	this.ApplicationController = 
	{
		listApplications: function()
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/applications",
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
		listCenarios: function()
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/cenarios",
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
		listEnvironments: function()
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/environments",
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
	};

	this.NetsmsVersionController = 
	{
		listNetsmsVersion: function(datasourceCode)
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/netsms-version/{datasourceCode}".replace("{datasourceCode}", datasourceCode),
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
	};

	this.NetsmsParameterController = 
	{
		listNetsmsParameter: function(datasourceCode)
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/netsms-parameter/{datasourceCode}".replace("{datasourceCode}", datasourceCode),
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
	};

	this.AccesscontrolController = 
	{
		listAccesscontrols: function(datasourceCode, type)
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/accesscontrols/{datasourceCode}".replace("{datasourceCode}", datasourceCode),
				params: {type}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
	};

	this.AsmController = 
	{
		listAsmdisks: function(datasourceCode)
		{
			let opt = 
			{
				method: "GET", 
				url: "/api/v1/asm-disks/{datasourceCode}".replace("{datasourceCode}", datasourceCode),
				params: {}, 
				headers: 
				{
					Authorization: "Basic cGF1bG86dGVzdGU="
				}, 
			};
			return $http(opt);
		},
	};

}]);
