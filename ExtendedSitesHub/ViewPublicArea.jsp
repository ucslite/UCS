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
<%@ page import="com.ibm.commerce.common.objects.StoreAccessBean" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="include/EnvironmentSetup.jsp" %>
<%@ include file="include/CacheParametersSetup.jspf"%>
<%
//get public store id
String publicStoreId = null;
Integer[] publicStores = sdb.getStoresForRelatedStore("com.ibm.commerce.channelStore");
if (publicStores != null && publicStores.length != 0) {
	publicStoreId = publicStores[0].toString();
} else {
	//check by storetype
	java.util.Enumeration pbsStores = sdb.findByStoreType("PBS");
	if (pbsStores.hasMoreElements()) {
		StoreAccessBean storeAB = (StoreAccessBean)pbsStores.nextElement();
		publicStoreId = storeAB.getStoreEntityId();
	}
}

String host = request.getServerName();
String currentWebpath = cmdcontext.getWebpath();
String portUsed = null;
String portUsedString = "";
String requestURL = request.getRequestURL().toString();
String[] parts = requestURL.split(":");
if (parts.length > 2) {
	//therefore parts[2] should have the port section
	String[] parts2 = parts[2].split("/");
	portUsed = parts2[0];
}
if (portUsed != null) {
	portUsedString = ":" + portUsed;
}

JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("viewstoredirectoryTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
	
<script Language="JavaScript">

   function viewpublicarea()
   {
      window.open("http://<%= host %><%= portUsedString %><%= currentWebpath %>/StoreView?<%= ECConstants.EC_STORE_ID %>=<%= publicStoreId %>&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%= langId %>' />", "viewpublicarea");
   }
   
   viewpublicarea();

</script>

</head>

<c:set var="storeId" value="<%= storeId %>"/>
<c:set var="langId" value="<%= langId %>"/>
<c:set var="userState" value="<%= userState %>"/>
<c:set var="siteAdmin" value="<%= strSiteAdmin %>"/>
<c:set var="sellAdmin" value="<%= strSellAdmin %>"/>
<c:set var="channelAdmin" value="<%= strChannelAdmin %>"/>
<c:set var="actionName" value="<%= actionName %>"/>

<body class="padding">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<td class="leftnavbk" valign="top">
	<!-- Start Navigation -->
	<%
	String incfile;
	incfile = includeDir + "CachedNavigation.jsp"; 
	
	%>
	<jsp:include page="<%=incfile%>" flush="true">
		<jsp:param name="storeId" value="${storeId}" />
		<jsp:param name="langId" value="${langId}" />
		<jsp:param name="userState" value="${userState}" />
		<jsp:param name="siteAdmin" value="${siteAdmin}" />
		<jsp:param name="sellAdmin" value="${sellAdmin}" />
		<jsp:param name="channelAdmin" value="${channelAdmin}" />
		<jsp:param name="actionSelected" value="viewstoredirectory" />
      	</jsp:include> 
	<!-- End Navigation -->
		</td>
		
		<td valign="top" class="greybk">
		<!-- Start Header -->
		<%
		incfile = includeDir + "CachedCommonHeader.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true">
			<jsp:param name="storeId" value="${storeId}" />
			<jsp:param name="langId" value="${langId}" />
			<jsp:param name="actionName" value="${actionName}" />
      		</jsp:include> 
		<!-- End Header -->
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="contentspc">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
				<h1><%= storeText.getString("viewstoredirectoryTitle") %></h1>
				<br />
				
				<p><%= storeText.getString("viewstoredirectoryDescription") %><br>
				<br>
				<br>
				<br>
				<br>
				</p>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- Start Footer -->
	<%
	incfile = includeDir + "CachedFooter.jsp"; 
	%>
	<jsp:include page="<%=incfile%>" flush="true" />
	<!-- End Footer -->
</table>

</body>
</html>
