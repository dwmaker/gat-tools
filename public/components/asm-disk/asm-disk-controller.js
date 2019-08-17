angular.module('myApp').controller('asm-disk-controller', ['$scope', 'asm-disk-service', 'Datatable', "asm-disk-service",
function($scope, asmDiskService, Datatable, asmDiskService)
{
	$scope.datatable = new Datatable(
	{
		columns:
		[
			{ name: 'cd_conexao'    , width: 139 },	
			{ name: 'host_name'    , width: 139 },
			{ name: 'dg_number'    , width: 80 },
			{ name: 'dg_name'      , width: 218 },
			{ name: 'instance_name', width: 107 },
			{ name: 'db_name'      , width: 79 },
			{ name: 'software_version', width: 120 },
			{ name: 'disk_name', width: 260 },
			{ name: 'disk_path', width: 399 },	
			
		]
	});
	
	$scope.$watch('progress', function() 
	{
		
	});
	
	$scope.progress = 0.01;
	$scope.messages=[];
	$scope.datatable.database = asmDiskService.getAsmDisks();
	$scope.metadata = asmDiskService.getMetadata();
	$scope.datatable.apply()
	$scope.progress = 1.00;
	
	$scope.exportData = function ()
	{
		var options = 
		{
			headers: true
		}; 
		alasql('SELECT * INTO XLSX(?,?) FROM ?',["export.xlsx", options, $scope.datatable.displaydata]);
	};
	
	
}]);

