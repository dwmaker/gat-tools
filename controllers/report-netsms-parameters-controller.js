'ues strict';
const service = require("../services/report-netsms-parameters-service.js");
let controller = {};
controller.reportNetsmsParameters = function(req, res, next)
{
	service.reportNetsmsParameters()
	.then((data)=>
	{
		return res.status(200).send(data);
	})
	.catch((error)=>
	{
		return res.status(500).send(error);
	})
};
module.exports = controller;