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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.min.css"/>

<aside class="left-sidebar">
    <!-- Sidebar scroll-->
    <div>
        <div class="brand-logo d-flex align-items-center justify-content-between">
            <a href="<%=request.getContextPath()%>/" class="text-nowrap logo-img">
                <img src="<%=request.getContextPath()%>/assets/images/logos/logo.png" width="225" alt=""/>
            </a>
            <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
                <i class="ti ti-x fs-8"></i>
            </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
            <ul id="sidebarnav">
                <li class="nav-small-cap">
                    <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                    <span class="hide-menu">Trang chủ</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link <%= (!isActive(request.getContextPath() + "/customer", request)
                        & !isActive(request.getContextPath() + "/system", request)
                        & !isActive(request.getContextPath() + "/system/", request)
                        & !isActive(request.getContextPath() + "/customer/", request)) ? "active" : "" %>"
                       href="<%=request.getContextPath()%>/" aria-expanded="false">
                <span>
                  <i class="ti ti-layout-dashboard"></i>
                </span>
                        <span class="hide-menu">Trang chủ</span>
                    </a>
                </li>
                <li class="nav-small-cap">
                    <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                    <span class="hide-menu">Quản lý tài khoản</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link <%= (isActive(request.getContextPath() + "/customer", request)
                        & isActive(request.getContextPath() + "/customer/", request)) ? "active" : "" %>"
                       href="<%=request.getContextPath()%>/customer/quan-ly-dai-ly.html " aria-expanded="false">
                <span>
                  <i class="ti ti-user"></i>
                </span>
                        <span class="hide-menu">Quản lý nhân viên</span>
                    </a>
                </li>
                <li class="nav-small-cap">
                    <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                    <span class="hide-menu">Quản lý hệ thống</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="./ui-alerts.html" aria-expanded="false">
                <span>
                  <i class="ti ti-user-circle"></i>
                </span>
                        <span class="hide-menu">Người dùng hệ thống</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="./authentication-login.html" aria-expanded="false">
                <span>
                  <i class="ti ti-login"></i>
                </span>
                        <span class="hide-menu">Quản lý nhóm quyền</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="./authentication-register.html" aria-expanded="false">
                <span>
                  <i class="ti ti-user-plus"></i>
                </span>
                        <span class="hide-menu">Chức năng hệ thống</span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</aside>