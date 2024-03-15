<%@page import="com.ada.model.User" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="https://code.iconify.design/2/2.2.1/iconify.min.js"></script>

<style>
	.selected1 {
		border-top-right-radius: 40px;
		border-bottom-right-radius: 40px;
		background-color: #3F3F46;
		color: #FAFAFA;
		margin-right: 5px;
	}
	.selected2 {
		background-color: #3F3F46;
		color: #FAFAFA;
		margin-right: 5px;
	}
	.nav-primary ul.nav > li > a{
		border-top: none;
	}
</style>

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
<%
	User user = (User) request.getSession().getAttribute("userLogin");
	request.setAttribute("userLogin", user);
%>

<%--<aside class="bg-light lter b-r aside-md hidden-print" id="nav">--%>
<aside style="width: 250px;" class="bg-dark b-r aside-md hidden-print" id="nav">
    <section class="vbox">
        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto"
                 data-disable-fade-out="true" data-distance="0" data-size="5px"
                 data-color="#333333">
                <!-- nav -->
                <nav class="nav-primary hidden-xs" id="menu">
                    <ul style="color: #D4D4D8; size: 16px;" class="nav">
                        <%
							request.setAttribute("userName", request.getRemoteUser());
                        %>
                        <li class="<%= (!isActive(request.getContextPath() + "/partner", request)
                        	& !isActive(request.getContextPath() + "/config-contract", request)
                        	& !isActive(request.getContextPath() + "/transaction", request)
                        	& !isActive(request.getContextPath() + "/reqPayment", request)
                        	& !isActive(request.getContextPath() + "/transReport", request)
                        	& !isActive(request.getContextPath() + "/system", request)
                        	& !isActive(request.getContextPath() + "/history", request)) ? "selected1" : ""%>"><a
                                href="<%=request.getContextPath()%>/">
								<i class="fa fa-home icon"> <b class="bg-primary"></b>
								</i> <span>Dashboard</span>
							</a>
                        </li>
<!--                        <li><a href="<%=request.getContextPath()%>/product/index.html">
								<i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
								<span>Quản lý sản phẩm</span>
							</a>
                        </li>-->
                        <li class="<%= isActive(request.getContextPath() + "/partner", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/partner/index.html"> <i
                                class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
                            <span>Quản lý Cộng tác viên</span>
                        </a>
                        </li>
                        <li class="<%= isActive(request.getContextPath() + "/config-contract", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/config-contract/index.html"> <i
                                class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
                            <span>QL cấu hình hoa hồng</span>
                        </a>
                        </li>

						<sec:authorize access="hasAnyRole('ROLE_PACKAGE_VIEW','ROLE_PACKAGE_EDIT')">
						<li class="<%= isActive(request.getContextPath() + "/package", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/package/index.html"> <i
								class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
							<span>Quản lý sản phẩm</span>
						</a>
						</li>
						</sec:authorize>

                        <li class="<%= isActive(request.getContextPath() + "/transaction", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/transaction/index.html"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
								<span>Danh sách giao dịch</span>
							</a>
                        </li>
<!--                        <li><a href="#uikit"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
								<span>Quản lý thông báo</span>
							</a>
                        </li>-->
                        <li class="<%= isActive(request.getContextPath() + "/reqPayment", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/reqPayment/index.html"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
								<span>Yêu cầu thanh toán</span>
							</a>
                        </li>
