'use strict';
const passport = require("passport");

let controller = {};

controller.basicAuth = 
function(authlist)
{
	return function(req, res, next)
	{
		passport.authenticate('basic', { session: false }, function(error, user, info)
		{
			console.log({error, user, info})
			if(error) return res.status("403").send(error);
			if(typeof user != 'object')
			{
				return res.status("401").send({statusCode: "Unauthorized", userMessage: `Necessária a autenticação`});
			};
			
			for(let iAuth=0; iAuth < authlist.length; iAuth++)
			{
				if(!(user.access.includes(authlist[iAuth])))
				{
					return res.status("403").send({statusCode: "Forbidden", userMessage: `Usuario não tem a regra requirida "${authlist[iAuth]}"`, requiredRole: authlist[iAuth]})
				}
			}
			req.user = user;
			return next();
		})(req, res, next);
	}
};

controller.getProfile = function(req, res, next)
{
	res.status("200").send(req.user);
};

module.exports = controller;
