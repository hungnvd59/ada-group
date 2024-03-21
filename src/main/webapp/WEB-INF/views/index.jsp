<%@page import="com.ada.model.User" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    User user = (User) request.getSession().getAttribute("userLogin");
    request.setAttribute("userLogin", user);
%>
</style>
<div class="container-fluid" style="padding: 0">
    <img src="<%=request.getContextPath()%>/assets/images/backgroup_main.jpg" width="100%">
</div>
<%-- --%>