    
	var app = angular.module('template', []);

	app.controller('homeCtrl', function($scope) {
	  $scope.items1 = [1,2,3,4,5];
	  $scope.items2 = [1,2,3,4,5,6,7,8,9,10];
	}).directive("owlCarousel", function() {
	    return {
	        restrict: 'E',
	        transclude: false,
	        link: function (scope) {
	            scope.initCarousel = function(element) {
	              // provide any default options you want
	                var defaultOptions = {
	                };
	                var customOptions = scope.$eval($(element).attr('data-options'));
	                // combine the two options objects
	                for(var key in customOptions) {
	                    defaultOptions[key] = customOptions[key];
	                }
	                // init carousel
	                $(element).owlCarousel(defaultOptions);
	            };
	        }
	    };
	})
	.directive('owlCarouselItem', [function() {
	    return {
	        restrict: 'A',
	        transclude: false,
	        link: function(scope, element) {
	          // wait for the last item in the ng-repeat then call init
	            if(scope.$last) {
	                scope.initCarousel(element.parent());
	            }
	        }
	    };
	}]);
   
    


