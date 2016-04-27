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
// 030818		KNG		  conform to W3C XHTML
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.ibm.icu.text.Collator" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="java.util.*" %>

<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.user.beans.CountryStateListDataBean" %>
<%@ page import="com.ibm.commerce.user.objects.OrganizationAccessBean" %>
<%@ page import="com.ibm.commerce.user.objects.PolicyAccountAccessBean" %>
<%@ page import="com.ibm.commerce.user.objects.PolicyPasswordAccessBean" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.price.utils.CurrencyManager" %>
<%@ page import="com.ibm.commerce.tools.util.BasicQuickSortCompare" %>
<%@ page import="com.ibm.commerce.tools.util.QuickSort" %>
<%@ page import="com.ibm.commerce.tools.util.StringPair" %>
<%@ include file="include/EnvironmentSetup.jsp" %>
<%@ include file="include/CacheParametersSetup.jspf"%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<jsp:useBean id="countryDB" class="com.ibm.commerce.user.beans.CountryStateListDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(countryDB, request); %>
</jsp:useBean>

<%!
//Retrive the list of supported currencies in the store. Return a sorted list.
public Vector getSupportedCurrencies(CommandContext cmdcontextlocal) {
	// Use for sorting currency descriptions.
	Collator collator = null;
	collator = Collator.getInstance(cmdcontextlocal.getLocale());
	collator.setStrength(Collator.IDENTICAL);
	
	Vector currenciesList = new Vector();
	try {
		CurrencyManager cm = CurrencyManager.getInstance();
		String [] supportedCurrencies = (String []) cm.getSupportedCurrencies(cmdcontextlocal.getStore());
	
		for (int i = 0; i < supportedCurrencies.length; ++i) {
			String strCurrDesc = cm.getDescription(cmdcontextlocal.getStore(), supportedCurrencies[i], cmdcontextlocal.getLanguageId());
			currenciesList.addElement(new StringPair(supportedCurrencies[i], strCurrDesc, collator));
		}
		
		if (!(currenciesList == null || currenciesList.size() == 0)) {
			// Sorts the currenciesList.
			QuickSort.sort(currenciesList, new BasicQuickSortCompare());
		}
	} catch (Exception ex) {
	
	}
	
	return currenciesList;
}
%>
 
<%
 //Organization Section
 String strOrganizationName = null;
 String strOrganizationDescription = null;
 String strOrganizationBusCategory = null;
 String strOrganizationAddress1 = null;
 String strOrganizationAddress2 = null;
 String strOrganizationAddress3 = null;
 String strOrganizationCity = null;
 String strOrganizationCountry = null;
 String strOrganizationState = null;
 String strOrganizationZipCode = null;
 
 //Organization Administrator Section
 String strOrganizationAdminLogonID = null;
 String strOrganizationAdminPwd = null;
 String strOrganizationAdminVerifyPwd = null;
 String strOrganizationAdminQuestion = null;
 String strOrganizationAdminTitle = null;
 String strOrganizationAdminAnswer = null;
 String strOrganizationAdminFirstName = null;
 String strOrganizationAdminMiddleName = null;
 String strOrganizationAdminLastName = null;
 String strOrganizationAdminPreferredCurrency = null;
 String strOrganizationAdminAddress1 = null;
 String strOrganizationAdminAddress2 = null;
 String strOrganizationAdminAddress3 = null;
 String strOrganizationAdminCity = null;
 String strOrganizationAdminCountry = null;
 String strOrganizationAdminState = null;
 String strOrganizationAdminZipCode = null;
 
 //Organization Contact Section
 String strOrganizationContactEmail1 = null;
 String strOrganizationContactEmail2 = null;
 String strOrganizationContactPhone1 = null;
 String strOrganizationContactPhone2 = null;
 String strOrganizationContactFax1 = null;
 String strOrganizationContactFax2 = null;
 String strOrganizationBestCallingTime = null;
 
  //Organization Admin Contact Section
 String strOrganizationAdminPreferredCommunication = null;
 String strOrganizationAdminContactEmail1 = null;
 String strOrganizationAdminContactEmail2 = null;
 String strOrganizationAdminContactPhone1 = null;
 String strOrganizationAdminContactPhone2 = null;
 String strOrganizationAdminContactFax1 = null;
 String strOrganizationAdminContactFax2 = null;
 String strOrganizationAdminBestCallingTime = null;

 HashMap constantsHelperMap = new HashMap();
 constantsHelperMap.put("OrgReg_ContactBestCallTime1Value", "D");
 constantsHelperMap.put("OrgReg_ContactBestCallTime2Value", "E");
 constantsHelperMap.put("OrgReg_AdminContactBestCallTime1Value", "D");
 constantsHelperMap.put("OrgReg_AdminContactBestCallTime2Value", "E");
 constantsHelperMap.put("OrgReg_AdminPreferredComm1Value", "P1");
 constantsHelperMap.put("OrgReg_AdminPreferredComm1Value", "P2");
 constantsHelperMap.put("OrgReg_AdminPreferredComm1Value", "E1");
 constantsHelperMap.put("OrgReg_AdminPreferredComm1Value", "E2");
 
 // Useful Debug Statements for Error Handling
 /*out.println("<BR>bnError.getExceptionData() = " + bnError.getExceptionData());
 out.println("<BR>bnError.getExceptionType() = " + bnError.getExceptionType());
 out.println("<BR>bnError.getMessageKey() = " + bnError.getMessageKey());
 out.println("<BR>bnError.getMessage() = " + bnError.getMessage());
 */
 

JSPHelper jhelper = new JSPHelper(request);
String actionName = jhelper.getParameter("actionName");
String strEmailError = jhelper.getParameter("emailError");

String strErrorMessage 		= null;
String strErrorCode 		= null;

