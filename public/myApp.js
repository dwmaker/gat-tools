angular.module('myApp', ['ngRoute'])
.config(function($routeProvider, $locationProvider) 
{
	$routeProvider
	.when('/home', 
	{
		templateUrl: '/pages/home.html',
		controller: 'home-controller'
	})
	.when('/asm-disks', 
	{
		templateUrl: '/pages/asm-disk.html',
		controller: 'asm-disk-controller'
	})
	.when('/controle-acesso', 
	{
		templateUrl: '/pages/controle-acesso.html',
		controller: 'controle-acesso-controller'
	})
	.when('/versao-netsms', 
	{
		templateUrl: '/pages/versao-netsms.html',
		controller: 'versao-netsms-controller'
	})
	
	
	.otherwise({redirectTo: '/home'});

});