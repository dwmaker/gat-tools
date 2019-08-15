"use strict";
const securityController = require("./security-controller.js")
let controller = {};

controller.getProfile = 
[
	securityController([{"basicAuth": ["read:profile"]}]),
	function(req, res, next)
	{
		res.status("200").send(req.user);
	}
];

module.exports = controller;
