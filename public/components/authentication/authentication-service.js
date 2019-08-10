angular.module('myApp')
.service("authentication-service", ["$http", "$base64", function($http, $base64)
{
	let profile;
	
	this.getProfile = function()
	{
		return profile;
	}
	
	this.login = function(username, password, rememberme)
	{
		let Authorization = "Basic " + $base64.encode(username + ":" + password);
		
		let opt = 
		{
			method: "GET",
			url: "/api/v1/profile",
			params: {},
			headers: 
			{
				Authorization: Authorization
			}
		};
		
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then((res)=>
			{
				$http.defaults.headers.common.Authorization = Authorization;
				profile = res.data;
				return resolve(this.profile);
			})
			.catch((res)=>
			{
				return reject(res.data);
			})
		});		
	}
	
	this.logoff = function()
	{
		let Authorization = "Basic ";
		$http.defaults.headers.common.Authorization = Authorization;
		profile = undefined;
	}
}])
