'use strict';
angular.module('myApp')
.service("authentication-service", ["$http", "$base64", "$cookies", function($http, $base64, $cookies)
{
	let _profile;
	let _securityschemas = {}
	_profile = $cookies.getObject("profile");
	_securityschemas.basicAuth = $cookies.getObject("securitySchemas.basicAuth")
	this.getProfile = function()
	{
		return _profile;
	};
	this.setProfile = function(profile)
	{
		_profile = profile;
		$cookies.putObject("profile", profile);
	};
	this.getSecuritySchema = function(schemakey)
	{
		return _securityschemas[schemakey];
	};
	this.setSecuritySchema = function(schemakey, schema)
	{
		_securityschemas[schemakey] = schema;
		$cookies.putObject("securitySchemas." + schemakey + "", schema);
	};
	Object.assign($http.defaults.headers.common, this.getSecuritySchema("basicAuth"));
	this.login = function(username, password, rememberme)
	{
		let me = this;
		let securityschema = {"Authorization": "Basic " + $base64.encode(username + ":" + password)};
		let opt =
		{
			method: "GET",
			url: "/api/v1/profile",
			params: {},
			headers: securityschema
		};
		return new Promise(function(resolve, reject)
		{
			$http(opt)
			.then((res)=>
			{
				me.setSecuritySchema("basicAuth", securityschema);
				Object.assign($http.defaults.headers.common, securityschema);
				me.setProfile(res.data);
				return resolve(res.data);
			})
			.catch((res)=>
			{
				console.error(res)
				return reject(res.data);
			})
		});
	}
	this.logoff = async function()
	{
		this.setProfile(null);
		this.setSecuritySchema("basicAuth", null);
		Object.assign($http.defaults.headers.common, {Authorization: null});
	}
	this.checkAuths = function(security)
	{
		let me = this;
		let profile = me.getProfile();
		function checkmodel(model)
		{
			let schemaKeys = Object.keys(model)
			for(let iSchemaKey= 0; iSchemaKey<schemaKeys.length;iSchemaKey++)
			{
				let schemaKey = schemaKeys[iSchemaKey];
				if(!me.getSecuritySchema(schemaKey)) return false;
				for(let i = 0; i < model[schemaKey].length; i++)
				{
					if(!(profile.permissions.includes(model[schemaKey][i]))) return false;
				}
			}
			return true;
		}
		if(typeof security === "undefined") return true;
		if(security.length == 0) return true;
		if(!profile) return false;
		for(let iModel = 0; iModel < security.length; iModel++)
		{
			let model = security[iModel];
			if(checkmodel(model)) return true;
		}
		return false;
	}
}])
