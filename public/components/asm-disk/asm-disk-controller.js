angular.module('myApp').controller('asm-disk-controller', ['$scope', '$http', 'asm-disk-service', 'Datatable',
function($scope, $http, asmdiskservice, Datatable)
{
	$scope.datatable = new Datatable(
	{
		columns:
		[
			{name: "host_name" },
			{name: "dg_number" },
			{name: "dg_name" },
			{name: "instance_name" },
			{name: "db_name" },
			{name: "software_version"},
			{name: "disk_name" },
			{name: "disk_path" },
		],
		database: asmdiskservice.getAsmDisks()
	});
	
	$scope.metadata = asmdiskservice.getMetadata();
	
	$scope.exportData = function () 
	{
		var options = 
		{
			headers: true,
			rows: 
			{
				1: 
				{ 
					style: 
					{ 
						Font: 
						{
							Color: "#FF0077"
						}
					}
				} 
			},
			columns: 
			[
				{ columnid: 'host_name', width: 139 },
				{ columnid: 'dg_number', width: 80 },
				{ columnid: 'dg_name', width: 218 },
				{ columnid: 'instance_name', width: 107 },
				{ columnid: 'db_name', width: 79 },
				{ columnid: 'software_version', width: 120 },
				{ columnid: 'disk_name', width: 260 },
				{ columnid: 'disk_path', width: 399 },

			],
			cells: 
			{
				1: 
				{
					1: 
					{
						style: { Font: { Color: "#00FFFF" } }
					}
				}
			}
		}; 
       alasql('SELECT * INTO XLSX("export.xlsx",?) FROM ?',[options, $scope.datatable.displaydata]);
    };
	
	$scope.datatable.apply();
}]);

