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
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ include file="include/EnvironmentSetup.jsp"%>

<%
JSPHelper jhelper = new JSPHelper(request);

String currentWebpath = cmdcontext.getWebpath();

boolean isError = false;
String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);
if (strArrayAuth != null) {
	isError = true;
}
String userType = cmdcontext.getUser().getRegisterType().trim();

String newURL = null;
String actionName = null;

if (!userType.equalsIgnoreCase("G"))
{
	// User is registered - show their User Account Profile
	newURL = "WelcomeView";
	actionName = "welcome";
}
else
{
	// User is not registered - show Logon Page again
	newURL = "LogonFormView";
	actionName = "logon";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("logonTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
</head>

<script LANGUAGE="JavaScript">
<!--
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

go("<c:out value='<%= actionName %>' />", "<c:out value='<%= newURL %>' />");
// -->
</script>
