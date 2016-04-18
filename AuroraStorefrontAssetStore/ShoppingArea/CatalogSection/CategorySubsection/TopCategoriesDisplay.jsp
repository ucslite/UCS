<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>

<!-- BEGIN TopCategoriesDisplay.jsp -->

<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>

<c:if test="${(WCParam.previousCommand eq 'logon' || WCParam.globalLogIn eq 'true') && env_shopOnBehalfEnabled_CSR eq 'true'}">
	<%-- User with CSR/CSS role has logged in. Redirect to CSR Landing Page. --%>
	<wcf:url var="redirectURL" value="CustomerServiceLandingPageView" scope="request">
	  <wcf:param name="langId" value="${param.langId}" />
	  <wcf:param name="storeId" value="${param.storeId}" />
	  <wcf:param name="catalogId" value="${param.catalogId}" />
	</wcf:url>
	<c:redirect url="${redirectURL}"/>
</c:if>


<wcf:rest var="getPageResponse" url="store/{storeId}/page/name/{name}">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:var name="name" value="HomePage" encode="true"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="profileName" value="IBM_Store_Details"/>
</wcf:rest>
<c:set var="page" value="${getPageResponse.resultList[0]}"/>

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<wcf:param name="objectIdentifier" value="${page.pageId}"/>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="Content"/>
</wcf:rest>
<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>

<c:set var="pageTitle" value="${page.title}" />
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription" value="${page.fullImageAltDescription}" scope="request" />
<c:set var="pageCategory" value="Browse" scope="request"/>

