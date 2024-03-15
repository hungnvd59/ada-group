<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/transReport/tong-hop-theo-divu.js"></script>
<style>
    .left {
        text-align: left !important;
        font-weight: bold;
    }

    .btn-secondary {
        background-color: gray;
        color: white;
    }

    form label {
        text-align: left !important;
    }

    .table > thead > tr > th {
        vertical-align: top;
    }
</style>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="partnerSC" ng-app="FrameworkBase" ng-controller="partnerCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="javascript:void(0)">Báo cáo thống kê</a></li>
            </ul>
            <div>
                <h3 style="font-weight: bold;">BÁO CÁO TỔNG HỢP SẢN LƯỢNG THEO DỊCH VỤ</h3>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Dịch vụ</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="itemType" name="itemType" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="itemType"
                                                ng-change="searchProduct(itemType)">
                                            <option selected="true" value="">-- Tất cả --</option>
                                            <option value="SIMSO">Sim số</option>
                                            <option value="GOICUOC">Gói cước</option>
                                        </select>
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
                                        <input ng-model="userName" style="border-radius: 10px" my-enter="search()"
                                               placeholder="Tìm kiếm số điện thoại CTV" maxlength="20"
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
                                        <label class="control-label color-label left">Số thuê bao</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="msisdnContract" style="border-radius: 10px" my-enter="search()"
                                               placeholder="Tìm kiếm theo số thuê bao khách hàng" maxlength="20"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
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
                                <a ng-click="clear()" style="border: 1px solid #222222; border-radius: 6px"
                                   class="btn btn-light">Xóa điều kiện</a>
                                <a ng-click="search()" style="border-radius: 6px" class="btn btn-secondary">Tìm
                                    kiếm</a>
                            </div>
                        </div>
                    </form>
                </div>
            </section>

            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive table-overflow-x-fix">
                    <table id="tbl" class="table table-striped table-bordered m-b-none b-light">
                        <thead>
                        <tr>
                            <th style="border-top-left-radius: 20px" class="box-shadow-inner small_col text-center">STT</th>
                            <th class="box-shadow-inner small_col text-center" width="20%">Dịch vụ</th>
                            <th class="box-shadow-inner small_col text-center" width="20%">Số lượng giao dịch thành
                                công
                            </th>
                            <th class="box-shadow-inner small_col text-center" width="20%">Tổng doanh thu khách
                                hàng(VNĐ)
                            </th>
                            <th class="box-shadow-inner small_col text-center" width="20%">Tổng lợi nhuận OSP
                                hưởng(VNĐ)
                            </th>
                            <th style="border-top-right-radius: 20px" class="box-shadow-inner small_col text-center" width="20%">Tổng hoa hồng CTV kinh
                                doanh(VNĐ)
                            </th>

                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td></td>
                            <td class="text-center"><font color="#2563EB">Tổng cộng</font></td>
                            <td class="text-center"><font color="#2563EB">{{totalRecord}}</font></td>
                            <td class="text-center"><font color="#2563EB">{{totalAmount}}</font></td>
                            <td class="text-center"><font color="#2563EB">{{totalOspValue}}</font></td>
                            <td class="text-center"><font color="#2563EB">{{totalShareValue}}</font></td>
                        </tr>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td class="text-center">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
                            <td class="text-center">{{item.itemName=='SIMSO'?'Sim số':'Gói cước'}}</td>
                            <td class="text-center">{{item.totalTransSuccess}}</td>
                            <td class="text-center">{{item.totalAmount}}</td>
                            <td class="text-center">{{item.ospValue }}</td>
                            <td class="text-center">{{item.shareValue }}</td>
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
                                                                           ng-click="search(1)">«</a>
                                    </li>
                                    <li ng-repeat="item in listData.pageList">
                                        <a href="javascript:void(0)" ng-if="item == listData.pageNumber"
                                           style="color:mediumvioletred;"> {{item}}</a>
                                        <a href="javascript:void(0)" ng-if="item != listData.pageNumber"
                                           ng-click="search(item)"> {{item}}</a>
                                    </li>
                                    <li ng-if="listData.pageNumber < listData.pageCount"><a
                                            href="javascript:void(0)"
                                            ng-click="search(listData.pageCount)">»</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </section>
        </section>
    </section>
</section>