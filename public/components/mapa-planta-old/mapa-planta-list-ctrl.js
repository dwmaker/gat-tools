angular.module("myApp").controller("mapa-planta-list-ctrl", ["$scope", "$location", "$routeParams", "mapa-planta-service",  "$uibModal", "$route", "list", "ambientes", "modelos",
function($scope, $location, $routeParams, mapaPlantaService, $uibModal,  $route, list, ambientes, modelos)
{
	$scope.list = list;
	$scope.ambientes = ambientes;
	$scope.orderBy = 'id';
	$scope.reverse = false;
	$scope.modelos = modelos;
	$scope.gotoEdit = function(id)
	{
		$location.path("/mapa-planta/:id/edit".replace(":id", id));
	};
	$scope.gotoCreate = function()
	{
		$location.path("/mapa-planta/add");
	};
	
	$scope.ordenar = function(campo)
	{
		if($scope.orderBy == campo) return $scope.reverse = !$scope.reverse;
		$scope.orderBy = campo;
		$scope.reverse = false;
	}
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
			if(['cancel', 'escape key press', 'backdrop click'].includes(err)) return false;
			throw err;
		});
	};
}]);
