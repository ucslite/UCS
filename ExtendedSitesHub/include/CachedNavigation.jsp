<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
//
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreEntityDataBean" %>
<%@ page import="com.ibm.commerce.common.objects.StoreEntityAccessBean" %>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.RoleDataBean" %>
<%@ include file="EnvironmentSetup.jsp" %>

<%

//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
JSPHelper jhelper 	= new JSPHelper(request);

String userState	= jhelper.getParameter("userState");
userState = userState.replaceAll("<","&lt;");
userState = userState.replaceAll(">","&gt;");

String siteAdmin 	= jhelper.getParameter("siteAdmin");
siteAdmin = siteAdmin.replaceAll("<","&lt;");
siteAdmin = siteAdmin.replaceAll(">","&gt;");

String sellAdmin 	= jhelper.getParameter("sellAdmin");
sellAdmin = sellAdmin.replaceAll("<","&lt;");
sellAdmin = sellAdmin.replaceAll(">","&gt;");

String channelAdmin 	= jhelper.getParameter("channelAdmin");
channelAdmin = channelAdmin.replaceAll("<","&lt;");
channelAdmin = channelAdmin.replaceAll(">","&gt;");

//Look and feel efects: determine if using selected or normal navigations
String actionSelected 	= jhelper.getParameter("actionSelected");
if (actionSelected == null) {
	actionSelected = "";
}

String selectedHighlite = "but_highlite2.gif";
String normalHighlite = "but_highlite.gif";
String selectedShadow = "but_shadow2.gif";
String normalShadow = "but_shadow.gif";
String selectedButton = "selectbut";
String normalButton = "greybut";

//check if there is a public store
boolean hasPublicStore = false;
Integer[] publicStores = sdb.getStoresForRelatedStore("com.ibm.commerce.channelStore");
if (publicStores != null && publicStores.length != 0) {
	hasPublicStore = true;
} else {
	//check by storetype
	java.util.Enumeration pbsStores = sdb.findByStoreType("PBS");
	if (pbsStores.hasMoreElements()) {
		hasPublicStore = true;
	}
}

//Create the URL for the Administration links
String host = request.getServerName();

String currentWebpath = cmdcontext.getWebpath();
String portUsed = null;
String requestURL = request.getRequestURL().toString();
String[] parts = requestURL.split(":");
if (parts.length > 2) {
	//therefore parts[2] should have the port section
	String[] parts2 = parts[2].split("/");
	portUsed = parts2[0];
}

String acceleratorContextPath = null;
String acceleratorURLMappingPath = null;
String orgadminContextPath = null;
String orgadminURLMappingPath = null;
Vector contextPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/contextPath");
Vector urlMappingPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/urlMappingPath");
Vector moduleNames = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/name");
for (int i=0; i<moduleNames.size(); i++) {
	String name = (String)moduleNames.elementAt(i);
	if (name.equals("CommerceAccelerator")) {
		acceleratorContextPath = (String)contextPath.elementAt(i);
		acceleratorURLMappingPath = (String)urlMappingPath.elementAt(i);
	} else if (name.equals("OrganizationAdministration")) {
		orgadminContextPath = (String)contextPath.elementAt(i);
		orgadminURLMappingPath = (String)urlMappingPath.elementAt(i);
	}
}

String toolsPort = ConfigProperties.singleton().getValue("WebServer/ToolsPort");
String orgadminPort = ConfigProperties.singleton().getValue("WebServer/OrgAdminPort");

StringBuffer acceleratorURL = new StringBuffer();
acceleratorURL.append("https://");
acceleratorURL.append(host);
acceleratorURL.append(":");
acceleratorURL.append(toolsPort);
acceleratorURL.append(acceleratorContextPath);
acceleratorURL.append(acceleratorURLMappingPath);
acceleratorURL.append("/MerchantCenterView?XMLFile=common.merchantCenterMHS&customFrameset=common.MerchantCenterFramesetMHS&webPathToUse=");
acceleratorURL.append(currentWebpath);
if (portUsed != null) {
	acceleratorURL.append("&portToUse=");
	acceleratorURL.append(portUsed);
}
acceleratorURL.append("&navigationViewName=NavigationView&headerViewName=CommonHeaderView&actionName=managestore&showStoreSelection=true&langId=");
acceleratorURL.append(langId);
acceleratorURL.append("&storeIdToUse=");
acceleratorURL.append(storeId);
acceleratorURL.append("&storeId=");
acceleratorURL.append(storeId);
acceleratorURL.append("&userState=");
acceleratorURL.append(userState);
acceleratorURL.append("&siteAdmin=");
acceleratorURL.append(siteAdmin);
acceleratorURL.append("&sellAdmin=");
acceleratorURL.append(sellAdmin);
acceleratorURL.append("&channelAdmin=");
acceleratorURL.append(channelAdmin);
acceleratorURL.append("&actionSelected=");
acceleratorURL.append("managestore");
String acceleratorEncodedURL = response.encodeURL(acceleratorURL.toString());

