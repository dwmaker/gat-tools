angular.module('myApp').service('ambiente-service', ['$http', 
function($http)
{
	this.list = function list()
	{
		let opt = 
		{
			"method": "GET", 
			"url": "/api/v1/environments", 
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
				reject(res.data);
			});
		});
	};
}]);

	
	