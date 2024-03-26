<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/checkbox.js"></script>
<script src="<%=request.getContextPath()%>/assets/note/js/nestable/jquery.nestable.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/js/nestable/nestable.css" type="text/css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/common.css" type="text/css"/>

<div class="container-fluid">
    <section style="color: #1F2937;" id="content">
        <c:if test="${!empty messageError }">
            <<div class="alert alert-success alert-dismissible bg-success text-white border-0 fade show" role="alert">
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"
                    fdprocessedid="1s3b0q"></button>
            <strong>${messageError}</strong>
            </div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <div class="row" style="margin-bottom: 1rem; display: flex; align-items: center;">
                    <div class="col-md-6">
                        <h5 class="card-title fw-semibold mb-0" style="font-size: 28px;">Chi tiết nhóm quyền</h5>
                    </div>
                </div>
                <div class="panel-body">
                    <form method="post" action="<%=request.getContextPath()%>/system/group/edit/" theme="simple"
                          enctype="multipart/form-data" class="form-horizontal" cssStyle="" validate="true"
                          name="myForm" onsubmit="return validateForm()" required>
                        <div class="col-sm-12 row" style="padding: 30px">
                            <div class="form-group col-sm-6">
                                <label class="col-sm-2"
                                       style="line-height: 30px;font-weight: bold;padding: 0">Tên nhóm quyền<span
                                        style="color: red">*</span></label>
                                <div class="col-sm-10">
                                    <div class="input-group m-b" style="width: 88%">
                                        <input style="border-radius: 10px;"
                                               maxlength="100"
                                               type="text" class="form-control input" value="${item.groupName}"
                                               name="groupName" id="groupName"/>
                                        <input type="hidden" class="form-control input" value="${item.id}"
                                               name="id"/>
                                    </div>
                                    <form:errors cssStyle="color: red" path="groupView.groupName"/>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-sm-3"
                                       style="line-height: 30px; font-weight: bold;">Mô tả</label>
                                <div class="col-sm-9">
                                    <div class="input-group m-b" style="width: 100%">
                                        <input
                                                style="border-radius: 10px"
                                                maxlength="100"
                                                name="description" path="" class="form-control input"
                                                value="${item.description}"
                                                rows="1">
                                    </div>

                                </div>
                            </div>
                        </div>
                        <h4 style="font-weight: 700;margin-left: 10%" class="m-t-none">Phân quyền
                        </h4>
                        <div class="row col-sm-12 no-padder">
                            <div class="col-sm-4 no-padder" style="margin-left:10%;margin-right:10%"><span><input
                                    type="checkbox" id="grantCheckAll"
                                    name="checkAll"/> &nbsp;<label
                                    class="font-bold"><spring:message code="label.role.all"/></label></span></div>
                            <div class="col-sm-8" style="padding-left: 10px">
                                <%--                                <a type="button" id="nestable-menu" class="btn btn-xs btn-default active"--%>
                                <%--                                        data-toggle="class:show">--%>
                                <%--                                    <i class="fa fa-plus text-active"></i>--%>
                                <%--                                    <span class="text-active">Đóng tất cả</span>--%>
                                <%--                                    <i class="fa fa-minus text"></i>--%>
                                <%--                                    <span class="text">Mở tất cả</span>--%>
                                <%--                                </a>--%>
                            </div>
                        </div>

                        <div class="row m-b" style="margin-left:10%;margin-right:10%">
                            <div class="dd" id="nestableGroup">
                                <ol class="dd-list">
                                    <c:forEach var="group" items="${groups}" varStatus="stat">
                                        <div class="col-sm-6">
                                            <li class="dd-item" data-id="${group.parent.id}">
                                                <div class="dd-handle"><input type="checkbox" name="listAuthority"
                                                                              value="${group.parent.id}"
                                                                              onchange="checkAllInRow(this)"/> ${group.parent.description}
                                                </div>
                                                <ol class="dd-list">
                                                    <c:forEach var="children" items="${group.childrens}">
                                                        <li class="dd-item" data-id="${children.id}">
                                                            <div class="dd-handle"><input type="checkbox"
                                                                                          name="listAuthority"
                                                                                          onchange="checkChildren(this)"
                                                                                          value="${children.id}"
                                                                                          alt="chk"/> ${children.description}
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ol>
                                            </li>
                                        </div>
                                    </c:forEach>
                                </ol>
                            </div>
                        </div>
                        <div class="line line-dashed line-lg pull-in" style="clear:both ;margin-bottom: 30px"></div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <a style="border-radius: 6px;float: right"
                                   href="<%=request.getContextPath()%>/system/group/quan-ly-nhom-quyen.html"
                                   class="btn btn-light"> Hủy bỏ</a>
                                <button type="submit"
                                        style="border-radius: 6px;float:right;margin-right: 10px"
                                        class="btn btn-warning">Cập nhật
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </section>
</div>

