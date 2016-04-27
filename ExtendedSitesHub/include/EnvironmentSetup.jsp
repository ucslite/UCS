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

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page session="false"%>

<jsp:useBean id="sdb" class="com.ibm.commerce.common.beans.StoreDataBean" scope="request">
<% com.ibm.commerce.beans.DataBeanManager.activate(sdb, request); %>
</jsp:useBean>

<%
CommandContext cmdcontext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Locale locale = cmdcontext.getLocale();
String storeId = cmdcontext.getStoreId().toString();
String langId = cmdcontext.getLanguageId().toString();

String storeDir = sdb.getJspPath();
String fileDir = sdb.getFilePath();

StringBuffer helperString = new StringBuffer();
helperString.append(storeDir);
helperString.append("include/");
String includeDir = helperString.toString();

String storeName = sdb.getDescription(cmdcontext.getLanguageId()).getDisplayName();

JSPResourceBundle storeText = (JSPResourceBundle) request.getAttribute("ResourceText");

if (storeText == null)
{
	storeText =  new JSPResourceBundle(sdb.getResourceBundle("b2cHostingChannel"));
	request.setAttribute("ResourceText", storeText);
}

response.setContentType(storeText.getString("ENCODESTATEMENT"));
%>

