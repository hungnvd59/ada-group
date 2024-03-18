<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Đăng nhập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- CSS -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/images/favion/favion.png"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/login/css/login.css">
    <style>
        .errorss {
            padding: 5px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
            position: absolute;
            top: 15rem;
            left: 2%;
        }

        section {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            width: 100%;
        <%--background: url('<%=request.getContextPath()%>/assets/image/img_login_bg.jpg') no-repeat;--%> background-color: #222222;
            background-position: center;
            background-size: cover;
        }
    </style>
</head>
<body onload='document.loginForm.password.focus();document.loginForm.username.focus();'>
<section>
    <div class="form-box">
        <div class="form-value">
            <form name='loginForm' style="text-align: center"
                  action="<c:url value='/j_spring_security_check'/>" method="POST">
                <h2>Đăng nhập hệ thống</h2>
                <div class="inputbox">
                    <ion-icon name="mail-outline"></ion-icon>
                    <input type="text"
                           id="username"
                           name="username" placeholder="Tên đăng nhập" required>
                    <c:if test="${not empty error}">
                        <div class="errorss" style="text-align: center;width: 92%"><spring:message
                                code="${error}"/></div>
                    </c:if>
                    <label for="">Tên đăng nhập</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="password" id="password" name="password"
                           placeholder="Mật khẩu" required>
                    <label for="">Mật khẩu</label>
                </div>
                <div class="forget">
                    <label>
                        <input type="checkbox" value="yes"
                               name="_spring_security_remember_me"> Ghi nhớ tài khoản
                    </label>
                </div>
                <button type="submit" class="btn btn-primary">Đăng nhập</button>
            </form>
        </div>
    </div>
</section>
<script src="<%=request.getContextPath()%>/assets/login/js/jquery-1.8.2.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/login/js/supersized.3.2.7.min.js"></script>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>
<script>
</script>
</html>

