angular.module("myApp", ["ngRoute", "ui.bootstrap", "base64", "ngCookies", 'ns.filter.unique'])
.config(['$provide', function($provide) {
	var DEFAULT_TIMEZONE = 'GMT-0300';
	$provide.decorator('dateFilter', ['$delegate', '$injector', 
	function($delegate, $injector) 
	{
		var oldDelegate = $delegate;
		var standardDateFilterInterceptor = 
		function(date, format, timezone) 
		{
			if(angular.isUndefined(timezone)) 
			{
				timezone = DEFAULT_TIMEZONE;
			}
			return oldDelegate.apply(this, [date, format, timezone]);
		};
		return standardDateFilterInterceptor;
	}]);
}])
