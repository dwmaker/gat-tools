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
			if(error) return next(error);
			
			for(let iAuth=0; iAuth < authlist.length; iAuth++)
			{
				if(!(user.access.includes(authlist[iAuth])))
				{
					return res.status("403").send({statusCode: "AcessoNegado", userMessage: `Usuario não tem a regra requirida "${authlist[iAuth]}"`, requiredRole: authlist[iAuth]})
				}
			}
			return next();
		})(req, res, next);
		
	}
}


module.exports = controller;
