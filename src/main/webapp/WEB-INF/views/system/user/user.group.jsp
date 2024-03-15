<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/checkbox.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<style>
    .btn-secondary {
        background-color: gray;
        color: white;
    }
</style>

<section style="color: #1F2937;" id="content">
    <section class="vbox">
        <section class="scrollable padder" style="background: white">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;<spring:message
                        code="label.system.home"></spring:message></a></li>
                <li><a href="#"><spring:message code="label.user"/></a></li>
                <li><a href="javascript:void(0)"><spring:message code="label.user"/></a></li>
            </ul>
            <c:if test="${messageError != null && messageError != ''}">
                <div class="m-b-md">
                    <span style="color:red"><spring:message code="${messageError}"/></span>
                </div>
            </c:if>

            <section class="panel panel-default" style="border-radius: 20px;">
                <header class="panel-heading" style="border-top-left-radius: 20px; border-top-right-radius: 20px;"><h4>Phân nhóm quyền người dùng <span
                        style="color:red">${user.username}</span></h4></header>
                <div class="panel-body">
                    <form method="post" action="<%=request.getContextPath()%>/system/user/user-group" theme="simple"
                          enctype="multipart/form-data" class="form-horizontal" cssStyle="" validate="true"
                          name="myForm" onsubmit="return validateForm()" required>
                        <input type="hidden" name="id" value="${user.id}"/>
                        <div class="form-group m-b-xs">
                            <div class="col-lg-4">
                                <h5><span><input type="checkbox" id="grantCheckAll" name="checkAll"/> &nbsp;<label
                                        class="font-bold">Tất cả các nhóm quyền</label></span></h5>
                                <div class="list-group">
                                    <c:forEach var="item" items="${allGroups}">
                                        <a href="javascript:void(0)" onclick="viewGroupAuthority('${item.id}')"
                                           id="groupAutho${item.id}"
                                           class="list-group-item list-group-item-action no-padder"
                                           style="padding: 5px 5px 5px 15px !important;"><input type="checkbox"
                                                                                                name="listGroup"
                                                                                                value="${item.id}"/>
                                            &nbsp;<label class="font-bold"> ${item.groupName}</label></a>
                                    </c:forEach>
                                </div>
                                <!--<div class="line line-dashed line-lg pull-in" style="clear:both ;margin-bottom: 20px"></div>-->
                                <div class="form-group">
                                    <div class="col-sm-12">
<%--                                        <button style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4;"--%>
<%--                                                type="submit" data-loading-text="Cập nhật" class="btn"><i--%>
<%--                                                class="fa fa-save"></i> Cập nhật--%>
<%--                                        </button>--%>
                                        <button type="submit" style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4" class="btn"><i class="fa fa-save"></i> Cập nhật</button>
                                        <a style="border-radius: 10px; color: #282424; border-color: #282424;"
                                           href="<%=request.getContextPath()%>/system/user/list" class="btn"><i
                                                class="fa fa-times"></i> Hủy bỏ</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <div id="userGroupViewResult"></div>
                            </div>
                        </div>
                    </form>

                </div>
            </section>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
<script>
    function validateForm() {
        var checkboxes = $('input:checkbox:checked').length;
        if (checkboxes==0) {
            toastr.error('Vui lòng chọn nhóm quyền!');
            return false;
        }
    }
    $(document).ready(function () {
        /*Quy uoc cha con cho checkbox*/
        $('#grantCheckAll').checkboxes({
            itemChild: 'list'
        });
        /*load quyen*/
        var grant = "${listGroupId}".split(",");
        $("input[name='listGroup']").each(function () {
            var active = false;
            for (var i = 0; i < grant.length; i++) {
                if (grant[i] == this.value) {
                    if (!active) {
                        $(this).parent().addClass("active");
                        active = true;
                        userGroupViewAction(grant[i]);
                    }
                    $(this).prop('checked', true);
                }
            }
        });

        /*Kiem tra checkbox trong bang dc check toan bo khong*/
        function checkAllCheck() {
            var result = true;
            $("input[name='listGroup']").each(function () {
                if (!$(this).is(':checked')) {
                    result = false;
                    return result;
                }

            });
            return result;
        }

        var checkAllCheck = checkAllCheck();
        if (checkAllCheck) {
            $('#grantCheckAll').prop('checked', true);
        }

    });

    function viewGroupAuthority(id) {
        $("a[class~='list-group-item']").each(function () {
            if ($(this).hasClass('active')) {
                $(this).removeClass("active");
            }
        });
        $('#groupAutho' + id).addClass("active");
        userGroupViewAction(id);
    }

    function userGroupViewAction(id) {
        if (id === '' || id === null) {
            return false;
        } else {
            $("#userGroupViewResult").html('<div class="text-center"><img src="<%=request.getContextPath()%>/assets/images/loading.gif" /> Đang tải dữ liệu...</div>');
            $("#userGroupViewResult").load("<%=request.getContextPath()%>/system/user/user-group-view-" + id);
        }
        return false;
    }
    ;

</script>