<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstra1p-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/system/parameter/index.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/common.css" type="text/css"/>
<style>
    .error {
        color: red;
        padding-top: 5px;
        font-size: 12px;
        display: none;
    }
</style>

<section style="color: #1F2937;" id="content" ng-app="ADAGROUP" ng-controller="systemParametersCtrl">
    <section class="vbox">
        <section class="scrollable padder" style="background: #f4f4f4">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in breadcrumb-common">
                <li>Quản trị hệ thống</li>
                <li>Tham số hệ thống</li>

            </ul>
            <section class="panel panel-default" style="border-radius: 16px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;margin-right: 10%;">
                            <div class="col-md-4 text-right">
                                <label style="font-weight: bold;" class="control-label color-label left-search">Mã tham
                                    số</label>
                            </div>
                            <div class="col-md-4">
                                <input style="border-radius: 10px" name="paramKey" ng-model="paramKey"
                                       maxlength="100"
                                       my-enter="search()"
                                       placeholder="Mã tham số" maxlength="100" class="form-control"/>
                            </div>
                            <div class="col-md-4">
                                <button ng-click="clean()" class="btn btn-info btn-clear-common">Xóa điều kiện
                                </button>
                                <button ng-click="search()" class="btn btn-info btn-search-common">Tìm kiếm</button>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix" style="overflow-x: scroll;">
                    <table class="table b-t b-light table-bordered table-hover" style="margin-bottom: 0px;">
                        <thead class="bg-gray">
                        <tr style="background-color: #172B4D">
                            <th class="text-center v-inherit text-white"
                                style="vertical-align: middle;">STT
                            </th>
                            <sec:authorize access="hasAnyRole('ROLE_SYSTEM_PARAMETERS_EDIT')">
                                <th class="text-center v-inherit text-white"
                                    style="vertical-align: middle;min-width: 130px;">Thao tác
                                </th>
                            </sec:authorize>
                            <th class="v-inherit text-white" style="vertical-align: middle;">
                                Mã tham số
                            </th>
                            <th class="v-inherit text-white" style="vertical-align: middle;">
                                Giá trị mặc định
                            </th>
                            <th class="v-inherit text-white" style="vertical-align: middle;">
                                Giá trị
                            </th>
                            <th class="v-inherit text-white" style="vertical-align: middle;">Mô tả
                            </th>
                            <th class="v-inherit text-white"
                                style="vertical-align: middle;">
                                Ngày cập nhật
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <sec:authorize access="hasAnyRole('ROLE_SYSTEM_PARAMETERS_EDIT')">
                                <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                    <img ng-click="showDetail(item)" title="Sửa"
                                         src="<%=request.getContextPath()%>/assets/image/icon/brush.png"
                                         style="cursor: pointer;">
                                </td>
                            </sec:authorize>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item.key}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item.defaultValue}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item.value}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item.description}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">
                                {{item.lastUpdate == null ? '-' : item.lastUpdate | date:'dd/MM/yyyy HH:mm:ss'}}
                            </td>
                        </tr>
                        <tr ng-show="listData.rowCount == 0">
                            <td colspan="10"
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
    <div class="modal fade" id="mdDetailParameters" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" style="width: 40%;bottom: 0%">
            <div class="modal-content">
                <div class="modal-header alert text-left"
                     style="padding: 7px; background: #0747A6;border-radius: 0;">
                    <button style="color: #FFFFFF; opacity: 1;margin-top: .7rem;margin-right: 1rem" type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-hidden="true" ng-click="clearError()">&times;
                    </button>
                    <h5 class="modal-title"
                        style="font-weight: 700;font-size: 14pt;color: White;margin-top: .7rem;margin-left: 1.5rem">Mã Tham Số <{{detailObj.key}}></h5>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="detailForm" name="detailForm">
                        <div class="row">
                            <div class="col-sm-12" style="line-height: 19px;width: 94%;padding-left: 40px;padding-bottom: 30px;">
                                <div class="row" style="margin-left: 0">
                                    <div class="col-sm-12">
                                        <label class="col-sm-6 control-label left" style="padding-left: 0">Mã tham số</label>
                                        <input disabled
                                               style=" border-radius: 8px;"
                                               ng-model="detailObj.key"
                                               placeholder="Mã tham số" class="form-control"/>
                                    </div>
                                </div>
                                <br>
                                <div class="row" style="margin-left: 0">
                                    <div class="col-sm-12">
                                        <label class="col-sm-6 control-label left" style="padding-left: 0">Giá trị<a
                                                style="color: red;">*</a></label>
                                        <input id="detailObjValue" style=";border-radius: 8px;"
                                               ng-model="detailObj.value"
                                               maxlength="100"
                                               ng-change="changeInput('detailParametersValueErr')"
                                               placeholder="Giá trị" class="form-control"/>
                                        <span class="error" id="detailParametersValueErr">Giá trị không được bỏ trống!</span>
                                    </div>
                                </div>
                                <br>
                                <div class="row" style="margin-left: 0">
                                    <div class="col-sm-12">
                                        <label class="col-sm-6 control-label left" style="padding-left: 0">Mô tả</label>
                                        <textarea type="text" style="border-radius: 8px;"
                                                  ng-model="detailObj.description"
                                                  maxlength="200"
                                                  placeholder="Mô tả" class="form-control">
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="row" style="text-align: center">
                        <a class="btn btn-info btn-clear-common"
                           ng-click="clearError()"
                           data-dismiss="modal">Hủy bỏ
                        </a>
                        <a class="btn btn-add-common"
                           ng-click="updateParameters()">Lưu
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>