// A problem with the user's input data will be detected here.
TypedProperty hshErrorProperties = bnError.getExceptionData();
if (hshErrorProperties != null || bnError.getExceptionType() != null || strEmailError != null) {
	Object[] strMessageParams = null;
	String strFieldName = null;
	strErrorMessage = bnError.getMessage();
	
 	if (strEmailError != null && strEmailError.length() != 0)
 	{
 		if (strEmailError.equals("invalid_email1_org")) {
 			strErrorMessage = storeText.getString("OrgReg_ERROR1");
 		} else if (strEmailError.equals("invalid_email2_org")) {
 			strErrorMessage = storeText.getString("OrgReg_ERROR2");
 		} else if (strEmailError.equals("invalid_email1_usr")) {
			strErrorMessage = storeText.getString("UsrReg_ERROR1");
 		} else if (strEmailError.equals("invalid_email2_usr")) {
 			strErrorMessage = storeText.getString("UsrReg_ERROR2");
 		} else if (strEmailError.equals("invalid_phone1_usr")) {
 			strErrorMessage = storeText.getString("OrgReg_AdminContactPhone1");
 		} else if (strEmailError.equals("invalid_phone2_usr")) {
 			strErrorMessage = storeText.getString("OrgReg_AdminContactPhone2");
 		}
 	}
	
	if (hshErrorProperties != null) {
		strErrorCode = hshErrorProperties.getString(ECConstants.EC_ERROR_CODE, "");
		Object[] arguments = {new Integer(0)};
		String policyAccount = ECSecurityConstants.ACCOUNT_POLICY;              // Get the default account policy
 
		PolicyAccountAccessBean abPolicyAccount= new PolicyAccountAccessBean();
		abPolicyAccount.setInitKey_iPolicyAccountId(policyAccount);
		String passPolicyId = abPolicyAccount.getPolicyPasswordId();           // Get the password policy id from the AccountPolicyDataBean

		PolicyPasswordAccessBean abPolicyPassword = new PolicyPasswordAccessBean();
		abPolicyPassword.setInitKey_iPolicyPasswordId(passPolicyId);
		String minLength = abPolicyPassword.getMinimumPasswordLength();        // Get the attributes needed for the error messages
		String minNumeric = abPolicyPassword.getMinimumNumeric();
		String minAlphabetic = abPolicyPassword.getMinimumAlphabetic();
		String maxInstances = abPolicyPassword.getMaximumInstances();
		String maxConsec = abPolicyPassword.getMaximumConsecutiveType();		
 
		//Logon ID and Password Errors
		if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONID)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_MissingLogonID");
		} else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONPASSWORD)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_MissingPassword");
		} else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONPASSWORDVERIFY)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_MissingVerifyPassword");
		} else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_PASSWORDS_NOT_SAME)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_PasswordsNotTheSame");
		} else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_LOGONID_EXISTS)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR14");
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD)) {
			arguments[0] = new Integer(minLength);
			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("UsrReg_ERROR_PasswordMinLength")), arguments);
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD)) {
			arguments[0] = new Integer(maxConsec);
			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("UsrReg_ERROR_PasswordMaxConsecutiveLength")),arguments);
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD)) {
			arguments[0] = new Integer(minNumeric);
			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("UsrReg_ERROR_PasswordMinDigits")),arguments);		
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD)) {
			arguments[0] = new Integer(minAlphabetic);
			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("UsrReg_ERROR_PasswordMinLetters")),arguments);
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_PasswordUserIdPasswordMatch");	
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD)) {
			strErrorMessage = storeText.getString("UsrReg_ERROR_PasswordReUsed");
		} else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD)) {
			arguments[0] = new Integer(maxInstances);
			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("UsrReg_ERROR_PasswordMaxInstanceChar")),arguments);
		}
	}
	// invalid mandatory parameters and others
	if (bnError.getMessageKey().equals("_ERR_CMD_INVALID_PARAM"))
	{	
		strMessageParams = bnError.getMessageParam();
		strFieldName = (String)strMessageParams[0];
		StringTokenizer st = new StringTokenizer(strFieldName, "=");
 		strFieldName = st.nextToken();  // if the strFieldName contains '=' sign, use only the string before '='

		if (strFieldName.equals("org_"+ECUserConstants.EC_ORG_ORGENTITYNAME))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR5");
		} 
		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_ADDRESS1))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR9");
		}
 		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_CITY))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR10");
		}
 		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_STATE))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR11");
		}
 		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_COUNTRY))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR12");
		}
 		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_ZIPCODE))
 		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR13");
		}
		else if (strFieldName.equals("org_"+ECUserConstants.EC_ADDR_EMAIL1))
		{
 			strErrorMessage = storeText.getString("OrgReg_ERROR1");
		}
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_LASTNAME))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR6");
		}
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_ADDRESS1))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR9");
 		}	
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_CITY))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR10");
		}
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_STATE))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR11");
		}
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_COUNTRY))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR12");
 		}	
 		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_ZIPCODE))
 		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR13");
 		}	
		else if (strFieldName.equals("usr_"+ECUserConstants.EC_ADDR_EMAIL1))
		{
 			strErrorMessage = storeText.getString("UsrReg_ERROR1");
 		}
 	}
 	
	// existing business name
	if (bnError.getMessageKey().equals("_ERR_RDN_ALREADY_EXIST"))
	{
 		strErrorMessage = storeText.getString("OrgReg_Error4");
 	}
 	

 	// Redisplay what was entered when the invalid entry was submitted.
 	strOrganizationName = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ORG_ORGENTITYNAME));
	strOrganizationDescription = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ORG_DESCRIPTION));
	strOrganizationBusCategory = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ORG_BUSINESSCATEGORY));
 	strOrganizationAddress1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_ADDRESS1));
	strOrganizationAddress2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_ADDRESS2));
	strOrganizationAddress3 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_ADDRESS3));
	strOrganizationCity = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_CITY));
	strOrganizationCountry = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_COUNTRY));
	strOrganizationState = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_STATE));
	strOrganizationZipCode = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_ZIPCODE));
	 


	// org contact section
 	strOrganizationContactEmail1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_EMAIL1));
	strOrganizationContactEmail2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_EMAIL2));
	strOrganizationContactPhone1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_PHONE1));
	strOrganizationContactPhone2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_PHONE2));
	strOrganizationContactFax1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_FAX1));
	strOrganizationContactFax2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_FAX2));
	strOrganizationBestCallingTime = jhelper.htmlTextEncoder(jhelper.getParameter("org_"+ECUserConstants.EC_ADDR_BESTCALLINGTIME));


	//Organization Administrator Section
	strOrganizationAdminLogonID = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_UREG_LOGONID));
	strOrganizationAdminPwd = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORD));
	strOrganizationAdminVerifyPwd = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY));
	strOrganizationAdminQuestion = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_UREG_CHALLENGEQUESTION));
	strOrganizationAdminAnswer = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_UREG_CHALLENGEANSWER));
	strOrganizationAdminTitle = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_PERSONTITLE));
	strOrganizationAdminFirstName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_FIRSTNAME));
	strOrganizationAdminMiddleName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_MIDDLENAME));
	strOrganizationAdminLastName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_LASTNAME));

	 
	strOrganizationAdminPreferredCurrency = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_USER_PREFERREDCURRENCY));//
	strOrganizationAdminAddress1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_ADDRESS1));
	strOrganizationAdminAddress2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_ADDRESS2));
	strOrganizationAdminAddress3 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_ADDRESS3));
	strOrganizationAdminCity = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_CITY));
	strOrganizationAdminCountry = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_COUNTRY));
	strOrganizationAdminState = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_STATE));
	strOrganizationAdminZipCode = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_ZIPCODE));
 
 	//Organization Administrator Contact Section
	strOrganizationAdminPreferredCommunication = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION));
	strOrganizationAdminContactEmail1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_EMAIL1));
	strOrganizationAdminContactEmail2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_EMAIL2));
 	strOrganizationAdminContactPhone1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_PHONE1));
	strOrganizationAdminContactPhone2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_PHONE2));
	strOrganizationAdminContactFax1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_FAX1));
	strOrganizationAdminContactFax2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_FAX2));
	strOrganizationAdminBestCallingTime = jhelper.htmlTextEncoder(jhelper.getParameter("usr_"+ECUserConstants.EC_ADDR_BESTCALLINGTIME));

} else {
 	// Form is loading under regular condition. Initialize all fields to empty.
	strOrganizationName = "";
	strOrganizationDescription = "";
 	strOrganizationBusCategory = "";
 	strOrganizationAddress1 = "";
 	strOrganizationAddress2 = "";
 	strOrganizationAddress3 = "";
 	strOrganizationCity = "";
 	strOrganizationCountry = "";
 	strOrganizationState = "";
 	strOrganizationZipCode = "";
 
 	//Organization Administrator Section
 	strOrganizationAdminLogonID = "";
	strOrganizationAdminPwd = "";
	strOrganizationAdminVerifyPwd = "";
	strOrganizationAdminQuestion = "";
	strOrganizationAdminAnswer = "";
	strOrganizationAdminTitle = "";
	strOrganizationAdminFirstName = "";
	strOrganizationAdminMiddleName = "";
	strOrganizationAdminLastName = "";
	strOrganizationAdminPreferredCurrency = "";
	strOrganizationAdminAddress1 = "";
	strOrganizationAdminAddress2 = "";
	strOrganizationAdminAddress3 = "";
	strOrganizationAdminCity = "";
 	strOrganizationAdminCountry = "";
 	strOrganizationAdminState = "";
 	strOrganizationAdminZipCode = "";
 
 	//Organization Contact Section
 	strOrganizationContactEmail1 = "";
	strOrganizationContactEmail2 = "";
	strOrganizationContactPhone1 = "";
	strOrganizationContactPhone2 = "";
	strOrganizationContactFax1 = "";
	strOrganizationContactFax2 = "";
	strOrganizationBestCallingTime = "";
	
	//Organization Admin Contact Section
	strOrganizationAdminPreferredCommunication = "";
 	strOrganizationAdminContactEmail1 = "";
	strOrganizationAdminContactEmail2 = "";
	strOrganizationAdminContactPhone1 = "";
	strOrganizationAdminContactPhone2 = "";
	strOrganizationAdminContactFax1 = "";
	strOrganizationAdminContactFax2 = "";
	strOrganizationAdminBestCallingTime = "";	
}