<!--                        <li><a href="#uikit"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
								<span>QL yêu cầu hỗ trợ</span>
							</a>
                        </li>-->

                        <li class="<%= isActive(request.getContextPath() + "/transReport", request) ? "selected2" : ""%>"><a id="<%= isActive(request.getContextPath() + "/transReport", request)? "btn" : "btn0"%>" href="#uikit"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i> <span class="pull-right"> <i class="fa fa-angle-down text"></i> <i class="fa fa-angle-up text-active"></i> </span>
								<span>Báo cáo thống kê</span>

							</a>
                            <ul class="nav lt">
                                <li class="<%= isActive(request.getContextPath() + "/transReport/tong-hop-theo-ngay.html", request) ? "active" : ""%>"><a
                                        href="<%=request.getContextPath()%>/transReport/tong-hop-theo-ngay.html">
									<i class="fa fa-angle-right"></i> <span> BC tổng hợp sản lượng theo ngày</span>
									</a></li>
                                <li class="<%= isActive(request.getContextPath() + "/transReport/tong-hop-theo-ctv.html", request) ? "active" : ""%>"><a
                                        href="<%=request.getContextPath()%>/transReport/tong-hop-theo-ctv.html">
									<i class="fa fa-angle-right"></i> <span> BC tổng hợp sản lượng theo CTV</span>
									</a></li>
                                <li class="<%= isActive(request.getContextPath() + "/transReport/tong-hop-theo-divu.html", request) ? "active" : ""%>"><a
                                        href="<%=request.getContextPath()%>/transReport/tong-hop-theo-divu.html">
									<i class="fa fa-angle-right"></i> <span>BC tổng hợp sản lượng theo dịch vụ</span>
									</a></li>
                                <li class="<%= isActive(request.getContextPath() + "/transReport/thong-ke-ctv.html", request) ? "active" : ""%>"><a
                                        href="<%=request.getContextPath()%>/transReport/thong-ke-ctv.html">
									<i class="fa fa-angle-right"></i> <span>BC thống kê Cộng tác viên</span>
									</a></li>
                            </ul>
                        </li>
                        <sec:authorize access="hasAnyRole('ROLE_SYSTEM_USER_VIEW','ROLE_SYSTEM_GROUP_VIEW','ROLE_SYSTEM_LOG_VIEW')">
                            <li class="<%= isActive(request.getContextPath() + "/system", request) ? "selected2" : ""%>"><a id="<%= isActive(request.getContextPath() + "/system/", request)? "btn" : "btn1"%>" href="#" class=""> <i class="fa fa-cogs icon"> <b class="bg-warning"></b> </i> <span class="pull-right"> <i class="fa fa-angle-down text"></i> <i class="fa fa-angle-up text-active"></i> </span> <span><spring:message code="label.system.manager"></spring:message></span> </a>
									<ul class="nav lt">
                                    <sec:authorize access="hasRole('ROLE_SYSTEM_USER_VIEW')">
                                        <li class="<%= isActive(request.getContextPath() + "/system/user", request) ? "active" : ""%>"><a href="<%=request.getContextPath()%>/system/user/list" class=""> <i class="fa fa-angle-right"></i> <span><spring:message code="label.user"></spring:message></span> </a></li>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_SYSTEM_GROUP_VIEW')">
                                        <li class="<%= isActive(request.getContextPath() + "/system/group", request) ? "active" : ""%>"><a href="<%=request.getContextPath()%>/system/group/list" class=""> <i class="fa fa-angle-right"></i> <span><spring:message code="lable.group.role"></spring:message></span> </a></li>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_SYSTEM_AUTHORITY_VIEW')">
                                        <li class="<%= isActive(request.getContextPath() + "/system/authority", request) ? "active" : ""%>"><a href="<%=request.getContextPath()%>/system/authority/list" class=""> <i class="fa fa-angle-right"></i> <span><spring:message code="label.system.function"></spring:message></span> </a></li>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_SYSTEM_PARAMETER_VIEW')">
                                        <li class="<%= isActive(request.getContextPath() + "/system/parameter", request) ? "active" : ""%>"><a href="<%=request.getContextPath()%>/system/parameter/list" class=""> <i class="fa fa-angle-right"></i> <span><spring:message code="label.system.parameter"></spring:message></span> </a></li>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_SYSTEM_LOG_VIEW')">
                                        <li class="<%= isActive(request.getContextPath() + "/system/history", request) ? "active" : ""%>"><a href="<%=request.getContextPath()%>/system/history/list" class=""> <i class="fa fa-angle-right"></i> <span><spring:message code="label.system.history"></spring:message></span> </a></li>
                                        </sec:authorize>
                                </ul>
                            </li>
                        </sec:authorize>
                        <li class="<%= isActive(request.getContextPath() + "/history", request) ? "selected1" : ""%>"><a href="<%=request.getContextPath()%>/history">
                                <i class="fa fa-clock-o icon">
                                    <b class="bg-danger dker"></b>
                                </i><span><spring:message code="label.system.myhistory"></spring:message></span></a>
							</li>
<!--							<li><a href="#uikit"> <i class="fa fa-list-alt icon"><b class="bg-primary"></b></i>
									<span>Quản trị website</span>
								</a>
							</li>-->
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
		<button style="display: none" id="btn"></button>
		</section>
	</aside>


	<script type="text/javascript">
		$(document).ready(function () {
			$('#changeNavXS').click(function () {
				$.ajax({
					type: "get",
					url: "<%=request.getContextPath()%>/change-nav",
					success: function (msg) {
					}
				});
			});
	<%--$.ajax({--%>
	<%--type: "get",--%>
	<%--url: "<%=request.getContextPath()%>/sun-moon",--%>
	<%--success: function(msg){--%>
	<%--}--%>
	<%--});--%>

			//document.getElementById("MyElement").className += " select1";
		});

		$(document).ready(function () {
			document.getElementById("btn").click();
		})
</script>