StringBuffer orgAdminConsoleURL = new StringBuffer();
orgAdminConsoleURL.append("https://");
orgAdminConsoleURL.append(host);
orgAdminConsoleURL.append(":");
orgAdminConsoleURL.append(orgadminPort);
orgAdminConsoleURL.append(orgadminContextPath);
orgAdminConsoleURL.append(orgadminURLMappingPath);
orgAdminConsoleURL.append("/BuyAdminConsoleView?XMLFile=buyerconsole.BuySiteAdminConsole&customFrameset=common.MerchantCenterFramesetMHS&webPathToUse=");
orgAdminConsoleURL.append(currentWebpath);
if (portUsed != null) {
	orgAdminConsoleURL.append("&portToUse=");
	orgAdminConsoleURL.append(portUsed);
}
orgAdminConsoleURL.append("&navigationViewName=NavigationView&headerViewName=CommonHeaderView&actionName=organization&langId=");
orgAdminConsoleURL.append(langId);
orgAdminConsoleURL.append("&storeIdToUse=");
orgAdminConsoleURL.append(storeId);
orgAdminConsoleURL.append("&storeId");
orgAdminConsoleURL.append(storeId);
orgAdminConsoleURL.append("&buyer=true");
orgAdminConsoleURL.append("&userState=");
orgAdminConsoleURL.append(userState);
orgAdminConsoleURL.append("&siteAdmin=");
orgAdminConsoleURL.append(siteAdmin);
orgAdminConsoleURL.append("&sellAdmin=");
orgAdminConsoleURL.append(sellAdmin);
orgAdminConsoleURL.append("&channelAdmin=");
orgAdminConsoleURL.append(channelAdmin);
orgAdminConsoleURL.append("&actionSelected=");
orgAdminConsoleURL.append("organization");
String orgAdminConsoleEncodedURL = response.encodeURL(orgAdminConsoleURL.toString());

String BrowserVerErrorURL = "";

%>
<html>
<head>
	
<SCRIPT language="javascript">
function launchAccelerator(actionName) {
	var bRightBrowser = false;
	
	if ( navigator.appName == "Microsoft Internet Explorer") {
		var locOfMSIE = navigator.appVersion.indexOf('MSIE') + 5;
		var bInstalled = false;
   		
		if (locOfMSIE > -1 && navigator.appVersion.substring(locOfMSIE, locOfMSIE + 1) > 4) {
			bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
		}

		if (bInstalled) {
			IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			version = IEversion.substr(0,3);
			versionNumber = parseInt(IEversion.substr(0,1));
			revisionNumber = parseInt(IEversion.substr(2,1));
			if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
				bRightBrowser = true
			}
		}
	}
		
	//if (bRightBrowser) 
	//{
		top.location.href=('<%=acceleratorEncodedURL%>');
	//}
	//else if (!bRightBrowser)
	//{
	//	parent.content.location.href=('<%=BrowserVerErrorURL%>');
	//}
}

function launchOrgAdminConsole(actionName) {	
	var bRightBrowser = false;

	if ( navigator.appName == "Microsoft Internet Explorer") {

		var locOfMSIE = navigator.appVersion.indexOf('MSIE') + 5;
		var bInstalled = false;
    		
		if (locOfMSIE > -1 && navigator.appVersion.substring(locOfMSIE, locOfMSIE + 1) > 4) {
			bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
		}

		if (bInstalled) {
			IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			version = IEversion.substr(0,3);
			versionNumber = parseInt(IEversion.substr(0,1));
			revisionNumber = parseInt(IEversion.substr(2,1));
			if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
				bRightBrowser = true
			}
		}
	}
	
	//if (bRightBrowser) 
	//{
		top.location.href=('<%=orgAdminConsoleEncodedURL%>');
	//}
	//else if (!bRightBrowser)
	//{
	//	parent.content.location.href=('<%=BrowserVerErrorURL%>');
	//}					
}

/****************************************************************************
* Determines whether an object has been assigned a value.
*
* Returns TRUE if it has been assigned a value; FALSE otherwise
****************************************************************************/
function defined(obj)
{
	var str = typeof obj;

	if((str == "undefined") || (obj == null)) {
		return false;
	} else {
		return true;
	}
}// END defined

function go(actionName, contentURL)
{
	top.location.href = "<%= currentWebpath %>/" + contentURL + "?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%= storeId %>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%=langId%>' />&actionName="+actionName;
}

</SCRIPT>
<IE:clientCaps ID="oClientCaps" STYLE="behavior:url('#default#clientCaps')"></IE:clientCaps>
</head>