Vector countries = countryDB.getCountries();
CountryStateListDataBean.Country aCountry = null;
CountryStateListDataBean.StateProvince[] states = null;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= storeText.getString("OrgReg_Title") %></title>
	<link rel="stylesheet" href="<%= fileDir %>spe.css" type="text/css" />
	
<script language="javascript">
//get the list of all countries and states available from the database.
var countries = new Array();

<%
for (int i=0; i<countries.size(); i++) {
	aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
	%>
	countries["<%= aCountry.getCode() %>"] = new Object();
	countries["<%= aCountry.getCode() %>"].name = "<%= aCountry.getDisplayName() %>";
  <%
  states = aCountry.getStates();
		
	if (states != null && states.length != 0) {
		for (int k=0; k<states.length; k++) {
			if (k==0) {
		  %>
				countries["<%= aCountry.getCode() %>"].states = new Object();
			<% 
			} 
			%>
			countries["<%= aCountry.getCode() %>"].states["<%= states[k].getCode() %>"] = "<%= states[k].getDisplayName() %>";
		<%
		}
	}
}
%>

// Reload the state field to be input or select depending on the data
function loadStatesUI(form, paramPrefix)
{
		var currentState = form[paramPrefix + "state"].value;
    var currentCountryCode = form[paramPrefix + "country"].value;
    var stateDivObj = document.getElementById(paramPrefix + "stateDiv");
		while(stateDivObj.hasChildNodes()) {
			stateDivObj.removeChild(stateDivObj.firstChild);
		}

    if (countries[currentCountryCode].states) {
        // switch to state list
        stateDivObj.appendChild(createStateWithOptions(paramPrefix, currentCountryCode, currentState));
    } else {
        // switch to state text input
        stateDivObj.appendChild(createState(paramPrefix, currentState));
    }
}

// Create an input element to represent the state
function createState(paramPrefix, currentState)
{
		var stateInput = document.createElement("input");
		stateInput.setAttribute("id", paramPrefix + "state");
		stateInput.setAttribute("name", paramPrefix + "state");
		stateInput.setAttribute("className", "logon input");
		stateInput.setAttribute("size", "35");
		stateInput.setAttribute("maxlength", "40");
		//stateInput.setAttribute("value", currentState);
		return stateInput
}

// Create an select element to represent the state and load it with the corresponding states
// as defined in the database
function createStateWithOptions(paramPrefix, currentCountryCode, currentState)
{
		var stateSelect = document.createElement("select");
		stateSelect.setAttribute("id", paramPrefix + "state");
		stateSelect.setAttribute("name", paramPrefix + "state");
		stateSelect.setAttribute("className", "logon select");
		
    // clear old options
    stateSelect.options.length = 0;
    
    // add all states
    for (state_code in countries[currentCountryCode].states) {
        // add a state
        aOption = document.createElement("option");
        stateSelect.options.add(aOption);
        aOption.text = countries[currentCountryCode].states[state_code];
        aOption.value = state_code;

        if (state_code == currentState || countries[currentCountryCode].states[state_code] == currentState) {
            aOption.selected = true;
        }
    }
    
    return stateSelect;
}
	
