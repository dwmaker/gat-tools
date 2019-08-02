var oracledb = require('oracledb');
var config_asm = require("../config_asm.json");
module.exports = 
{
	getDatasources: async function (param)
	{
		return Object.keys(config_asm).map(key=>{return {code: key, type: "asm"}});
	},
	getAsmdisks: async function (param)
	{
		let connection;
		try
		{
			if (typeof config_asm[param.datasourceCode] === "undefined") throw new Error("Invalid Datasource Code " +param.datasourceCode+ "")
			connection = await oracledb.getConnection(config_asm[param.datasourceCode]);
			var selectStatement = 
			'select \r\n' +
			'(select host_name from v$instance) "hostName", \r\n' + 
			'dg.group_number "diskgroupNumber", \r\n' +
			'dg.name "diskgroupName", \r\n' +
			'dg.instance_name "instanceName", \r\n' +
			'dg.db_name "databaseName", \r\n' +
			'dg.software_version "softwareVersion", \r\n' +
			'dsk.name "name", \r\n' +
			'dsk.path "path" \r\n' +
			'from \r\n' +
			'v$asm_disk dsk  \r\n' +
			'join  \r\n' +
			'( \r\n' +
			'    select  \r\n' +
			'    dg.group_number,  \r\n' +
			'    cli.software_version,  \r\n' +
			'    cli.db_name,  \r\n' +
			'    cli.instance_name,  \r\n' +
			'    dg.name  \r\n' +
			'    from   \r\n' +
			'    v$asm_diskgroup dg  \r\n' +
			'    join v$asm_client cli on dg.group_number = cli.group_number \r\n' +
			') dg on dsk.group_number = dg.group_number \r\n' +
			'order by \r\n' +
			'"diskgroupNumber", \r\n' +
			'"databaseName", \r\n' +
			'"name"';
			var x = await connection.execute( selectStatement, [], {outFormat: oracledb.OBJECT})
			return x.rows;
		} 
		catch(err) 
		{
			console.log("Error: ", err);
			throw err;
		} 
		finally 
		{
			if (connection) 
			{
				try 
				{
					await connection.close();
				} 
				catch(err) 
				{
					console.log("Error when closing the database connection: ", err);
					throw err;
				}
			}
		}
	}
};