<html ng-app="home"  xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled>
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${pageTitle}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageIdentifier" content="HomePage"/>
		<meta name="pageId" content="<c:out value="${page.pageId}"/>"/>
		<meta name="pageGroup" content="content"/>	
	    <link rel="canonical" href="<c:out value="${env_TopCategoriesDisplayURL}"/>" />
		
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>
		
		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude.jspf" %>
		<%-- <script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js"></script>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js"></script>
		
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				shoppingActionsJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','<c:out value="${env_CurrencySymbolToFormat}" />');
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>--%>
		<wcpgl:jsInclude/>
		
		<flow:ifEnabled feature="FacebookIntegration">
			<%@include file="../../../Common/JSTLEnvironmentSetupExtForFacebook.jspf" %>
			<%--Facebook Open Graph tags that are required  --%>
			<meta property="og:title" content="<c:out value="${pageTitle}"/>" /> 			
			<meta property="og:image" content="<c:out value="${schemeToUse}://${request.serverName}${portUsed}${jspStoreImgDir}images/logo.png"/>" />
			<meta property="og:url" content="<c:out value="${env_TopCategoriesDisplayURL}"/>"/>
			<meta property="og:type" content="website"/>
			<meta property="fb:app_id" name="fb_app_id" content="<c:out value="${facebookAppId}"/>"/>
			<meta property="og:description" content="${page.metaDescription}" />
		</flow:ifEnabled>
	</head>
	<body>

		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
		
		<!-- Begin Page -->
		<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
		<c:set var="layoutPageName" value="${page.name}"/>
		<%@ include file="/Widgets_701/Common/ESpot/LayoutPreviewSetup.jspf"%>
		
		<div id="page">
		
			<div id="grayOut"></div>
			<div id="headerWrapper">
				<c:set var="overrideLazyLoadDepartmentsList" value="true" scope="request"/>
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
					<c:param name="overrideLazyLoadDepartmentsList" value="${overrideLazyLoadDepartmentsList}" />
				</c:import>
				<%out.flush();%>
			</div>
			
			
			<%-- Template code starts carousel--%> 
				<!--   *** SLIDER *** -->
	



   <div id="slider" class="owl-carousel owl-theme">

        <div class="item">
            <a href="#">
                <img src="/wcsstore/AuroraStorefrontAssetStore/images/banner_new_1.jpg" alt="" class="img-responsive">
            </a>
        </div>

        <div class="item">
            <a href="#">
                <img src="/wcsstore/AuroraStorefrontAssetStore/images/banner_new_2.jpg" alt="" class="img-responsive">
            </a>
        </div>

        <div class="item">
            <a href="#">
                <img src="/wcsstore/AuroraStorefrontAssetStore/images/banner_new_3.jpg" alt="" class="img-responsive">
            </a>
        </div>
	 </div>
     

   
    <!-- /#slider -->

    <!-- *** SLIDER END *** -->
    
    
     <div id="all">

       

        <!-- *** CONTENT ***
	    _________________________________________________________
	    _________________________________________________________
	    -->

        <div id="content">
            <div class="container">

                <div class="col-sm-12">

                    <div class="box text-center">
                        <h3 class="text-uppercase">New summer arrivals</h3>

                        <h4 class="text-muted"><span class="accent">Free shipping</span> on all</h4>
                    </div>

                    <div class="row products">

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product1.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">Fur coat with very but very very long name</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product2.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">White Blouse Armani</a></h3>
                                    <p class="price"><del>$280</del> $143.00</p>
                                </div>
                                <!-- /.text -->

                                <div class="ribbon sale">
                                    <div class="theribbon">SALE</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->

                                <div class="ribbon new">
                                    <div class="theribbon">NEW</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product3.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">Black Blouse Versace</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product4.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">Black Blouse Versace</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product3.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">White Blouse Armani</a></h3>
                                    <p class="price"><del>$280</del> $143.00</p>
                                </div>
                                <!-- /.text -->

                                <div class="ribbon sale">
                                    <div class="theribbon">SALE</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->

                                <div class="ribbon new">
                                    <div class="theribbon">NEW</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product4.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">White Blouse Versace</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->

                                <div class="ribbon new">
                                    <div class="theribbon">NEW</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product2.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">White Blouse Versace</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->

                                <div class="ribbon new">
                                    <div class="theribbon">NEW</div>
                                    <div class="ribbon-background"></div>
                                </div>
                                <!-- /.ribbon -->
                            </div>
                            <!-- /.product -->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="image">
                                    <a href="detail.html">
                                        <img src="/wcsstore/AuroraStorefrontAssetStore/images/product1.jpg" alt="" class="img-responsive image1">
                                    </a>
                                    <div class="quick-view-button">
                                        <a href="#" data-toggle="modal" data-target="#product-quick-view-modal" class="btn btn-default btn-sm">Quick view</a>
                                    </div>
                                </div>
                                <!-- /.image -->
                                <div class="text">
                                    <h3><a href="detail.html">Fur coat</a></h3>
                                    <p class="price">$143.00</p>
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>
                        <!-- /.col-md-4 -->
                        
                        
                        
                        <%out.flush();%>
								<c:import url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.CatalogEntryRecommendation/CatalogEntryRecommendation.jsp">
									<c:param name="emsName" value="Homepage_espot1"/>
									<c:param name="widgetOrientation" value="vertical"/>
									<c:param name="pageSize" value="2"/>
								</c:import>
								<%out.flush();%>
                        
                        
                        

                        <div class="modal fade" id="product-quick-view-modal" tabindex="-1" role="dialog" aria-hidden="false">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-body">

                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        <div class="row quick-view product-main">
                                            <div class="col-sm-6">
                                                <div class="quick-view-main-image">
                                                    <img src="/wcsstore/AuroraStorefrontAssetStore/images/detailbig1.jpg" alt="" class="img-responsive">
                                                </div>

                                                <div class="ribbon ribbon-quick-view sale">
                                                    <div class="theribbon">SALE</div>
                                                    <div class="ribbon-background"></div>
                                                </div>
                                                <!-- /.ribbon -->

                                                <div class="ribbon ribbon-quick-view new">
                                                    <div class="theribbon">NEW</div>
                                                    <div class="ribbon-background"></div>
                                                </div>
                                                <!-- /.ribbon -->

                                                <div class="row thumbs">
                                                    <div class="col-xs-4">
                                                        <a href="/wcsstore/AuroraStorefrontAssetStore/images/detailbig1.jpg" class="thumb">
                                                            <img src="/wcsstore/AuroraStorefrontAssetStore/images/detailsquare.jpg" alt="" class="img-responsive">
                                                        </a>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <a href="/wcsstore/AuroraStorefrontAssetStore/images/detailbig2.jpg" class="thumb">
                                                            <img src="/wcsstore/AuroraStorefrontAssetStore/images/detailsquare2.jpg" alt="" class="img-responsive">
                                                        </a>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <a href="/wcsstore/AuroraStorefrontAssetStore/images/detailbig3.jpg" class="thumb">
                                                            <img src="/wcsstore/AuroraStorefrontAssetStore/images/detailsquare3.jpg" alt="" class="img-responsive">
                                                        </a>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-sm-6">

                                                <h2>White Blouse Armani</h2>

                                                <p class="text-muted text-small text-center">White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>

                                                <div class="box">

                                                    <form>
                                                        <div class="sizes">

                                                            <h3>Available sizes</h3>

                                                            <label for="size_s">
                                                                <a href="#">S</a>
                                                                <input type="radio" id="size_s" name="size" value="s" class="size-input">
                                                            </label>
                                                            <label for="size_m">
                                                                <a href="#">M</a>
                                                                <input type="radio" id="size_m" name="size" value="m" class="size-input">
                                                            </label>
                                                            <label for="size_l">
                                                                <a href="#">L</a>
                                                                <input type="radio" id="size_l" name="size" value="l" class="size-input">
                                                            </label>

                                                        </div>

                                                        <p class="price">$124.00</p>

                                                        <p class="text-center">
                                                            <button type="submit" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Add to cart</button>
                                                            <button type="submit" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="Add to wishlist"><i class="fa fa-heart-o"></i>
                                                            </button>
                                                        </p>


                                                    </form>
                                                </div>
                                                <!-- /.box -->

                                                <div class="quick-view-social">
                                                    <h4>Show it to your friends</h4>
                                                    <p>
                                                        <a href="#" class="external facebook" data-animate-hover="pulse"><i class="fa fa-facebook"></i></a>
                                                        <a href="#" class="external gplus" data-animate-hover="pulse"><i class="fa fa-google-plus"></i></a>
                                                        <a href="#" class="external twitter" data-animate-hover="pulse"><i class="fa fa-twitter"></i></a>
                                                        <a href="#" class="email" data-animate-hover="pulse"><i class="fa fa-envelope"></i></a>
                                                    </p>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/.modal-dialog-->
                        </div>
                        <!-- /.modal -->

                    </div>
                    <!-- /.products -->

                </div>
                <!-- /.col-sm-12 -->

            </div>
            <!-- /.container -->
    
    		 <!-- *** PROMO BAR ***
_________________________________________________________ -->

            <div class="bar background-image-fixed-2 no-mb color-white text-center">
                <div class="dark-mask"></div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                        
                           
                        <%out.flush();%>
								<c:import url="${env_siteWidgetsDir}/com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
									<c:param name="emsName" value="Homepage_espot2"/>
									
								</c:import>
								<%out.flush();%>
                        
                        </div>

                    </div>
                </div>
            </div>

            <!-- *** PROMO BAR END *** -->

        </div>
        <!-- /#content -->
    
			<%-- Template code ends --%>
			<%-- 
			<div id="contentWrapper">
				<div id="content" role="main">
					<c:set var="rootWidget" value="${pageDesign.widget}"/>
					<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionId}" debug=false/>
				</div>
			</div>
			--%>
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
			</div>
		</div>
		
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${page.pageId}"/>
<!-- END TopCategoriesDisplay.jsp -->		
</html>
