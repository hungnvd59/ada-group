<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/partner/index.js"></script>
<style>
    .left {
        text-align: left !important;
        font-weight: bold;
    }

    .btn-secondary {
        background-color: #52525b;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #aaa;
        color: white;
    }

    form label {
        text-align: left !important;
    }

    .table > thead > tr > th {
        vertical-align: top;
    }

    .dot {
        height: 8px;
        width: 8px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
    }

    .btn-export {
        background-color: #FFFFFF;
        color: #2563EB;
        border-radius: 10px;
        border: 1px solid #2563EB;
    }

    .btn-export:hover {
        background-color: #2563EB;
        color: #FFFFFF;
        border-radius: 10px;
        border: 1px solid #FFFFFF;
    }
</style>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="partnerSC" ng-app="FrameworkBase" ng-controller="partnerCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="javascript:void(0)">Quản lý cộng tác viên</a></li>
            </ul>
            <div>
                <h3><font style="font-weight: bold">DANH SÁCH CỘNG TÁC VIÊN</font></h3>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Cộng tác viên</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="mobile" style="border-radius: 10px" my-enter="search()"
                                               placeholder="Tìm kiếm số điện thoại CTV" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Trạng thái</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="status" name="status" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="status">
                                            <option ng-value="-1">-- Tất cả --</option>
                                            <option ng-value="0">Dừng hoạt động</option>
                                            <option ng-value="1">Đang hoạt động</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Thời gian</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6" style="padding-right: 5px">
                                        <input id="fromDate" name="fromDate" style="border-radius: 10px"
                                               type="text" my-enter="search()"
                                               class="form-control" data-date-format="DD/MM/YYYY"
                                               placeholder="Từ ngày"
                                               ng-model="fromDate"/>
                                    </div>
                                    <div class="col-md-6" style="padding-left: 5px">
                                        <input id="toDate" name="toDate" style="border-radius: 10px"
                                               type="text" my-enter="search()"
                                               class="form-control" data-date-format="DD/MM/YYYY"
                                               placeholder="Đến ngày"
                                               ng-model="toDate"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="padding-top: 30px">
                            <div class="col-lg-12 text-center">
                                <a ng-click="clear()" style="width:136px; border: 1px solid #222222; border-radius: 6px"
                                   class="btn btn-light">Xóa điều kiện</a>
                                <a ng-click="search()" style="width:136px; border-radius: 6px"
                                   class="btn btn-secondary">Tìm kiếm</a>
                            </div>
                        </div>
                    </form>
                </div>
            </section>

            <div class="row">
                <div class="col-md-6">
                    <h4 style="width: 60%;"><font style="font-weight: bold">{{listData.rowCount | currency:"":0}} cộng
                        tác viên</font></h4>
                </div>
                <div class="col-md-6">
                    <a ng-if="listData.items.length > 0" class="btn btn-export" ng-click="export()"
                       style="float:right"><i class="fa fa-file-excel-o"></i> Xuất Excel</a>
                </div>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix" style="border-radius: 20px;">
                    <table id="tbl"
                           class="table table-striped table-bordered m-b-none b-light" style="border-radius: 20px;">
                        <thead>
                        <tr>
                            <th style="border-top-left-radius: 20px;vertical-align: middle;"
                                class="box-shadow-inner small_col text-center"
                                width="4%">STT
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center"
                                width="6%">Thao tác
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center"
                                width="25%">Cộng tác viên
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center"
                                width="25%">Họ và tên
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center"
                                width="25%">Thời gian đăng kí
                            </th>
                            <th style="border-top-right-radius: 20px;vertical-align: middle;"
                                class="box-shadow-inner small_col text-center"
                                width="15%">Trạng thái
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td class="text-center">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <td class="text-center">
                                <div class="dropdown">
                                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i
                                            class="fa fa-cog text-default"></i></a>
                                    <ul class="dropdown-menu pull-left" style="width: fit-content;">
                                        <li>
                                            <a href="<%=request.getContextPath()%>/partner/detail.html?id={{item.id}}"
                                               ng-click="showDetailTab(item);"><i
                                                    class="fa fa-eye"></i> Xem chi tiết</a></li>
                                        <li ng-show="item.status == 0"><a href="#" ng-click="preConfirm(item)"><i
                                                class="fa fa-unlock-alt"></i>
                                            Kích hoạt tài khoản</a></li>
                                        <li ng-show="item.status == 1"><a href="#" ng-click="preBlock(item)"><i
                                                class="fa fa-lock"></i>
                                            Khóa tài khoản</a></li>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/partner/detail.html?id={{item.id}}#!#configContract"><i
                                                    class="fa fa-usd"></i> Cấu hình hoa hồng</a></li>
                                        <li>
                                        <li>
                                            <a ng-click="preRestorePass(item)"><i
                                                    class="fa fa-refresh"></i> Khôi phục mật khẩu</a></li>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/partner/detail.html?id={{item.id}}#!#balanceHis"><i
                                                    class="fa fa-line-chart"></i> Lịch sử biến động số dư</a>
                                        </li>
                                        <li><a href="#" ng-click="preDelete(item)"><i class="fa fa-trash-o"></i> Xóa</a>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                            <td class="text-center">
                                <i ng-if="item.status == 1" class="fa fa-check-circle"
                                   style="color: #60A5FA"></i>
                                <i ng-if="item.status == 0" class="fa fa-check-circle"
                                   style="color: #D4D4D8"></i>
                                {{item.mobile}}
                            </td>
                            <td class="text-center">{{item.partnerName == null ? '-' : item.partnerName}}</td>
                            <td class="text-center">{{item.genDate | date:'dd/MM/yyyy HH:mm:ss'}}</td>
                            <td class="text-center">
                                <span style="background-color: #00dd1c" ng-if="item.status==1" class="dot"></span>
                                <span style="background-color: #bbb" ng-if="item.status==0" class="dot"></span>
                                {{item.status == 1 ? 'Đang hoạt động' :
                                    (item.status == 0 ? 'Dừng hoạt động' : item.status)}}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12" ng-if="listData.rowCount == 0" class="text-center">Không có dữ liệu</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <footer class="panel-footer">
                    <div class="row">
                        <div class="col-sm-12 text-right text-center-xs">
                            <div class="col-sm-6 text-left">
                                <span>Tổng số <code>{{listData.rowCount | currency:"":0}}</code> bản ghi</span>
                                <label class="input-sm"><span>Hiển thị: </span></label>
                                <select class="input-sm form-control input-s-sm inline" style="width: 60px;"
                                        ng-model="numberPerPage" ng-change="setNumberPerPage(numberPerPage);"
                                        ng-init="numberPerPage = '15'">
                                    <option value="5">5</option>
                                    <option value="15">15</option>
                                    <option value="25">25</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <ul class="pagination pagination-sm m-t-none m-b-none">
                                    <li ng-if="listData.pageNumber > 1"><a href="javascript:void(0)"
                                                                           ng-click="loadPageData(1)">«</a>
                                    </li>
                                    <li ng-repeat="item in listData.pageList">
                                        <a href="javascript:void(0)" ng-if="item == listData.pageNumber"
                                           style="color:mediumvioletred;"> {{item}}</a>
                                        <a href="javascript:void(0)" ng-if="item != listData.pageNumber"
                                           ng-click="loadPageData(item)"> {{item}}</a>
                                    </li>
                                    <li ng-if="listData.pageNumber < listData.pageCount"><a href="javascript:void(0)"
                                                                                            ng-click="loadPageData(listData.pageCount)">»</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </section>
        </section>
    </section>

    <div class="modal fade" id="mdConfirmPartner" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="a">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn kích hoạt tài khoản CTV</label>
                        <span>{{editPartner.userName}}?</span>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-add" style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E"
                                ng-click=" activePartner(editPartner)">Đồng ý
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="mdBlockPartner" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="a">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn khóa tài khoản CTV</label>
                        <span>{{editPartner.userName}}?</span>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-add" style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E"
                                ng-click=" blockPartner(editPartner)">Đồng ý
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="mdDeletePartner" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="a">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn xóa tài khoản CTV</label>
                        <span>{{editPartner.userName}}?</span>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-add"
                                style="width:136px;border: 1px solid #222222; border-radius: 6px;"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E"
                                ng-click=" deletePartner(editPartner)">Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="mdRestorePass" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="ad">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn khôi phục mật khẩu CTV</label>
                        <span><font style="font-weight: 700">{{restoreObj.userName}} - {{restoreObj.partnerName}}</font> về mặc định?</span>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-add"
                                style="width:136px;border: 1px solid #222222; border-radius: 6px;"
                                data-dismiss="modal">Hủy
                        </button>
                        <button class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E"
                                ng-click=" restorePass()">Đồng ý
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>