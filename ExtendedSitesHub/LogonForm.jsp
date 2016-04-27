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
<%@ page import="com.ibm.commerce.common.beans.LanguageDescriptionDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.SupportedLanguageDataBean" %>
<%@ page import="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>

<%@ include file="include/EnvironmentSetup.jsp"%>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");

String strlogonId = "";
%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
// Using the ErrorDataBean, a problem with the user's input data will be detected here.
String strErrorMessage = null;

String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);

if (strArrayAuth != null)
{
      if( strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_LOGONID) == true) {
         strErrorMessage = storeText.getString("Logon_ID_MISSING");      
      } else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_LOGONID) == true ||  	
               strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_PASSWORD) == true) {
         strErrorMessage = storeText.getString("Logon_Incorrect");         
      } else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_PASSWORD) == true) {
         strErrorMessage = storeText.getString("Logon_PASSWD_MISSING");
      } else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_DISABLED_ACCOUNT) == true) {
         strErrorMessage = storeText.getString("Logon_Warning1");
      } else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_LOGON_NOT_ALLOWED) == true) {
         strErrorMessage = storeText.getString("Logon_WAIT_TO_LOGIN");  
      } else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_USER_IN_PENDING_APPROVAL) == true) {
         strErrorMessage = storeText.getString("Logon_Warning2");
      } else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_PARENT_ORG_LOCKED)==true) {
         strErrorMessage = storeText.getString("Logon_ERROR_org_locked");
      } else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_NOT_REGISTERED_CUSTOMER)==true) {
         strErrorMessage = storeText.getString("Logon_ERROR_Authority");                  
      } else {
      	 strErrorMessage = storeText.getString("Logon_ERROR_Unknown");
      }
      	 
	//Get the entered logonId from the URL parameters in order to re-display it.
	strlogonId = jhelper.getParameter("logonId"); 
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("logonTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">

	<script language="javascript" src="<%=fileDir%>javascript/URLParser.js"></script>
	<script language="javascript">
	function getValueFromSelection(formObject) {
		var selectedIndex = formObject.selectedIndex;
		return formObject.options[selectedIndex].value;
	}

	function submitForm(form)
	{
		form.submit()
	}
	
	function pressEnter(keyPressed){
	     if (keyPressed == 13){
	        document.LogonForm.submit()
	     }
	}

	function reloadPage() {
		var newURL = "";
		var parser = new URLParser(document.URL);
		newURL += parser.getProtocol() + "://";
		newURL += parser.getServerName();
		newURL += parser.getRequestURI() + "?";
		var parameterNames = parser.getParameterNames();
		for (i=0; i<parameterNames.length; i++) {
			if (i != 0) {
				newURL += "&";
			}
			if (parameterNames[i] != "<%= ECConstants.EC_LANGUAGE_ID %>") {
				newURL += parameterNames[i] + "=";
				newURL += parser.getParameterValue(parameterNames[i]);
			} else {
				newURL += parameterNames[i] + "=";
				newURL += getValueFromSelection(document.LogonForm.<%= ECConstants.EC_LANGUAGE_ID %>);
			}
		}
	
		document.location.href = newURL;
	}
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
		<jsp:param name="actionSelected" value="logon" />
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

				<h1><%= storeText.getString("logonTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("logonSubHeading") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt=""></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt=""></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<%
					if (strErrorMessage != null) {
						//Display error messages.
						%>
						<p><font color="red"><%=strErrorMessage%></font><br><br></p>
					<%		
					}			
					%>
					<form name="LogonForm" method="Post" action="Logon">
						<input type="hidden" name="<%= ECConstants.EC_STORE_ID %>" value="<c:out value='<%=storeId%>' />">
						<input type="hidden" name="actionName" value="logon">
						<input type="hidden" name="reLogonURL" value="LogonFormView">
						<input type="hidden" name="<%= ECConstants.EC_URL %>" value="LogonView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%=storeId%>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%=langId%>' />&actionName=logon">
						<tr>
							<td><label for="WCHostingHub_logonId"><%= storeText.getString("logonID") %></label></td>
						</tr>
						<tr>	
							<td><input type="text" name="logonId" id="WCHostingHub_logonId" value="<c:out value='<%=strlogonId%>' />" tabindex="1" onkeypress="pressEnter(window.event.keyCode)" size="13" class="iform"></td>
						</tr>
						<tr>
							<td><label for="WCHostingHub_logonPassword"><%= storeText.getString("logonPassword") %></label></td>
						</tr>
						<tr>
							<td><input type="password" autocomplete="off" name="logonPassword" id="WCHostingHub_logonPassword" tabindex="2" onkeypress="pressEnter(window.event.keyCode)" size="13" class="iform"></td>
						</tr>
						<tr>
							<td><label for="WCHostingHub_langId"><%= storeText.getString("logonChooseLang") %></label></td>
						</tr>
						<tr>
							<td><select name="<%= ECConstants.EC_LANGUAGE_ID %>" id="WCHostingHub_langId" onChange="javascript:reloadPage()">
							<%
							SupportedLanguageDataBean supportedLanguageDB = new SupportedLanguageDataBean();
							Enumeration slList = supportedLanguageDB.findByStore(new Integer(storeId));
							while (slList.hasMoreElements()) {
								SupportedLanguageAccessBean aSLB = (SupportedLanguageAccessBean) slList.nextElement();
								String languageId = aSLB.getLanguageId();
								LanguageDescriptionDataBean ldb = new LanguageDescriptionDataBean();
								ldb.setDataBeanKeyLanguageId(langId);
								ldb.setDataBeanKeyDescriptionLanguageId(languageId);
								if (langId.equals(languageId)) {
								%>
									<option value="<c:out value='<%= languageId %>' />" selected ><%= ldb.getDescription() %></option>
								<% } else { %>
									<option value="<c:out value='<%= languageId %>' />"><%= ldb.getDescription() %></option>
								<% }
							}
							%>
							</select></td>
						</tr>
						<tr>
							<td><br /><button type="button" name="logonButton" id="form" onClick="javascript:submitForm(document.LogonForm);"><%= storeText.getString("logonButton") %></button></td>
						</tr>
						<tr>
							<td><br /><%= storeText.getString("logonDescription1") %></td>
						</tr>
						<tr>
							<td><br /><%= storeText.getString("logonDescription2") %></td>
						</tr>
					</form>
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
