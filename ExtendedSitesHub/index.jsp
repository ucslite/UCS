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
// date=10/10/25 13:39:05  release info=src/businessModels/demandChannelHosting/CommercePlaza/web/index.jsp, wcs.models.Hosting.Channel, wc.70.fp
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

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>

<%@ include file="include/parameters.jsp"%>

<%
String servletPath = (String)request.getAttribute(ECConstants.EC_SERVLET_PATH);
//if the servlet path in the request attributes is null, as in the case of launching from Studio, the page will be redirected to the correct URL
if (servletPath == null) {		
	String redirectURL = (String)request.getContextPath()+ "/servlet" + (String)request.getServletPath();
	response.sendRedirect(redirectURL);
	return;
}
%>

<%
JSPHelper jhelper = new JSPHelper(request);
String storeentId = jhelper.getParameter(ECConstants.EC_STORE_ID);
if (storeentId != null && !storeentId.equals("")) {
	storeId = storeentId;
}
%>

<jsp:useBean id="storeDB" class="com.ibm.commerce.common.beans.StoreDataBean" scope="request">
<%
storeDB.setStoreId(storeId);
com.ibm.commerce.beans.DataBeanManager.activate(storeDB, request);
%>
</jsp:useBean>

<%
CommandContext cmdcontext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
String currentWebpath = cmdcontext.getWebpath();
String langId = jhelper.getParameter(ECConstants.EC_LANGUAGE_ID);
if (langId == null && langId.equals("")) {
	cmdcontext.getLanguageId().toString();
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<META HTTP-EQUIV=Refresh CONTENT="0;URL=<%= currentWebpath %>/LogonView?<%= ECConstants.EC_STORE_ID %>=<%=storeId%>&<%= ECConstants.EC_LANGUAGE_ID %>=<%=langId%>&actionName=logon">
</head>
<body>
</body>
</html>
