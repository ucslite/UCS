<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  * How to use this snippet?
  *	This is an example of how this file could be included into a page:
  * <c:import url="${env_jspStoreDir}${storeNameDir}/UserArea/AccountSection/ServiceSection/InterestItemListSubsection/WishListForUser.jsp">
  * 	<c:param name="storeId" value="${storeId}" />
  * 	<c:param name="langId" value="${langId}"/>
  * 	<c:param name="catalogId" value="${catalogId}"/>
  * </c:import>
 --%>

<!-- Wish List for a shopper logic begins -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../../../include/parameters.jspf" %>
<%@ include file="../../../../../Common/EnvironmentSetup.jspf" %>

<%@ page import="com.ibm.commerce.command.CommandContext" %>

<fmt:message bundle="${storeText}" var="defaultWishListName" key="DEFAULT_WISH_LIST_NAME"/>
<c:set var="defaultShoppingListId" value="-1" />

<!-- Do not check for wish list if it is a generic shopper. -->
<c:if test="${!(CommandContext.user.userId eq '-1002')}">
	<!-- Obtain the wish list of a registered shopper -->
	<wcf:rest var="wishListResult" url="/store/{storeId}/wishlist/@self">
		<wcf:var name="storeId" value="${WCParam.storeId}" />
	</wcf:rest>
	<c:set var="userWishLists" value="${wishListResult.GiftList}"/>
	
	<c:forEach var="userList" items="${userWishLists}">
		<c:if test="${userList.descriptionName eq defaultWishListName}">
			<c:set var="defaultShoppingListId" value="${userList.uniqueID}" />
		</c:if>
	</c:forEach>
</c:if>

<div><label for="wishListSelection"></label></div>

<select class="secondary_button button_full" id="wishListSelection" name="wishListSelection" onchange="addToWishList('<c:out value="${param.itemsAttributes}" />', '<c:out value="${param.selValSeparator}" />')">
	<option disabled="disabled" selected="selected" value=""><fmt:message bundle="${storeText}" key="WISHLIST"/></option>
	<option value=""><fmt:message bundle="${storeText}" key="CREATE_WISHLIST_OPTION"/></option>
	<c:if test="${defaultShoppingListId == -1}">
		<option value="-1" ><c:out value="${defaultWishListName}"/></option>
	</c:if>
	<c:if test="${!(CommandContext.user.userId eq '-1002')}">
		<c:forEach var="userList" items="${userWishLists}">
			<c:out value="${userList.uniqueID}" />
			<option value="<c:out value="${userList.uniqueID}" escapeXml="false"/>"><c:out value="${userList.descriptionName}" escapeXml="false"/></option>
		</c:forEach>
	</c:if>
</select>

<!-- Wish List for a shopper logic ends -->

