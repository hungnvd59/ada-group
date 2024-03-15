<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<!DOCTYPE html>
<html lang="en" class="bg-white" style="background-color: whitesmoke">
<head>
    <meta charset="utf-8"/>
    <title><spring:message code="label.login.header"></spring:message></title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/osp.ico"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/bootstrap.css" type="text/css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/animate.css" type="text/css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/font-awesome.min.css" type="text/css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/font.css" type="text/css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/app.css" type="text/css"/>
    <!--[if lt IE 9]>
    <script src="<%=request.getContextPath()%>/assets/note/js/ie/html5shiv.js"></script>
    <script src="<%=request.getContextPath()%>/assets/note/js/ie/respond.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/note/js/ie/excanvas.js"></script>
    <![endif]-->
</head>
<body class="">
<style>
    .navbar-brand img {
        max-height: 50px;
    }
    .errorss {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
}  
</style>
<div class="forgot-grid">
 <!--<a href="?lang=en" style="float: right;"><img src="<%=request.getContextPath()%>/assets/images/icon/language_en.png" title="English"></a> | <a style="float: right;" href="?lang=vi"><img src="<%=request.getContextPath()%>/assets/images/icon/language_vi.png" title="Vietnamese"></a>-->
                       </div>
<section id="content" class="m-t-lg wrapper-md animated fadeInUp">
    <div class="row" style="height: 100px;"></div>
    <div class="container aside-xxl">
        <%--<a class="navbar-brand block" href="index.html"><img src="#" class="img-rounded"></a>--%>
        <section class="panel panel-default bg-white m-t-lg vertical-center" style="border-radius: 15px;">
            <header class="panel-heading text-center" style="border-top-left-radius: 15px;border-top-right-radius: 15px; font-weight: bold; font-size: 15px;">
<%--                <spring:message code="label.login.title"/>--%>
                Đăng nhập hệ thống
            </header>
            <form action="<c:url value='/j_spring_security_check'/>" class="panel-body wrapper-lg" method="post"
                  class="form-group ">
                <c:if test="${not empty error}">
                        <div class="errorss">
  <spring:message code="${error}"/>
  </div>
                </c:if>
                <div class="form-group">
                    <label class="control-label"><spring:message code="label.login.input.username"/></label>
                    <input style="border-radius: 15px;" id="username" name="username" placeholder="<spring:message code='label.login.input.username'/>" class="form-control input-lg">
                </div>
                <div class="form-group">
                    <label class="control-label"><spring:message code="label.login.input.password"/></label>
                    <input style="border-radius: 15px;" type="password" id="password" name="password" placeholder="<spring:message code='label.login.input.password'/>" class="form-control input-lg">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" id="rememberme" name="remember-me"><label style="padding-top: 3px;"> <spring:message code="label.login.remember"/></label>
                    </label>
                </div>

                <button style="border-radius: 15px;" type="submit" class="btn btn-primary"><spring:message code="label.login.title"/></button>
                <div class="line line-dashed"></div>
            </form>
        </section>
    </div>
</section>

<!-- footer -->
<footer id="footer">
    <div class="text-center padder">
        <p>
            <small>OSP &copy; 2019</small>
        </p>
    </div>
</footer>
<!-- / footer -->
<script src="<%=request.getContextPath()%>/assets/note/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="<%=request.getContextPath()%>/assets/note/js/bootstrap.js"></script>
<!-- App -->
<script src="<%=request.getContextPath()%>/assets/note/js/app.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/app.plugin.js"></script>
<script>

</script>
</body>
</html>