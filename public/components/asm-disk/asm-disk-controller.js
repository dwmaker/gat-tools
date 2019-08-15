angular.module('myApp').controller('asm-disk-controller', ['$scope', 'asm-disk-service', 'Datatable', 'api-client-service',
function($scope, asmDiskService, Datatable, apiClientService)
{
	$scope.datatable = new Datatable(
	{
		columns:
		[
			{ name: 'hostName'    , width: 139 },
			{ name: 'diskgroupNumber'    , width: 80 },
			{ name: 'diskgroupName'      , width: 218 },
			{ name: 'instanceName', width: 107 },
			{ name: 'databaseName'      , width: 79 },
			{ name: 'softwareVersion', width: 120 },
			{ name: 'name', width: 260 },
			{ name: 'path', width: 399 },			
		]
	});
	
	$scope.$watch('progress', function() 
	{
		
	});
	
	$scope.progress = 0.01;
	$scope.messages=[];
	apiClientService.DatasourceController.listDatasources("asm")
	.then(
	(res)=>
	{
		
		let count = 0;
		let db = [];
		let promises = res.data.map((row)=>
		{
			let promise = apiClientService.AsmController.listAsmdisks(row.code);
			promise
			.then((res)=> 
			{
				count = count+1;
				$scope.progress = (count / promises.length);
				db = db.concat(res.data);
				if(count == promises.length) 
				{
					$scope.datatable.database = db;
					$scope.datatable.apply();
					$scope.progress = false;
				}
			})
			.catch((res)=>
			{
				count = count+1;
				$scope.progress = (count / promises.length);
				$scope.messages[$scope.messages.length] = {"status":"danger", "title": row.code, "text": res.statusText};
				if(count == promises.length) 
				{
					$scope.datatable.database = db;
					$scope.datatable.apply();
					$scope.progress = false;
				}
			})
			return promise; 
		});
	})
	.catch(
	(err)=>
	{
		console.error(err);
	})
	
	$scope.exportData = function ()
	{
		var options = 
		{
			headers: true
		}; 
		alasql('SELECT * INTO XLSX(?,?) FROM ?',["export.xlsx", options, $scope.datatable.displaydata]);
	};
	
	
}]);

