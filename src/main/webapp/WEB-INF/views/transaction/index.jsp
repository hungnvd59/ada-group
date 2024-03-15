<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/transaction/index.js"></script>
<style>
    .left {
        text-align: left !important;
        font-weight: bold;
    }

    .btn-secondary {
        background-color: #52525B;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #79797f;
        color: white;
    }

    .btn-light:hover {
        background-color: #e8e1e1;
    }

    .btn-export {
        background-color: #FFFFFF;
        color: #2563EB;
        border-radius: 10px;
        border-color: #2563EB;
    }

    .btn-export:hover {
        background-color: #3c6fba;
        color: #FFFFFF;
    }

    .btn-cancel {
        border-radius: 10px;
        color: #282424;
        border-color: #282424;
        background-color: #ffffff;
    }

    .btn-cancel:hover {
        background-color: #eae6e6;
    }

    form label {
        text-align: left !important;
    }

    .table > thead > tr > th {
        vertical-align: top;
    }

    .right {
        text-align: right !important;
        font-weight: bold;
    }

    .radius-field {
        border-radius: 10px;
        background-color: #FAFAFA;
        margin: 10px;
        padding: 10px;
    }

    .dot {
        height: 8px;
        width: 8px;
        background-color: #A1A1AA;
        border-radius: 50%;
        display: inline-block;
    }

</style>