<script src="<%=request.getContextPath()%>/assets/note/js/nestable/jquery.nestable.js"></script>
<!--<script src="<%=request.getContextPath()%>/asset/note/js/nestable/demo.js"></script>-->
<script>
    function validateForm() {
        var x = document.forms["myForm"]["groupName"].value;
        if (x == null || x.trim() == "") {
            toastr.error('Chưa nhập tên nhóm người dùng');
            document.getElementById("groupName").focus();
            return false;
        }
        var checkboxes = $('input:checkbox:checked').length;
        if (checkboxes == 0) {
            toastr.error('Vui lòng chọn chức năng của hệ thống!');
            return false;
        }
    }

    $(document).ready(function () {
        /*Quy uoc cha con cho checkbox*/
        $('#grantCheckAll').checkboxes({
            itemChild: 'list'
        });
        /*load quyen*/
        var systems = "${item.listAuthority}".split(",");
//		alert("${item.listAuthority}");
//console.log("${item.listAuthority}");
        $("input[name='listAuthority']").each(function () {
            for (var i = 0; i < systems.length; i++) {
                if (systems[i] === this.value) {
                    $(this).prop('checked', true);
                }
            }
        });

        /*Kiem tra checkbox trong bang dc check toan bo khong*/
        function checkAllCheck() {
            var result = true;
            $("input[name='listAuthority']").each(function () {

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

        // activate Nestable for class #nestableGroup
        $('#nestableGroup').nestable({});

        var $expandAll = false;
        $('#nestable-menu').on('click', function (e) {
            if ($expandAll) {
                $expandAll = false;
                $('.dd').nestable('expandAll');
            } else {
                $expandAll = true;
                $('.dd').nestable('collapseAll');
            }
        });

//        $('.dd').nestable('collapseAll');

    });

    // table - .parent().parent().parent()
    function checkAllInRow(e) {
        if ($(e).is(':checked'))
            $(e).parent().parent().find("input:checkbox").each(function () {
                $(this).prop('checked', true);
            });
        else
            $(e).parent().parent().find("input:checkbox").each(function () {
                $(this).prop('checked', false);
            });
    }

    function checkChildren(e) {
        if ($(e).is(':checked')) {
            var check = checkAllValue();
            if (check) {
                $(e).parent().parent().parent().parent().find("input:checkbox").each(function (i) {
                    if (i == 0) {
                        $(this).prop('checked', true);
                    }
                });
            }
        } else {
            $(e).parent().parent().parent().parent().find("input:checkbox").each(function (i) {
                if (i == 0) {
                    $(this).prop('checked', false);
                }
            });
        }

        function checkAllValue() {
            var result = true;
            $(e).parent().parent().parent().parent().find("input[type='checkbox']").each(function (i) {
                //ko tinh doi tuong dau tien: item_ALL(leader nhom quyen)
                if (!$(this).is(':checked')) {
                    if (i > 0) {
                        result = false;
                    }
                }
            });
            return result;
        }
    }
</script>