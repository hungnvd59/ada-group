<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/customer/index.js"></script>

<style>
    .error {
        color: red;
        padding-top: 5px;
    }

    .left {
        text-align: left !important;
        font-weight: bold;
    }

    .left-search {
        text-align: left !important;
        font-weight: bold;
        font-size: 14px;
        line-height: 25px;
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

    .box-full {
        box-shadow: rgba(0, 0, 0, 0.3) 0px 5px 15px;
        border: 1px solid white;
        border-radius: 6px;
        width: 93%;
        margin-left: 5rem;
        margin-top: 0rem;
        padding-bottom: 20px;
        line-height: 0px;
    }

    .status-active {
        background-color: #DBEAFE;
        color: #2563EB;
        border-radius: 4px;
        pointer-events: none;
    }

    .status-remove {
        background-color: #E5E7EB;
        color: #374151;
        border-radius: 4px;
        pointer-events: none;
    }

    .status-lock {
        background-color: #FFE4E6;
        color: #E11D48;
        border-radius: 4px;
        pointer-events: none;
    }

    .status-pending {
        background-color: #E5E7EB;
        color: #374151;
        border-radius: 4px;
        pointer-events: none;
    }

    .status-success {
        background-color: #CCFBF1;
        color: #0D9488;
        border-radius: 4px;
        pointer-events: none;
    }

    .status-waitting {
        background-color: #FEF3C7;
        color: #D97706;
        border-radius: 4px;
        pointer-events: none;
    }
</style>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="content" ng-app="ADAGROUP" ng-controller="customerUser">
    <section class="vbox">
        <section class="scrollable padder" style="background: #f4f4f4">
            <ul style="font-weight: 700;color: #2A2C54"
                class="bg-white breadcrumb no-border no-radius b-b b-light pull-in breadcrumb-common">
                <li style="color: gray"><span><i class="fa fa-home"></i>&nbsp;Trang chủ</span></li>
                <li style="color: gray"><span>Quản lý đại lý</span></li>
                <li><span>Danh sách đại lý</span></li>
            </ul>
            <div class="row" style="margin-bottom: 1rem">
                <div class="col-md-6">
                    <h4 style="font-weight: 700">THÔNG TIN TÌM KIẾM</h4>
                </div>
                <div class="col-md-6">
                    <%--                    <sec:authorize--%>
                    <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                    <a class="btn btn-add btn-search-common" ng-click="preAddCust()"
                       style="float:right;margin-right: .5rem;"><i
                            class="fa fa-plus"></i>&nbsp;Thêm mới đại lý</a>
                    <%--                    </sec:authorize>--%>
                </div>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-left: 30px;margin-right: 30px;">
                            <div class="row" style="margin-top: 0px;">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">Họ và tên</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="fullName" style="border-radius: 6px" my-enter="search()"
                                                   id="fullName"
                                                   placeholder="Họ và tên" maxlength="100"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Số điện thoại</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="mobile" style="border-radius: 6px" my-enter="search()"
                                                   id="mobile"
                                                   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                   maxlength="10"
                                                   placeholder="Số điện thoại"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="row" style="margin-top: 0px;">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">CEO - kim cương cấp
                                                trên</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="presenter" style="border-radius: 6px"
                                                   my-enter="search()"
                                                   id="presenter"
                                                   placeholder="Số điện thoại hoặc họ và tên CTV cấp trên"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">Trạng thái hoạt
                                                động</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select id="status" name="status" class="form-control"
                                                    style="width: 100% ;border-radius: 6px" ng-model="status">
                                                <option ng-value="-1">-- Tất cả --</option>
                                                <option ng-value="0">Ngừng hoạt động</option>
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
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Tỉnh/Thành
                                                phố</label>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Quận/Huyện</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <select id="provinceId" name="provinceId"
                                                    style="width: 100% ;border-radius: 6px"
                                                    class="form-control"
                                                    ng-model="provinceId"
                                                    ng-change="onChangeCity(provinceId)">
                                                <option ng-value="-1" selected="true">Tỉnh/ Thành phố
                                                </option>
                                                <option ng-repeat="city in provinceListAdd track by $index"
                                                        ng-value="{{city.id}}">
                                                    {{city.name}}
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <select id="districtId" name="districtId"
                                                    style="width: 100% ;border-radius: 6px"
                                                    class="form-control"
                                                    ng-model="districtId"
                                                    ng-change="getDistrict(provinceId)">
                                                <option ng-value="-1" selected="true">Quận/ Huyện
                                                </option>
                                                <option ng-repeat="district in districtList track by $index"
                                                        ng-value="{{district.id}}">
                                                    {{district.name}}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Thời gian vào công
                                                ty</label>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Thời gian rời công
                                                ty</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <input id="comingDate" name="comingDate" style="border-radius: 6px"
                                                   type="text"
                                                   class="form-control" data-date-format="DD-MM-YYYY"
                                                   placeholder="Từ ngày"
                                                   ng-model="comingDate"/>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                 height="16" fill="currentColor" class="bi bi-calendar2"
                                                 viewBox="0 0 16 16"
                                                 style="float: right; margin:-26px 10px 0 0;color:#9CA3AF">
                                                <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
                                                <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
                                            </svg>
                                        </div>
                                        <div class="col-md-6">
                                            <input id="leaveDate" name="leaveDate" style="border-radius: 6px"
                                                   type="text"
                                                   class="form-control" data-date-format="DD-MM-YYYY"
                                                   placeholder="Đến ngày"
                                                   ng-model="leaveDate"/>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                 height="16" fill="currentColor" class="bi bi-calendar2"
                                                 viewBox="0 0 16 16"
                                                 style="float: right; margin:-26px 10px 0 0;color:#9CA3AF">
                                                <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
                                                <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="row" style="padding-top: 30px">
                            <div class="col-lg-12 text-center">
                                <a ng-click="clear()"
                                   class="btn btn-light btn-clear-common">Xóa điều kiện</a>
                                <a ng-click="search()"
                                   class="btn btn-secondary btn-search-common">Tìm kiếm</a>
                                <sec:authorize
                                        access="hasAnyRole('ROLE_CTV_USER_ADD')">
                                    <a ng-click="preAdd()"
                                       style="width: 136px;background: #0071ce;border-radius: 8px;color: #FFFFFF;border: none"
                                       class="btn btn-secondary">Tạo tài khoản</a>
                                </sec:authorize>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <div class="row">
                <div class="col-md-6">
                    <h4 style="font-weight: 700">DANH SÁCH NHÂN VIÊN</h4>
                </div>
                <div class="col-md-6">
                    <%--                    <sec:authorize--%>
                    <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                    <a class="btn btn-add btn-export-common" ng-click="export()"
                       style="margin-right: 2rem;"><i
                            class="fa fa-download"></i>&nbsp;Xuất excel</a>
<%--                        <a class="btn btn-add btn-import-common" ng-click="import()"--%>
<%--                           style="float:right;margin-right: .5rem;">--%>
<%--                           <i class="fa fa-upload"></i>&nbsp;Tải lên danh sách nhân viên</a>--%>
                    <%--                    </sec:authorize>--%>
                </div>
            </div>
            <section class="panel panel-default" style="border-radius: 20px; margin-top: 1rem;">
                <div class="table-responsive table-overflow-x-fix">
                    <table class="table b-t b-light table-bordered table-hover" style="margin-bottom: 0px;">
                        <thead class="bg-gray">
                        <tr style="background-color: #222222;">
                            <th style="border-top-left-radius: 20px;vertical-align: middle"
                                class="text-white small_col text-center">STT
                            </th>
                            <sec:authorize
                                    access="hasAnyRole('ROLE_CTV_USER_DELETE','ROLE_CTV_USER_LOCK_UNLOCK','ROLE_CTV_USER_VIEW_REQ_PAYMENT','ROLE_CTV_USER_VIEW_REF_USER','ROLE_CTV_USER_VIEW_HISTORY_BALANCE','ROLE_CTV_USER_VIEW_CONFIG_CONTRACT','ROLE_CTV_USER_VIEW_CONFIRM','ROLE_CTV_USER_VIEW_DETAIL')">
                                <th style="vertical-align: middle;"
                                    class="text-white small_col text-center">Thao tác
                                </th>
                            </sec:authorize>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Họ và tên
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Kiểu nhân viên
                            </th>
                            <th style="vertical-align: middle;" class="text-white small_col text-left">Số điện thoại
                            </th>
                            <th style="vertical-align: middle;" class="text-white small_col text-left">Email
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Trạng thái hoạt động
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Tỉnh/Thành phố
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Quận/Huyện
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Đại lý cấp trên
                            </th>
                            <th style="vertical-align: middle;"
                                class="text-white small_col text-left">Thời gian vào công ty
                            </th>
                            <th style="border-top-right-radius: 20px;vertical-align: middle;"
                                class="text-white small_col text-left">Thời gian rời công ty
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td style="vertical-align: middle;" class="text-center">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <sec:authorize
                                    access="hasAnyRole('ROLE_CTV_USER_DELETE','ROLE_CTV_USER_LOCK_UNLOCK','ROLE_CTV_USER_VIEW_REQ_PAYMENT','ROLE_CTV_USER_VIEW_REF_USER','ROLE_CTV_USER_VIEW_HISTORY_BALANCE','ROLE_CTV_USER_VIEW_CONFIG_CONTRACT','ROLE_CTV_USER_VIEW_CONFIRM','ROLE_CTV_USER_VIEW_DETAIL')">
                                <td style="vertical-align: middle;" class="text-center">
                                    <div class="dropdown">
                                        <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i
                                                class="fa fa-info-circle text-default"></i></a>
                                        <ul class="dropdown-menu pull-left" style="width: fit-content;">
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_DETAIL')">
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}"><i
                                                            class="fa fa-eye"></i> Xem chi tiết</a></li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_CONFIRM')">
                                                <li ng-show="(item[0].statusVerify == 0 || item[0].statusVerify == 4) && item[0].status != 0">
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}"><i
                                                            class="fa fa-check-circle-o"></i> Xác thực tài khoản</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_CONFIG_CONTRACT')">
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}#!#configCommission"><i
                                                            class="fa fa-dollar"></i> Cấu hình hoa hồng</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_HISTORY_BALANCE')">
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}#!#balanceHis"><i
                                                            class="fa fa-line-chart"></i> Lịch sử biến động số dư</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_REQ_PAYMENT')">
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}#!#yctt"><i
                                                            class="fa fa-money"></i> Danh sách YC thanh toán</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_VIEW_REF_USER')">
                                                <li>
                                                    <a href="<%=request.getContextPath()%>/ctv/user/chi-tiet-tai-khoan-ctv.html?id={{item[0].id}}#!#lowerGrade"><i
                                                            class="fa fa-group"></i> Danh sách CTV cấp dưới</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_LOCK_UNLOCK')">
                                                <li ng-show="item[0].status == 0">
                                                    <a href="#" ng-click="preUnLockPartner(item[0])"><i
                                                            class="fa fa-unlock"></i> Mở khóa tài khoản</a>
                                                </li>
                                                <li ng-show="item[0].status == 1">
                                                    <a href="#" ng-click="preLockPartner(item[0])"><i
                                                            class="fa fa-lock"></i> Khóa tài khoản</a>
                                                </li>
                                            </sec:authorize>
                                            <sec:authorize
                                                    access="hasAnyRole('ROLE_CTV_USER_DELETE')">
                                                <li>
                                                    <a href="#" ng-click="preDeletePartner(item[0])"><i
                                                            class="fa fa-trash"></i>&nbsp;
                                                        Xóa tài khoản</a></li>
                                            </sec:authorize>
                                        </ul>
                                    </div>
                                </td>
                            </sec:authorize>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.fullName}}
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{getTypeCtv(item.type)}}
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.phone}}
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.email}}
                            </td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                <label class="text-center {{item.status == 1 ? 'status-active': (item.status == 2?'status-remove':'status-lock')}}"
                                       style="width: 100%; text-align:center;padding: 2%;display: inline-block">
                                    {{getStatusCtv(item.status)}}
                                </label>
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.provinceName}}
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.districtName}}
                            </td>
                            <td style="vertical-align: middle;text-align: left">
                                {{item.presenter}} <br>
                            </td>
                            <td style="vertical-align: middle;text-align: right" class="text-left v-inherit">
                                {{item.comingDate == null ? '-' : (item.comingDate | date:'dd/MM/yyyy HH:mm:ss')}}
                            </td>
                            <td style="vertical-align: middle;text-align: right" class="text-left v-inherit">
                                {{item.leaveDate == null ? '-' : (item.leaveDate | date:'dd/MM/yyyy HH:mm:ss')}}
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
    <%--    Add form--%>
    <div class="modal fade" id="addCtvModal" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static">
        <div class="modal-dialog" style="width: 70%">
            <div class="modal-content">
                <div class="modal-header alert "
                     style="padding: 20px; background: rgb(227, 29, 147);text-align: center">
                    <a style="color: #FFFFFF; opacity: 1" type="button" class="close" data-dismiss="modal"
                       aria-hidden="true" ng-click="clearFormAdd()">&times;
                    </a>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">THÊM MỚI TÀI KHOẢN</h5>
                </div>
                <form id="addForm">
                    <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem;">
                        <div class="row col-sm-12">
                            <div class="col-sm-6" style="font-weight: bold">Kiểu cộng tác<font color="red"> *</font>
                            </div>
                            <div class="col-sm-6" style="font-weight: bold">Số điện thoại đăng ký<font color="red">
                                *</font>
                            </div>
                        </div>

                        <div class="row col-sm-12" style="padding-top: 5px">
                            <div class="col-sm-6">
                                <select ng-model="addCtv.typeCtv" id="addCtv-typeCtv" class="form-control"
                                        style="border-radius: 6px"
                                        ng-change="changeType()"
                                        ng-init="addCtv.typeCtv = 7">
                                    <option ng-value="3" selected>Cộng tác viên</option>
                                    <option ng-value="7">Nhân viên bán hàng</option>
                                    <option ng-value="1">Đại lý chuyên</option>
                                    <option ng-value="2">Điểm bán</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" ng-model="addCtv.mobile"
                                       style="border-radius: 6px"
                                       placeholder="Số điện thoại đăng ký"
                                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                       ng-change="changeInput('mobileAddMsgErr')"
                                       id="addCtv-mobile"
                                       maxlength="10">
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="mobileAddMsgErr"> Số điện thoại đăng ký không được để trống!</span>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="mobileExistAddMsgErr"> Số điện thoại đã được đăng ký!</span>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="mobileAddLengthMsgErr"> Số điện thoại không đúng định dạng</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                        <div class="row col-sm-12">
                            <div class="col-sm-6" style="font-weight: bold">Họ và tên<font color="red"> *</font>
                            </div>
                            <div class="col-sm-6" style="font-weight: bold">Số CMND/CCCD<font color="red">
                                *</font>
                            </div>
                        </div>

                        <div class="row col-sm-12" style="padding-top: 5px">
                            <div class="col-sm-6">
                                <input type="text" class="form-control" ng-model="addCtv.fullName"
                                       placeholder="Họ và tên"
                                       style="border-radius: 6px"
                                       ng-change="changeInput('fullNameAddMsgErr')"
                                       id="addCtv-fullName"
                                       maxlength="50">
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="fullNameAddMsgErr"> Họ và tên không được để trống!</span>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" ng-model="addCtv.idNumber"
                                       style="border-radius: 6px"
                                       placeholder="Số CMND/CCCD"
                                       ng-change="changeInput('idNumberAddMsgErr')"
                                       id="addCtv-idNumber"
                                       oninput="this.value = this.value.replace(/[^0-9,a-zA-Z]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                       maxlength="12">
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="idNumberAddMsgErr"> Số CMND/CCCD không được để trống!</span>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="idNumberExistAddMsgErr"> Số CMND/CCCD đã tồn tại trong hệ thống!</span>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="idNumberFormatAddMsgErr"> Số CMND/CCCD không đúng định dạng!</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                        <div class="row col-sm-12">
                            <div class="col-sm-6" style="font-weight: bold">Tỉnh/Thành phố<font color="red"> *</font>
                            </div>
                            <div class="col-sm-6" style="font-weight: bold">Quận/Huyện<font color="red">
                                *</font>
                            </div>
                        </div>

                        <div class="row col-sm-12" style="padding-top: 5px">
                            <div class="col-sm-6">
                                <select chosen style="width: 100% ;border-radius: 6px"
                                        id="addCtv-provinceId"
                                        ng-model="addCtv.provinceId"
                                        data-placeholder="--Tất cả--"
                                        ng-change="addChangeCity()"
                                        options="provinceListAdd"
                                        ng-options="item.id as item.name for item in provinceListAdd"
                                        tabindex="7">
                                </select>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="provinceIdAddMsgErr"> Tỉnh/Thành không được để trống!</span>
                            </div>
                            <div class="col-sm-6">
                                <select chosen style="width: 100% ;border-radius: 6px"
                                        id="addCtv-districtId"
                                        ng-model="addCtv.districtId"
                                        data-placeholder="--Tất cả--"
                                        ng-change="addChangeDistrict()"
                                        options="districtListAdd"
                                        ng-options="item.id as item.name for item in districtListAdd"
                                        tabindex="7">
                                </select>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="districtIdAddMsgErr"> Quận/Huyện không được để trống!</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                        <div class="row col-sm-12">
                            <div class="col-sm-6" style="font-weight: bold">Phường/Xã<font color="red"> *</font>
                            </div>
                            <div class="col-sm-6" style="font-weight: bold">Trạng thái hoạt động <font color="red">
                                *</font>
                            </div>
                        </div>
                        <div class="row col-sm-12" style="padding-top: 5px">
                            <div class="col-sm-6">
                                <select chosen style="width: 100% ;border-radius: 6px"
                                        id="addCtv-communeId"
                                        ng-model="addCtv.communeId"
                                        data-placeholder="--Tất cả--"
                                        ng-change="changeCommuneAdd()"
                                        options="communeListAdd"
                                        ng-options="item.id as item.name for item in communeListAdd"
                                        tabindex="7">
                                </select>
                                <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                      id="communeIdAddMsgErr"> Phường/Xã không được để trống!</span>
                            </div>
                            <div class="col-sm-6">
                                <select id="addCtv-status" name="addCtv-status" class="form-control"
                                        ng-init="addCtv.status = 1"
                                        style="width: 100% ;border-radius: 6px" ng-model="addCtv.status">
                                    <option ng-value="0">Ngừng hoạt động</option>
                                    <option ng-value="1">Đang hoạt động</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div ng-if="addCtv.typeCtv == 7">
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Quận/Huyện quản lý<font color="red">
                                    *</font>
                                </div>
                                <div class="col-sm-6" style="font-weight: bold">Phường/Xã quản lý<font color="red">
                                    *</font>
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <select chosen multiple max-selection="10"
                                            style="width: 100% ;border-radius: 6px"
                                            id="addCtv-districtId2"
                                            ng-model="addCtv.districtIdList"
                                            ng-change="addChangeDistrictMul()"
                                            tabindex="7"
                                            options="districtListAdd"
                                            ng-options="item.id as item.name for item in districtListAdd"
                                            data-placeholder="--Lựa chọn--">
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="districtIdListMsgErr">Quận/Huyện quản lý không được để trống!</span>
                                </div>
                                <div class="col-sm-6">
                                    <select chosen multiple max-selection="10"
                                            style="width: 100% ;border-radius: 6px"
                                            id="addCtv-communeId2"
                                            ng-model="addCtv.communeIdList"
                                            ng-change="addChangeCommuneMul()"
                                            tabindex="7"
                                            options="communeListAddMul"
                                            ng-options="item.id as item.name for item in communeListAddMul"
                                            data-placeholder="--Tất cả--">
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="communeIdListMsgErr">Phường/Xã quản lý không được để trống!</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Shopcode M+<font color="red"> *</font>
                                </div>
                                <div class="col-sm-6" style="font-weight: bold">Shopcode Skynet<font color="red">
                                    *</font>
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <select chosen style="width: 100% ;border-radius: 6px"
                                            id="addCtv-smShopId"
                                            ng-model="addCtv.smShopId"
                                            data-placeholder="--Tất cả--"
                                            ng-change="changeInput('codeMAddMsgErr')"
                                            options="listSmShop"
                                            ng-options="item.id as item.shopCode + '-' + item.fullName for item in listSmShop"
                                            tabindex="7">
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="codeMAddMsgErr"> Shopcode M+ không được để trống!</span>
                                </div>
                                <div class="col-sm-6">
                                    <select ng-model="addCtv.shopcodeSkynet" id="addCtv-codeSkynet" class="form-control"
                                            ng-change="changeInput('codeSkynetAddMsgErr')"
                                            style="border-radius: 6px">
                                        <option ng-value="-1">--Lựa chọn--</option>
                                        <option ng-repeat="item in listSkynet track by $index"
                                                ng-value="item.shopCode">{{item.shopCode}}
                                        </option>
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="codeSkynetAddMsgErr"> Shopcode Skynet không được để trống!</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Mã nhân viên(EMPCODE)<font color="red">
                                    *</font>
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" ng-model="addCtv.empCode"
                                           placeholder="Mã nhân viên"
                                           ng-change="changeInput('empCodeAddMsgErr')"
                                           oninput="$(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));"
                                           style="border-radius: 6px"
                                           id="addCtv-empCode"
                                           maxlength="50">
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="empCodeAddMsgErr"> Mã nhân viên không được để trống!</span>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="empCodeExitsAddMsgErr"> Mã nhân viên đã tồn tại</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div ng-if="addCtv.typeCtv == 1">
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Shopcode M+<font color="red"> *</font>
                                </div>
                                <div class="col-sm-6" style="font-weight: bold">Shopcode Skynet<font color="red">
                                    *</font>
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <select chosen style="width: 100% ;border-radius: 6px"
                                            id="addCtv-smShopId"
                                            ng-model="addCtv.smShopId"
                                            data-placeholder="--Tất cả--"
                                            ng-change="changeInput('codeMAddMsgErr')"
                                            options="listSmShop"
                                            ng-options="item.id as item.shopCode + '-' + item.fullName for item in listSmShop"
                                            tabindex="7">
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="codeMAddMsgErr"> Shopcode M+ không được để trống!</span>
                                </div>
                                <div class="col-sm-6">
                                    <select ng-model="addCtv.shopcodeSkynet" id="addCtv-codeSkynet" class="form-control"
                                            ng-change="changeInput('codeSkynetAddMsgErr')"
                                            style="border-radius: 6px">
                                        <option ng-value="-1">--Lựa chọn--</option>
                                        <option ng-repeat="item in listSkynet track by $index"
                                                ng-value="item.shopCode">{{item.shopCode}}
                                        </option>
                                    </select>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="codeSkynetAddMsgErr"> Shopcode Skynet không được để trống!</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div ng-if="addCtv.typeCtv == 2">
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Mã điểm bán <font color="red"> *</font>
                                </div>
                                <div class="col-sm-6" style="font-weight: bold">Mã giới thiệu (nếu có)
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" ng-model="addCtv.salePointCode"
                                           style="border-radius: 6px;"
                                           ng-change="changeInput('salePointCodeMsgErr')"
                                           placeholder="Mã điểm bán"
                                           oninput="$(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));this.value = this.value.toUpperCase();"
                                           id="addCtv-salePointCode">
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="salePointCodeMsgErr"> Mã điểm bán không được để trống!</span>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="salePointExistCodeMsgErr"> Mã điểm bán đã tồn tại!</span>
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" ng-model="addCtv.refCode"
                                           style="border-radius: 6px"
                                           ng-change="changeInput('refCodeMsgErr')"
                                           placeholder="Mã giới thiệu (nếu có)"
                                           oninput="$(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));"
                                           id="addCtv-refCode">
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="refCodeMsgErr"> Mã giới thiệu không tồn tại!</span>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="refCodeNvbhMsgErr"> Mã giới thiệu không hợp lệ!</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div ng-if="addCtv.typeCtv == 3">
                        <div class="modal-body row" style="padding: 10px;padding-left: 7rem;padding-right: 7rem">
                            <div class="row col-sm-12">
                                <div class="col-sm-6" style="font-weight: bold">Mã giới thiệu (nếu có)
                                </div>
                            </div>
                            <div class="row col-sm-12" style="padding-top: 5px">
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" ng-model="addCtv.refCode"
                                           style="border-radius: 6px"
                                           oninput="$(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));"
                                           placeholder="Mã giới thiệu (nếu có)"
                                           id="addCtv-refCode">
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="refCodeMsgErr"> Mã giới thiệu không tồn tại!</span>
                                    <span class="error" style="display: none;text-align: left;margin-top: -.5rem"
                                          id="refCodeNvbhMsgErr"> Mã giới thiệu không hợp lệ!</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="modal-footer" style="margin-top: 30px">
                    <div style="text-align: center;">
                        <a class="btn" ng-click="clearFormAdd()"
                           style="border-radius: 6px; width: 100px; color: rgb(227, 29, 147); background-color: #FFFFFF;border: 1px rgb(227, 29, 147) solid"
                           data-dismiss="modal">Huỷ
                        </a>
                        <a class="btn" ng-click="addNewCtv()"
                           style="width: 100px; color: white; background-color: rgb(227, 29, 147);border-radius: 6px">
                            Lưu
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%--    End add form--%>
    </div>
    <div class="modal fade" id="mdLockUser" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="a">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert text-center" style="padding: 7px; background: #e31d93;border-radius: 0">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true" ng-click="clearFormAdd()">&times;
                    </button>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn khóa tài khoản </label>
                        <span style="font-weight: bold">{{userLock.fullName}} - {{userLock.mobile}}</span>
                        <label>hay không?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <a class="btn btn-light"
                           type="button"
                           style="width:136px; border: 1px solid #e31d93;color: #e31d93; border-radius: 8px"
                           data-dismiss="modal">Hủy
                        </a>
                        <a class="btn btn-secondary"
                           style="width: 136px;background: #e31d93;border-radius: 8px;color: #FFFFFF;border: none"
                           type="button"
                           ng-click="lockUser()">Đồng ý
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="mdUnLockUser" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="b">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert text-center" style="padding: 7px; background: #e31d93;border-radius: 0">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true" ng-click="clearFormAdd()">&times;
                    </button>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn mở khóa người dùng </label>
                        <span style="font-weight: bold">{{userUnLock.fullName}} - {{userUnLock.mobile}}</span>
                        <label>hay không?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <a class="btn btn-light"
                           type="button"
                           style="width:136px; border: 1px solid #e31d93;color: #e31d93; border-radius: 8px"
                           data-dismiss="modal">Hủy
                        </a>
                        <a class="btn btn-secondary"
                           style="width: 136px;background: #e31d93;border-radius: 8px;color: #FFFFFF;border: none"
                           type="button"
                           ng-click="unLockUser()">Đồng ý
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="mdDeleteUser" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" id="d">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert text-center" style="padding: 7px; background: #e31d93;border-radius: 0">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true" ng-click="clearFormAdd()">&times;
                    </button>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                </div>
                <div>
                    <div class="modal-body">
                        <label>Bạn có chắc chắn muốn xóa tài khoản </label>
                        <span style="font-weight: bold">{{userDelete.fullName}} - {{userDelete.mobile}}</span>
                        <label>hay không?</label>
                    </div>
                    <div class="modal-footer" style="border: none;text-align: center">
                        <a class="btn btn-light"
                           type="button"
                           style="width:136px; border: 1px solid #e31d93;color: #e31d93; border-radius: 8px"
                           data-dismiss="modal">Hủy
                        </a>
                        <a class="btn btn-secondary"
                           style="width: 136px;background: #e31d93;border-radius: 8px;color: #FFFFFF;border: none"
                           type="button"
                           ng-click="deleteUserF()">Đồng ý
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>