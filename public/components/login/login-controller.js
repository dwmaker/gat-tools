angular.module("myApp")
.controller("login-controller", ["$scope", "authentication-service", "$location",
function($scope, authenticationService, $location)
{
	$scope.login = function(email, password, rememberMe)
	{	
		authenticationService.login(email, password, rememberMe)
		.then((profile)=>
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