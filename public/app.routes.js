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
		controller: "mapa-planta-controller", 
		operation: "browse",		
	})
	.when("/mapa-planta/:id/view", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-view.html",
		controller: "mapa-planta-controller", 
		operation: "view"
	})
	.when("/mapa-planta/add", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-edit.html",
		controller: "mapa-planta-controller", 
		operation: "add"
	})
	.when("/mapa-planta/:id/edit", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-edit.html",
		controller: "mapa-planta-controller", 
		operation: "edit"
	})
		.when("/mapa-planta/:id/delete", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-delete.html",
		controller: "mapa-planta-controller", 
		operation: "delete"
	})

	.otherwise({redirectTo: "/home"});
});