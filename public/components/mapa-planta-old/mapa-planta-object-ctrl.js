angular.module("myApp").controller("mapa-planta-object-ctrl", ["$scope", "$location",  "mapa-planta-service",  "$uibModal", "id", "object", "ambientes", "modelos",
function($scope, $location, mapaPlantaService, $uibModal,  id, object, ambientes, modelos) {
	$scope.id = id;
	$scope.data = object;
	$scope.ambientes = ambientes;
	$scope.modelos = modelos;

	
	$scope.gotoEdit = function(id) {
		$location.path("/mapa-planta/:id/edit".replace(":id", id));
	};
	$scope.save = function() {
		if($scope.id) {
			mapaPlantaService.update($scope.id, $scope.data)
			.then(function(data) {
				//console.log(data)
			})
			.catch(function(err) {
				throw err
			})
		}
		else {
			mapaPlantaService.add($scope.data)
			.then(function(res)
			{
				$scope.gotoEdit(res.data.id);
			})
			.catch(function(err)
			{
				$scope.messages = err;
			})
		};
	};
	
	$scope.modalDelete = function(irow) {
		var modalInstance = $uibModal.open(
		{
			animation: true,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: "components/mapa-planta/modal-delete-mapa-planta.html",
			controllerAs: "modal",
			controller: ["$uibModalInstance", function($uibModalInstance) {
				let modal = this;
				modal.row = $scope.list[irow];
				modal.ok = function() {
					mapaPlantaService.delete(modal.row.id)
					.then(function() {
						$uibModalInstance.close();
					})
					.catch(function(err) {
						$uibModalInstance.dismiss(err);
					});
				}
				this.cancel = function() {
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
			if(['cancel', 'escape key press', 'backdrop click'].includes(err)) return false;
			throw err;
		});
	};
	$scope.modalDeleteMapaUsuario = function(cd_tecnologia, cd_servidor, username)
	{
		delete $scope.data.tecnologias[cd_tecnologia][cd_servidor].usuarios[username];
	}
	$scope.modalAddMapaServidor = function()
	{
		var modalInstance = $uibModal.open(
		{
			animation: true,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: "components/mapa-planta/modal-add-mapa-servidor.html",
			resolve:
			{
				template: function()
				{
					if (!$scope.data.id_mapa_template) return null;
					return mapaPlantaService.get($scope.data.id_mapa_template)
				}
			},
			controller: ["$uibModalInstance", "template",
			function($uibModalInstance, template)
			{
				let modal = this;
				modal.listModelTecnologia = function()
				{
					if(!template) return [];
					if(!template.tecnologias) return [];
					return Object.keys(template.tecnologias);
				};
				modal.listModelServidor = function(cd_tecnologia)
				{
					if(!template) return [];
					if(!template.tecnologias) return [];
					if(!template.tecnologias[cd_tecnologia]) return [];
					return Object.keys(template.tecnologias[cd_tecnologia]);
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
			if(['cancel', 'escape key press', 'backdrop click'].includes(err)) return false;
			throw err;
		});
	};
	$scope.modalAddMapaUsuario = function(cd_tecnologia, cd_servidor)
	{
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
		.catch(function(err)
		{
			if(['cancel', 'escape key press', 'backdrop click'].includes(err)) return false;
			throw err;
		});
	};
}]);