<title>Danh sách giao dịch</title>
<section style="color: #1F2937;" id="partnerSC" ng-app="FrameworkBase" ng-controller="transactionCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="javascript:void(0)">Danh sách giao dịch</a></li>
            </ul>
            <div>
                <h3 style="font-weight: bold;">DANH SÁCH GIAO DỊCH</h3>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Danh mục sản phẩm</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select class="form-control" id="itemType" name="itemType"
                                                style="width: 100% ;border-radius: 10px" ng-model="itemType">
                                            <option value="-1">-- Tất cả --</option>
                                            <option value="0">Gói cước</option>
                                            <option value="1">Sim số</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Sản phẩm</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="itemName" my-enter="search()" style="border-radius: 10px"
                                               placeholder="Tìm kiếm tên sản phẩm" maxlength="20"
                                               class="form-control"
                                               ng-change="getValueCount()"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Số thuê bao</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="msisdnContact" style="border-radius: 10px"
                                               placeholder="Tìm kiếm theo số thuê bao khách hàng" maxlength="12"
                                               class="form-control" my-enter="search()"
                                               ng-change="getValueCount()"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Cộng tác viên</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="mobile" my-enter="search()" style="border-radius: 10px"
                                               placeholder="Tìm kiếm số điện thoại CTV" maxlength="12"
                                               class="form-control" my-enter="search()"
                                               ng-change="getValueCount()"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Mã giao dịch</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="transCode" style="border-radius: 10px" my-enter="search()"
                                               placeholder="Tìm kiếm theo mã giao dịch" maxlength="20"
                                               class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Trạng thái giao dịch</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select class="form-control" id="status" name="status"
                                                style="width: 100% ;border-radius: 10px" ng-model="status">
                                            <option value="-1">-- Tất cả --</option>
                                            <option value="0">Thất bại/Chưa đủ điều kiện</option>
                                            <option value="1">Thành công/Đủ điều kiện</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row" style="margin-top: 0px;">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="control-label color-label left">Thời gian giao
                                                    dịch</label>
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
                                                    <option value="1">Sim số</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="dropDownSim">
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
                                                <option value="1">Gói hot</option>
                                                <option value="2">Data</option>
                                                <option value="3">Thoại & SMS</option>
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
                                                <option value="7">7 ngày</option>
                                                <option value="30">30 ngày</option>
                                                <option value="90">90 ngày</option>
                                                <option value="180">180 ngày</option>
                                                <option value="270">270 ngày</option>
                                                <option value="360">360 ngày</option>
                                                <option value="540">540 ngày</option>
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
                                <a ng-click="clear()"
                                   style="border: 1px solid #222222; border-radius: 10px; width: 136px"
                                   class="btn btn-light">Xóa điều kiện</a>
                                <a ng-click="search()" style="border-radius: 10px;width: 136px"
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

            <div class="row">
                <div class="col-md-6">
                    <h4 style="width: 60%; font-weight: bold;">{{listData.rowCount | currency:"":0}} giao dịch</h4>
                </div>
                <div class="col-md-6">
                    <a ng-if="listData.items.length > 0" class="btn btn-export" ng-click="exportExcel()"
                       style="float:right;"><span><i class="fa fa-file-excel-o"></i> Xuất Excel</span></a>
                </div>
            </div>
            <br/>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix" style="border-radius: 20px;">
                    <table id="tbl" class="table table-hover" style="border-radius: 20px;">
                        <thead>
                        <tr style="color:#1F2937; background-color: #F4F4F5">
                            <th style="border-top-left-radius: 20px;" class="box-shadow-inner small_col text-center">
                                STT
                            </th>
                            <th class="box-shadow-inner small_col text-center">Thao tác</th>
                            <th class="box-shadow-inner small_col text-center">Thời gian</th>
                            <th class="box-shadow-inner small_col text-center">Mã giao dịch</th>
                            <th class="box-shadow-inner small_col text-center">Danh mục</th>
                            <th class="box-shadow-inner small_col text-center">Sản phẩm</th>
                            <th class="box-shadow-inner small_col text-center">Telco</th>
                            <th class="box-shadow-inner small_col text-center">Cộng tác viên</th>
                            <th class="box-shadow-inner small_col text-center">Khách hàng</th>
                            <th class="box-shadow-inner small_col text-center">Loại hoa hồng</th>
                            <th class="box-shadow-inner small_col text-center">Trạng thái giao dịch</th>
                            <th class="box-shadow-inner small_col text-center">Giá trị giao dịch (VNĐ)</th>
                            <th style="border-top-right-radius: 20px;" class="box-shadow-inner small_col text-center">
                                Hoa hồng CTV (VNĐ)
                            </th>
                        </tr>
                        </thead>
                        <tbody style="color: #1F2937">
                        <tr ng-repeat="item in listData.items track by $index">
                            <td class="text-center">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <td class="text-center">
                                <a ng-if="item.item_type == 'SIMSO'" data-toggle="modal" data-target="#modalDetailSim"
                                   ng-click="showPopupDetail(item);">
                                    <i class="fa fa-eye"></i>
                                </a>
                                <a ng-if="item.item_type =='GOICUOC'" data-toggle="modal"
                                   data-target="#modalDetailPackage" ng-click="showPopupDetail(item);">
                                    <i class="fa fa-eye"></i>
                                </a>
                            </td>
                            <td class="text-center">{{item.gen_date | date:'dd/MM/yyyy HH:mm:ss'}}</td>
                            <td style="word-break: break-all" class="text-center">{{item.trans_code}}</td>
                            <td class="text-center">{{getItemType(item.item_type)}}</td>
                            <td style="word-break: break-all" class="text-center">{{item.item_name}}</td>
                            <td style="word-break: break-all" class="text-center">{{item.typeTelcoStr}}</td>
                            <td style="word-break: break-all" class="text-center">{{item.mobile}}</td>
                            <td style="word-break: break-all" class="text-center">{{item.msisdn_contact}}</td>
                            <td class="text-center">{{getShareType(item.share_type)}}</td>
                            <td class="text-left">
                                <span style="background-color: #8EC165"
                                      ng-if="item.status==3||item.status==6" class="dot"></span>
                                <span style="background-color: #F15836"
                                      ng-if="!(item.status==3||item.status==6)" class="dot"></span>
                                {{getStatus(item.status)}}
                            </td>
                            <td class="text-center">{{numbersWithDots(item.amount)}}</td>
                            <td class="text-center">
                                {{(getStatus(item.status) == 'Thành công' || getStatus(item.status) == 'Đủ điều kiện') ? (numbersWithDots(item.share_value)) : '0'}}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12" ng-if="listData.rowCount==0" class="text-center">Không có dữ liệu</td>
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
                                    <li ng-if="listData.pageNumber < listData.pageCount"><a
                                            href="javascript:void(0)"
                                            ng-click="loadPageData(listData.pageCount)">»</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    </div>
                    </div>
                </footer>
                <div style="border-radius: 20px;" id="modalDetailSim" class="modal fade bs-example-modal-lg"
                     tabindex="-1" role="dialog">
                    <div class="modal-dialog modal-lg" style="width: 70%;overflow-y: auto;border-radius: 20px;">
                        <div class="modal-content" style="border-radius: 20px;">
                            <div class="modal-body" style="border-radius: 20px;">
                                <section class="panel panel-default" style="border-radius: 20px;border: none;">
                                    <div class="panel-body">
                                        <button type="button" class="btn btn-default close" data-dismiss="modal"
                                                aria-hidden="true">
                                            &times;
                                        </button>
                                        <div class="row">
                                            <h3 class="modal-title" style="text-align: center">THÔNG TIN GIAO DỊCH SIM
                                                SỐ</h3>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin chung</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Cộng tác viên</span>
                                                    <span class="col-sm-8 right">
                                                {{detailSim.user_name == null ? '-' : detailSim.user_name}}
                                                </span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Đối tượng giữ số</span>
                                                    <span class="col-sm-6 right">{{detailSim.user_name == null ? 'Khách hàng' : 'Cộng tác viên'}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-5 label-view">Họ và tên</span>
                                                    <span class="col-sm-7 right">{{detailSim.full_name}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Số điện thoại liên hệ</span>
                                                    <span class="col-sm-6 right">{{detailSim.msisdn_contact}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">CCCD</span>
                                                    <span class="col-sm-8 right">{{detailSim.id_passpost}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Địa chỉ</span>
                                                    <span class="col-sm-8 right">{{detailSim.address}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Ghi chú</span>
                                                    <span class="col-sm-8 right">{{detailSim.user_name == null ? '-' : 'CTV giữ số cho khách hàng'}}</span>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin số thuê bao</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Số thuê bao</span>
                                                    <span class="col-sm-6 right">{{detailSim.msisdn}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Loại thuê bao</span>
                                                    <span class="col-sm-6 right">{{detailSim.msisdn_type == 0 ? 'Trả trước' : 'Trả sau'}}</span>
                                                </div>
                                                <%--                                                <div class="row radius-field">--%>
                                                <%--                                                    <span class="col-sm-5 label-view">Nơi quản lý</span>--%>
                                                <%--                                                    <span class="col-sm-7 right">{{detailSim.dw_type}}</span>--%>
                                                <%--                                                </div>--%>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Loại số</span>
                                                    <span class="col-sm-8 right">
                                                        {{getDtailGroupMsisdn(detailSim.group_id)}}
                                                    </span>
                                                    <%--                                                    <span class="col-sm-8 right">--%>
                                                    <%--                                                        {{detailApi.groupName}}--%>
                                                    <%--                                                    </span>--%>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Nhà mạng</span>
                                                    <span class="col-sm-8 right">{{getSimType(detailSim.type)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-5 label-view">Thông tin cam kết</span>
                                                    <span class="col-sm-7 right">{{detailApi.minPrice > 0 ? ((numbersWithDots(detailApi.minPrice)) + ' VNĐ/Tháng') : 'Sim không cam kết'}}</span>
                                                </div>

                                                <%--                                                <div class="row radius-field">--%>
                                                <%--                                                    <span class="col-sm-7 label-view">Gói cước KH yêu cầu</span>--%>
                                                <%--                                                    <span class="col-sm-5 right">---</span>--%>
                                                <%--                                                </div>--%>
                                                <br/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin giao dịch</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Trạng thái giao dịch</span>
                                                    <span class="col-sm-6 right">{{getStatusSim(detailSim.status)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Thời gian giữ số</span>
                                                    <span class="col-sm-6 right">{{detailSim.assign_time == null ? '-' : (detailSim.assign_time | date:'dd/MM/yyyy HH:mm:ss')}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Thời gian gán số</span>
                                                    <span class="col-sm-6 right">{{detailSim.connection_time == null ? '-' : (detailSim.connection_time | date:'dd/MM/yyyy HH:mm:ss')}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Thời gian hòa mạng</span>
                                                    <span class="col-sm-6 right">{{detailSim.payment_expried_time == null ? '-' : (detailSim.payment_expried_time | date:'dd/MM/yyyy HH:mm:ss')}}</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin hòa mạng</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Người xử lý</span>
                                                    <span class="col-sm-8 right">-</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Nơi hòa mạng</span>
                                                    <span class="col-sm-8 right">-</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Địa chỉ nơi hòa mạng</span>
                                                    <span class="col-sm-6 right">-</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Đối tượng hòa mạng</span>
                                                    <span class="col-sm-6 right">-</span>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin đối soát</b></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Trạng thái đối soát</span>
                                                    <span class="col-sm-6 right">{{getReviewStatus(detailSim.review_status)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Thời gian đối soát</span>
                                                    <span class="col-sm-6 right">{{detailSim.review_date == null ? '-' : (detailSim.review_date | date:'dd/MM/yyyy HH:mm:ss')}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Doanh thu</span>
                                                    <span class="col-sm-8 right">{{numbersWithDots(detailSim.amount)}} VNĐ</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Hoa hồng</span>
                                                    <span class="col-sm-8 right">{{detailSim.status == 6 ? ((numbersWithDots(detailSim.share_value)) + ' VNĐ') : '0 VNĐ'}}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row" style="text-align: center">
                                            <button type="button" class="btn btn-cancel" data-dismiss="modal">Quay lại
                                            </button>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="border-radius: 20px;" id="modalDetailPackage" class="modal fade bs-example-modal-lg"
                     tabindex="-1" role="dialog">
                    <div class="modal-dialog modal-lg" style="width: 70%;overflow-y: auto;border-radius: 20px;">
                        <div class="modal-content" style="border-radius: 20px;">
                            <div class="modal-body" style="border-radius: 20px;">
                                <section class="panel panel-default" style="border-radius: 20px;border: none;">
                                    <div class="panel-body">
                                        <button type="button" class="btn btn-default close" data-dismiss="modal"
                                                aria-hidden="true">
                                            &times;
                                        </button>
                                        <div class="row">
                                            <h3 class="modal-title" style="text-align: center">THÔNG TIN GIAO DỊCH GÓI
                                                CƯỚC</h3>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin chung</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Cộng tác viên</span>
                                                    <span class="col-sm-8 right">
                                                {{detailPackage.user_name}}
                                                </span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Tên gói cước</span>
                                                    <span class="col-sm-6 right">{{detailPackage.pack_code}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-5 label-view">Telco</span>
                                                    <span class="col-sm-7 right">{{getPackageType(detailPackage.type)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Loại gói cước</span>
                                                    <span class="col-sm-6 right">{{detailPackage.pack_type == 1 ? 'Hot'
                                                            : (detailPackage.pack_type == 2 ? 'Data'
                                                                    : (detailPackage.pack_type == 3 ? 'Thoại & SMS' : '-'))}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Ưu đãi gói cước</span>
                                                    <span class="col-sm-8 right">-</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Giá gói</span>
                                                    <span class="col-sm-8 right">{{numbersWithDots(detailPackage.amount)}} VNĐ</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Chu kỳ</span>
                                                    <span class="col-sm-8 right">{{detailPackage.cycle}} ngày</span>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin đăng ký</b></span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Trạng thái</span>
                                                    <span class="col-sm-6 right">{{getStatusPackage(detailPackage.status)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Kênh đăng ký</span>
                                                    <span class="col-sm-8 right">{{detailPackage.source}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Số thuê bao</span>
                                                    <span class="col-sm-6 right">{{detailPackage.msisdn}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-5 label-view">Thời gian đăng ký</span>
                                                    <span class="col-sm-7 right">{{detailPackage.reg_time | date:'dd/MM/yyyy HH:mm:ss'}}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="row">
                                                    <span style="color: #0c63e4;margin-left: 10px;"
                                                          class="col-sm-12 label-view"><b>Thông tin đối soát</b></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Trạng thái đối soát</span>
                                                    <span class="col-sm-6 right">{{getReviewStatus(detailPackage.review_status)}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-6 label-view">Thời gian đối soát</span>
                                                    <span class="col-sm-6 right">{{detailPackage.review_date == null ? '-' : (detailPackage.review_date | date:'dd/MM/yyyy HH:mm:ss')}}</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Doanh thu</span>
                                                    <span class="col-sm-8 right">{{numbersWithDots(detailPackage.amount)}} VNĐ</span>
                                                </div>
                                                <div class="row radius-field">
                                                    <span class="col-sm-4 label-view">Hoa hồng</span>
                                                    <span class="col-sm-8 right">{{detailPackage.status == 3 ? (numbersWithDots(detailPackage.share_value)) : '0'}} VNĐ</span>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row" style="text-align: center">
                                            <button type="button" class="btn btn-cancel" data-dismiss="modal">Quay lại
                                            </button>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </section>
    </section>
</section>