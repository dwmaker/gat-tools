"use strict";
const passport = require("passport");
const {ResponseError, FORBIDDEN, UNAUTHORIZED} = require("../errors");
function securityController(security)
{
	return function(req, res, next)
	{
		let auths = {};
		
		function checkPermissions(permissions, user)
		{
			return new Promise((resolve, reject)=>
			{
				let lst = []
				for(let i =0; i< permissions.length; i++)
				{
					if(!user.permissions.includes(permissions[i]))
					{
						lst.push(permissions[i]);
					}
				}
				return resolve(lst);
			})
		};
		
		async function authSecurity(security)
		{
			if(typeof security === "undefined") return next();
			for (let modelKey in security)
			{		
				let model = security[modelKey];
				for(let schemaKey in model)
				{
					let permissions = model[schemaKey];
					if(typeof auths[schemaKey] === "undefined") auths[schemaKey] = await authenticate(schemaKey, { session: false });
					
					if(auths[schemaKey] !== false)
					{
						let requirePermissions = await checkPermissions(permissions, auths[schemaKey]);
						if(requirePermissions.length > 0)
						{
							throw new FORBIDDEN({requirePermissions});
						}
					}
					else
					{
						throw new UNAUTHORIZED;
					}
				};
				return auths[Object.keys(model)[0]];
			}
		};
		
		function authenticate(schemaKey, options)
		{
			return new Promise((resolve, reject) =>
			{
				passport.authenticate(schemaKey, options, function(error, user, info)
				{
					if(error == null) return resolve(user);
					if(typeof error !== "undefined") return reject(error);
				})(req, res, next)
			})
		};
		
		authSecurity(security)
		.then((obj)=>
		{
			req.user = obj;
			next();
		})
		.catch((err)=>
		{
			if(err instanceof ResponseError)
			{
				res.status(err.status).send(err);
			}
			else
			{
				return next(err);
				console.error(err)
			}
		});
	}
}	
module.exports = securityController;