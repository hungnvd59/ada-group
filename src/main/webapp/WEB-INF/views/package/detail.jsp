<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/package/detail.js"></script>
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
                <h3><font style="font-weight: bold"><a id="comeBack" href="<%=request.getContextPath()%>/package/index.html"> < THÔNG TIN SẢN PHẨM</a></font></h3>
            </div>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Danh mục<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select class="form-control" disabled
                                                style="width: 100% ;border-radius: 10px">
                                            <option selected >Gói cước</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Mã sản phẩm<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input disabled id="affPackage_packCode" ng-model="affPackage.packCode" style="border-radius: 10px"
                                               placeholder="Mã sản phẩm" maxlength="20"
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
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Telco<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="affPackage_type" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="affPackage.type">
                                            <option ng-value="-1">-- Lựa chọn --</option>
                                            <option ng-value="0">MobiFone</option>
                                            <option ng-value="3">VinaPhone</option>
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
                                        <label class="control-label color-label left">Giá gói (VNĐ)<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_amount" ng-model="affPackage.amount" style="border-radius: 10px"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               ng-change="formatAmount('amount')"
                                               placeholder="Giá gói cước" maxlength="10"
                                               class="form-control"/>
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
                                    <div class="col-md-10 left">
                                        <label class="control-label color-label left">Tỷ lệ hoa hồng OSP nhận được từ Telco (có VAT)<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input id="affPackage_ratioValue" ng-model="affPackage.ratioValue" style="border-radius: 10px"
                                               ng-change="formatAmount('ratioValue')"
                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                               placeholder="Phần trăm hoa hồng" maxlength="3"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Chu kỳ (ngày)<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="affPackage_numExpired" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="affPackage.numExpired">
                                            <option ng-value="-1">-- Lựa chọn --</option>
                                            <option ng-value="7">7 ngày</option>
                                            <option ng-value="30">30 ngày</option>
                                            <option ng-value="90">90 ngày</option>
                                            <option ng-value="180">180 ngày</option>
                                            <option ng-value="270">270 ngày</option>
                                            <option ng-value="360">360 ngày</option>
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
                                        <label class="control-label color-label left">Trạng thái<font color="red">*</font></label>
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
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-10 left">
                                        <label class="control-label color-label left">Hoa hồng OSP nhận được từ VNP (không VAT)<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input disabled id="affPackage_hhOsp" class="form-control" ng-model="affPackage.hhOsp" style="border-radius: 10px"
<%--                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"--%>
                                               ng-change="formatAmount('hhOsp')" placeholder="Hoa hồng OSP" />
                                    </div>
                                </div>
                            </div>

                        </div>
                        <br>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-5 left">
                                        <label class="control-label color-label left">Mô tả sản phẩm<font color="red">*</font></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <textarea id="affPackage_packInfo" class="form-control" ng-model="affPackage.packInfo" style="border-radius: 10px"
                                                  placeholder="Mô tả sản phẩm" ></textarea>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row" style="padding-top: 30px">
                            <div class="col-lg-12 text-center">
                                <a href="<%=request.getContextPath()%>/package/index.html" style="width:136px; border: 1px solid #222222; border-radius: 6px"
                                   class="btn btn-light">Quay lại</a>
                                <a ng-click="updatePackage()" style="width:136px; border-radius: 6px"
                                   class="btn btn-secondary">Cập nhật</a>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
        </section>
    </section>
</section>