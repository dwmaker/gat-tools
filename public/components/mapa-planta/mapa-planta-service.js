angular.module("myApp").service("mapa-planta-service", ['$http',
function($http)
{
	this.list = function list(params)
	{
		let opt = 
		{
			"method": "GET", 
			"url": "/api/v1/mapa-planta", 
			"params": params
		};
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then(function(res)
			{
				resolve(res.data);
			})
			.catch(function(res)
			{
				reject(res.data);
			});
		});
	};
	
	this.get = function get(id)
	{
		let opt = 
		{
			"method": "GET", 
			"url": "/api/v1/mapa-planta/:id".replace(":id", id), 
			"params": {}
		};
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then(function(res)
			{
				resolve(res.data);
			})
			.catch(function(res)
			{
				reject(res);
			});
		});
	};
	
	this.update = function update(id, obj)
	{
		let opt = 
		{
			"method": "PUT", 
			"url": "/api/v1/mapa-planta/:id".replace(":id", id), 
			"params": {},
			"data": obj
		};
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then(function(res)
			{
				resolve(res.data);
			})
			.catch(function(res)
			{
				reject(res);
			});
		});
	};
	this.new = function()
	{
		return {
			nome: null,
			cd_ambiente: null,
			id_mapa_template: null,
			tecnologias: {},
			tp_mapa:"M"
		};
	}
	
	this.add = function add(obj)
	{
		let opt = 
		{
			"method": "POST", 
			"url": "/api/v1/mapa-planta/", 
			"params": {},
			"data": obj
		};
		return $http(opt);
			
	};
	
	this.delete = function (id)
	{
		let opt = 
		{
			"method": "DELETE", 
			"url": "/api/v1/mapa-planta/:id".replace(":id", id), 
			"params": {}
		};
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then(function(res)
			{
				resolve(res.data);
			})
			.catch(function(res)
			{
				reject(new Error(res));
			});
		});
	};
}]);