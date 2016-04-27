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
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans used %> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %> 
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>

<%@ include file="include/EnvironmentSetup.jsp"%>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");

ErrorDataBean errorBean = new ErrorDataBean ();
com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);

String errorMessageKey = errorBean.getMessageKey().trim();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title><%=storeText.getString("genericErrorTitle")%></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
</head>

<c:set var="storeId" value="<%= storeId %>"/>
<c:set var="langId" value="<%= langId %>"/>
<c:set var="userState" value="<%= userState %>"/>
<c:set var="siteAdmin" value="<%= strSiteAdmin %>"/>
<c:set var="sellAdmin" value="<%= strSellAdmin %>"/>
<c:set var="channelAdmin" value="<%= strChannelAdmin %>"/>
	
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
			<jsp:param name="storeId" value="<%= storeId %>" />
			<jsp:param name="langId" value="<%= langId %>" />
			<jsp:param name="actionName" value="<%= actionName %>" />
      		</jsp:include> 
		<!-- End Header -->
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="contentspc">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>

				<h1><%= storeText.getString("genericErrorTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("genericErrorTitle") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt=""></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt=""></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
				<tr>
					<td width="10"></td>
					<td width="590" colspan="2">
					<br /><br /><br /><br />
					<% 
					if (errorMessageKey != null)
					{
						if (errorMessageKey.equals("_ERR_USER_AUTHORITY"))
						{
						%>
							<font class="medium"><%=storeText.getString("genericErrorAccessControlError")%></font>
						<%
						}
						else if (errorMessageKey.equals("_ERR_BAD_STORE_STATE"))
						{
						%>
							<font class="medium"><%=storeText.getString("genericErrorClosed")%></font>
						<%
						}
						else
						{
						%>
							<font class="medium"><%=storeText.getString("genericErrorText2")%></font>
						<%
						}
					}
					else
					{ 	
					%>
						<font class="medium"><%=storeText.getString("genericErrorText1")%></font>
					<%
					}
					%>
					<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
					<hr width="580" noshade align="left"> <br />
					<%=storeText.getString("GENERICERR_DEVELOPER")%> <br />
					<%=storeText.getString("GENERICERR_HTML")%>
					<br /><br /><br /><br />				
						
					</td>
				</tr>
				</table>
   
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

</body>
</html>

<!--
//********************************************************************
//*-------------------------------------------------------------------
<% 
try {

%>
<%=storeText.getString("GENERICERR_TEXT3")%>
<%=storeText.getString("GENERICERR_TEXT4")%>

<%=storeText.getString("GENERICERR_TYPE")%> <%= errorBean.getExceptionType()%>
<%=storeText.getString("GENERICERR_KEY")%> <%= errorBean.getMessageKey() %>
<%=storeText.getString("GENERICERR_MESSAGE")%> <%= errorBean.getMessage() %>
<%=storeText.getString("GENERICERR_SYSMESSAGE")%> <%= errorBean.getSystemMessage() %>
<%=storeText.getString("GENERICERR_CMD")%> <%= errorBean.getOriginatingCommand() %>
<%=storeText.getString("GENERICERR_CORR_ACTION")%> <%= errorBean.getCorrectiveActionMessage() %>
<%
	com.ibm.commerce.datatype.TypedProperty nvps = errorBean.getExceptionData();
	if (nvps != null) {
		Enumeration en = nvps.keys();
%>
<%=storeText.getString("GENERICERR_EXCEPTIONDATA")%>
<%
		while(en.hasMoreElements()) {
			String name = (String)en.nextElement();
%>
<%=storeText.getString("GENERICERR_NAME")%> <%= name %>    <%=storeText.getString("GENERICERR_VALUE")%> <%= nvps.getString(name, "") %>
<%	
		}
	}

} catch (Exception e) {
	out.println ("Exception:"+e);
}
%>
//*-------------------------------------------------------------------
//*
-->
