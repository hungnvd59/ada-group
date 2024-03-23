<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/assets/images/logos/favicon.png"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.min.css"/>
</head>

<body>
<!--  Body Wrapper -->
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
     data-sidebar-position="fixed" data-header-position="fixed">
    <div
            class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
        <div class="d-flex align-items-center justify-content-center w-100">
            <div class="row justify-content-center w-100">
                <div class="col-md-8 col-lg-6 col-xxl-3">
                    <div class="card mb-0">
                        <div class="card-body">
                            <a href="<%=request.getContextPath()%>/"
                               class="text-center d-block" style="margin-bottom: 2rem">
                                <img src="<%=request.getContextPath()%>/assets/images/ada_logo.png" width="100"
                                     alt="">
                            </a>
                            <form name='loginForm' style="text-align: center"
                                  action="<c:url value='/j_spring_security_check'/>" method="POST">
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <label class="form-label">Tài khoản</label>
                                    </div>
                                    <div class="col-sm-9">
                                        <input for="" type="text"
                                               id="username"
                                               name="username" placeholder="Tên đăng nhập" required
                                               class="form-control">
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <label for="" class="form-label">Mật khẩu</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <input type="password" id="password" name="password"
                                                   placeholder="Mật khẩu" required class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" style="text-align: center;width: 100%">
                                        <spring:message
                                                code="${error}"/></div>
                                </c:if>
<%--                                <div class="d-flex align-items-center justify-content-between mb-4">--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input name="_spring_security_remember_me" class="form-check-input primary"--%>
<%--                                               type="checkbox" value="" id="flexCheckChecked" checked>--%>
<%--                                        <label class="form-check-label text-dark" for="flexCheckChecked">--%>
<%--                                            Ghi nhớ tài khoản--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
                                <button type="submit" class="btn btn-warning w-100 py-8 fs-4 mb-4 rounded-2">Đăng
                                    nhập
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/assets/libs/jquery/dist/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

