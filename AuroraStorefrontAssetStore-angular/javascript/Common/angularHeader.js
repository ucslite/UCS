var app = angular.module('home', []);

app.controller('categoryList', function ($scope, $http) {
	alert('hello');
    // Makes the REST request to get the data to populate the grid.
   
        $http({
            url: 'http://localhost:80/search/resources/store/10203/categoryview/@top',
            method: 'GET',
            params: {
            	langId: -1,
            	responseFormat: 'json',
            	catalogId: 10001,
            	depthAndLimit:'11,11'
            }
        }).success(function (data) {
           alert('hii');
           
           var  json_data= JSON.stringify(data);
           
           var tot = JSON.parse(json_data);
           console.log(tot);
           
           
           
           $scope.topcats = data.catalogGroupView;
         
          
        });
        
      
   

   
});