define(["angular"], function($) {
	 var myapp= angular.module('scopeExample', []);
	  
		myapp.controller('MyController', ['$scope', function($scope) {
		  $scope.username = 'World';

		  $scope.sayHello = function() {
		    $scope.greeting = 'Hello ' + $scope.username + '!';
		  };
		}]);
	   
		var shopperapp=angular.module('ShopperApp',[]);
		shopperapp.controller('Shopcartcontroller',['$scope', function($scope){
		                                            
		     alert("hello");    
		    var selectedAttributesList= new Object();
		     $scope.Add2ShopCartAjax = function(entitledItemId,quantity,isPopup,customParams) {
		    	 alert("button clicked   "+quantity+"--------"+entitledItemId+"---------"+isPopup+"----------"+customParams); 
		    	 if (angular.element(entitledItemId)!=null) {
		 			//the json object for entitled items are already in the HTML. 
		 			 entitledItemJSON = eval('('+ angular.element(entitledItemId).innerHTML +')');
		 			 alert(angular.element(entitledItemId));
		 		}else{
		 			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
		 			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
		 			entitledItemJSON = this.getEntitledItemJsonObject(); 
		 		}
		    	 var catalogEntryId = getCatalogEntryId(entitledItemId);
		     }
		     function getCatalogEntryId(entitledItemId){
					var attributeArray = [];
					var selectedAttributes = selectedAttributesList[entitledItemId];
					for(attribute in selectedAttributes){
						attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
					}
					return resolveSKU(attributeArray);
				}
		     function resolveSKU(attributeArray){
					console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
					var catentry_id = "";
					var attributeArrayCount = attributeArray.length;
					
					// if there is only one item, no need to check the attributes to resolve the sku
					if(this.entitledItems.length == 1){
						return this.entitledItems[0].catentry_id;
					}
					for(x in this.entitledItems){
						var catentry_id = this.entitledItems[x].catentry_id;
						var Attributes = this.entitledItems[x].Attributes;
						var attributeCount = 0;
						for(index in Attributes){
							attributeCount ++;
						}

						// Handle special case where a catalog entry has one sku with no attributes
						if (attributeArrayCount == 0 && attributeCount == 0){
							return catentry_id;
						}
						if(attributeCount != 0 && attributeArrayCount >= attributeCount){
							var matchedAttributeCount = 0;

							for(attributeName in attributeArray){
								var attributeValue = attributeArray[attributeName];
								if(attributeValue in Attributes){
									matchedAttributeCount ++;
								}
							}
							
							if(attributeCount == matchedAttributeCount){
								console.debug("CatEntryId:" + catentry_id + " for Attribute: " + attributeArray);
								return catentry_id;
							}
						}
					}
					return null;
				}
				
		                                            
		}]);
		
		
	   
	
   });

