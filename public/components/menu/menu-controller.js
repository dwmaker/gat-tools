angular.module("myApp").controller("menu-controller", ["$scope", "authentication-service", "$location",
function($scope, authenticationService, $location)
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
			
			$scope.$apply(function (){$location.path("/home");});
		})
		.catch((err)=>
		{
			$scope.data = err;
		});
	}
}]);

