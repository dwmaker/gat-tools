"use strict";
const express = require('express');
const morgan = require('morgan');
const Datasource = require("./controllers/datasource-controller.js");
const Application = require("./controllers/application-controller.js");
const NetsmsVersion = require("./controllers/netsms-version-controller.js");
const NetsmsParameter = require("./controllers/netsms-parameter-controller.js");
const Profile = require("./controllers/profile-controller.js");
const Accesscontrol = require("./controllers/accesscontrol-controller.js");
const Asm = require("./controllers/asm-controller.js");
let router = express.Router();
router.use(morgan('dev'));
 
router.get("/datasources", Datasource.listDatasources );
router.get("/datasources/:datasourceCode", Datasource.getDatasource ); 
router.put("/datasources/:datasourceCode", Datasource.updateDatasource ); 
router.post("/datasources", Datasource.createDatasource );
router.delete("/datasources/:datasourceCode", Datasource.deleteDatasource ); 

router.get("/applications", Application.listApplications ); 
router.get("/cenarios", Application.listCenarios ); 
router.get("/environments", Application.listEnvironments ); 
router.get("/netsms-version/:datasourceCode", NetsmsVersion.listNetsmsVersion ); 
router.get("/netsms-parameter/:datasourceCode", NetsmsParameter.listNetsmsParameter ); 
router.get("/profile",  Profile.getProfile ); 
router.get("/accesscontrols", Accesscontrol.getMetadata);
router.get("/accesscontrols/:datasourceCode", Accesscontrol.listAccesscontrols ); 
router.get("/asm-disks/:datasourceCode", Asm.listAsmdisks );

module.exports = router;