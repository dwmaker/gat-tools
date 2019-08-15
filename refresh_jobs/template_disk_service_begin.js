angular.module('myApp').service('asm-disk-service', 
['$http', 
function($http)
{
	this.getDisks = function()
	{
		var arr = [];
