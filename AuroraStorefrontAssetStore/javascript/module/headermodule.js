var app = angular.module('home', ['autocomplete']);

app.controller('menu', function ($scope, $http) {
    // Makes the REST request to get the data to populate the grid.
   
        $http({
            url: 'http://localhost:80/search/resources/store/10203/categoryview/@top',
            method: 'GET',
            params: {
            	langId: WCParamJS.langId,
            	responseFormat: 'json',
            	catalogId: WCParamJS.catalogId,
            	depthAndLimit:'11,11'
            }
        }).success(function (data) {
           var  json_data= JSON.stringify(data);
           var tot = JSON.parse(json_data);
           console.log(tot);
           $scope.topcats = data.catalogGroupView;
          
        });
        
      
   

   
});


app.controller('search', function($scope, $http){

  
  $scope.doSearch = function(){
	  //alert($scope.searchtext);
	 if($scope.searchtext != 'undefined') {
	 if($scope.searchtext.length < 2){
		 $("#search .list_section").css('display','none');
	 }
	 if($scope.searchtext.length >= 2){
		 $("#search .list_section").css('display','block');
	  $http({
	        url: 'http://localhost:80/search/resources/store/10203/sitecontent/keywordSuggestionsByTerm/*',
	        method: 'GET',
	        params: {
	        	langId: WCParamJS.langId,
	        	responseFormat: 'json',
	        	searchTerm: $scope.searchtext,
	        	catalogId:WCParamJS.catalogId,
	        	
	        }
	    }).success(function (data) {
	      
	       console.log(data);
	     
	     
	    }); 
	 
	   
		  $http({
		        url: 'http://localhost:80/search/resources/store/10203/sitecontent/productSuggestionsBySearchTerm/*',
		        method: 'GET',
		        params: {
		        	langId: WCParamJS.langId,
		        	responseFormat: 'json',
		        	searchTerm: $scope.searchtext,
		        	catalogId:WCParamJS.catalogId,
		        	pageNumber:1,
		        	pageSize:4,
		        	
		        	
		        }
		    }).success(function (data) {
		       console.log(data);
		       
		       suggestion=data.suggestionView[0];
		       $scope.suggestion=suggestion;
		     
		    });
		  
	   
	    	$http({
		        url: ' http://localhost:80/search/resources/store/10203/sitecontent/suggestions',
		        method: 'GET',
		        params: {
		        	langId: WCParamJS.langId,
		        	responseFormat: 'json',
		        	catalogId:WCParamJS.catalogId,
		        }
		    }).success(function (data) {
		       console.log(data);
		       
		       categorysuggestion=data.suggestionView;
		       $scope.categorysuggestion=categorysuggestion;
		    });
  		}
  	}
  } 
  
});

app.controller('signin', function($scope, $http){
	 $scope.submitSignin = function(){
		// var configuratorUrl = SW.Properties.CMD.BASE + "AjaxLogon";
		 
	 }
});
