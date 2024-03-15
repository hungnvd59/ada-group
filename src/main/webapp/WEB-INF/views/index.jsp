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


<style>
    .count {
        font-size: 30px;
        font-weight: 600;
    }

    .green-special {
        color: #1ABB9C;
    }

    .nau-xam {
        color: #73879C;
        font-weight: 400;
        font-size: 13px;
    }

    .red {
        color: #E74C3C;
    }

    #container {
        min-height: 350px;
        max-height: 600px;
        margin: 0 auto;
    }
</style>

<!--<section id="content">
<section class="vbox">
<section class="scrollable padder" style="background: white">
<ul class="bg-primary breadcrumb no-border no-radius b-b b-light pull-in">
<li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
</ul>
<div class="m-b-md">
<small><span class="text-success"><sec:authentication property="principal.fullName"/></span>, mừng bạn trở lại.</small>
</div>
</section>
</section>
<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>-->
<section style="color: #1F2937;" id="content">
    <section class="vbox">
        <section class="scrollable padder" style="background: white">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
            </ul>
            <div class="row">
                <div class="wrapper-lg">
                    <h3 class="m-b-xs font-bold m-t-none">Hello, <sec:authentication
                            property="principal.fullName"/></h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-2">

                </div>
                <div class="col-lg-8">
                    <img style="width: 100%" class="center-pill" src="<%=request.getContextPath()%>/assets/images/HomeOSP.png">
                </div>
                <div class="col-lg-2">

                </div>
            </div>

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen, open" data-target="#nav,html"></a>
</section>

<script src="<%=request.getContextPath()%>/assets/note/js/calendar/bootstrap_calendar.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/calendar/demo.js"></script>

<script src="<%=request.getContextPath()%>/assets/note/js/sortable/jquery.sortable.js"></script>

<script src="<%=request.getContextPath()%>/assets/note/js/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/jvectormap/demo.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/app.plugin.js"></script>
