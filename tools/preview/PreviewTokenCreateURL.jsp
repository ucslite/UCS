<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@page trimDirectiveWhitespaces="true"%>

<%@page import="com.ibm.commerce.server.ConfigProperties"%>
<%@page import="com.ibm.commerce.server.WcsApp"%>

<%
	pageContext.setAttribute("toolsPort", (ConfigProperties.singleton().getValue("WebServer/ToolsPort")));	
	pageContext.setAttribute("toolsWebAppPath", WcsApp.configProperties.getWebModule("CommerceAccelerator").getContextPath() + WcsApp.configProperties.getWebModule("CommerceAccelerator").getUrlMappingPath());
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:url value="https://${pageContext.request.serverName}:${toolsPort}${toolsWebAppPath}/AjaxPreviewTokenCreate">
	<c:param name="storeId" value="${param.storeId}"/>
	<c:param name="krypto" value="${param.krypto}"/>
</c:url>
