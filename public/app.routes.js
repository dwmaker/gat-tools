angular.module("myApp")
.config(function($routeProvider, $locationProvider) 
{
	$routeProvider
	.when("/login", 
	{
		templateUrl: "/components/login/login-view.html",
		controller: "login-controller"
	})
	.when("/logoff", 
	{
		controller: "logoff-controller",
		template: "/logoff",
	})
	.when("/profile", 
	{
		templateUrl: "/components/profile/profile-view.html",
		controller: "profile-controller"
	})
	.when("/home", 
	{
		templateUrl: "/components/home/home-view.html",
		controller: "home-controller"
	})
	.when("/asm-disks", 
	{
		templateUrl: "/components/asm-disk/asm-disk-view.html",
		controller: "asm-disk-controller"
	})
	.when("/controle-acesso", 
	{
		templateUrl: "/components/controle-acesso/controle-acesso-list.html",
		controller: "controle-acesso-controller"
	})
	.when("/versao-netsms", 
	{
		templateUrl: "/components/versao-netsms/versao-netsms-view.html",
		controller: "versao-netsms-controller"
	})
	.when("/mapa-planta", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-list.html",
		controller: "mapa-planta-controller"
	})
	.otherwise({redirectTo: "/home"});
});