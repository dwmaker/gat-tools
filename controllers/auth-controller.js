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
			
			authlist.forEach((authItem)=>
			{
				console.log({user, authItem})
			})
			
			next();
		})(req, res, next);
		
	}
}


module.exports = controller;
