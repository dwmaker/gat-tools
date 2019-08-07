'use strict';
const fs = require('fs');
const jsyaml = require('js-yaml');
const path = require('path');
const ejs = require("ejs");
var util = require('util');



	

function loadEjs(ejs_path, ejs_encode)
{
	return new Promise((resolve, reject)=>
	{
		fs.readFile(ejs_path, ejs_encode, 
		function (err, ejs_data) 
		{
			if (err) return reject(err); 
			return resolve(ejs.compile(ejs_data));
		});
	});
}
async function init()
{
	var spec = fs.readFileSync(`${__dirname}/swagger.yaml`, 'utf8');
	var swaggerDoc = jsyaml.safeLoad(spec);
	let swUtil = parseSwagger(swaggerDoc);
	let genlist = 
	[
		{"code": "api-server-router"    , "scope-list": swUtil.documents  , "maskfile-body": "templates/default/api-server-router.ejs"    , "mask-path": "api-router.js"},
		{"code": "api-server-controller", "scope-list": swUtil.controllers, "maskfile-body": "templates/default/api-server-controller.ejs", "mask-path": "controllers/<%=scope.controlCode%>.js"},
		{"code": "api-server-service"   , "scope-list": swUtil.controllers, "maskfile-body": "templates/default/api-server-service.ejs"   , "mask-path": "services/<%=scope.controlCode%>.js"},
		{"code": "api-client-service"   , "scope-list": swUtil.documents  , "maskfile-body": "templates/default/api-client-service.ejs"   , "mask-path": "public/services/api-client-service.js"},
	];

	genlist
	.forEach((gen) => 
	{
		gen["scope-list"].forEach((scope)=>
		{
			scope[gen.code] = ejs.compile(gen["mask-path"])({scope, swUtil, path, JSON});
			console.log(scope)
			//newfile.body = ejs.compile(fs.readFileSync(gen["maskfile-body"], 'utf8'))(newfile);
			//fs.writeFileSync(newfile.filename, newfile.body, 'utf8');  
		})
	});
	
	genlist
	.forEach((gen) => 
	{
		gen["scope-list"].forEach((scope)=>
		{
			const codegenmark ="@CodeGeneratorOverwrite: enabled"
			
			let filename = scope[gen.code];
			if(fs.existsSync(filename))
			{
				let old = fs.readFileSync(filename);
				if(!old.includes(codegenmark)) 
				{
					console.log("ignorado", filename);
					return false;
				}
			};
			let body = ejs.compile(fs.readFileSync(gen["maskfile-body"], 'utf8'))({scope,  swUtil, path, JSON});
			console.log("criando", filename)
			fs.writeFileSync(filename, body, 'utf8');  
		});
	});
}

function parseSwagger(swaggerDoc)
{
	let swUtil = 
	{
		controllers:[], 
		operations: [], 
		paths: [], 
		parameters: [], 
		documents:[],
		angularModuleName: "myApp"
	};
	
	// documents
	swUtil.documents.push({});
	// controllers
	for(let pathkey in swaggerDoc.paths) 
	{
		for(let methodkey in swaggerDoc.paths[pathkey]) 
		{
			let operationId = swaggerDoc.paths[pathkey][methodkey].operationId;
			let swControl = 
			{
				controlCode: swaggerDoc.paths[pathkey][methodkey]["x-swagger-router-controller"]
			};
			if(swUtil.controllers.filter(c => c.controlCode == swControl.controlCode).length == 0) swUtil.controllers.push(swControl);
		};
	};
	
	// operations
	for(let pathkey in swaggerDoc.paths) 
	{
		for(let methodkey in swaggerDoc.paths[pathkey]) 
		{
			let swOperation = 
			{
				method: methodkey,
				path: pathkey,
				operationCode: swaggerDoc.paths[pathkey][methodkey].operationId, 
				controlCode: swaggerDoc.paths[pathkey][methodkey]["x-swagger-router-controller"]
			};
			if(swUtil.operations.filter(c => c.operationCode == swOperation.operationCode && c.controlCode == swOperation.controlCode).length==0) swUtil.operations.push(swOperation);
		};
	};
	
	// parameters
	for(let pathkey in swaggerDoc.paths) 
	{
		for(let methodkey in swaggerDoc.paths[pathkey]) 
		{
			swaggerDoc.paths[pathkey][methodkey].parameters.forEach((p, index)=>
			{
				let parameter =
				{ 
					name:     p.name,
					in:       p.in,
					required: p.required,
					style:    p.style,
					explode:  p.explode,
					schema:   p.schema,
					method:   methodkey,
					path:     pathkey,
					index:    index,
					operationCode: swaggerDoc.paths[pathkey][methodkey].operationId, 
					controlCode: swaggerDoc.paths[pathkey][methodkey]["x-swagger-router-controller"],
				};
				swUtil.parameters.push(parameter);
			});			
		};
	};
	return swUtil;
}

