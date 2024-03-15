<%@ page import="java.util.Random" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%!
    public void randomCache(String urlCache, HttpServletRequest request) {
        request.setAttribute("urlCache", urlCache);
    }
%>
<%
    /*clear cache chrome */
    Random rand = new Random();
    Integer numberCache = rand.nextInt(99999999);
    String urlCache = "?updated=" + numberCache;
    randomCache(urlCache, request);
%>

<style>
    .table > thead > tr > th {
        vertical-align: top;
    }

    .field_set {
        border: 1px solid #0a0a0a;
        width: 200px;
    }

    fieldset {
        background-color: white;
    }

    legend {
        font-size: 14pt;
        color: #0a0a0a;
        font-weight: bold;
    }

    .left {
        text-align: left !important;
        font-weight: bold;
    }

    .currency {
        padding-left: 11px;
    }

    .currency-symbol {
        position: absolute;
        padding: 9px 5px;
        right: 10px;
        top: 0px;
    }

    .btn-add {
        background-color: #2563EB;
        color: white;
        border-radius: 10px;
    }

    .btn-add:hover {
        background-color: #3f68c2;
        color: white;
    }

    .btn-export {
        background-color: #FFFFFF;
        color: #2563EB;
        border-radius: 10px;
    }

    .btn-export:hover {
        background-color: #c3c7ce;
        color: #2563EB;
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

    .status0 {
        background-color: #FFE4E6;
        color: #E11D48;
        border-radius: 4px;
    }

    .status1 {
        background-color: #FEF3C7;
        color: #D97706;
        border-radius: 4px;
    }

    .status2 {
        background-color: #DBEAFE;
        color: #2563EB;
        border-radius: 4px;
    }

    .status3 {
        background-color: #CCFBF1;
        color: #0D9488;
        border-radius: 4px;
    }
</style>

<script src="<%=request.getContextPath()%>/assets/project/req-payment/index.js"></script>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="giaosimCtrlId" ng-app="FrameworkBase" ng-controller="frameworkCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="javascript:void(0)">Yêu cầu thanh toán</a></li>
            </ul>
            <div>
                <div class="row">
                    <div class="col-md-6">
                        <h3 style="font-weight: bold;">DANH SÁCH YÊU CẦU THANH TOÁN</h3>
                    </div>
                    <div class="col-md-6">
                        <sec:authorize access="hasRole('ROLE_REQ_PAYMENT_ADM_ADD')">
                            <a href="<%=request.getContextPath()%>/reqPayment/add.html" class="btn btn-add"
                               style="float:right;"> <i
                                    class="fa fa-plus"></i> Thêm thông tin thanh toán</a>
                        </sec:authorize>
                    </div>
                </div>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Cộng tác viên</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input name="mobile" ng-model="mobile"
                                               style="border-radius: 10px"
                                               placeholder="Tìm kiếm số điện thoại CTV"
                                               maxlength="100" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Mã yêu cầu thanh toán</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input name="reqCode" ng-model="reqCode"
                                               placeholder="Tìm kiếm mã yêu cầu thanh toán"
                                               style="border-radius: 10px"
                                               maxlength="100" class="form-control"/>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Trạng thái thanh toán</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select ng-model="status" id="status" class="form-control"
                                                style="border-radius: 10px">
                                            <option value="">-- Tất cả --</option>
                                            <option ng-value="1">Chờ xử lý</option>
                                            <option ng-value="3">Đang xử lý</option>
                                            <option ng-value="2">Hoàn tất</option>
                                            <option ng-value="0">Từ Chối</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Thời gian yêu cầu</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6" style="padding-right: 5px">
                                        <input id="fromGenDate" name="fromGenDate" type="text" class="form-control"
                                               style="border-radius: 10px"
                                               ng-model="fromGenDate"
                                               data-date-format="DD/MM/YYYY" placeholder="Từ ngày">
                                    </div>
                                    <div class="col-md-6" style="padding-left: 5px">
                                        <input id="toGenDate" name="toGenDate" type="text" class="form-control"
                                               style="border-radius: 10px"
                                               ng-model="toGenDate"
                                               data-date-format="DD/MM/YYYY" placeholder="Đến ngày">
                                    </div>
                                </div>
                            </div>

                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Thời gian thanh toán</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6" style="padding-right: 5px">
                                        <input id="fromPaymentDate" name="fromPaymentDate" type="text"
                                               style="border-radius: 10px"
                                               class="form-control"
                                               ng-model="fromPaymentDate"
                                               placeholder="Từ ngày">
                                    </div>
                                    <div class="col-md-6" style="padding-left: 5px">
                                        <input id="toPaymentDate" name="toPaymentDate" type="text"
                                               style="border-radius: 10px"
                                               class="form-control"
                                               ng-model="toPaymentDate"
                                               placeholder="Đến ngày">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Import file thanh toán</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-8" style="padding-right: 5px">
                                        <input id="file" type="file"
                                               file-model="file" custom-on-change="fileChange"
                                               style="border-radius: 10px"
                                               class="form-control ng-pristine ng-untouched ng-valid ng-empty">
                                        <input type="hidden" ng-model="thumbnail" id="thumbnail">
                                    </div>
                                    <div class="col-sm-4" style="padding-left: 5px">
                                        <a href="" ng-click="importPaymentFile()" class="btn btn-export"
                                           style="border: 1px solid #2563EB; border-radius: 10px;width: 100%;">
                                            <i class="fa fa-arrow-circle-o-up"></i> Import file Excel thanh toán</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 2%; text-align: center">
                            <a ng-click="resetValue()"
                               style="border: 1px solid #222222; border-radius: 6px;width: 136px"
                               class="btn btn-light">Xóa điều kiện</a>
                            <a ng-click="search()" style="border-radius: 6px;width: 136px"
                               class="btn btn-secondary">Tìm kiếm</a>
                            <!--<button type="button" ng-click="exportExcelReqPayment2();" class="btn btn-s-sm btn-success">Xuất excel thanh toán</button>-->
                        </div>
                        <div class="line line-dashed line-lg pull-in" style="clear:both ;border-top:0px"></div>
                    </form>
                </div>
            </section>
            <div class="row">
                <div class="col-sm-6">
                    <h4 style="width: 60%; font-weight: bold;">{{page.rowCount | currency:"":0}} yêu cầu
                        thanh toán</h4>
                </div>
                <div class="col-sm-6">
                    <button type="button" ng-click="exportExcelReqPayment();"
                            style="float:right;border: 1px solid #2563EB; border-radius: 10px"
                            class="pull-right btn btn-export"><i class="fa fa-file-excel-o"></i> Xuất Excel
                    </button>
                </div>
            </div>
            <br/>
            <section class="panel panel-default" style="border-radius: 20px;">
                <!--                <header class="panel-heading">
                                    <a href="javascript:void(0)">
                                        <h4 class="panel-title font-bold text-uppercase" data-toggle="collapse">
                                            DANH SÁCH YÊU CẦU THANH TOÁN
                                        </h4>
                                    </a>
                                </header>-->
                <%--                <div style="border-radius: 20px;" id="collapseTwo" class="panel-collapse collapse in" aria-expanded="true">--%>
                <%--                    <div style="border-radius: 20px;" class="panel-body background-xam">--%>

                <%--                        <div class="row">--%>
                <%--                            <div class="col-sm-6">--%>
                <%--                                <h4 style="width: 60%; font-weight: bold;">{{page.rowCount | currency:"":0}} yêu cầu--%>
                <%--                                    thanh toán</h4>--%>
                <%--                            </div>--%>
                <%--                            <div class="col-sm-6">--%>
                <%--                                <button type="button" ng-click="exportExcelReqPayment();"--%>
                <%--                                        style="float:right;border: 1px solid #2563EB; border-radius: 10px"--%>
                <%--                                        class="pull-right btn btn-export"><i class="fa fa-file-excel-o"></i> Xuất Excel--%>
                <%--                                </button>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <div class="table-responsive" style="overflow-x:auto; border-radius: 20px;">
                    <table id="tbl" class="table table-hover" style="border-radius: 20px;">
                        <thead>
                        <tr style="color:#1F2937; background-color: #F4F4F5">
                            <th class="small_col text-center"
                                style="width: 1%; vertical-align: middle;border-top-left-radius: 20px;">STT
                            </th>
                            <th class="small_col text-center"
                                style="width: 3%; vertical-align: middle;">Thao tác
                            </th>
                            <th class="small_col text-center"
                                style="width: 6%; vertical-align: middle;">Mã yêu cầu
                            </th>
                            <th class="small_col text-center"
                                style="width: 8%; vertical-align: middle;">Cộng tác viên
                            </th>
                            <th class="small_col text-center"
                                style="width: 10%; vertical-align: middle;">Thời gian yêu cầu
                            </th>
                            <th class="small_col text-center"
                                style="width: 11%; vertical-align: middle;">Số tiền yêu cầu (VNĐ)
                            </th>
                            <th class="small_col text-center"
                                style="width: 10%; vertical-align: middle;">Thời gian xử lý
                            </th>
                            <th class="small_col text-center"
                                style="width: 23%; vertical-align: middle;">Nội dung xử lý
                            </th>
                            <th class="small_col text-center"
                                style="width: 10%; vertical-align: middle;">Thời gian thanh toán
                            </th>
                            <th class="small_col text-center"
                                style="width: 11%; vertical-align: middle;">Số tiền thanh toán
                                (VNĐ)
                            </th>
                            <th class="small_col text-center"
                                style="vertical-align: middle;border-top-right-radius: 20px;">
                                Trạng
                                Thái
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-show="listData.rowCount == 0">
                            <td colspan="14"
                                style="height: 100%;background-color: #ececec; line-height: 3.429;text-align: center; font-style: italic;">
                                Không có dữ liệu
                            </td>
                        </tr>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                <div class="btn-group">
                                    <a class="btn btn-default"
                                       href="<%=request.getContextPath()%>/reqPayment/detail.html?id={{item.id}}&status={{item.status}}">
                                        <i class="fa fa-pencil"
                                           aria-hidden="true"></i>
                                    </a>
                                </div>
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">{{item.reqCode}}</td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">{{item.username}}</td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{item.genDate | date:'dd/MM/yyyy HH:mm:ss'}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">{{item.reqAmount | number}}</td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{item.lastUpdated == null ? '-' : (item.lastUpdated | date:'dd/MM/yyyy HH:mm:ss')}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{item.description == null ? '-' : item.description}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                {{ (item.approveDate == null ? '-' : item.approveDate | date:'dd/MM/yyyy HH:mm:ss')}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">{{item.status == 2 ? (item.amount | number) : "-"}}
                            </td>
                            <td style="vertical-align: middle;" class="text-center v-inherit">
                                <a style="text-align:center;padding: 5%;display: inline-block;width: 90px;"
                                   class="text-center v-inherit {{item.status == 1 ? 'status1':(item.status == 0 ? 'status0' : item.status == 3 ? 'status3' :'status2')}}">
                                    {{item.status == 0 ? 'Từ chối' : (item.status == 1 ? 'Chờ xử lý' : item.status == 3 ? 'Đang xử lý' : 'Hoàn tất')}}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <footer class="panel-footer">
                    <div class="row">
                        <div class="p-r-0 col-sm-12 text-right text-center-xs">
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
                </footer>
            </section>
        </section>
    </section>
    <div class="modal fade" id="mdConfirmPayment" role="dialog" aria-labelledby="mdConfirmPayment" aria-hidden="true"
         data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog" style="width: 80%">
            <div class="modal-content">
                <div class="modal-header alert-success" style="padding: 7px;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h5 class="modal-title" style="font-size: 20pt">Xác nhận thanh toán</h5>
                </div>
                <div class="modal-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row">
                            <div class="col-sm-12" style="text-align: center">
                                <span style="font-size: 18px">Bạn có chắc chắn xác nhận đã thanh toán cho yêu cầu mã</span>
                                <span style="color: #0065FF; font-size: 18px">{{reqProcess.reqCode}}</span> <span
                                    style="font-size: 18px"> hay không?</span>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <div class="row" style="text-align: center">
                        <button type="button" style="border: 1px solid #222222; border-radius: 6px"
                                class="btn btn-light" data-dismiss="modal">Hủy bỏ
                        </button>
                        <button class="btn btn-add" ng-click=" confirmPayment(reqProcess)">Đồng ý
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>

</section>


