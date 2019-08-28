"use strict";
const { validationResult } = require("express-validator");
const {INVALID_USER_ENTRY} = require("../errors");

function controller(validations) 
{
	return async (req, res, next) => 
	{
		await Promise.all(validations.map(validation => validation.run(req)));
		const errors = validationResult(req);
		if (errors.isEmpty()) 
		{
			return next();
		}
		
		let err = new INVALID_USER_ENTRY({errors:errors.array({ onlyFirstError: true })});
		res.status(err.status).send(err);
			
		
	};
};

module.exports = controller;