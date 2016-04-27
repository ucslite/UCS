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
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="include/EnvironmentSetup.jsp" %>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");

String validationError = jhelper.getParameter("validationError");
String subject = jhelper.getParameter("subject");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("contactusTitle") %></title>
	<link rel=stylesheet href="<%= fileDir %>spe.css" type="text/css">

<script language="javascript">
function submitComment() {
	if (document.sendMsgForm.messageContent.value == "") {
		document.sendMsgForm.action = "ContactUsView";
	} else {
		document.sendMsgForm.validationError.value = "false";
		document.sendMsgForm.action = "ContactUsSendMessageView";
	}
	document.sendMsgForm.submit();
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
		<jsp:param name="actionSelected" value="contactus" />
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
				<h1><%= storeText.getString("contactusTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("contactusSubHeading") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt=""></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt=""></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
				<form name="sendMsgForm" method="post" action="" >
					<input type="hidden" NAME="<%= ECConstants.EC_STORE_ID %>" VALUE="<c:out value='<%= storeId %>' />">
					<input type="hidden" NAME="<%= ECConstants.EC_LANGUAGE_ID %>" VALUE="<c:out value='<%= langId %>' />">
					<input type="hidden" name="validationError" value="true" >
					<input type="hidden" name="actionName" value="contactus" >
					<%
					if (validationError != null && validationError.equals("true")) {
					%>
						<tr><td><p><font color="red"><%= storeText.getString("contactusNoComments") %></font><br><br></p></td></tr>
					<%
					}
					%>
					
					<tr>
						<td><%= storeText.getString("contactusDescription") %>
							<p>
							<label for="WCHostingHub_subject"><%= storeText.getString("contactusSubject") %></label><br>
							<select name="subject" id="WCHostingHub_subject">
							<%
							if ( (subject==null) || (subject != null && subject.equals(storeText.getString("contactusOption1"))) ) {
							%>
								<option value="<%= storeText.getString("contactusOption1") %>" selected="selected" ><%= storeText.getString("contactusOption1") %></option>
							<%
							} else {
							%>
								<option value="<%= storeText.getString("contactusOption1") %>" ><%= storeText.getString("contactusOption1") %></option>
							<%
							}
							
							if (subject != null && subject.equals(storeText.getString("contactusOption2"))) {
							%>
								<option value="<%= storeText.getString("contactusOption2") %>" selected="selected" ><%= storeText.getString("contactusOption2") %></option>
							<%
							} else {
							%>
								<option value="<%= storeText.getString("contactusOption2") %>" ><%= storeText.getString("contactusOption2") %></option>
							<%
							}
							
							if (subject != null && subject.equals(storeText.getString("contactusOption3"))) {
							%>
								<option value="<%= storeText.getString("contactusOption3") %>" selected="selected" ><%= storeText.getString("contactusOption3") %></option>
							<%
							} else {
							%>
								<option value="<%= storeText.getString("contactusOption3") %>" ><%= storeText.getString("contactusOption3") %></option>
							<%
							}
							%>
							</select>
							</p>
							<label for="WCHostingHub_messageContent"><%= storeText.getString("contactusMessage") %></label><br>
							<textarea name="messageContent" id="WCHostingHub_messageContent" cols="40" rows="6" value=" "></textarea>
							<p>
							<table>
								<tr>
									<td><button type="button" name="submitForm" id="form" onClick="javascript:submitComment();" ><%= storeText.getString("contactusSubmit") %></button></td>
									<td>&nbsp;</td>
									<td><button type="reset" name="reset" id="form"><%= storeText.getString("contactusReset") %></button></td>
								</tr>
							</table>
							</p>
						</td>
					</tr>
				</form>
				</table>
				<br />

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