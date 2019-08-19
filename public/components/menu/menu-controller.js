angular.module("myApp").controller("menu-controller", ["$scope", "authentication-service",
function($scope, authenticationService)
{
	$scope.getProfile = authenticationService.getProfile;
	$scope.checkAuths = function(param)
	{
		return authenticationService.checkAuths(param);
	}
	$scope.logoff = function()
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
	}
}]);

