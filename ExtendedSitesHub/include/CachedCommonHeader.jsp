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

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="EnvironmentSetup.jsp" %>

<%
JSPHelper jhelper = new JSPHelper(request);
String action = jhelper.getParameter("actionName");
if (action == null || action.equals("") || action.equals("null")) {
	action = "welcome";
}
%>
<html>

<style type="text/css">
.headerbk {background-image: url(<%= fileDir %>images/stripes_header.gif);}
.bannerbk {background-image: url(<%= fileDir %>images/banner.jpg);width:644px;height:47px;}
.bannertxt {font: 32px Verdana, Geneva, Arial, Helvetica, sans-serif; color: white; padding-bottom:0px; padding-right:6px;}
</style>

<body style="overflow: auto" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">

			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="headerbk"><img src="<%= fileDir %>images/stripes_header.gif" alt="" width="147" height="47" border="0"></td>
					<td align="right" valign="bottom" class="bannerbk"><span class="bannertxt"><%= storeText.getString(action) %></span></td>
				</tr>
			</table>

</body>
</html>