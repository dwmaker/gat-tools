angular.module("myApp").controller("mapa-planta-controller", ["$scope", "$location", "$routeParams", "mapa-planta-service",  "$uibModal", "ambiente-service", "$route",
function($scope, $location, $routeParams, mapaPlantaService, $uibModal, ambienteService, $route)
{
	async function init()
	{
		$scope.operation = $route.current.$$route.operation;
		if($scope.operation == "browse")
		{
			$scope.list = await mapaPlantaService.list({tp_mapa_in:['M']});
		}
		else if($scope.operation == "read")
		{
			$scope.id = $routeParams.id;
			$scope.data = await mapaPlantaService.get($routeParams.id);
			
		}
		else if($scope.operation == "edit")
		{
			$scope.id = $routeParams.id;
			$scope.templates = await mapaPlantaService.list({tp_mapa_in:['T']});
			$scope.data = await mapaPlantaService.get($routeParams.id);
			$scope.id_mapa_template_change();
		}
		else if($scope.operation == "add")
		{
			$scope.id = null;
			$scope.templates = await mapaPlantaService.list({tp_mapa_in:['T']});
			$scope.data = {tecnologias:{}, tp_mapa:'M'};
		}
		else if($scope.operation == "delete")
		{
			$scope.id = $routeParams.id;
			$scope.data = await mapaPlantaService.get($routeParams.id);
		}
		else
		{
			throw new Error(`operação "${$scope.operation}" não reconhecida`)
		}
		$scope.ambientes = await ambienteService.list();
	};
	
	$scope.id_mapa_template_change = function()
	{
		if($scope.data.id_mapa_template) 
		{
			mapaPlantaService.get($scope.data.id_mapa_template)
			.then(function(val)
			{
				$scope.template =  val;
				
			})
			.catch(function(val)
			{
				$scope.messages = [val];
			})
		}
		else
		{
			$scope.template = null;
		}
	};
	
	init()
	.then(function()
	{
		$scope.$apply()
	})
	.catch(function(err)
	{
		$scope.messages = err.data
		$scope.$apply()
	});
	$scope.callEditRoute = function(id)
	{
		$location.path("/mapa-planta/:id/edit".replace(":id", id));
	};
	$scope.gotoCreate = function(id)
	{
		$location.path("/mapa-planta/add");
	};
	$scope.save = function()
	{
		if($scope.operation == "edit")
		{
			mapaPlantaService.update($scope.id, $scope.data)
			.then(function(data)
			{
				console.log(data)
			})
			.catch(function(err)
			{
				throw err
			})
		}
		else if($scope.operation == "add")
		{
			mapaPlantaService.add($scope.data)
			.then(function(id)
			{
				$scope.callEditRoute(id);
				$scope.$apply();
			})
			.catch(function(err)
			{
				$scope.messages = err.data.errors;
				$scope.$apply();
			})
		}
		else
		{
			throw new Error(`operação "${$scope.operation}" não reconhecida`)
		};
	};
	$scope.modalDelete = function(irow)
	{
		var modalInstance = $uibModal.open(
		{
			animation: true,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: "components/mapa-planta/modal-delete-mapa-planta.html",
			controllerAs: "modal",
			controller: ["$uibModalInstance",
			function($uibModalInstance)
			{
				let modal = this;
				modal.row = $scope.list[irow];
				modal.ok = function()
				{
					mapaPlantaService.delete(modal.row.id)
					.then(function()
					{
						$uibModalInstance.close();
					})
					.catch(function(err)
					{
						$uibModalInstance.dismiss(err);
					});
				}
				this.cancel = function()
				{
					$uibModalInstance.dismiss('cancel');
				}
			}]
		});
		modalInstance.result
		.then(function(res)
		{
			$scope.list.splice(irow,1)
		})
		.catch(function(err)
		{
			throw err
		});
	};
	$scope.modalDeleteMapaUsuario = function(cd_tecnologia, cd_servidor, username)
	{
		alert(JSON.stringify({cd_tecnologia, cd_servidor, username}))
	}
	$scope.modalAddMapaServidor = function()
	{
		
		
		
		
		var modalInstance = $uibModal.open(
		{
			animation: true,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: "components/mapa-planta/modal-add-mapa-servidor.html",
			controller: ["$uibModalInstance",
			function($uibModalInstance)
			{
				let modal = this;
				
				modal.listModelTecnologia = function()
				{
					if(!$scope.template) return [];
					if(!$scope.template.tecnologias) return [];
					return Object.keys($scope.template.tecnologias);
				};
				modal.listModelServidor = function(cd_tecnologia)
				{
					if(!$scope.template) return [];
					if(!$scope.template.tecnologias) return [];
					if(!$scope.template.tecnologias[cd_tecnologia]) return [];
					return Object.keys($scope.template.tecnologias[cd_tecnologia]);
				};
				modal.ok = function()
				{
					if(typeof $scope.data.tecnologias[modal.cd_tecnologia] === "undefined") $scope.data.tecnologias[modal.cd_tecnologia] = {};
					$scope.data.tecnologias[modal.cd_tecnologia][modal.cd_servidor] = {usuarios:{}}
					$uibModalInstance.close();
				}
				modal.cancel = function()
				{
					$uibModalInstance.close();
				}
			}],
			controllerAs: 'modal'
		});
		modalInstance.result
		.then(function(modal)
		{
		})
		.catch(function(err)
		{
			console.error(err)
		});
	};
	$scope.modalAddMapaUsuario = function(cd_tecnologia, cd_servidor)
	{
		alert
		var modalInstance = $uibModal.open(
		{
			animation: true,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: "components/mapa-planta/modal-add-mapa-usuario.html",
			controller: ["$uibModalInstance",
			function($uibModalInstance)
			{
				let modal = this;
				modal.ok = function()
				{
					$uibModalInstance.close({"username": modal.username, "password": modal.password});
				};
				modal.cancel = function()
				{
					$uibModalInstance.dismiss('cancel');
				};
			}],
			controllerAs: 'modal'
		});
		modalInstance.result
		.then(function(res)
		{
			$scope.data.tecnologias[cd_tecnologia][cd_servidor].usuarios[res.username] = res.password;
		})
		.catch(function(err) {console.log(err)});
	};
	$scope.filtrar = function(filtro)
	{
		return function(object)
		{
			if(typeof filtro.plantSchemaCode !== "undefined") if(object.plantSchemaCode != filtro.plantSchemaCode) return false;
			if(typeof filtro.code !== "undefined") if(object.code != filtro.code) return false;
			return true;
		}
	}
}]);
