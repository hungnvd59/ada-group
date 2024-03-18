<%@ page pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<!-- .aside -->
<%!
    public boolean isActive(String navPath, HttpServletRequest request) {
        String namespace = (String) request.getAttribute("javax.servlet.forward.request_uri");
        if (namespace.startsWith(navPath)) {
            return true;
        }
        return false;
    }

    ;

    public boolean isActiveIndex(String navPath, HttpServletRequest request) {
        String namespace = (String) request.getAttribute("javax.servlet.forward.request_uri");
        if (namespace.equals(navPath)) {
            return true;
        }
        return false;
    }

    public boolean isNavXs(HttpServletRequest request) {
        if (request.getSession().getAttribute("nav-xs") != null) {
            Boolean thugon = (Boolean) request.getSession().getAttribute("nav-xs");
            if (thugon.equals(true)) {
                return true;
            }
        }
        return false;
    }
//    public boolean isSun(HttpServletRequest request){
//        if(request.getSession().getAttribute("sun-moon")!=null){
//            Boolean sun=(Boolean) request.getSession().getAttribute("sun-moon");
//            return sun;
//        }
//        return false;
//    }

%>
<aside class="bg-dark b-r aside-md hidden-print" id="nav">
    <section class="vbox">
        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto"
                 data-disable-fade-out="true" data-distance="0" data-size="5px"
                 data-color="#333333">
                <nav class="nav-primary hidden-xs">
                    <ul class="nav">
                        <%
                            request.setAttribute("userName", request.getRemoteUser());
                        %>
                        <li class="<%= (!isActive(request.getContextPath() + "/customer", request)
                        & !isActive(request.getContextPath() + "/system", request)
                        & !isActive(request.getContextPath() + "/system/", request)
                        & !isActive(request.getContextPath() + "/customer/", request)) ? "active" : "" %>">
                            <a href="<%=request.getContextPath()%>/">
                                <i class="fa fa-home icon">
                                </i> <span>Trang chủ</span>
                            </a>
                        </li>
                        <c:set var="typeUser" scope="page"><sec:authentication property="principal.type"/></c:set>
                        <%--USER--%>
                        <%--						<sec:authorize access="hasAnyRole('ROLE_SYSTEM_USER_WEB_LIST','ROLE_SYSTEM_USER_CMS_LIST')">--%>
                        <li class="<%= (isActive(request.getContextPath() + "/customer", request)
                        	& isActive(request.getContextPath() + "/customer/", request)) ? "active" : "" %>">
                            <a href="<%=request.getContextPath()%>/customer/quan-ly-dai-ly.html">
                                <i class="fa fa-user icon">
                                </i> <span>Quản lý đại lý</span>
                            </a>
                        </li>

                        <li class="<%= isActive(request.getContextPath() + "/account", request) ? "active" : ""%>">
                            <a id="<%= isActive(request.getContextPath() + "/account/", request)
                            || isActive(request.getContextPath() + "/account", request)
                        ||isActive(request.getContextPath() + "/account/", request) ? "active" : ""%>"
                               href="<%=request.getContextPath()%>/account/quan-ly-tai-khoan-he-thong.html"> <i
                                    class="fa fa-user icon"
                                    style="padding-top: 12px;padding-bottom: 10px;"></i>  </span>
                                Quản lý tài khoản hệ thống</span> </a>
                        </li>
                        <%--//						</sec:authorize>--%>

                        <%--SYSTEM--%>
                        <%--						<c:if test="${pageScope.typeUser != 2 && pageScope.typeUser != 3}">--%>
                        <%--							<sec:authorize--%>
                        <%--									access="hasAnyRole('ROLE_SYSTEM_GROUP_LIST','ROLE_SYSTEM_AUTHORITY_LIST','ROLE_SYSTEM_PARAMETERS_LIST','ROLE_SYSTEM_LOG_HISTORY')">--%>
                        <li class="<%= isActive(request.getContextPath() + "/system/group", request)
                          || isActive(request.getContextPath() + "/system/authority", request) ? "active" : ""%>">
                            <a class="<%= isActive(request.getContextPath() + "/system/group/", request)
                            || isActive(request.getContextPath() + "/system/authority", request) ? "active" : ""%>"
                               href="#" class=""> <i class="fa fa-cogs icon"></i> <span
                                    class="pull-right"> <i class="fa fa-angle-down text"></i> <i
                                    class="fa fa-angle-up text-active"></i> </span> <span>Quản lý hệ thống</span> </a>
                            <ul class="nav lt">
                                <%--										<sec:authorize--%>
                                <%--												access="hasAnyRole('ROLE_SYSTEM_GROUP_LIST')">--%>
                                <li>
                                    <a href="<%=request.getContextPath()%>/system/group/quan-ly-nhom-quyen.html"
                                       class=""> <i
                                            class="fa fa-angle-right"></i> <span>Nhóm quyền</span> </a></li>
                                <%--										</sec:authorize>--%>
                                <%--										<sec:authorize--%>
                                <%--												access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_LIST')">--%>
                                <li>
                                    <a href="<%=request.getContextPath()%>/system/authority/quan-ly-chuc-nang-he-thong.html"
                                       class=""> <i
                                            class="fa fa-angle-right"></i> <span>Chức năng hệ thống</span> </a></li>
                                <%--										</sec:authorize>--%>
                            </ul>
                        </li>
                        <%--							</sec:authorize>--%>
                        <%--						</c:if>--%>
                    </ul>
                </nav>
                <!-- / nav -->
            </div>
        </section>
        <footer class="footer lt hidden-xs b-t b-light">
            <div id="chat" class="dropup">
                <section class="dropdown-menu on aside-md m-l-n">
                    <section class="panel bg-white">
                        <header class="panel-heading b-b b-light">Active chats</header>
                        <div class="panel-body animated fadeInRight">
                            <p class="text-sm">No active chats.</p>

                            <p>
                                <a href="#" class="btn btn-sm btn-default">Start a chat</a>
                            </p>
                        </div>
                    </section>
                </section>
            </div>
            <div id="invite" class="dropup">
                <section class="dropdown-menu on aside-md m-l-n">
                    <section class="panel bg-white">
                        <header class="panel-heading b-b b-light">
                            John <i class="fa fa-circle text-success"></i>
                        </header>
                        <div class="panel-body animated fadeInRight">
                            <p class="text-sm">No contacts in your lists.</p>
                            <p>
                                <a href="#" class="btn btn-sm btn-facebook">
                                    <i class="fa fa-fw fa-facebook"></i>
                                    Invite from Facebook
                                </a>
                            </p>
                        </div>
                    </section>
                </section>
            </div>
            <a href="#nav" data-toggle="class:nav-xs" class="pull-right btn btn-sm btn-default btn-icon">
                <i class="fa fa-angle-left text"></i>
                <i class="fa fa-angle-right text-active"></i>
            </a>
        </footer>
    </section>
</aside>
<!-- /.aside -->
<script type="text/javascript">
    $(document).ready(function () {
        if (window.location.href.lastIndexOf("/") == window.location.href.length - 1) {
            $(".link-home").addClass("active");
        } else {
            $(".nav-primary .nav li a").each(function () {
                if (!$(this).attr("href").match("/$") && window.location.href.indexOf($(this).attr("href")) >= 0) {
                    if ($(this).parent().parent().parent().is("li")) {
                        $(this).parent().parent().parent().addClass("active");
                        //$(this).parent().css("background-color","#428bca");
                    } else
                        $(this).parent().addClass("active");

                    $(this).css("color", "white");
                }
            });
        }
    });
</script>