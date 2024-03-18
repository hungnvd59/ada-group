<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/system/group/index.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/common.css" type="text/css"/>
<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="content" ng-app="ADAGROUP" ng-controller="groupListCtrl">
    <section class="vbox">
        <section class="scrollable padder" style="background: #f4f4f4">
            <ul style="font-weight: 700;color: #2A2C54"
                class="bg-white breadcrumb no-border no-radius b-b b-light pull-in breadcrumb-common">
                <li style="color: gray"><span><i class="fa fa-home"></i>&nbsp;Trang chủ</span></li>
                <li style="color: gray"><span>Quản lý hệ thống</span></li>
                <li><span>Danh sách nhóm quyền</span></li>
            </ul>
            <div class="m-b-md"><h3 class="m-b-none" id="adagroup-status" style="color: #009900"><c:if
                    test="${success.length()>0}"><spring:message code="${success}"/></c:if></h3></div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-sm-8" style="padding-left: 0">
                                    <input style="border-radius: 10px;" name="filterName"
                                           placeholder="Tìm kiếm nhóm quyền"
                                           maxlength="50" ng-model="filterName" class="input form-control"/>
                                </div>
                                <div class="col-sm-4">
                                    <button ng-click="search()" class="btn btn-info btn-search-common"><spring:message
                                            code="label.button.search"/></button>
                                </div>
                            </div>
                        </div>
                        <div class="line line-dashed line-lg pull-in" style="clear:both ;border-top:0px"></div>
                    </form>
                </div>
            </section>
            <div class="row">
                <div class="col-md-6">
                </div>
                <div class="col-md-6">
                    <%--                                <sec:authorize access="hasRole('ROLE_SYSTEM_USER_ADD')">--%>
                    <a class="btn btn-add btn-search-common"
                       style="float:right !important;"
                       href="<%=request.getContextPath()%>/system/group/them-moi-nhom-quyen.html">Thêm mới</a>
                    <%--                                </sec:authorize>--%>
                </div>
            </div>
            <br>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix">
                    <table class="table table-hover mb-sm-2">
                        <thead class="bg-gray">
                        <tr style="background-color: #222222">
                            <th class="text-center v-inherit text-white"
                                style="width: 1%;vertical-align: middle;">STT
                            </th>
                            <th class="text-center v-inherit text-white"
                                style="width: 1%;vertical-align: middle;">Thao tác
                            </th>
                            <th class="text-center v-inherit text-white" style="width: 7%;vertical-align: middle;">Tên
                                nhóm quyền
                            </th>
                            <th class="text-center v-inherit text-white" style="vertical-align: middle;width: 13%">Mô
                                tả
                            </th>
                            <th class="text-center v-inherit text-white" style="vertical-align: middle;width: 7%">Người
                                tạo
                            </th>
                            <th class="text-center v-inherit text-white" style="vertical-align: middle;width: 7%">Ngày
                                tạo
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
<%--                                <sec:authorize access="hasRole('ROLE_SYSTEM_GROUP_EDIT')">--%>
                                    <img width="14px" height="14px" ng-click="redirectDetail(item.id)" title="Sửa" src="<%=request.getContextPath()%>/assets/images/icon/brush.png" style="cursor: pointer;">
<%--                                </sec:authorize>--%>
                            </td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item.groupName}}</td>
                            <td style="vertical-align: middle;" class="text-left v-in herit">{{item.description}}</td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                {{item.createBy}}
                            </td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                {{item.genDate | date: 'dd/MM/yyyy | HH:mm:ss'}}
                            </td>
                        </tr>
                        <tr ng-show="listData.rowCount == 0">
                            <td colspan="13"
                                style="height: 100%;background-color: #ececec; line-height: 3.429;text-align: center; font-style: italic;">
                                Không có dữ liệu
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <footer class="panel-footer">
                    <div class="row">
                        <div class="p-r-0 col-sm-12 text-right text-center-xs">
                            <div class="col-sm-6 text-left">
                                <span style="color: black">Tổng số {{listData.rowCount}} dữ liệu</span>
                            </div>
                            <div class="col-sm-6">
                                <ul class="pagination pagination-sm m-t-none m-b-none">
                                    <li ng-if="listData.pageNumber > 1"><a href="javascript:void(0)"
                                                                           ng-click="loadPageData(1)">«</a></li>
                                    <li ng-repeat="item in listData.pageList">
                                        <a href="javascript:void(0)" ng-if="item == listData.pageNumber"
                                           style="color:mediumvioletred;"> {{item}}</a>
                                        <a href="javascript:void(0)" ng-if="item != listData.pageNumber"
                                           ng-click="loadPageData(item)"> {{item}}</a>
                                    </li>
                                    <li ng-if="listData.pageNumber < listData.pageCount"><a
                                            href="javascript:void(0)"
                                            ng-click="loadPageData(listData.pageCount)">»</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </section>
        </section>
    </section>
    <div class="modal fade" id="mdDelete" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="c">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert text-center" style="padding: 7px; background: #172B4D;border-radius: 0">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true" ng-click="clearFormAdd()">&times;
                    </button>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn xóa nhóm quyền </label>
                        <span style="font-weight: bold">{{deleteObj.groupName}}</span>
                        <label>hay không?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <a class="btn btn-light"
                           type="button"
                           style="width:136px; border: 1px solid #172B4D;color: #172B4D; border-radius: 8px"
                           data-dismiss="modal">Hủy
                        </a>
                        <a class="btn btn-secondary"
                           style="width: 136px;background: #172B4D;border-radius: 8px;color: #FFFFFF;border: none"
                           type="button"
                           ng-click="deleteGroup(deleteObj)">Đồng ý
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>