"use strict";
/// Aten��o: Este arquivo � gerado dinamicamente pelos refresh_jobs
angular.module('myApp').service('asm-disk-service', 
['$http', 
function($http)
{
	this.getDisks = function()
	{
		var disks = [];
