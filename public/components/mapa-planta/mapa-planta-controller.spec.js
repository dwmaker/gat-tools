describe('$scope.grade', 
function() 
{	var $controller, $rootScope;
	
	
	beforeEach(angular.mock.module('myApp'));
	beforeEach(inject(function(_$controller_, _$rootScope_)
	{
		$rootScope = _$rootScope_;
		$controller = _$controller_;
		
	}))

		
	it('oi', 
	function() 
	{
		let $scope  = $rootScope.$new();
		var controller = $controller('mapa-planta-controller', {$scope});
		$scope.save();
		
		console.log(Object.keys($scope))
		expect("strong").toEqual('strong');
	});
});