function isValidEmail(strEmail) {
	if (strEmail.length < 5) {
             return false;
       	}else{
           	if (strEmail.indexOf(" ") > 0){
                      	return false;
               	}else{
                  	if (strEmail.indexOf("@") < 1) {
                            	return false;
                     	}else{
                           	if (strEmail.lastIndexOf(".") < (strEmail.indexOf("@") + 2)){
                                     	return false;
                                }else{
                                        if (strEmail.lastIndexOf(".") >= strEmail.length-2){
                                        	return false;
                                        }
                              	}
                       	}
              	}
       	}
      	return true;	
}

function submitRegistration()
{
	if(!isValidEmail(document.registrationForm.org_<%=ECUserConstants.EC_ADDR_EMAIL1%>.value)) {
		document.registrationForm.emailError.value = "invalid_email1_org";
	}
	else if(document.registrationForm.org_<%=ECUserConstants.EC_ADDR_EMAIL2%>.value != "" && !isValidEmail(document.registrationForm.org_<%=ECUserConstants.EC_ADDR_EMAIL2%>.value)) {
		document.registrationForm.emailError.value = "invalid_email2_org";
	}
	else if(!isValidEmail(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_EMAIL1%>.value)) {
		document.registrationForm.emailError.value = "invalid_email1_usr";
	}
	else if(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_EMAIL2%>.value != "" && !isValidEmail(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_EMAIL2%>.value)) {
		document.registrationForm.emailError.value = "invalid_email2_usr";
	}
	
	//verify that if there is a preferred communication selected then make that field mandatory
	if(document.registrationForm.emailError.value.length == 0) {
		if(document.registrationForm.usr_<%=ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION%>.value == "E2") {
			if(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_EMAIL2%>.value == "") {
				document.registrationForm.emailError.value = "invalid_email2_usr";
			}
		}
		if(document.registrationForm.usr_<%=ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION%>.value == "P1") {
			if(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_PHONE1%>.value == "") {
				document.registrationForm.emailError.value = "invalid_phone1_usr";
			}
		}
		if(document.registrationForm.usr_<%=ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION%>.value == "P2") {
			if(document.registrationForm.usr_<%=ECUserConstants.EC_ADDR_PHONE2%>.value == "") {
				document.registrationForm.emailError.value = "invalid_phone2_usr";
			}
		}
	}
	
	if(document.registrationForm.emailError.value.length != 0) {
		document.registrationForm.action="OrgRegistrationAddFormView";
		document.registrationForm.submit();
	}
	else {
		//verify address fields #1-#3, if #2 or #3 are filled and not #1 then move the data for the user
		if (document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value == "") {
			if (document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value == "") {	
				if (document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value != "") {
					document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value = document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value;
					document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value = "";
				}
			} else {
				document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value = document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value;
				document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value = "";
				if (document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value != "") {
					document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value = document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value;
					document.registrationForm.org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value = "";
				}
			}
		}

		if (document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value == "") {
			if (document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value == "") {	
				if (document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value != "") {
					document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value = document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value;
					document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value = "";
				}
			} else {
				document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>.value = document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value;
				document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value = "";
				if (document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value != "") {
					document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>.value = document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value;
					document.registrationForm.usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>.value = "";
				}
			}
		}
	
		document.registrationForm.action=document.registrationForm.registrationCmdName.value;
		document.registrationForm.submit();
	}
}

