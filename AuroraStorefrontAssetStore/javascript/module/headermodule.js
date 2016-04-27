var app = angular.module('home', ['autocomplete']);
//Menu starts
app.controller('menu', function ($scope, $http,$location) {
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

//Menu ends
//Search starts
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

//Search ends

//Login Starts
app.controller('signin', function($scope, $http,$httpParamSerializer){
			var cookieDomain = "";	
			$scope.InitHTTPSecure= function(){
				var href = document.location.href;
				var index = href.lastIndexOf("s", 4);
				
				if (index != -1){
					// Open sign in panel if loaded with HTTPS.
					//GlobalLoginJS.displayPanel(widgetId);
					
				}else{
					// Loaded with HTTP			
					var newHref = href.substring(0,4) + "s" + (href.substring(4));
					setCookie("WC_DisplaySignInPanel_"+WCParamJS.storeId, "true" , {path:'/', domain:cookieDomain});
					window.location = newHref;
					return;
			} 
			}
			$scope.deleteUserLogonIdCookie= function(){
				 
				 var userLogonIdCookie = getCookie("WC_LogonUserId_"+WCParamJS.storeId);
				
				 if( userLogonIdCookie != null){
					setCookie("WC_LogonUserId_"+WCParamJS.storeId, null, {expires:-1,path:'/', domain:cookieDomain});
				 }	
				 setCookie("WC_BuyOnBehalf_"+WCParamJS.storeId, null, {path: '/', expires: -1, domain:cookieDomain});
			 }
			$scope.logout= function(url){
				setDeleteCartCookie();
				document.location.href = url;
			}
			function setDeleteCartCookie(){
				setCookie("WC_DeleteCartCookie_"+WCParamJS.storeId, true, {path:'/', domain:cookieDomain});
			}
			 function getCookie(c) {
					var cookies = document.cookie.split(";");
					for (var i = 0; i < cookies.length; i++) {
						var index = cookies[i].indexOf("=");
						var name = cookies[i].substr(0,index);
						name = name.replace(/^\s+|\s+$/g,"");
						if (name == c) {
							return decodeURIComponent(cookies[i].substr(index + 1));
						}
					}
				}
			 
			 
			 function setCookie(cookieName, cookieVal, props)
				{
					if(!props){
						
						$.cookie(cookieName, cookieVal);
						
					}
					else{
						var cookieProps = props;
						for (var propName in cookieProps) {
							  if (!cookieProps[propName]) {
							    delete cookieProps[propName];
							  }
						}
						$.cookie(cookieName, cookieVal,cookieProps);
					}
				}
		 $scope.submitSignin = function(form){
			
			 var postData = {
			           formId: form.id,
			           requesttype: "ajax",
			           reLogonURL:form.reLogonURL,
			           URL:form.URL,
			           logonId:form.logonId,
			           logonPassword:form.password,
			           calculationUsageId:form.calculationUsageId,
			           catalogId:WCParamJS.catalogId,
			           continue:form.continue,
			           createIfEmpty:form.createIfEmpty,
			           deleteIfEmpty:form.deleteIfEmpty,
			           errorViewName:form.errorViewName,
			           fromOrderId:form.fromOrderId,
			           storeId:WCParamJS.storeId,
			           toOrderId:form.toOrderId,
			           previousPage:form.previousPage,
			           myAcctMain:form.myAcctMain,
			           returnPage:form.returnPage,
			         };
			 var configuratorUrl = "https://localhost/webapp/wcs/stores/servlet/AjaxLogon";
			  $http.post(
			           configuratorUrl,
			             $httpParamSerializer( postData ), {
			               headers: {
			                 'Content-Type': 'application/x-www-form-urlencoded'
			               }
			           })
			           .success( function( data ) {
			        	 var logindata= ParseCommentedJSON(data);
			        	 console.log(logindata.URL+"--------------");
			        	 var furl=logindata.URL;
			        	 var url = furl.toString().replace(/&amp;/g, '&');
			 			var languageId = logindata.langId;
			 			
			 			/*if(languageId!=null && document.getElementById('langSEO'+languageId)!=null){// Need to switch language.
			 				alert('hii');
			 				var browserURL = document.location.href;
			 				var currentLangSEO = '/'+document.getElementById('currentLanguageSEO').value+'/';
			 				
			 				if (browserURL.indexOf(currentLangSEO) != -1) {
			 					// If it's SEO URL.
			 					var preferLangSEO = '/'+document.getElementById('langSEO'+languageId).value+'/';
			 					
			 					var query = url.substring(url.indexOf('?')+1, url.length);
			 					var parameters = dojo.queryToObject(query);
			 					if(parameters["URL"]!=null){
			 						var redirectURL = parameters["URL"];
			 						var query2 = redirectURL.substring(redirectURL.indexOf('?')+1, redirectURL.length);
			 						var parameters2 = dojo.queryToObject(query2);
			 						// No redirect URL
			 						if(parameters2["URL"]!=null){
			 							var finalRedirectURL = parameters2["URL"];
			 							if(finalRedirectURL.indexOf(currentLangSEO)!=-1){
			 								// Get the prefer language, and replace with prefer language.
			 								finalRedirectURL = finalRedirectURL.replace(currentLangSEO,preferLangSEO);
			 								parameters2["URL"] = finalRedirectURL;
			 							}
			 							query2 = dojo.objectToQuery(parameters2);
			 							redirectURL = redirectURL.substring(0, redirectURL.indexOf('?'))+'?'+query2;
			 						}else{
			 							//Current URL is the final redirect URL.
			 							redirectURL = redirectURL.toString().replace(currentLangSEO,preferLangSEO);
			 						}
			 						parameters["URL"]=redirectURL;
			 					}
			 					query = dojo.objectToQuery(parameters);
			 					url = url.substring(0, url.indexOf('?'))+'?'+query;
			 					
			 				}else{
			 					// Not SEO URL.
			 					// Parse the parameter and check whether if have langId parameter. 
			 					if(url.contains('?')){
			 						var query = url.substring(url.indexOf('?')+1, url.length);
			 						var parameters = dojo.queryToObject(query);
			 						if(parameters["langId"]!=null){
			 							parameters["langId"] = languageId;
			 							var query2 = dojo.objectToQuery(parameters);
			 							url = url.substring(0,url.indexOf('?'))+'?'+query2;
			 						}else{
			 							url = url + "&langId="+ languageId;
			 						}
			 					}else{
			 						url = url + "?langId="+ languageId;
			 					}
			 				}
			 			
			 			}*/
			 			
			 			setCookie("WC_LogonUserId_"+WCParamJS.storeId, logindata.logonId , {path:'/', domain:cookieDomain});
			 			alert('url'+url);
			 			//location.reload();
			 			window.location = url;
			           });
			 
		 }
		 
		 function ParseCommentedJSON( input ) {
			    switch( typeof input ) {
			      case "object":
			        // if it's already an object, just return it -- no need to process
			        return input;
			        break;
			      case "string":
			        // if it's a string, let's strip whitespace and try to remove any commenting-out that may wrap it
			        try {
			          input = input.trim();
			          input = input.replace( /^\/\*/, '' );
			          input = input.replace( /\*\/$/, '' );
			          input = input.trim();
			          // parse as JSON
			          input = JSON.parse( input );
			          return input;
			        } catch( _err ) {
			         
			        	  console.log( "SW.Utilities.ParseCommentedJSON(): Encountered error parsing JSON string.", _err );
			        
			        }
			        break;
			    }
			    return {};
			  }
	
});	

//Login ends

//PDP starts
app.controller('productdetail', function($scope, $http,$httpParamSerializer){
	var skuImageId="";
	var replaceStr001= "&#039;";
	var replaceStr002= "&#034;";
	var search01= "'";
	var search02= '"';
	var replaceStr01= /\\\'/g;
	var replaceStr02= /\\\"/g;
	var ampersandChar= /&/g;
	var ampersandEntityName= "&amp;" ;
	var moreInfoUrl ="";
	var selectedAttributesList= new Object();
	$scope.setSKUImageId = function(skuImageId){
		alert('hiiiiiiiiiiiiiii');
		
		skuImageId = skuImageId;
	}
	$scope.selectSwatch = function(selectedAttributeName, selectedAttributeValue, entitledItemId, doNotDisable, selectedAttributeDisplayValue, skuImageId, imageField){
		alert('helloooo');
		skuImageId = skuImageId;
		var selectedAttributes = selectedAttributesList[entitledItemId];
		var selectedAttributes = selectedAttributesList[entitledItemId];
		for (attribute in selectedAttributes) {
			if (attribute == selectedAttributeName) {
				// case when the selected swatch is already selected with a value, if the value is different than
				// what's being selected, reset other swatches and deselect the previous value and update selection
				if (selectedAttributes[attribute] != selectedAttributeValue) {
					// deselect previous value and update swatch selection
					 $("swatch_" + entitledItemId + "_" + selectedAttributes[attribute]).class("color_swatch");
					
					 $("swatch_" + entitledItemId + "_" + selectedAttributes[attribute]).src("_enabled.png");
					
					//change the title text of the swatch link
					//dojo.byId("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]).title = swatchElement.alt;
				}
			}
			/*if (document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]) != null) {
				document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]).setAttribute("aria-checked", "false");
			}*/
		}
		makeSwatchSelection(selectedAttributeName, selectedAttributeValue, entitledItemId, doNotDisable, selectedAttributeDisplayValue, skuImageId, imageField);
	}
	function makeSwatchSelection(swatchAttrName, swatchAttrValue, entitledItemId, doNotDisable, selectedAttributeDisplayValue, skuImageId, imageField) {
		setSelectedAttribute(swatchAttrName, swatchAttrValue, entitledItemId, skuImageId, imageField);
		document.getElementById("swatch_" + entitledItemId + "_" + swatchAttrValue).className = "color_swatch_selected";
		document.getElementById("swatch_link_" + entitledItemId + "_" + swatchAttrValue).setAttribute("aria-checked", "true");
		document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrName).className = "header color_swatch_label";
		if (document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).style.display == "none") {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).style.display = "inline";
		}
		if (selectedAttributeDisplayValue != null) {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).innerHTML = selectedAttributeDisplayValue;
		} else {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).innerHTML = swatchAttrValue;
		}
		updateSwatchImages(swatchAttrName, entitledItemId, doNotDisable,imageField);
	}
	function setSelectedAttribute(selectedAttributeName , selectedAttributeValue, entitledItemId, skuImageId, imageField, selectedAttributeDisplayValue){
		var selectedAttributes = selectedAttributesList[entitledItemId];
		if(selectedAttributes == null){
			selectedAttributes = new Object();
		}
		selectedAttributeValue = selectedAttributeValue.replace(replaceStr001, search01);
		selectedAttributeValue = selectedAttributeValue.replace(replaceStr002, search02);
		selectedAttributeValue = selectedAttributeValue.replace(replaceStr01, search01);
		selectedAttributeValue = selectedAttributeValue.replace(replaceStr02, search02);
		selectedAttributeValue = selectedAttributeValue.replace(ampersandChar,ampersandEntityName);
		selectedAttributes[selectedAttributeName] = selectedAttributeValue;
		moreInfoUrl=moreInfoUrl+'&'+selectedAttributeName+'='+selectedAttributeValue;
		selectedAttributesList[entitledItemId] = selectedAttributes;
		if(skuImageId != undefined){
			setSKUImageId(skuImageId);
		}
		var entitledItemJSON;
		if ($(entitledItemId)!=null && !isPopup) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ $(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = getEntitledItemJsonObject(); 
		}
		setEntitledItems(entitledItemJSON);
		var attributeIds = getAttributeIds(selectedAttributeName, entitledItemId);
		if (attributeIds != null) {
			var usedFilterValue = $(attributeIds.usedFilterValueId);
			if (usedFilterValue != null) {
				if (selectedAttributeDisplayValue) {
					usedFilterValue.innerHTML = selectedAttributeDisplayValue;
				} else {
					usedFilterValue.innerHTML = selectedAttributeValue;
				}
			}
			if (selectedAttributeValue == "") {
				$(attributeIds.usedFilterId).removeClass("visible");
				var hideCurrentUsedFilters = true;
				var dropdownList = this.allDropdownsList[entitledItemId];
				for (var i in dropdownList) {
					if (selectedAttributes[dropdownList[i].name] != "") {
						hideCurrentUsedFilters = false;
						break;
					}
				}
				if (hideCurrentUsedFilters) {
				$("currentUsedFilters_" + entitledItemId).addClass("hidden");
				}
			}
			else {
				$(attributeIds.usedFilterId).addClass("visible");
				$("currentUsedFilters_" + entitledItemId).removeClass("hidden");
				var selectedAttributeNameId = selectedAttributeName.replace(search01, "\\\'").replace(search02,'\\\"');
				dojo.addClass("attr_" + entitledItemId + '_' + selectedAttributeNameId, "hidden");
			}
			
			makeDropdownSelection(selectedAttributeName, selectedAttributeValue, entitledItemId);
		}
	}
	function updateSwatchImages(selectedAttrName, entitledItemId, doNotDisable,imageField) {
		var swatchToUpdate = new Array();
		var selectedAttributes = selectedAttributesList[entitledItemId];
		var selectedAttrValue = selectedAttributes[selectedAttrName];
		var swatchList = allSwatchesArrayList[entitledItemId];
		
		// finds out which swatch needs to be updated, add to swatchToUpdate array
		for(var i=0; i<swatchList.length; i++) {
			var attrName = swatchList[i][0];
			var attrValue = swatchList[i][1];
			var attrImg1 = swatchList[i][2];
			var attrImg2 = swatchList[i][3];
			var attrOnclick = swatchList[i][4];
			var attrDisplayValue = swatchList[i][6];
			
			if (attrName != doNotDisable && attrName != selectedAttrName) {
				var swatchRecord = new Array();
				swatchRecord[0] = attrName;
				swatchRecord[1] = attrValue;
				swatchRecord[2] = attrImg1;
				swatchRecord[4] = attrOnclick;
				swatchRecord[5] = false;
				swatchRecord[6] = attrDisplayValue;
				swatchToUpdate.push(swatchRecord);
			}
		}
		
		// finds out which swatch is entitled, if it is, image should be set to enabled
		// go through entitledItems array and find out swatches that are entitled 
		for (x in entitledItems) {
			var Attributes = entitledItems[x].Attributes;

			for(y in Attributes){
				var index = y.indexOf("_|_");
				var entitledSwatchName = y.substring(0, index);
				var entitledSwatchValue = y.substring(index+3);	
				
				//the current entitled item has the selected attribute value
				if (entitledSwatchName == selectedAttrName && entitledSwatchValue == selectedAttrValue) {
					//go through the other attributes that are available to the selected attribute
					//exclude the one that is selected
					for (z in Attributes) {
						var index2 = z.indexOf("_|_");
						var entitledSwatchName2 = z.substring(0, index2);
						var entitledSwatchValue2 = z.substring(index2+3);
						
						if(y != z){ //only check the attributes that are not the one selected
							for (i in swatchToUpdate) {
								var swatchToUpdateName = swatchToUpdate[i][0];
								var swatchToUpdateValue = swatchToUpdate[i][1];
								
								if (entitledSwatchName2 == swatchToUpdateName && entitledSwatchValue2 == swatchToUpdateValue) {
									swatchToUpdate[i][5] = true;
								}
							}
						}
					}
				}
			}
		}

		// Now go through swatchToUpdate array, and update swatch images
		var disabledAttributes = [];
		for (i in swatchToUpdate) {
			var swatchToUpdateName = swatchToUpdate[i][0];
			var swatchToUpdateValue = swatchToUpdate[i][1];
			var swatchToUpdateImg1 = swatchToUpdate[i][2];
			var swatchToUpdateImg2 = swatchToUpdate[i][3];
			var swatchToUpdateOnclick = swatchToUpdate[i][4];
			var swatchToUpdateEnabled = swatchToUpdate[i][5];		
			
			if (swatchToUpdateEnabled) {
				if(document.getElementById("swatch_" + entitledItemId + "_" + swatchToUpdateValue).className != "color_swatch_selected"){
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateValue);
					swatchElement.className = "color_swatch";
					swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
					
					//change the title text of the swatch link
					dojo.byId("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).title = swatchElement.alt;
				}
				document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "false");
				document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).onclick = swatchToUpdateOnclick;
			} else {
				if(swatchToUpdateName != doNotDisable){
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateValue);
					var swatchLinkElement = dojo.byId("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue);
					swatchElement.className = "color_swatch_disabled";					
					swatchLinkElement.onclick = null;
					swatchElement.src = swatchElement.src.replace("_enabled.png","_disabled.png");
					
					//change the title text of the swatch link
					var titleText = storeNLS["INV_ATTR_UNAVAILABLE"];
					swatchLinkElement.title = dojo.string.substitute(titleText,{0: swatchElement.alt});
					
					document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "true");
					
					//The previously selected attribute is now unavailable for the new selection
					//Need to switch the selection to an available value
					if(selectedAttributes[swatchToUpdateName] == swatchToUpdateValue){
						disabledAttributes.push(swatchToUpdate[i]);
					}
				}
			}
		}
		
		//If there were any previously selected attributes that are now unavailable
		//Find another available value for that attribute and update other attributes according to the new selection
		for(i in disabledAttributes){
			var disabledAttributeName = disabledAttributes[i][0];
			var disabledAttributeValue = disabledAttributes[i][1];

			for (i in swatchToUpdate) {
				var swatchToUpdateName = swatchToUpdate[i][0];
				var swatchToUpdateValue = swatchToUpdate[i][1];
				var swatchToUpdateDisplayValue = swatchToUpdate[i][6];
				var swatchToUpdateEnabled = swatchToUpdate[i][5];	
				
				if(swatchToUpdateName == disabledAttributeName && swatchToUpdateValue != disabledAttributeValue && swatchToUpdateEnabled){
						makeSwatchSelection(swatchToUpdateName, swatchToUpdateValue, entitledItemId, doNotDisable, swatchToUpdateDisplayValue, imageField);
					break;
				}
			}
		}
	}
	
});	


//PDP ends

