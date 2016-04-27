<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page import="com.ibm.commerce.payments.plugincontroller.PPCConstants"%>
<HTML lang="en">
	<HEAD><TITLE>Punchout Payment Result</TITLE></HEAD>
	<BODY>
<%
String paymentMethod = (String) request.getAttribute(PPCConstants.PUNCHOUT_PAYMENT_METHOD);
if ("SimplePunchoutPlugin".equalsIgnoreCase(paymentMethod)) {
	out.println("DONE");
}
%>
</BODY>
</HTML>