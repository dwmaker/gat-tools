angular.module('myApp').service('disk_service', 
['$http', 
function($http)
{
	this.getDisks = function()
	{
		var arr = [];
