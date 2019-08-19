angular.module("myApp")
.controller("logoff-controller", ["$scope", "authentication-service", "$location",
function($scope, authenticationService, $location)
{
	authenticationService.logoff()
	.then(() =>
	{
		$location.path("/home");
		$scope.$apply();
	})
	.catch((err)=>
	{
		$scope.data = err;
	});
}]);