<%@ page import="com.ada.model.User" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
    User user = (User) request.getSession().getAttribute("userLogin");
    request.setAttribute("userLogin", user);
%>

<header class="app-header">
    <c:set var="typeUser" scope="page"><sec:authentication property="principal.type"/></c:set>
    <nav class="navbar navbar-expand-lg navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item d-block d-xl-none">
                <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse" href="javascript:void(0)">
                    <i class="ti ti-menu-2"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-icon-hover" href="javascript:void(0)"></a>
            </li>
        </ul>
        <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                <li style="text-align: right;">
                    <h6 class="mb-0 fs-4 fw-semibold"><%=request.getRemoteUser()%>
                    </h6>
                    <c:if test="${pageScope.typeUser == 0}">
                        <span class="fs-2">Hỗ trợ kỹ thuật</span>
                    </c:if>
                    <c:if test="${pageScope.typeUser == 1}">
                        <span class="fs-2">CEO - ADA GROUP</span>
                    </c:if>
                    <c:if test="${pageScope.typeUser == 2}">
                        <span class="fs-2">CEO - Kim cương</span>
                    </c:if>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <img src="<%=request.getContextPath()%>/assets/images/ada_logo.png" alt="" width="35"
                             height="35" class="rounded-circle">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                        <div class="message-body">
                            <a href="<%=request.getContextPath()%>/system/user/thong-tin-ca-nhan.html"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-user-circle fs-6"></i>
                                <p class="mb-0 fs-3">Thông tin cá nhân</p>
                            </a>
                            <a href="<c:url value="/j_spring_security_logout" />"
                               class="btn btn-warning mx-3 mt-2 d-block"><i class="ti ti-logout"></i> &nbsp;Đăng xuất</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</header>


