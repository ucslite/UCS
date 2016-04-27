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
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants"%>

<%@ include file="include/EnvironmentSetup.jsp"%>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");
%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
// Using the ErrorDataBean, a problem with the user's input data will be detected here.
String strLogonID= null;
String strErrorCode = null;
String strErrorMessage = null;

// Get users logon ID
strLogonID=jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID);

// If there is an error, it is passed in through the URL.  Look for error code.
strErrorCode = jhelper.getParameter(ECConstants.EC_ERROR_CODE);

if (strErrorCode != null)
{
	//There is an error in the form submission.
		
	if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORD)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingNewPassword");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORDVERIFY)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingVerifyPassword");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_PASSWORD)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingPassword");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_OLDPASSWORD)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingOldPassword");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_INVALID_OLDPASSWORD)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_InvalidOldPassword");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MISMATCH_PASSWORDS)) {
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MismatchPasswords");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinLength");		
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinDigits");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinLetters");	
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordUserIdPasswordMatch");	
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordReUsed");
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMaxConsecutiveLength");	
	} else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD)) {
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMaxInstanceChar");
	} else {
		strErrorMessage = storeText.getString("genericErrorText1");
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("CHANGEPWD_TITLE") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">
	<script language="javascript">
	function submitForm(form)
	{
		form.submit()
	}
	
	function pressEnter(keyPressed){
	     if (keyPressed == 13){
	        document.LogonForm.submit()
	     }
	}
	</script>	
</head>

<c:set var="storeId" value="<%= storeId %>"/>
<c:set var="langId" value="<%= langId %>"/>
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
		<jsp:param name="userState" value="G" />
		<jsp:param name="siteAdmin" value="false" />
		<jsp:param name="sellAdmin" value="false" />
		<jsp:param name="channelAdmin" value="false" />
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

				<h1><%= storeText.getString("CHANGEPWD_TITLE") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("CHANGEPWD_TITLE") %></td>
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
					<form name="ChangeResetPassword" method="Post" action="ResetPassword">
						<input type="hidden" name="<%= ECConstants.EC_STORE_ID %>" value="<c:out value='<%=storeId%>' />">
						<input type="hidden" name="actionName" value="logon">
						<input type="hidden" name="<%=ECUserConstants.EC_UREG_LOGONID%>" value="<c:out value='<%= strLogonID%>' />" />
						<input type="hidden" name="<%=ECUserConstants.EC_RELOGIN_URL %>" value="ChangePassword" />
						<input type="hidden" name="<%= ECConstants.EC_URL %>" value="LogonView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%=storeId%>' />&<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%=langId%>' />&actionName=logon">
						<tr>
							<td><label for="WCHostingHub_logonId"><%= storeText.getString("CHANGEPWD_GeneratedPassword") %></label></td>
						</tr>
						<tr>	
							<td><input type="password" autocomplete="off" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORDOLD%>" id="WCHostingHub_logonId" tabindex="1" onkeypress="pressEnter(window.event.keyCode)" size="13" class="iform"></td>
						</tr>
						<tr>
							<td><label for="WCHostingHub_logonPassword"><%= storeText.getString("CHANGEPWD_NewPassword") %></label></td>
						</tr>
						<tr>
							<td><input type="password" autocomplete="off" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORD%>" id="WCHostingHub_logonPassword" tabindex="2" onkeypress="pressEnter(window.event.keyCode)" size="13" class="iform"></td>
						</tr>
						<tr>
							<td><label for="WCHostingHub_langId"><%= storeText.getString("CHANGEPWD_VerifyPassword") %></label></td>
						</tr>
						<tr>
							<td><input type="password" autocomplete="off" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY%>" id="WCHostingHub_logonPassword" tabindex="3" onkeypress="pressEnter(window.event.keyCode)" size="13" class="iform"></td>
						</tr>
						<tr>
							<td><br /><button type="button" name="changePwdButton" id="form" onClick="javascript:submitForm(document.ChangeResetPassword);"><%= storeText.getString("CHANGEPWD_Submit") %></button></td>
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
