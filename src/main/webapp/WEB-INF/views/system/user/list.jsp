<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<style>
    .btn-secondary {
        background-color: gray;
        color: white;
    }
    .btn-add {
        border-radius: 10px;
        color: #0c63e4;
        border-color: #0c63e4;
        margin: 0.5px;
    }
</style>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="content" ng-controller="userListCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;<spring:message
                        code="label.system.home"></spring:message></a></li>
                <li><a href="#"><spring:message code="label.user"/></a></li>
                <li><a href="javascript:void(0)"><spring:message code="label.list.user"/></a></li>
            </ul>
            <div>
                <h3><font style="font-weight: bold">DANH SÁCH NGƯỜI DÙNG</font></h3>
            </div>
            <div class="m-b-md"><h3 class="m-b-none" id="sansim-status" style="color: #009900"><c:if
                    test="${success.length()>0}"><spring:message code="${success}"/></c:if></h3></div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form action="list" role="form">
                        <div class="form-group">
                            <div class="col-md-6">
                                <div class="col-sm-8">
                                    <input style="border-radius: 10px;" name="filterUsername" placeholder="Username"
                                           maxlength="50" value="${filterUsername}" class="input form-control"/>
                                </div>
                                <div class="col-sm-4">
                                    <button style="border-radius: 10px;" type="submit" class="btn btn-secondary">
                                        <spring:message code="label.button.search"/></button>
                                </div>
                            </div>
                            <!--                            <div class="col-md-6">
                            <sec:authorize access="hasRole('ROLE_SYSTEM_USER_ADD')">
                                <a class="btn btn-primary pull-right"
                                   href="<%=request.getContextPath()%>/system/user/add"><i class="fa fa-plus"></i> Thêm mới</a>
                            </sec:authorize>
                        </div>-->
                        </div>
                        <div class="line line-dashed line-lg pull-in" style="clear:both ;border-top:0px"></div>
                    </form>
                </div>
            </section>
            <input type="hidden" value="" name="ids" id="ids">
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix">
                    <table class="table table-hover mb-sm-2">
                        <thead>
                        <tr>
                            <th class="box-shadow-inner small_col text-center" style="width: 1%;border-top-left-radius: 20px;">#</th>
                            <th class="box-shadow-inner small_col text-center" style="width: 1%"><input type="checkbox"
                                                                                                        name="chkAll"
                                                                                                        id="chkAll"
                                                                                                        onclick="checkAll('chkAll', 'chk');"/>
                            </th>
                            <th class="box-shadow-inner small_col text-center" style="width: 8%"><spring:message
                                    code="label.login.input.username"/></th>
                            <th class="box-shadow-inner small_col text-center" style="width: 15%"><spring:message
                                    code="label.user.fullname"/></th>
                            <th class="box-shadow-inner small_col text-center" style="width: 10%"><spring:message
                                    code="label.status"/></th>
                            <th class="box-shadow-inner small_col text-center" style="width: 5%;border-top-right-radius: 20px;"><spring:message
                                    code="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.items}" var="item" varStatus="stat">
                            <tr>
                                <td class="align-center">${stat.count+((page.pageNumber-1)*page.numberPerPage)}</td>
                                <td class="align-center"><input type="checkbox" value="${item.id}" class="selected_item"
                                                                alt="chk" onclick="choose();"></td>
                                <td class="align-center">${item.username}</td>
                                <td class="align-center">${item.fullName}</td>
                                <td><div class="sactive" style="color:${item.status ==1 ? 'green' : 'red'}; width:100px;cursor:pointer;font-weight:600;" title="${item.status ==1 ? 'Click để khóa' : 'Click để kích hoạt'}" onclick="activeShipper(${item.id},${item.status ==1 ? '0' : '1'});">${item.status ==1 ?  'Kích hoạt' : 'Khóa'}</div></td>
                                <sec:authorize
                                        access="hasAnyRole('ROLE_SYSTEM_USER_EDIT','ROLE_SYSTEM_USER_AUTHORITY','ROLE_SYSTEM_LOG_VIEW')">
                                    <td class="align-center">
                                        <div class="btn-group">
                                            <button class="btn btn-default btn-xs dropdown-toggle"
                                                    data-toggle="dropdown"><i
                                                    class="fa fa-th-list"></i></button>
                                            <ul class="dropdown-menu pull-right">
                                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_EDIT')">
                                                    <li>
                                                        <a href="<%=request.getContextPath()%>/system/user/edit/${item.id}"><img
                                                                src="<%=request.getContextPath()%>/assets/images/edit.png"
                                                                style="max-height: 18px; "> <font
                                                                style="font-weight: bold;"> <spring:message
                                                                code="label.edit.info"/></font></a></li>
                                                    <div class="line line-dashed m-b-none m-t-none"></div>
                                                </sec:authorize>
                                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_AUTHORITY')">
                                                    <li>
                                                        <a href="<%=request.getContextPath()%>/system/user/user-group/${item.id}"><img
                                                                src="<%=request.getContextPath()%>/assets/images/icon-singin.png"
                                                                style="max-height: 18px; "> <font
                                                                style="font-weight: bold;"> <spring:message
                                                                code="label.set.role"/></font></a></li>
                                                    <div class="line line-dashed m-b-none m-t-none"></div>
                                                </sec:authorize>
                                                <sec:authorize access="hasRole('ROLE_SYSTEM_LOG_VIEW')">
                                                    <li>
                                                        <a href="<%=request.getContextPath()%>/system/history/${item.id}"><img
                                                                src="<%=request.getContextPath()%>/assets/images/icon-history.png"
                                                                style="max-height: 18px; "> <font
                                                                style="font-weight: bold;"> <spring:message
                                                                code="label.view.history"/></font></a></li>
                                                    <div class="line line-dashed m-b-none m-t-none"></div>
                                                </sec:authorize>
                                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_EDIT')">
                                                    <li><a href="javascript:void(0)"
                                                           onclick="restorePassword(${item.id})"><img
                                                            src="<%=request.getContextPath()%>/assets/images/icon-reset.png"
                                                            style="max-height: 18px; "> <font
                                                            style="font-weight: bold;"> <spring:message
                                                            code="label.reset.password"/></font></a></li>
                                                </sec:authorize>
                                            </ul>
                                        </div>
                                    </td>
                                </sec:authorize>
                            </tr>

                        </c:forEach>
                        <c:if test="${page.rowCount ==0}">
                            <tr>
                                <td colspan="12" class="text-center">Không có dữ liệu</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <footer class="panel-footer">
                    <div class="row">
                        <div class="col-sm-12 text-right text-center-xs">
                            <div class="col-sm-8 text-right" style="vertical-align: middle;">
                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_ADD')">
                                    <a class="btn btn-add pull-left"
                                       href="<%=request.getContextPath()%>/system/user/add"><i
                                            class="fa fa-plus"></i> <spring:message code="label.add.user"/></a>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_AUTHORITY')">
                                    <a class="btn btn-add pull-left"
                                       style="margin-left: 10px;"
                                       href="javascript:void(0);" onclick="search_result_authority();"><i
                                            class="fa fa-list"></i> <spring:message code="label.list.group.user"/></a>
                                </sec:authorize>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 text-left">
                            <div class="col-sm-6 text-left" style="margin-top: 5px;">
                                <span>Tổng số <code>${page.rowCount}</code> bản ghi</span>
                                <label class="input-sm"><span>Hiển thị: </span></label>
                                <select class="input-sm form-control input-s-sm inline" style="width: 60px;"
                                        onchange="location = this.value;" ng-model="numberPerPage">
                                    <c:choose>
                                        <c:when test="${numberPerPage==15}">
                                        <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=5&filterUsername=${filterUsername}">5</option>
                                        <option selected value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=15&filterUsername=${filterUsername}">15</option>
                                        <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=25&filterUsername=${filterUsername}">25</option>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${numberPerPage == 5}">
                                                <option selected value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=5&filterUsername=${filterUsername}">5</option>
                                                <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=15&filterUsername=${filterUsername}">15</option>
                                                <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=25&filterUsername=${filterUsername}">25</option>
                                            </c:if>
                                            <c:if test="${numberPerPage == 25}">
                                                <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=5&filterUsername=${filterUsername}">5</option>
                                                <option value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=15&filterUsername=${filterUsername}">15</option>
                                                <option selected value="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=25&filterUsername=${filterUsername}">25</option>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <ul style="float:right;" class="pagination pagination-sm m-t-none m-b-none">
                                    <c:if test="${page.pageNumber > 1}">
                                        <li>
                                            <a href="<%=request.getContextPath()%>/system/user/list.html?p=1&numberPerPage=${numberPerPage}&filterUsername=${filterUsername}">«</a>
                                        </li>
                                    </c:if>
                                    <c:forEach items="${page.pageList}" var="item" varStatus="stat">
                                        <c:choose>
                                            <c:when test="${page.pageNumber==item}">
                                                <li><a style="color: #aa1111"
                                                       href="<%=request.getContextPath()%>/system/user/list.html?p=${item}&numberPerPage=${numberPerPage}&filterUsername=${filterUsername}">${item}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/system/user/list.html?p=${item}&numberPerPage=${numberPerPage}&filterUsername=${filterUsername}">${item}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                    <c:if test="${page.pageNumber < page.getPageCount()}">
                                        <li>
                                            <a href="<%=request.getContextPath()%>/system/user/list.html?p=${page.getPageCount()}&numberPerPage=${numberPerPage}&filterUsername=${filterUsername}">»</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </section>
            <div class="col-sm-12 no-padder">
                <div id="searchResultAuthority"></div>
            </div>
        </section>
    </section>
    <form method="post" action="active.html" id="frmActive">
        <input type="hidden" name="userId" id="hdfsId"/>
        <input type="hidden" name="active" id="hdfsActive"/>
    </form>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
