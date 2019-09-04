angular.module("myApp")
.config(function($routeProvider, $locationProvider) 
{
	$routeProvider
	.when("/login", 
	{
		templateUrl: "/components/login/login-view.html",
		controller: "login-controller",
	})
	.when("/logoff", 
	{
		controller: "logoff-controller",
		template: "/logoff",
	})
	.when("/perfil", 
	{
		templateUrl: "/components/profile/profile-view.html",
		controller: "profile-controller",
		resolve:
		{
			profile: ["api-client-service", function(apiClientService){ return apiClientService.Authentication.getCurrentUser()}]
		}
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
		controller: "mapa-planta-list-ctrl", 
		operation: "browse",
		security: [{"basicAuth": ["browse:datasource"]}],
		resolve:
		{
			list: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['M']})],
			ambientes: ["ambiente-service", (ambienteService) => ambienteService.list()],
			modelos: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['T']})],
		},
	})
	.when("/mapa-planta/:id/view", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-view.html",
		controller: "mapa-planta-object-ctrl", 
		operation: "view",
		security: [{"basicAuth": ["read:datasource"]}],
		resolve:
		{
			id: ["$route", $route => $route.current.params.id],
			object: ["$route", "mapa-planta-service", ($route, mapaPlantaService) => 
			{
				return mapaPlantaService.get($route.current.params.id)
			}],
			ambientes: ["ambiente-service", (ambienteService) => ambienteService.list()],
			modelos: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['T']})],
		},
	})
	.when("/mapa-planta/add", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-edit.html",
		controller: "mapa-planta-object-ctrl", 
		operation: "add",
		security: [{"basicAuth": ["add:datasource"]}],
		resolve:
		{
			id: () => null,
			object: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.new()],
			ambientes: ["ambiente-service", (ambienteService) => ambienteService.list()],
			modelos: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['T']})],
		},
	})
	.when("/mapa-planta/:id/edit", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-edit.html",
		controller: "mapa-planta-object-ctrl", 
		operation: "edit",
		security: [{"basicAuth": ["edit:datasource"]}],
		resolve:
		{
			id: ["$route", $route => $route.current.params.id],
			object: ["$route", "mapa-planta-service", ($route, mapaPlantaService) => 
			{
				return mapaPlantaService.get($route.current.params.id)
			}],
			ambientes: ["ambiente-service", (ambienteService) => ambienteService.list()],
			modelos: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['T']})],
		},
	})
	.when("/mapa-planta/:id/delete", 
	{
		templateUrl: "/components/mapa-planta/mapa-planta-delete.html",
		controller: "mapa-planta-object-ctrl", 
		operation: "delete",
		security: [{"basicAuth": ["delete:datasource"]}],
		resolve:
		{
			id: ["$route", $route => $route.current.params.id],
			object: ["$route", "mapa-planta-service", ($route, mapaPlantaService) => 
			{
				return mapaPlantaService.get($route.current.params.id)
			}],
			ambientes: ["ambiente-service", (ambienteService) => ambienteService.list()],
			modelos: ["mapa-planta-service", (mapaPlantaService) => mapaPlantaService.list({tp_mapa_in:['T']})],
		},
	})

	.otherwise({redirectTo: "/home"});
});