'use strict';
const authService = require("../services/auth-service.js");
let controller = {};

controller.getProfile = function(req, res, next)
{
	authService.basicAuth(req, res, next)
	.then((user)=>
	{
		res.status("200").send(user);
	})
	.catch((err)=>
	{
		res.status("401").send(err);
	});
};

module.exports = controller;
