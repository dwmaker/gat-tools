angular.module("myApp").controller("menu-controller", ["$scope", "authentication-service",
function($scope, authenticationService)
{
	$scope.getProfile = authenticationService.getProfile;
}]);

