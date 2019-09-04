angular.module('myApp')
.controller("profile-controller", ["$scope", "profile",
function($scope, profile)
{
	$scope.profile = profile.data;
}]);