function userRegistration()
{
	document.userRegistrationForm.submit();
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
		<jsp:param name="actionSelected" value="registration" />
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

				<h1><%= storeText.getString("OrgReg_Title") %></h1>
				
				<%
				if (strErrorMessage != null) {
					//Display error messages. 
					%>
					<p><font color="red"><c:out value='<%=strErrorMessage%>'/></font><br /><br /></p>
					<%
				}			
				%>
				
				<!--
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<form name="userRegistrationForm" method="post" action="UserRegistrationAddFormView">
					<input type="hidden" name="<%= ECConstants.EC_STORE_ID %>" value="<c:out value='<%= storeId %>' />" />
					<input type="hidden" name="<%= ECConstants.EC_LANGUAGE_ID %>" value="<c:out value='<%= langId %>' />" />
					<input type="hidden" name="actionName" value="registration" />
					
					<tr>
						<td colspan="2" ><%= storeText.getString("OrgReg_Text6") %>&nbsp;&nbsp;
						<button type="button" name="userRegistrationButton" id="form" onclick="javascript:userRegistration();"><%= storeText.getString("OrgReg_Text7") %></button></td>
					</tr>
					</form>
				</table>
				-->
				
				<form name="registrationForm" method="post" action="">
				
				<!-- organization information -->
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("OrgReg_OrgInfo") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt="" /></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt="" /></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<%= storeText.getString("OrgReg_Text1") %>
					
					<!-- organization information (part 1) -->
					<tr>
						<td colspan="2" ><br /><label for="org_<%= ECUserConstants.EC_ORG_ORGENTITYNAME %>"><%= storeText.getString("OrgReg_OrgName") %></label></td>
					</tr>
					<tr>
						<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ORG_ORGENTITYNAME %>" name="org_<%= ECUserConstants.EC_ORG_ORGENTITYNAME %>" value="<%= strOrganizationName %>" size="45" maxlength="128" /></td>
					</tr>
					<tr>
						<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ORG_DESCRIPTION %>"><%= storeText.getString("OrgReg_Description") %></label></td>
					</tr>
					<tr>
						<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ORG_DESCRIPTION %>" name="org_<%= ECUserConstants.EC_ORG_DESCRIPTION %>" value="<%= strOrganizationDescription %>" size="45" maxlength="512" /></td>
					</tr>
					<tr>
						<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ORG_BUSINESSCATEGORY %>"><%= storeText.getString("OrgReg_BusCategory") %></label></td>
					</tr>
					<tr>
						<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ORG_BUSINESSCATEGORY %>" name="org_<%= ECUserConstants.EC_ORG_BUSINESSCATEGORY %>" value="<%= strOrganizationBusCategory %>" size="45" maxlength="128" /></td>
					</tr>
					
					<% if(locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")) { %>
						<tr>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
						</tr>
						<tr>
							<td>
							<select id="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'org_')">
							<%
							if (strOrganizationCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
							</select>
							</td>
							<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationZipCode %>" size="45" maxlength="40" /></td>
						</tr>
						<tr>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
						</tr>
						<tr>
							<td>
								<div id="org_stateDiv">
	<%
    	if (!strOrganizationCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
	<%
	}
	%>
							</div>
							</td>
							<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_CITY %>" name="org_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationCity %>" size="45" maxlength="128" /></td>
						</tr>
						<tr>
							<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
					<% } else if(locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) { %>
						<tr>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							<td><label for="org_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
						</tr>
						<tr>
							<td>
							<select id="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'org_')">
							<%
							if (strOrganizationCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
							</select>
							</td>
							<td>
								<div id="org_stateDiv">
	<%
    	if (!strOrganizationCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
	<%
	}
	%>
							</div>
							</td>
						</tr>
						<% if(locale.toString().equals("zh_CN")) { %>
							<tr>
								<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
							</tr>
							<tr>
								<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_CITY %>" name="org_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationCity %>" size="45" maxlength="128" /></td>
							</tr>
						<% } else { %>
							<tr>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_CITY %>" name="org_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationCity %>" size="45" maxlength="128" />&nbsp;</td>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationZipCode %>" size="45" maxlength="40" /></td>
							</tr>
						<% } %>
						<tr>
							<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
						<% if(locale.toString().equals("zh_CN")) { %>
							<tr>
								<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationZipCode %>" size="90" maxlength="40" /></td>
							</tr>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("OrgReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="org_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
						<% if(locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES")) { %>
							<tr>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationZipCode %>" size="45" maxlength="40" />&nbsp;</td>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_CITY %>" name="org_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationCity %>" size="45" maxlength="128" /></td>
							</tr>
							<tr>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							</tr>
							<tr>
								<td>
									<div id="org_stateDiv">
	<%
    	if (!strOrganizationCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
	<%
	}
	%>
								</div>
								</td>
								<td>
								<select id="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'org_')">
							<%
							if (strOrganizationCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
								</select>
								</td>
							</tr>
						<% } else { %>
							<tr>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_CITY %>" name="org_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationCity %>" size="45" maxlength="128" />&nbsp;</td>
								<td>
									<div id="org_stateDiv">
	<%
    	if (!strOrganizationCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="org_<%= ECUserConstants.EC_ADDR_STATE %>" name="org_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationState %>" size="45" maxlength="128" />
	<%
	}
	%>
									</div>
								</td>
							</tr>
							<tr>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
								<td><label for="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td>
								<select id="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="org_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'org_')">
							<%
							if (strOrganizationCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
								</select>
								</td>
								<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="org_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationZipCode %>" size="45" maxlength="40" /></td>
							</tr>
						<% } %>
					<% } %>
					<tr>
						<td colspan="2" >&nbsp;</td>
					</tr>
					
					<!-- organization information (part 2) -->
					<tr>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_EMAIL1 %>"><%= storeText.getString("OrgReg_ContactEmail1") %></label></td>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_EMAIL2 %>"><%= storeText.getString("OrgReg_ContactEmail2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_EMAIL1 %>" name="org_<%= ECUserConstants.EC_ADDR_EMAIL1 %>" value="<%= strOrganizationContactEmail1 %>" size="45" maxlength="256" />&nbsp;</td>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_EMAIL2 %>" name="org_<%= ECUserConstants.EC_ADDR_EMAIL2 %>" value="<%= strOrganizationContactEmail2 %>" size="45" maxlength="256" /></td>
					</tr>
					<tr>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_PHONE1 %>"><%= storeText.getString("OrgReg_ContactPhone1") %></label></td>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_PHONE2 %>"><%= storeText.getString("OrgReg_ContactPhone2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_PHONE1 %>" name="org_<%= ECUserConstants.EC_ADDR_PHONE1 %>" value="<%= strOrganizationContactPhone1 %>" size="45" maxlength="32" />&nbsp;</td>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_PHONE2 %>" name="org_<%= ECUserConstants.EC_ADDR_PHONE2 %>" value="<%= strOrganizationContactPhone2 %>" size="45" maxlength="32" /></td>
					</tr>
					<tr>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_FAX1 %>"><%= storeText.getString("OrgReg_ContactFax1") %></label></td>
						<td><label for="org_<%= ECUserConstants.EC_ADDR_FAX2 %>"><%= storeText.getString("OrgReg_ContactFax2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_FAX1 %>" name="org_<%= ECUserConstants.EC_ADDR_FAX1 %>" value="<%= strOrganizationContactFax1 %>" size="45" maxlength="32" />&nbsp;</td>
						<td><input type="text" id="org_<%= ECUserConstants.EC_ADDR_FAX2 %>" name="org_<%= ECUserConstants.EC_ADDR_FAX2 %>" value="<%= strOrganizationContactFax2 %>" size="45" maxlength="32" /></td>
					</tr>
					<tr>
						<td colspan="2" ><label for="org_<%= ECUserConstants.EC_ADDR_BESTCALLINGTIME %>"><%= storeText.getString("OrgReg_ContactBestCallTime") %></label></td>
					</tr>
					<tr>
						<td colspan="2" >
						<select id="org_<%= ECUserConstants.EC_ADDR_BESTCALLINGTIME %>" name="org_<%=ECUserConstants.EC_ADDR_BESTCALLINGTIME%>">
						<% if (strOrganizationBestCallingTime.equals ("")) { %>
							<option selected="selected" value="">&nbsp;</option>
						<% } else { %>
							<option value="">&nbsp;</option>
						<% }
						for (int i = 1; i < 3; i++) {
							String sCallTime = "OrgReg_ContactBestCallTime" + i;
							String sCallTimeValue = "OrgReg_ContactBestCallTime" + i+"Value";
						%>
							<option  value="<%=constantsHelperMap.get(sCallTimeValue)%>"<%= (strOrganizationBestCallingTime != null && strOrganizationBestCallingTime.equals (constantsHelperMap.get(sCallTimeValue)))? "selected=\"selected\"" : "" %>>
							<%= storeText.getString(sCallTime) %>
							</option>
						<% } %>
						</select>
						</td>
					</tr>
				</table>
				<br />
				
				<!-- admin information -->
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td width="349" class="titlebar"><%= storeText.getString("OrgReg_AdminInfo") %></td>
						<td align="right" width="267"><img src="<%= fileDir %>images/title_bar_grad.jpg" width="267" height="23" border="0" alt="" /></td>
					</tr>
					<tr>
						<td colspan="2"><img src="<%= fileDir %>images/title_bar_line.gif" width="616" height="4" border="0" alt="" /></td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<%= storeText.getString("OrgReg_Text2") %>
					<!-- admin information (part 1) -->
					<tr>
						<td colspan="2" ><br /><label for="usr_<%= ECUserConstants.EC_UREG_LOGONID %>"><%= storeText.getString("OrgReg_AdminLogonID") %></label></td>
					</tr>
					<tr>
						<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_UREG_LOGONID %>" name="usr_<%= ECUserConstants.EC_UREG_LOGONID %>" value="<%= strOrganizationAdminLogonID %>" size="45" maxlength="254" /></td>
					</tr>
					<tr>
						<td><label for="<%= ECUserConstants.EC_UREG_LOGONPASSWORD %>"><%= storeText.getString("OrgReg_AdminPassword") %></label></td>
						<td><label for="<%= ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY %>"><%= storeText.getString("OrgReg_AdminVerifyPassword") %></label></td>
					</tr>
					<tr>
						<td><input type="password" autocomplete="off" id="<%= ECUserConstants.EC_UREG_LOGONPASSWORD %>" name="<%= ECUserConstants.EC_UREG_LOGONPASSWORD %>" value="<%= strOrganizationAdminPwd %>" size="45" maxlength="128" />&nbsp;</td>
						<td><input type="password" autocomplete="off" id="<%= ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY %>" name="<%= ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY %>" value="<%= strOrganizationAdminVerifyPwd %>" size="45" maxlength="128" /></td>
					</tr>
					<tr>
						<td><label for="usr_<%= ECUserConstants.EC_UREG_CHALLENGEQUESTION %>"><%= storeText.getString("OrgReg_AdminQuestion") %></label></td>
						<td><label for="usr_<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>"><%= storeText.getString("OrgReg_AdminAnswer") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_UREG_CHALLENGEQUESTION %>" name="usr_<%= ECUserConstants.EC_UREG_CHALLENGEQUESTION %>" value="<%= strOrganizationAdminQuestion %>" size="45" maxlength="254" />&nbsp;</td>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>" name="usr_<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>" value="<%= strOrganizationAdminAnswer %>" size="45" maxlength="254" /></td>
					</tr>
					<% if(locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) { %>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>"><%= storeText.getString("OrgReg_AdminLName") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>"><%= storeText.getString("OrgReg_AdminFName") %></label></td>
						</tr>
						<tr>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>" name="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>" value="<%= strOrganizationAdminLastName %>" size="45" maxlength="128" />&nbsp;</td>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>" name="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>" value="<%= strOrganizationAdminFirstName %>" size="45" maxlength="128" /></td>
						</tr>
						<% if(locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")) { %>
							<tr>
								<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_USER_PREFERREDCURRENCY %>"><%=storeText.getString("OrgReg_AdminCurrency")%></label></td>
							</tr>
							<tr>
								<td colspan="2" >
						<% } else { %>
							<tr>
								<td><br /><label for="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>"><%= storeText.getString("OrgReg_AdminPersonTitle") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_USER_PREFERREDCURRENCY %>"><%=storeText.getString("OrgReg_AdminCurrency")%></label></td>
							</tr>
							<tr>
								<td>
								<select id="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>" name="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>">
								<% if (strOrganizationAdminTitle.equals ("")) { %>
									<option selected="selected" value="">&nbsp;</option>
								<% } else { %>
									<option value="">&nbsp;</option>
								<% }
								for (int i = 1; i < 5; i++) {
									String sPersonTitle = "OrgReg_AdminPersonTitle" + i;
									%>
									<option  value="<%=storeText.getString(sPersonTitle)%>"<%= (strOrganizationAdminTitle != null && strOrganizationAdminTitle.equals (storeText.getString(sPersonTitle)))? "selected=\"selected\"" : "" %>>
									<%=storeText.getString(sPersonTitle)%>
									</option>
								<% } %>
								</select>
								</td>
								<td>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="2" ><br /><label for="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>"><%= storeText.getString("OrgReg_AdminPersonTitle") %></label></td>
						</tr>
						<tr>
							<td colspan="2" >
							<select id="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>" name="usr_<%= ECUserConstants.EC_ADDR_PERSONTITLE %>">
							<% if (strOrganizationAdminTitle.equals ("")) {	%>
								<option selected="selected" value="">&nbsp;</option>
							<% } else { %>
								<option value="">&nbsp;</option>
							<% }
							for (int i = 1; i < 5; i++) {
								String sPersonTitle = "OrgReg_AdminPersonTitle" + i;
								%>
								<option  value="<%=storeText.getString(sPersonTitle)%>"<%= (strOrganizationAdminTitle != null && strOrganizationAdminTitle.equals (storeText.getString(sPersonTitle)))? "selected=\"selected\"" : "" %>>
								<%=storeText.getString(sPersonTitle)%>
								</option>
							<% } %>
							</select>
							</td>
						</tr>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>"><%= storeText.getString("OrgReg_AdminFName") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_MIDDLENAME %>"><%= storeText.getString("OrgReg_AdminMName") %></label></td>
						</tr>
						<tr>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>" name="usr_<%= ECUserConstants.EC_ADDR_FIRSTNAME %>" value="<%= strOrganizationAdminFirstName %>" size="45" maxlength="128" />&nbsp;</td>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_MIDDLENAME %>" name="usr_<%= ECUserConstants.EC_ADDR_MIDDLENAME %>" value="<%= strOrganizationAdminMiddleName %>" size="45" maxlength="128" /></td>
						</tr>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>"><%= storeText.getString("OrgReg_AdminLName") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_USER_PREFERREDCURRENCY %>"><%=storeText.getString("OrgReg_AdminCurrency")%></label></td>
						</tr>
						<tr>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>" name="usr_<%= ECUserConstants.EC_ADDR_LASTNAME %>" value="<%= strOrganizationAdminLastName %>" size="45" maxlength="128" />&nbsp;</td>
							<td>
					<% } %>
					
						<select id="usr_<%= ECUserConstants.EC_USER_PREFERREDCURRENCY %>" name="usr_<%=ECUserConstants.EC_USER_PREFERREDCURRENCY%>">
						<%
							String currency = cmdcontext.getCurrency();
							Vector curr = getSupportedCurrencies(cmdcontext);							
							if (!curr.isEmpty()) {
								for (int i = 0; i <curr.size(); i++) {
									StringPair currStringPair = (StringPair)curr.elementAt(i);
									String currId = currStringPair.getKey();
									String currDesc = currStringPair.getValue();
									
									if (strOrganizationAdminPreferredCurrency != null && !strOrganizationAdminPreferredCurrency.equals("")) {
										if (strOrganizationAdminPreferredCurrency.equals(currId)) { %>
											<option value="<%=currId%>" selected="selected"><%=currDesc%></option>
										<% } else { %>
											<option value="<%=currId%>"><%=currDesc%></option>
										<% }
									} else {
										if (currency.equals(currId)) { %>
											<option value="<%=currId%>" selected="selected"><%=currDesc%></option>
										<% } else { %>
											<option value="<%=currId%>"><%=currDesc%></option>
										<% }
									}
								}
							}
						%>
						</select>
						</td>
					</tr>
					
					<% if(locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")) { %>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
						</tr>
						<tr>
							<td>
							<select id="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'usr_')">
							<%
							if (strOrganizationAdminCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationAdminCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
							</select>
							</td>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationAdminZipCode %>" size="45" maxlength="40" /></td>
						</tr>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
						</tr>
						<tr>
							<td>
								<div id="usr_stateDiv">
	<%
    	if (!strOrganizationAdminCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationAdminCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationAdminState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationAdminState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
	<%
	}
	%>
							</div>
							</td>
							<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_CITY %>" name="usr_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationAdminCity %>" size="45" maxlength="128" /></td>
						</tr>
						<tr>
							<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAdminAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAdminAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAdminAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
					<% } else if(locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) { %>
						<tr>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							<td><label for="usr_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
						</tr>
						<tr>
							<td>
							<select id="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'usr_')">
							<%
							if (strOrganizationAdminCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationAdminCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
							</select>
							</td>
							<td>
								<div id="usr_stateDiv">
	<%
    	if (!strOrganizationAdminCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationAdminCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationAdminState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationAdminState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
	<%
	}
	%>
							</div>
							</td>
						</tr>
						<% if(locale.toString().equals("zh_CN")) { %>
							<tr>
								<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
							</tr>
							<tr>
								<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_CITY %>" name="usr_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationAdminCity %>" size="45" maxlength="128" /></td>
							</tr>
						<% } else { %>
							<tr>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE  %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_CITY %>" name="usr_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationAdminCity %>" size="45" maxlength="128" />&nbsp;</td>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE  %>" name="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationAdminZipCode %>" size="45" maxlength="40" /></td>
							</tr>
						<% } %>
						<tr>
							<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAdminAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAdminAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAdminAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
						<% if(locale.toString().equals("zh_CN")) { %>
							<tr>
								<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationAdminZipCode %>" size="90" maxlength="40" /></td>
							</tr>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>"><%= storeText.getString("OrgReg_Address1") %></label></td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS1 %>" value="<%= strOrganizationAdminAddress1 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address2") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS2 %>" value="<%= strOrganizationAdminAddress2 %>" size="90" maxlength="50" /></td>
						</tr>
						<tr>
						<td colspan="2" >
						<label for="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>"><img src="<%= fileDir %>images/blank.gif" height="1" width="1" border="0" alt="<%= storeText.getString("UsrReg_Address3") %>" /></label>
						</td>
						</tr>
						<tr>
							<td colspan="2" ><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" name="usr_<%= ECUserConstants.EC_ADDR_ADDRESS3 %>" value="<%= strOrganizationAdminAddress3 %>" size="90" maxlength="50" /></td>
						</tr>
						<% if(locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES")) { %>
							<tr>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"name="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationAdminZipCode %>" size="45" maxlength="40" />&nbsp;</td>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_CITY %>"name="usr_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationAdminCity %>" size="45" maxlength="128" /></td>
							</tr>
							<tr>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
							</tr>
							<tr>
								<td>
									<div id="usr_stateDiv">
	<%
    	if (!strOrganizationAdminCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationAdminCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationAdminState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationAdminState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
	<%
	}
	%>
									</div>
								</td>
								<td>
								<select id="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'usr_')">
							<%
							if (strOrganizationAdminCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationAdminCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
								</select>
								</td>
							</tr>
						<% } else { %>
							<tr>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_CITY %>"><%= storeText.getString("OrgReg_City") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_STATE %>"><%= storeText.getString("OrgReg_State") %></label></td>
							</tr>
							<tr>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_CITY %>" name="usr_<%= ECUserConstants.EC_ADDR_CITY %>" value="<%= strOrganizationAdminCity %>" size="45" maxlength="128" />&nbsp;</td>
								<td>
									<div id="usr_stateDiv">
	<%
    	if (!strOrganizationAdminCountry.equals("")) {
    		states = countryDB.getStates(strOrganizationAdminCountry);
		
		if (states != null && states.length != 0) {
		%>
			<select id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>">
			<%
			if (strOrganizationAdminState.equals("")) {
			%>
				<option value="" selected="selected">
			<%
			} else {
			%>
				<option value="">
			<%
			}
			
			for (int k=0; k<states.length; k++) {
				if (strOrganizationAdminState.equals(states[k].getCode())) {
				%>
					<option value="<%= states[k].getCode() %>" selected="selected"><%= states[k].getDisplayName() %>
				<%
				} else {
				%>
					<option value="<%= states[k].getCode() %>"><%= states[k].getDisplayName() %>
				<%
				}
			}
			%>
			</select>
			<%
		} else {
		%>
			<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
		<%
		}
	} else {
	%>
		<input type="text" id="usr_<%= ECUserConstants.EC_ADDR_STATE %>" name="usr_<%= ECUserConstants.EC_ADDR_STATE %>" value="<%= strOrganizationAdminState %>" size="45" maxlength="128" />
	<%
	}
	%>
								</div>
								</td>
							</tr>
							<tr>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>"><%= storeText.getString("OrgReg_Country") %></label></td>
								<td><label for="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>"><%= storeText.getString("OrgReg_ZipCode") %></label></td>
							</tr>
							<tr>
								<td>
								<select id="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" name="usr_<%= ECUserConstants.EC_ADDR_COUNTRY %>" onChange="javascript:loadStatesUI(document.registrationForm, 'usr_')">
							<%
							if (strOrganizationAdminCountry.equals("")) {
							%>
								<option value="" selected="selected">
							<%
							}
							else
							{
							%>
								<option value="">
							<%
							}
							%>
	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		if (strOrganizationAdminCountry.equals(aCountry.getCode())) {
		%>
			<option value="<%= aCountry.getCode() %>" selected="selected"><%= aCountry.getDisplayName() %>
		<%
		}
		else
		{
		%>
			<option value="<%= aCountry.getCode() %>"><%= aCountry.getDisplayName() %>
	<%
		}
	}
	%>
								</select>
								</td>
								<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" name="usr_<%= ECUserConstants.EC_ADDR_ZIPCODE %>" value="<%= strOrganizationAdminZipCode %>" size="45" maxlength="40" /></td>
							</tr>
						<% } %>
					<% } %>
					<tr>
						<td colspan="2" >&nbsp;</td>
					</tr>
					
					<!-- admin information (part 2) -->
					<tr>
						<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION %>"><%= storeText.getString("OrgReg_AdminPreferredComm") %></label></td>
					</tr>
					<tr>
						<td colspan="2" >
						<select id="usr_<%= ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION %>" name="usr_<%=ECUserConstants.EC_UPROF_PREFERREDCOMMUNICATION%>">
						<% if (strOrganizationAdminPreferredCommunication.equals ("")) { %>
							<option selected="selected" value="">&nbsp;</option>
						<% } else { %>
							<option value="">&nbsp;</option>
						<% } 
						for (int i = 1; i < 5; i++) {
							String sComm = "OrgReg_AdminPreferredComm" + i;
							String sCommValue = "OrgReg_AdminPreferredComm" + i+"Value";
							%>
							<option  value="<%= constantsHelperMap.get(sCommValue) %>"<%= (strOrganizationAdminPreferredCommunication != null && strOrganizationAdminPreferredCommunication.equals (constantsHelperMap.get(sCommValue)))? "selected=\"selected\"" : "" %>>
							<%= storeText.getString(sComm) %>
							</option>
						<% } %>
						</select>
						</td>
					</tr>
					<tr>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_EMAIL1 %>"><%= storeText.getString("OrgReg_AdminContactEmail1") %></label></td>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_EMAIL2 %>"><%= storeText.getString("OrgReg_AdminContactEmail2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_EMAIL1 %>" name="usr_<%= ECUserConstants.EC_ADDR_EMAIL1 %>" value="<%= strOrganizationAdminContactEmail1 %>" size="45" maxlength="256" />&nbsp;</td>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_EMAIL2 %>" name="usr_<%= ECUserConstants.EC_ADDR_EMAIL2 %>" value="<%= strOrganizationAdminContactEmail2 %>" size="45" maxlength="256" /></td>
					</tr>
					<tr>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_PHONE1 %>"><%= storeText.getString("OrgReg_AdminContactPhone1") %></label></td>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_PHONE2 %>"><%= storeText.getString("OrgReg_AdminContactPhone2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_PHONE1 %>" name="usr_<%= ECUserConstants.EC_ADDR_PHONE1 %>" value="<%= strOrganizationAdminContactPhone1 %>" size="45" maxlength="32" />&nbsp;</td>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_PHONE2 %>" name="usr_<%= ECUserConstants.EC_ADDR_PHONE2 %>" value="<%= strOrganizationAdminContactPhone2 %>" size="45" maxlength="32" /></td>
					</tr>
					<tr>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_FAX1 %>"><%= storeText.getString("OrgReg_AdminContactFax1") %></label></td>
						<td><label for="usr_<%= ECUserConstants.EC_ADDR_FAX2 %>"><%= storeText.getString("OrgReg_AdminContactFax2") %></label></td>
					</tr>
					<tr>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_FAX1 %>" name="usr_<%= ECUserConstants.EC_ADDR_FAX1 %>" value="<%= strOrganizationAdminContactFax1 %>" size="45" maxlength="32" />&nbsp;</td>
						<td><input type="text" id="usr_<%= ECUserConstants.EC_ADDR_FAX2 %>" name="usr_<%= ECUserConstants.EC_ADDR_FAX2 %>" value="<%= strOrganizationAdminContactFax2 %>" size="45" maxlength="32" /></td>
					</tr>
					<tr>
						<td colspan="2" ><label for="usr_<%= ECUserConstants.EC_ADDR_BESTCALLINGTIME %>"><%= storeText.getString("OrgReg_AdminContactBestCallTime") %></label></td>
					</tr>
					<tr>
						<td colspan="2" >
						<select id="usr_<%= ECUserConstants.EC_ADDR_BESTCALLINGTIME %>" name="usr_<%=ECUserConstants.EC_ADDR_BESTCALLINGTIME%>">
						<% if (strOrganizationAdminBestCallingTime.equals ("")) { %>
							<option selected="selected" value="">&nbsp;</option>
						<% } else { %>
							<option value="">&nbsp;</option>
						<% }
						for (int i = 1; i < 3; i++) {
							String sCallTime = "OrgReg_AdminContactBestCallTime" + i;
							String sCallTimeValue = "OrgReg_AdminContactBestCallTime" + i+"Value";
						%>
							<option  value="<%=constantsHelperMap.get(sCallTimeValue)%>"<%= (strOrganizationAdminBestCallingTime != null && strOrganizationAdminBestCallingTime.equals (constantsHelperMap.get(sCallTimeValue)))? "selected=\"selected\"" : "" %>>
							<%= storeText.getString(sCallTime) %>
							</option>
						<% } %>
						</select>
						</td>
					</tr>
				</table>
				<br />
				
				
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td colspan="3" ><button type="button" name="registrationButton" id="form" onclick="javascript:submitRegistration();"><%= storeText.getString("registrationSubmit") %></button></td>
					</tr>
				</table>
				
				<!--registration type -->
				<input type="hidden" name="registrationCmdName" value="ResellerRegistrationAdd" />
				
				
				<input type="hidden" name="<%= ECConstants.EC_STORE_ID %>" value="<c:out value='<%= storeId %>' />" />
				<input type="hidden" name="<%= ECConstants.EC_LANGUAGE_ID %>" value="<c:out value='<%= langId %>' />" />
				<input type="hidden" name="actionName" value="registration" />
				<input type="hidden" name="emailError" value="" />
				<input type="hidden" name="<%= ECConstants.EC_URL %>" value="OrgRegistrationAddSuccessView?<%= ECConstants.EC_STORE_ID %>=<c:out value='<%= storeId %>' />&amp;<%= ECConstants.EC_LANGUAGE_ID %>=<c:out value='<%= langId %>' />&amp;actionName=registration" />
				<input type="hidden" name="<%= ECConstants.EC_ERROR_VIEWNAME %>" value="OrgRegistrationAddFormView" />
				
				<input type="hidden" name="usr_profileType" value="B">
				<input type="hidden" name="<%= ECUserConstants.EC_ORG_ORGENTITYTYPE %>" value="<%= ECUserConstants.EC_ORG_ORGANIZATION %>" />
				</form>

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
