<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/checkbox.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/system/group/add.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/js/nestable/nestable.css" type="text/css" />
<section style="color: #1F2937;" id="content" ng-app="FrameworkBase" ng-controller="addGroupCtrl">
    <section class="vbox">
        <section class="scrollable padder" style="background: white">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in bg-primary">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;<spring:message code="label.system.home"/></a></li>
                <li><a href="<%=request.getContextPath()%>/system/group/list"><spring:message code="label.group"/></a></li>
                <li><a href="javascript:void(0)"><spring:message code="label.group.add"/></a></li>
            </ul>
            <c:if test="${!empty messageError }">
                <div class="m-b-md">
                    <span style="color:red"><spring:message code="${messageError}"/></span>
                </div>
            </c:if>
            <section class="panel panel-default" style="border-radius: 20px;">
                <header class="panel-heading" style="border-top-left-radius: 20px; border-top-right-radius: 20px;"><a href="<%=request.getContextPath()%>/system/group/list"><h4><span class="fa fa-angle-left"></span> <spring:message code="label.group.add"/></h4></a></header>
                <div class="panel-body">
                    <form method="post" action="add" theme="simple"  enctype="multipart/form-data" class="form-horizontal" cssStyle="" validate="true"
                          name="myForm" onsubmit="return validateForm()" required>
                        <div class="col-sm-12">
                            <div class="col-sm-6 form-group">
                                <label class="col-sm-4 control-label" style="line-height: 30px"><spring:message code="label.group.name"/><span style="color: red">*</span></label>
                                <div class="col-sm-8">
                                    <div class="input-group m-b">
                                        <span class="input-group-addon">
                                            <i class="fa fa-user" aria-hidden="true"></i>
                                        </span>
                                        <input style="border-top-right-radius: 10px;border-bottom-right-radius: 10px;" type="text" class="form-control input" value="${item.groupName}" name="groupName" data-required="true"
                                               placeholder="<spring:message code="label.group.user"/>" data-required="true"
                                               data-required-message="<font color=green><spring:message code="label.group.name"/></font><spring:message code="message.isnot.empty"/>"
                                               data-maxlength="100" id="groupName"
                                               data-maxlength-message="<spring:message code="validate.lenght.input"/>"/>
                                        <input type="hidden" class="form-control input" value="${item.id}" name="id"/>
                                    </div>
                                    <form:errors cssStyle="color: red" path="groupView.groupName" />
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-sm-4 control-label" style="line-height: 30px; font-weight: bold;"><spring:message code="label.infor.description"></spring:message> </label>
                                <div class="col-sm-8">
                                    <div class="input-group m-b">
                                        <span class="input-group-addon">
                                            <i class="fa fa-list" aria-hidden="true"></i>
                                        </span>
                                        <textarea style="border-top-right-radius: 10px;border-bottom-right-radius: 10px;"  name="description"  path="" class="form-control input" rows="1">${item.description}</textarea>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <h4 class="m-t-none"><spring:message code="label.systme.tree.funtion"/>
                        </h4>
                        <div class="col-sm-12 no-padder">
                            <div class="col-sm-4 no-padder"><span><input type="checkbox" id="grantCheckAll" name="checkAll" /> &nbsp;<label class="font-bold"><spring:message code="label.role.all"/></label></span></div>
                            <div class="col-sm-8" style="padding-left: 10px"> <button id="nestable-menu" class="btn btn-xs btn-default active" data-toggle="class:show">
                                <i class="fa fa-plus text-active"></i>
                                <span class="text-active">Expand All</span>
                                <i class="fa fa-minus text"></i>
                                <span class="text">Collapse All</span>
                            </button>
                            </div>
                        </div>

                        <div class="row m-b">
                            <div class="dd" id="nestableGroup">
                                <ol class="dd-list">
                                    <c:forEach var="group" items="${groups}" varStatus="stat">
                                        <div class="col-sm-4">
                                            <li class="dd-item" data-id="${group.parent.id}">
                                                <div class="dd-handle"><input type="checkbox"  name="listAuthority" value="${group.parent.id}"   onchange="checkAllInRow(this)" /> ${group.parent.description}</div>
                                                <ol class="dd-list">
                                                    <c:forEach var="children" items="${group.childrens}">
                                                        <li class="dd-item" data-id="${children.id}"><div class="dd-handle"><input type="checkbox" name ="listAuthority" onchange="checkChildren(this)" value="${children.id}" alt="chk"  /> ${children.description}</div></li>
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
                            <div class="col-sm-4 col-sm-offset-5">
                                <a style="border-radius: 10px; color: #282424; border-color: #282424" href="<%=request.getContextPath()%>/system/group/list" class="btn"><i class="fa fa-times"></i> <spring:message code="message.modal.cancel"/></a>
<%--                                <button style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4" type="submit" data-loading-text="<spring:message code="label.button.add"/>" class="btn"><i class="fa fa-save"></i> <spring:message code="label.button.add"/></button>--%>
                                <button type="submit" style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4" class="btn"><i class="fa fa-save"></i> Thêm mới</button>
                            </div>
                        </div>
                    </form>

                </div>
            </section>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>

<script src="<%=request.getContextPath()%>/assets/note/js/nestable/jquery.nestable.js"></script>
<script>
    let listData ='';
    app.controller('addGroupCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {//$scope.listData = '';

        $scope.loadListData = function () {
            $http.get(preUrl + "/system/group/list-group")
                .then(function (response) {
                    if (response != null && response != 'undefined' && response.status == 200) {
                        listData = response.data;
                    }
                });
        }
        $scope.loadListData();
    }]);

    function validateForm() {
        var x = document.forms["myForm"]["groupName"].value;
        if (x == "") {
            toastr.error('Chưa nhập tên nhóm người dùng');
            document.getElementById("groupName").focus();
            return false;
        }
        var checkboxes = $('input:checkbox:checked').length;
        if (checkboxes==0) {
            toastr.error('Vui lòng chọn chức năng của hệ thống!');
            return false;
        }

        for (let i = 0; i < listData.length; i++) {
            if(listData[i].groupName.toUpperCase() == document.forms["myForm"]["groupName"].value.toUpperCase()){
                toastr.error('Tên nhóm đã tồn tại!');
                document.getElementById("groupName").focus();
                return false;
            }
        }

    }

    $(document).ready(function () {
        /*Quy uoc cha con cho checkbox*/
        $('#grantCheckAll').checkboxes({
            itemChild: 'list'
        });
        /*load quyen*/
        var systems = "${item.listAuthority}".split(",");
        $("input[name='listAuthority']").each(function () {
            for (var i = 0; i < systems.length; i++) {
                if (systems[i] == this.value) {
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
        $('#nestableGroup').nestable({
        });

        var $expandAll = false;
        $('#nestable-menu').on('click', function (e)
        {
            if ($expandAll) {
                $expandAll = false;
                $('.dd').nestable('expandAll');
            } else {
                $expandAll = true;
                $('.dd').nestable('collapseAll');
            }
        });

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