angular.module("myApp")
.controller("login-controller", ["$scope", "authentication-service", "$location", "$q",
function($scope, authenticationService, $location, $q)
{
	
	$scope.email = "paulo.ponciano@spread.com.br";
	$scope.password = "teste"
	$scope.login = function(email, password, rememberMe)
	{		
		$q(function(resolve, reject)
		{
			authenticationService.login(email, password, rememberMe)
			.then(resolve).catch(reject)
		})
		.then(function resolve(profile)
		{
			$location.path("/home");
		})
		.catch(function(err)
		{
			$scope.data = err;
		})
	}
}]);