<script>
    window.onload = function() {
        setTimeout(clearChecked, 10);
    }
    function clearChecked() {
        var w = document.getElementsByTagName('input');
        for(var i = 0; i < w.length; i++){
            if(w[i].type=='checkbox'){
                w[i].checked = false;
            }
        }
    }
    $(document).ready(function () {
        $('#tblUser').dataTable({
            "bFilter": false,
            "bPaginate": false,
            "bAutoWidth": false,
            "sPaginationType": "full_numbers"
        });
        $(".sactive").hover(function () {
            if ($(this).text() == "Kích hoạt") {
                $(this).css("color", "red");
                $(this).text("Khóa");
            } else {
                $(this).css("color", "green");
                $(this).text("Kích hoạt");
            }
        });
    });

    function choose() {
        var selected_val = "";
        var chkAll = true;
        $('.selected_item').each(function () {
            if (this.checked) {
                if (selected_val === "") {
                    selected_val = $(this).val();
                } else {
                    selected_val = selected_val + "," + $(this).val();
                }
            } else {
                chkAll = false;
                $("#chkAll").prop("checked", false);
            }
        });
        if (chkAll) {
            $("#chkAll").prop("checked", true);
        }

        $("#ids").val(selected_val);
    }

    function checkAll(selector_fire, alt_name) {
        $('input[alt=' + alt_name + ']').prop('checked', $('#' + selector_fire).is(':checked'));
        var selected_val = "";
        $('.selected_item').each(function () {
            if (this.checked) {
                if (selected_val === "") {
                    selected_val = $(this).val();
                } else {
                    selected_val = selected_val + "," + $(this).val();
                }
            }
        });
        $("#ids").val(selected_val);
    }

    function activeShipper(sId, active) {
        $("#hdfsId").val(sId);
        $("#hdfsActive").val(active);
        $("#frmActive").submit();
    };

    function search_result_authority() {
        if ($("#ids").val() === '' || $("#ids").val() === null) {
            CommonFunction.showPopUpMsg("<spring:message code="message"/>", "<spring:message code="message.selected.arecord"/>", "error");
        } else if ($("#ids").val().indexOf(",") > -1) {
            CommonFunction.showPopUpMsg("<spring:message code="message"/>", "<spring:message code="message.view.arecord"/>", "error");
        } else {
            var id = $("#ids").val();
            $("#searchResultAuthority").html('<div class="text-center"><img src="<%=request.getContextPath()%>/assets/images/loading.gif" /><spring:message code="label.loading.data"/></div>');
            $("#searchResultAuthority").load("<%=request.getContextPath()%>/system/user/search-group-by-user-" + id);
        }
        return false;
    };

    function restorePassword(userId) {
        $.ajax({
            url: "<%= request.getContextPath() %>/system/user/khoi-phuc-mat-khau",
            type: "POST",
            data: {userId: userId},
            success: function (data) {
                if (data === 'ok') {
                    CommonFunction.showPopUpMsg("Thông báo", "Khôi phục mật khầu thành công!", "success");
                } else {
                    CommonFunction.showPopUpMsg("Thông báo", data, "error");
                }
            },
            error: function (data) {
                CommonFunction.showPopUpMsg("Thông báo", "Có lỗi xảy ra. Vui lòng thử lại sau!", "error");
            }
        });
        return false;
    }

</script>