<style type="text/css">
.padding { padding: 0px; margin: 0px; background-color: #E9E9EA;}
.leftnavbk {background-image: url(<%= fileDir %>images/stripes.gif);width: 157px;}
.selectbut {background-image: url(<%= fileDir %>images/but_purp.gif);font: 12px Verdana, Geneva, Arial, Helvetica, sans-serif; color: black;height:23px; padding-left: 22px;padding-right:3px;}
.butlink {font: 12px Verdana, Geneva, Arial, Helvetica, sans-serif; color: black; text-decoration: none; padding-left: 22px;padding-top: 3px;background-image: url(<%= fileDir %>images/but_grey.gif); height:23px; width:100%; display: block;padding-right:3px;}
.butlink:hover {font: 12px Verdana, Geneva, Arial, Helvetica, sans-serif; color: #472586; text-decoration: none; padding-left: 22px;padding-top: 3px;background-image: url(<%= fileDir %>images/but_rollover.gif); height:23px; width:100%; display: block;}
.footerbk {background-image: url(<%= fileDir %>images/footer.gif);}
</style>

<body class="leftnavbk" style="overflow: auto" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<td class="leftnavbk" valign="top">
			<table cellpadding="0" cellspacing="0" border="0" >
				<tr>
					<td><img src="<%= fileDir %>images/nav_logo.gif" alt="" width="157" height="82" border="0"></td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("welcome")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("welcome")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("welcome")) {%>
						<a href="javascript:go('welcome','WelcomeView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationHome") %>
					<% if (!actionSelected.equals("welcome")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("welcome")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>

				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("aboutus")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("aboutus")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("aboutus")) {%>
						<a href="javascript:go('aboutus','AboutUsView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationAboutUs") %>
					<% if (!actionSelected.equals("aboutus")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("aboutus")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>

				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("servicesprovided")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("servicesprovided")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("servicesprovided")) {%>
						<a href="javascript:go('servicesprovided','ServicesProvidedView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationServicesProvided") %>
					<% if (!actionSelected.equals("servicesprovided")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("servicesprovided")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>

				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("prices")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("prices")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("prices")) {%>
						<a href="javascript:go('prices','PricesView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationPrices") %>
					<% if (!actionSelected.equals("prices")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("prices")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>

<% if (hasPublicStore)
{
%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("viewstoredirectory")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("viewstoredirectory")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("viewstoredirectory")) {%>
						<a href="javascript:go('viewstoredirectory','ViewPublicAreaView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationViewPublicArea") %>
					<% if (!actionSelected.equals("viewstoredirectory")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("viewstoredirectory")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
<%
}
%>

<%
if (userState.equalsIgnoreCase("G"))
{
%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("registration")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("registration")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("registration")) {%>
						<a href="javascript:go('registration','OrgRegistrationAddFormView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationRegistration") %>
					<% if (!actionSelected.equals("registration")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("registration")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
				
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("logon")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("logon")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("logon")) {%>
						<a href="javascript:go('logon','LogonView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationLogon") %>
					<% if (!actionSelected.equals("logon")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("logon")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
<%
}
%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("faq")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("faq")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("faq")) {%>
						<a href="javascript:go('faq','FaqView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationFAQ") %>
					<% if (!actionSelected.equals("faq")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("faq")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
				
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("contactus")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("contactus")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("contactus")) {%>
						<a href="javascript:go('contactus','ContactUsView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationContactUs") %>
					<% if (!actionSelected.equals("contactus")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("contactus")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/stripes.gif" alt="" width="157" height="40" border="0"></td>
				</tr>
<%
// If the user is not a guest, then do not show registration. Also, see which admin links to display.
if (!userState.equalsIgnoreCase("G"))
{
	if (sellAdmin.equalsIgnoreCase("true") || siteAdmin.equalsIgnoreCase("true") || channelAdmin.equalsIgnoreCase("true")) {
	%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("createstore")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("createstore")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("createstore")) {%>
						<a href="javascript:go('createstore','CreateStoreView')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationCreateStore") %>
					<% if (!actionSelected.equals("createstore")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("createstore")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
	<%
	}
	%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("managestore")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("managestore")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("managestore")) {%>
						<a href="javascript:launchAccelerator('managestore')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationManageStore") %>
					<% if (!actionSelected.equals("managestore")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("managestore")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
	<%
	if (sellAdmin.equalsIgnoreCase("true") || siteAdmin.equalsIgnoreCase("true") || channelAdmin.equalsIgnoreCase("true")) {
	%>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("organization")) ? selectedHighlite : normalHighlite %>" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="<%= (actionSelected.equals("organization")) ? selectedButton : normalButton %>">
					<% if (!actionSelected.equals("organization")) {%>
						<a href="javascript:launchOrgAdminConsole('organization')" class="butlink">
					<% } %>
					<%= storeText.getString("navigationManageOrganization") %>
					<% if (!actionSelected.equals("organization")) {%>
						</a>
					<% } %>
					</td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/<%= (actionSelected.equals("organization")) ? selectedShadow : normalShadow %>" alt="" width="156" height="3" border="0"></td>
				</tr>
	<%
	}
	%>
				<tr>
					<td><img src="<%= fileDir %>images/but_highlite.gif" alt="" width="156" height="2" border="0"></td>
				</tr>
				<tr>
					<td class="greybut"><a href="<%=currentWebpath%>/Logoff?storeId=<c:out value='<%=storeId%>' />&URL=LogonView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%= storeId %>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%=langId%>' />&actionName=logon" class="butlink"><%= storeText.getString("navigationLogoff") %></a></td>
				</tr>
				<tr>
					<td><img src="<%= fileDir %>images/but_shadow.gif" alt="" width="156" height="3" border="0"></td>
				</tr>
	<%
}
%>
		</table>
	</td>
	</tr>
</table>
</body>
</html>
