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
// 020930	    KNG	      Initial create
// 021030	    KNG	      Restructure pages without frames
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="include/EnvironmentSetup.jsp" %>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);

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
Vector contextPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/contextPath");
Vector urlMappingPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/urlMappingPath");
Vector moduleNames = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/name");
for (int i=0; i<moduleNames.size(); i++) {
	String name = (String)moduleNames.elementAt(i);
	if (name.equals("CommerceAccelerator")) {
		acceleratorContextPath = (String)contextPath.elementAt(i);
		acceleratorURLMappingPath = (String)urlMappingPath.elementAt(i);
	}
}

String toolsPort = ConfigProperties.singleton().getValue("WebServer/ToolsPort");

StringBuffer returnURL = new StringBuffer();
returnURL.append("https://");
returnURL.append(host);
if (portUsed != null) {
	returnURL.append(":");
	returnURL.append(portUsed);
}
returnURL.append(currentWebpath);
returnURL.append("/StoreView?storeId=");
returnURL.append(storeId);
returnURL.append("%26langId=");
returnURL.append(langId);

StringBuffer scwURL = new StringBuffer();
scwURL.append("https://");
scwURL.append(host);
scwURL.append(":");
scwURL.append(toolsPort);
scwURL.append(acceleratorContextPath);
scwURL.append(acceleratorURLMappingPath);
scwURL.append("/SCWLogonView?storetype=BMP&storetype=MPS&storeId=");
scwURL.append(storeId);
//scwURL.append("&paymentOverride=true");
scwURL.append("&launchSeparateWindow=false");
scwURL.append("&callingURL=");
scwURL.append(returnURL);
scwURL.append("&customFrameset=common.MerchantCenterFramesetMHS&webPathToUse=");
scwURL.append(currentWebpath);
if (portUsed != null) {
	scwURL.append("&portToUse=");
	scwURL.append(portUsed);
}
scwURL.append("&navigationViewName=NavigationView&headerViewName=CommonHeaderView&actionName=createstore");
scwURL.append("&storeIdToUse=");
scwURL.append(storeId);
scwURL.append("&userState=");
scwURL.append(userState);
scwURL.append("&siteAdmin=");
scwURL.append(siteAdmin);
scwURL.append("&sellAdmin=");
scwURL.append(sellAdmin);
scwURL.append("&channelAdmin=");
scwURL.append(channelAdmin);
scwURL.append("&actionSelected=");
scwURL.append("createstore");
String scwEncodedURL = response.encodeURL(scwURL.toString());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title><%= storeText.getString("browserTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
</head>

<frameset COLS="156,*" FRAMEBORDER="0" FRAMESPACING="0" BORDER="0" >
   <frame NAME="navigation" title="navigation" SRC="NavigationView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%= storeId %>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%= langId %>' />&userState=<c:out value='<%= userState %>' />&siteAdmin=<c:out value='<%= siteAdmin %>' />&sellAdmin=<c:out value='<%= sellAdmin %>' />&channelAdmin=<c:out value='<%= channelAdmin %>' />" FRAMEBORDER="0" MARGINWIDTH="0" MARGINHEIGHT="0" NORESIZE SCROLLING="no">

   <frameset ROWS="55,*" FRAMEBORDER="0" FRAMESPACING="0" BORDER="0">
      <frame NAME="header" title="header" SRC="CommonHeaderView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%= storeId %>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%= langId %>' />&actionName=createstore" FRAMEBORDER="0" MARGINWIDTH="0" MARGINHEIGHT="0" NORESIZE SCROLLING="no">
      <frame NAME="content" title="content" SRC="<%=scwEncodedURL%>" FRAMEBORDER="0" MARGINWIDTH="10" MARGINHEIGHT="10" NORESIZE SCROLLING="auto">
   </frameset>
</frameset>

</html>
