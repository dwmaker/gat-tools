angular.module('myApp')
.controller("profile-controller", ["$scope","api-client-service",
function($scope, apiClientService)
{
	$scope.messages=[];
	apiClientService.Authentication.getCurrentUser()
	.then((res) =>
	{
		$scope.profile = res.data;
	})
	.catch((res) =>
	{
		$scope.messages.push(res.data);
	})
}]);