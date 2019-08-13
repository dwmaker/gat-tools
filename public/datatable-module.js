angular.module('myApp').factory('Datatable', [
function()
{ 
	return function(obj)
	{
		var datatable = 
		{
			columns: [],
			filters:{},
			database: [],
			apply: function()
			{
				this.displaydata = this.database.filter((value) =>
				{
					var exibe = true;
					this.columns.forEach((col)=>
					{
						if (!(isNull(this.filters[col.name]) || value[col.name] == this.filters[col.name])) exibe = false;
					});
					return exibe;
				});

				/////////////////////////
				this.columns.forEach((col) =>
				{
					var columnName = col.name;
					var dist = {};
					this.database.forEach((row) =>
					{
						var exibe = true;
						Object.keys(this.filters)
						.filter((val)=> val != columnName)
						.forEach((val)=> 
						{
							if(!(isNull(this.filters[val]) || row[val] == this.filters[val])) exibe = false;
						});
						if(exibe)
						{
							dist[row[columnName]]++;
						}
					});
					col.list = Object.keys(dist).sort();
				});
			}
		};
		
		function isNull(val)
		{
			if(typeof val === "undefined") return true;
			if(val === "") return true;
			if(val === null) return true;
			return false;
		};
		
		["columns","filters","database"]
		.forEach((att)=>
		{
			if(!isNull(obj[att])) datatable[att] = obj[att];
		});
		
		return datatable;
	};
}]);