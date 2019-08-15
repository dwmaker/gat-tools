"use strict";
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const {UNAUTHORIZED, INVALID_CREDENTIALS, INVALID_USER_ENTRY} = require("./errors");
const LoginDAO = require("./dao/login-dao.js");
const UserDAO = require("./dao/user-dao.js");
let securityschemas = {};
let loginDAO = new LoginDAO();
let userDAO = new UserDAO();

securityschemas.basicAuth = {};


securityschemas.basicAuth.strategy = 
new BasicStrategy(
	function(username, password, callback) 
	{
		
		loginDAO.find({ username: username })
		.then((login)=>
		{
			
			if (!login) 
			{
				return callback(new INVALID_USER_ENTRY(), undefined); 
			}	
			if (login.password != password)
			{
				
				return callback(new INVALID_CREDENTIALS(), undefined);
			}
			userDAO.find({ id: login.userId })
			.then((user)=>
			{
				return callback(undefined, user);
			})
			.catch((err)=>
			{
				
				return callback(err, undefined);
			})
		})
		.catch((err)=>
		{
			
			if(err instanceof NO_DATA_FOUND)
			{
				return callback(new INVALID_CREDENTIALS({err}), undefined);
			}
			else
			{
				return callback(err, undefined);
			}
		})
	}
);

securityschemas.basicAuth.authenticate = function (req)
{
	return new Promise((resolve, reject) =>
	{
		passport.authenticate('basicAuth', { session: false }, function(error, user, info)
		{
			if(error) return reject(error);
			if(typeof user != 'object') return reject(new UNAUTHORIZED());
			return resolve(user);
		})(req)
	})
};

module.exports = securityschemas;