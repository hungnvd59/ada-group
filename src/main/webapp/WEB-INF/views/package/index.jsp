<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/package/index.js"></script>
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

    .btn-add {
        background-color: #2563EB;
        color: white;
        border-radius: 10px;
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
<section style="color: #1F2937;" id="partnerSC" ng-app="FrameworkBase" ng-controller="packageCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="javascript:void(0)">Quản lý sản phẩm</a></li>
            </ul>
            <div>
                <h3><font style="font-weight: bold">DANH SÁCH SẢN PHẨM</font></h3>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Tên sản phẩm</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="packName" style="border-radius: 10px" my-enter="search()"
                                               placeholder="Tên sản phẩm" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Danh mục</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="itemType" name="itemType" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="itemType">
<%--                                            <option value="-1">-- Tất cả --</option>--%>
                                            <option value="0">Gói cước</option>
<%--                                            <option value="1">Sim số</option>--%>
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
                                        <label class="control-label color-label left">Trạng thái</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="status" name="status" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="status">
                                            <option ng-value="-1">-- Tất cả --</option>
                                            <option ng-value="0">Ẩn hiển thị</option>
                                            <option ng-value="1">Hiển thị</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row" style="margin-top: 0px;">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="control-label color-label left">Thời gian tạo</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6" style="padding-right: 5px">
                                                <input id="fromGenDate" name="fromGenDate" style="border-radius: 10px"
                                                       my-enter="search()"
                                                       type="text" my-enter="search()" maxlength="10"
                                                       class="form-control" data-date-format="DD/MM/YYYY"
                                                       placeholder="Từ ngày"/>
                                            </div>
                                            <div class="col-md-6" style="padding-left: 5px">
                                                <input id="toGenDate" name="toGenDate" style="border-radius: 10px"
                                                       my-enter="search()"
                                                       type="text" my-enter="search()" maxlength="10"
                                                       class="form-control" data-date-format="DD/MM/YYYY"
                                                       placeholder="Đến ngày"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>

                        <div id="advancedFilter">
                            <br/><br/>
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <label class="control-label color-label left" style="color: #3B82F6">Bộ
                                                    lọc theo</label>
                                            </div>
                                            <div class="col-md-5">
                                                <select class="form-control" id="searchOption" name="searchOption"
                                                        style="border-radius: 10px; background-color: #EFF6FF; border-color: #3B82F6;"
                                                        ng-model="searchOption">
                                                    <option value="0">Gói cước</option>
<%--                                                    <option value="1">Sim số</option>--%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div ng-show="1==2" id="dropDownSim">
                            <br/><br/>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Loại thuê bao</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="msisdnType" name="msisdnType"
                                                    style="width: 100% ;border-radius: 10px;" ng-model="msisdnType">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">Trả trước</option>
                                                <option value="1">Trả sau</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Loại số</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="group_id" name="group_id"
                                                    style="width: 100% ;border-radius: 10px;" ng-model="group_id">
                                                <option ng-repeat="item in groupMsisdn" value="{{item.id}}">
                                                    {{item.groupName}}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br/>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Đối tượng giữ số</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="doiTuongGiuSo" name="doiTuongGiuSo"
                                                    style="width: 100% ;border-radius: 10px" ng-model="doiTuongGiuSo">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">Khách hàng</option>
                                                <option value="1">Cộng tác viên</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="dropDownPackage">
                            <br/><br/>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Telco</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="type" name="type"
                                                    style="width: 100% ;border-radius: 10px" ng-model="type">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">MobiFone</option>
                                                <%--                                                <option value="1">Viettel</option>--%>
                                                <%--                                                <option value="2">Reddi</option>--%>
                                                <option value="3">VinaPhone</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Loại gói cước</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="loaiGoiCuoc" name="loaiGoiCuoc"
                                                    style="width: 100% ;border-radius: 10px;" ng-model="loaiGoiCuoc">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">Trả trước</option>
                                                <option value="1">Trả sau</option>
                                                <option value="2">Data</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br/>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Chu kỳ</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="chuKy" name="chuKy"
                                                    style="width: 100% ;border-radius: 10px;" ng-model="chuKy">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">Dưới 7 ngày</option>
                                                <option value="1">Từ 7 - 30 ngày</option>
                                                <option value="2">Từ 30 - 90 ngày</option>
                                                <option value="3">Từ 90 - 180 ngày</option>
                                                <option value="4">Từ 180 - 270 ngày</option>
                                                <option value="5">Từ 270 - 360 ngày</option>
                                                <option value="6">Trên 360 ngày</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left">Giá gói</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select class="form-control" id="giaGoi" name="giaGoi"
                                                    style="width: 100% ;border-radius: 10px;" ng-model="giaGoi">
                                                <option value="-1">-- Tất cả --</option>
                                                <option value="0">Dưới 50k</option>
                                                <option value="1">Từ 50k - 100k</option>
                                                <option value="2">Từ 100k - 200k</option>
                                                <option value="3">Từ 200k - 500k</option>
                                                <option value="4">Từ 500k - 1000k</option>
                                                <option value="5">Trên 1000k</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br/>

                        <div class="row" style="padding-top: 30px">
                            <div class="col-lg-12 text-center">
                                <a ng-click="clear()" style="width:136px; border: 1px solid #222222; border-radius: 6px"
                                   class="btn btn-light">Xóa điều kiện</a>
                                <a ng-click="search()" style="width:136px; border-radius: 6px"
                                   class="btn btn-secondary">Tìm kiếm</a>
                                <a id="dropDown" ng-click="dropDown()"
                                   style="border: 1px solid #222222; border-radius: 10px; position: relative;"
                                   class="btn btn-light"><i class="fa fa-angle-double-down"></i>
                                    <span ng-if="checkSearch()==1" class="dot"
                                          style="background-color: #FC5555;top: 5px;right: 10px;position: absolute;">
                                    </span>
                                </a>
                                <a id="dropUp" ng-click="dropUp()"
                                   style="border: 1px solid #222222; border-radius: 10px"
                                   class="btn btn-light"><i class="fa fa-angle-double-up"></i>
                                    <%--                                    <i class="glyphicon glyphicon-menu-up"></i>--%>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </section>

<%--            <div class="row">--%>
<%--                <div class="col-md-6">--%>
<%--                </div>--%>
<%--                <div class="col-md-6">--%>
<%--                    <a ng-if="listData.items.length > 0" class="btn btn-export" ng-click="export()"--%>
<%--                       style="float:right;margin: 5px;"><i class="fa fa-file-excel-o"></i> Xuất Excel</a>--%>
<%--                    <a class="btn btn-add" ng-click="showPopupAdd()"--%>
<%--                       style="float:right;margin: 5px;"><i class="fa fa-plus"></i> Thêm mới</a>--%>
<%--                </div>--%>
<%--            </div>--%>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix" style="border-radius: 20px;">
                    <table id="tbl"
                           class="table table-striped table-bordered m-b-none b-light" style="border-radius: 20px;">
                        <thead>
                        <tr>
                            <th style="border-top-left-radius: 20px;vertical-align: middle;"
                                class="box-shadow-inner small_col text-center">STT
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Thao tác
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Mã sản phẩm
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Danh mục
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Tên sản phẩm
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Telco
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Trạng thái
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Người tạo
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Ngày tạo
                            </th>
                            <th style="vertical-align: middle;" class="box-shadow-inner small_col text-center">Người cập nhật
                            </th>
                            <th style="border-top-right-radius: 20px;vertical-align: middle;" class="box-shadow-inner small_col text-center">Ngày cập nhật
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
                                        <li><a href="<%=request.getContextPath()%>/package/detail.html?id={{item.id}}"
<%--                                               ng-click="showPopupDetail(item)"--%>
                                        ><i class="fa fa-edit"></i> Chỉnh sửa</a></li>
                                        <li ng-show="item.status == 0"><a href="#"
                                                                          ng-click="confirmChangeStatus(item, 'unlock')">
                                            <i class="fa fa-eye"></i> Hiển thị</a></li>
                                        <li ng-show="item.status == 1"><a href="#"
                                                                          ng-click="confirmChangeStatus(item, 'lock')">
                                            <i class="fa fa-eye-slash"></i> Ẩn hiển thị</a></li>
                                        <li><a href="#" ng-click="showPopupDelete(item)">
                                            <i class="fa fa-trash-o"></i> Xóa</a></li>
                                    </ul>
                                </div>
                            </td>
                            <td class="text-center">{{item.packCode}}</td>
                            <td class="text-center">Gói cước</td>
                            <td class="text-center">{{item.packName}}</td>
                            <td class="text-center">{{item.type == 0? 'MobiFone' : item.type == 3? 'VinaPhone' : '-' }}</td>
                            <td class="text-left">
                                <span style="background-color: #8EC165"
                                      ng-if="item.status==1" class="dot"></span>
                                <span style="background-color: #F15836"
                                      ng-if="item.status!=1" class="dot"></span>
                                {{item.status == 1 ? "Hiển thị" : "Ẩn hiển thị"}}
                            </td>
                            <td class="text-center">{{item.createBy}}</td>
                            <td class="text-center">{{item.genDate | date:'dd/MM/yyyy HH:mm:ss'}}</td>
                            <td class="text-center">{{item.updateBy}}</td>
                            <td class="text-center">{{item.lastUpdated | date:'dd/MM/yyyy HH:mm:ss'}}</td>
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

    <div class="modal fade" id="mdDetailPackage" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog modal-lg" style="width: 60%">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 ng-show="affPackage.id == null" style="font-weight: bold" class="modal-title">THÊM MỚI GÓI CƯỚC</h4>
                    <h4 ng-show="affPackage.id != null" style="font-weight: bold" class="modal-title">CẬP NHẬT GÓI CƯỚC</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Mã gói cước<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_packCode" ng-model="affPackage.packCode" style="border-radius: 10px"
                                               placeholder="Mã gói cước" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Tên gói cước<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_packName" ng-model="affPackage.packName" style="border-radius: 10px"
                                               placeholder="Tên gói cước" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Giá gói cước<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_amount" ng-model="affPackage.amount" style="border-radius: 10px"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               ng-change="formatAmount('amount')"
                                               placeholder="Giá gói cước" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Trạng thái</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="affPackage_status" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="affPackage.status">
                                            <option ng-value="0">Ẩn hiển thị</option>
                                            <option ng-value="1">Hiển thị</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Loại nhà mạng<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="affPackage_type" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="affPackage.type">
                                            <option ng-value="-1">-- Lựa chọn --</option>
                                            <option ng-value="0">CTV MBF</option>
                                            <option ng-value="1">Viettel</option>
                                            <option ng-value="2">Vinafone</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Loại gói cước<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="affPackage_packType" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="affPackage.packType">
                                            <option ng-value="-1">-- Lựa chọn --</option>
                                            <option ng-value="0">Trả trước</option>
                                            <option ng-value="1">Trả sau</option>
                                            <option ng-value="2">Data</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Số ngày hết hạn<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_numExpired" ng-model="affPackage.numExpired" style="border-radius: 10px"
                                               placeholder="Số ngày hết hạn" maxlength="20"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Hoa hồng OSP</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input class="form-control" ng-model="affPackage.hhOsp" style="border-radius: 10px"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               ng-change="formatAmount('hhOsp')"
                                               maxlength="20" placeholder="Hoa hồng OSP" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Phần trăm hoa hồng</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="affPackage.ratioValue" style="border-radius: 10px"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               placeholder="Phần trăm hoa hồng" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Chi tiết gói cước</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input class="form-control" ng-model="affPackage.packDetail" style="border-radius: 10px"
                                               placeholder="Chi tiết gói cước" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-light" style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button ng-show="affPackage.id == null" class="btn btn-add"
                                style="width:136px;color: #FFF;"
                                ng-click="addPackage()">Lưu
                        </button>
                        <button ng-show="affPackage.id != null" class="btn btn-add"
                                style="width:136px;color: #FFF;"
                                ng-click="updatePackage()">Cập nhật
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mdConfirmChangeStatus" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn {{titleChangeStatus}} sản phẩm?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-light" style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button ng-show="titleChangeStatus == 'hiển thị'" class="btn btn-add"
                                style="width:136px;color: #FFF;border-radius: 6px"
                                ng-click="updateStatusPackage('unlock')">Hiển thị
                        </button>
                        <button ng-show="titleChangeStatus == 'ẩn hiển thị'" class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E;border-radius: 6px"
                                ng-click="updateStatusPackage('lock')">Ẩn hiển thị
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mdConfirmDelete" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="close" class="btn btn-default" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">XÁC NHẬN</h4>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn xóa sản phẩm?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <button class="btn btn-light" style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                data-dismiss="modal">Quay lại
                        </button>
                        <button class="btn btn-add"
                                style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E;border-radius: 6px"
                                ng-click="deletePackage()">Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>