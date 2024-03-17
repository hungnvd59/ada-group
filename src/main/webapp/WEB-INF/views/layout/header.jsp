<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
    .userLG{
        color: whitesmoke;
    }
    .userLG:hover{
        color: #FFFFFF;
        cursor: pointer;
    }
    .nav-user > li > a:hover{
        background-color: transparent;
    }
</style>
<header class="bg-secondary dk header navbar navbar-fixed-top-xs" style="background-color: #222222">

    <div class="navbar-header aside-md ">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
            <i class="fa fa-bars"></i>
        </a>
        <a href="<%=request.getContextPath()%>/" class="navbar-brand" data-toggle="fullscreen1111"><img
                src="<%=request.getContextPath()%>/assets/images/logo-osp.png" class="m-r-sm" style="max-height: 45px;"></a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user">
            <i class="fa fa-cog"></i>
        </a>
    </div>
    <ul class="nav navbar-nav navbar-right hidden-xs nav-user" style="margin-top: 10px;margin-right: 15px;color: #FFFFFF">
        <li style="border-radius: 20px;border:1px solid #FFF" class="dropdown"><a style=";padding-bottom: 5px;padding-top: 5px" class="dropdown-toggle userLG" onclick="myFunction()">
            <%=request.getRemoteUser()%> <b class="caret"></b>
        </a>
            <ul id="myDropdown" class="dropdown-menu animated fadeInRight">
                <li><a
                        href="<%=request.getContextPath()%>/cap-nhat-thong-tin-tai-khoan.html">Hồ sơ</a></li>
                <li><a href="docs.html">Trợ giúp</a></li>
                <li class="divider"></li>
                <li><a href="<c:url value="/j_spring_security_logout" />">Đăng
                    xuất</a></li>
            </ul>
        </li>
    </ul>

</header>

<script>
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }

    document.getElementsByClassName("userLG").onclick = function (event) {
        var dropdowns = document.getElementsByClassName("dropdown-menu");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }

</script>

