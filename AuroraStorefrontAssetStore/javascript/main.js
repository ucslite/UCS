// Place third party dependencies in the lib folder
//
// Configure loading modules from the lib directory,
// except 'app' ones, 
requirejs.config({
    "baseUrl": "/wcsstore/AuroraStorefrontAssetStore/javascript/lib",
    "paths": {
      "common": "/wcsstore/AuroraStorefrontAssetStore/javascript/common",
	  "pages": "/wcsstore/AuroraStorefrontAssetStore/javascript/pages",
      'angular' : '/wcsstore/AuroraStorefrontAssetStore/javascript/angular/angular',
      'ngResource': '/wcsstore/AuroraStorefrontAssetStore/javascript/angular/angular-resource',
      'ngCookies': '/wcsstore/AuroraStorefrontAssetStore/javascript/angular/angular-cookies',
     
    },
    "shim": {
        "owl.carousel.min": ["jquery"],
        "ngResource": {deps: ['angular'],exports: 'angular'},
	    "ngCookies": {deps: ['angular'],exports: 'angular'},
	    "angular": {exports : 'angular'}

    }
});

// Load the main app module to start the app
requirejs(["common/jquery-1.11.0.min"]);
requirejs(["common/jquery.cookie"]);
requirejs(["common/bootstrap.min"]);
requirejs(["common/owl.carousel.min"]);
requirejs(["common/front"]);
requirejs(["common/respond.min"]);
requirejs(["common/common"]);
requirejs(["pages/homepage"]);
requirejs(["pages/search"]);
requirejs(["pages/minishopcart"]);
requirejs(["pages/signin"]);
requirejs(["pages/app"]);




