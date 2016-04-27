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
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="include/EnvironmentSetup.jsp" %>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("welcomeTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
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
		<jsp:param name="actionSelected" value="welcome" />
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
				<h1><%= storeText.getString("welcomeTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("welcomeWhatsNew") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt=""></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt=""></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td valign="top"><%= storeText.getString("welcomeDescription1") %>
						<p><%= storeText.getString("welcomeDescription2") %></p>
						</td>
						<td width="285" align="right"><img src="<%= fileDir %>images/welcome.jpg" width="278" height="183" border="0" alt=""></td>
					</tr>
					<tr>
						<td colspan="2" width"616"><br />
						<%= storeText.getString("welcomeDescription3") %><br /><br />
						
						<%= storeText.getString("welcomeDescription4") %>
						</td>
					</tr>
				</table>

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