init()
.then((data)=>{console.log("sucesso")})
.catch((err)=>{console.error(err)})

//////////////////////////////////////////////////////////




function apiClientService(req, res)
{
	const crlf = "\r\n";
	const tab = "\t";
	let i=0;
	let serviceClassName = req.options.serviceName.split("-").map(name=>name.charAt(0).toUpperCase() + name.slice(1)).join("");
	res.write(tab.repeat(i) + "'use strict';" + crlf)
	res.write(tab.repeat(i) + "/**" + crlf);
	res.write(tab.repeat(i) + "* @class " + serviceClassName + crlf);
	res.write(tab.repeat(i) + "* @memberOf angular_module." + req.options.moduleName + crlf);
	res.write(tab.repeat(i) + "* @description " + req.data.info.description + crlf);
	res.write(tab.repeat(i) + "*/" + crlf);
	res.write(tab.repeat(i) + 'angular.module('+JSON.stringify(req.options.moduleName)+').service('+JSON.stringify(req.options.serviceName)+', ["$http", ' + crlf)
	res.write(tab.repeat(i) + 'function($http)' + crlf)
	res.write(tab.repeat(i++) +'{' + crlf)
	Object.keys(req.data.paths).forEach((pathKey)=>
	{
		let path = req.data.paths[pathKey]
		Object.keys(req.data.paths[pathKey]).forEach((methodKey)=>
		{
			let method = path[methodKey];
			let baseUrl = "";
			if(req.data.servers) if(req.data.servers[0]) if(req.data.servers[0].url) baseUrl = req.data.servers[0].url;
			res.write(tab.repeat(i) + "/**" + crlf);
			res.write(tab.repeat(i) + "* @function " + method.operationId + crlf);
			res.write(tab.repeat(i) + "* @memberOf angular_module." + req.options.moduleName + "." + serviceClassName + crlf);
			res.write(tab.repeat(i) + "* @description " + req.data.info.description + crlf);
			res.write(tab.repeat(i) + "*/" + crlf);
			res.write(tab.repeat(i) + 'this.' + method.operationId + ' = function(' + method.parameters.map((param)=>param.name).join(', ') + ')' + crlf)
			res.write(tab.repeat(i++) + '{'  + crlf)
			res.write(tab.repeat(i) + 'let opt = '  + crlf)
			res.write(tab.repeat(i++) + '{'  + crlf)
			res.write(tab.repeat(i) + '"method": ' + JSON.stringify(methodKey.toUpperCase()) + ', ' + crlf)
			res.write(tab.repeat(i) + '"url": ' + JSON.stringify(baseUrl + pathKey) + method.parameters.filter((param)=>param.in=='path').map((param)=>'.replace(' + JSON.stringify("{"+param.name+"}") + ', ' + param.name + ')').join('') + ',' + crlf);
			res.write(tab.repeat(i) + '"params": '  + crlf)
			res.write(tab.repeat(i++) + '{'  + crlf)
			res.write(method.parameters.filter((param)=>param.in=='query').map((param)=> tab.repeat(i) + JSON.stringify(param.name) + ': ' + param.name+','+ crlf).join('') )
			res.write(tab.repeat(--i) + '}, ' + crlf)
			res.write(method.parameters.filter((param)=>param.in=='body').map((param)=>'				data: ' + JSON.stringify(param.name) + ','+ crlf).join(''))
			res.write(tab.repeat(--i) + '};' + crlf)
			res.write(tab.repeat(i) + 'return $http(opt);'+ crlf)
			res.write(tab.repeat(--i) + '};' + crlf);
			res.write('' + crlf)
		})
	})
	res.write(tab.repeat(--i) +'}]);' + crlf);
	res.end();
};



