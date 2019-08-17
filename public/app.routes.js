angular.module('myApp')
.config(function($routeProvider, $locationProvider) 
{
	$routeProvider
	.when('/home', 
	{
		templateUrl: '/components/home/home-view.html',
		controller: 'home-controller'
	})
	.when('/asm-disks', 
	{
		templateUrl: '/components/asm-disk/asm-disk-view.html',
		controller: 'asm-disk-controller'
	})
	.when('/controle-acesso', 
	{
		templateUrl: '/components/controle-acesso/controle-acesso-list.html',
		controller: 'controle-acesso-controller'
	})
	.when('/versao-netsms', 
	{
		templateUrl: '/views/versao-netsms.html',
		controller: 'versao-netsms-controller'
	})
	.when('/parametro-netsms', 
	{
		templateUrl: '/components/report-parametro-netsms/report-parametro-netsms-view.html',
		controller: 'report-parametro-netsms-controller'
	})
	.when('/profile', 
	{
		templateUrl: '/components/profile/profile-view.html',
		controller: 'profile-controller'
	})
	.when('/login', 
	{
		templateUrl: '/components/login/login-view.html',
		controller: 'login-controller'
	})
	.otherwise({redirectTo: '/home'});
});