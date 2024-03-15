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

    .btn-export {
        background-color: #FFFFFF;
        color: #2563EB;
        border-radius: 10px;
    }

    .btn-secondary {
        background-color: #52525b;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #aaa;
        color: white;
    }
</style>

<script src="<%=request.getContextPath()%>/assets/project/req-payment/detail.js"></script>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="giaosimCtrlId" ng-app="FrameworkBase" ng-controller="frameworkCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="<%=request.getContextPath()%>/reqPayment/index.html">Yêu cầu thanh toán</a></li>
            </ul>
            <div>
                <div class="row">
                    <div class="col-md-6">
                        <a href="<%=request.getContextPath()%>/reqPayment/index.html"><h3 style="font-weight: bold">
                            <span class="fa fa-angle-left"></span> THÔNG TIN YÊU CẦU THANH TOÁN</h3></a>
                    </div>
                </div>
            </div>
            <form class="form-horizontal" role="form" theme="simple">
                <div class="row" style="margin-top: 0px;">
                    <div class="col-lg-5">
                        <div class="row">
                            <h4 style="color: #166AEB;padding: 15px 15px 5px 15px; font-weight: bold">Thông tin yêu cầu
                                thanh toán</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Mã
                                        yêu cầu thanh toán</label>
                                    <div class="col-md-8 "
                                         style="text-align: right;line-height: 30px; font-weight: bold">
                                        {{info.reqCode}}
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Trạng
                                        thái</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.status == 0">
                                        <font color="#E11D48">Từ chối</font>
                                    </div>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.status == 1">
                                        <font color="#D97706">Chờ xử lý</font>
                                    </div>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.status == 2">
                                        <font color="#2563EB">Hoàn tất</font>
                                    </div>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.status == 3">
                                        <font color="#0D9488">Đang xử lý</font>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Thời
                                        gian yêu
                                        cầu thanh toán</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        {{info.genDate | date:'dd-MM-yyyy HH:mm:ss'}}
                                    </div>

                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Người
                                        yêu
                                        cầu thanh toán</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.sourceRequest == 0">
                                        Admin
                                    </div>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold"
                                         ng-show="info.sourceRequest != 0">
                                        <a href="javascript:void(0);"
                                           ng-click="linkDetailCtv(info)">{{info.reqPartnerUsername}}</a>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Cộng
                                        tác
                                        viên</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.mobilePartner}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Họ
                                        và tên</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.fullName}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Số
                                        tiền yêu
                                        cầu</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.amount | currency:'':0}} VNĐ</div>

                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Phí
                                        rút</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.fee != null && info.fee > 0 ? info.fee : 0 | currency:'':0}}
                                            VNĐ
                                        </div>

                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Số
                                        dư tài
                                        khoản</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.walletBalance | currency:'':0}} VNĐ</div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <div class="row"
                             style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                            <h4 style="color: #166AEB;padding: 15px 15px 5px 15px; font-weight: bold">Thông tin chuyển
                                khoản</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Ngân
                                        hàng</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.accBank}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;ine-height: 30px">Chi
                                        nhánh</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.accBranch}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Số
                                        tài khoản</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.accNumber}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Tên
                                        tài
                                        khoản</label>
                                    <div class="col-md-8" style="text-align: right;line-height: 30px;font-weight: bold">
                                        <div class="">{{info.accName}}</div>
                                    </div>
                                </div>
                            </div>
                        </section>

                    </div>
                    <div class="col-lg-7">
                        <div class="row">
                            <h4 style="color: #166AEB;padding: 15px 15px 5px 15px; font-weight: bold">Thông tin thanh
                                toán</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="row"
                                         style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Trạng thái thanh
                                                toán<span
                                                        style="color: red"> *</span></label></label>
                                        </div>
                                    </div>
                                    <div class="row"
                                         style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-12">
                                            <select style="margin-bottom: 15px;border-radius: 10px;"
                                                    id="preStatus"
                                                    ng-model="info.preStatus" id="info.preStatus"
                                                    ng-change="fillData(info.preStatus)"
                                                    class="form-control"
                                                    ng-disabled="info.status == 0 || info.status == 2">
                                                <option ng-hide="{{info.preStatus != ''}}" value="">Lựa chọn</option>
                                                </option>
                                                <%--                                                <option ng-value="1" ng-show="info.status == 1">Chờ xử lý</option>--%>
                                                <option ng-value="3" ng-show="info.status == 1">Đang xử lý</option>
                                                <option ng-value="2"
                                                        ng-show="info.status == 1 || info.status == 3">
                                                    Hoàn tất
                                                </option>
                                                <option ng-value="0" ng-show="info.status == 1">Từ chối
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;" ng-show="showFlag != 0">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Số tiền thanh
                                                toán
                                                (VNĐ)<span
                                                        style="color: red"> *</span></label></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;"
                                         ng-show="showFlag != 0">
                                        <div class="col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px" name="payAmount"
                                                   id="payAmount"
                                                   data-type="currency"
                                                   ng-value="info.payAmount"
                                                   ng-model="info.payAmount" maxlength="20"
                                                   ng-disabled="info.status != 1"
                                                   class="form-control currency"
                                                   data-parsley-trigger="change" placeholder="Số tiền thanh toán"
                                                   data-parsley-required="true"
                                                   data-parsley-required-message="Số tiền thanh toán không được bỏ trống"
                                                   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"/>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;"
                                         ng-show="showFlag != 0">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class="color-label left">Người thanh
                                                toán<span
                                                        style="color: red"> *</span></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;"
                                         ng-show="showFlag != 0">
                                        <div class="col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px"
                                                   name="prePaymentBy"
                                                   id="paymentBy"
                                                   ng-value="info.prePaymentBy"
                                                   ng-model="info.prePaymentBy" maxlength="100" class="form-control"
                                                   ng-disabled="isDisabled"
                                                   data-parsley-trigger="change" placeholder="Người thanh toán"
                                                   data-parsley-required="true"
                                                   data-parsley-required-message="Người thanh toán không được bỏ trống"/>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;"
                                         ng-show="showFlag != 0">
                                        <div class=" col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Thời gian<span
                                                    style="color: red"> *</span></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;"
                                         ng-show="showFlag != 0">
                                        <div class="col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px" type="text"
                                                   id="info-paymentDate"
                                                   placeholder="Thời gian thanh toán"
                                                   ng-model="info.prePaymentDate"
                                                   ng-disabled="isDisabled"
                                                   class="form-control"
                                                   data-date-format="DD/MM/YYYY hh:mm:ss"/>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Ghi chú<span
                                                    style="color: red"> *</span></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px"
                                                   name="description" id="description"
                                                   ng-value="info.preDescription"
                                                   ng-disabled="isDisabled"
                                                   ng-model="info.preDescription"
                                                   maxlength="128"
                                                   placeholder="Ghi chú" maxlength="20"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">File đính
                                                kèm</label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-12">
                                            <input style="float: left; display: none;" type="file"
                                                   ng-model="flagFile" id="file"
                                                   file-model="file" custom-on-change="fileValidate"
                                                   ng-disabled="isDisabled"
                                                   name="file"
                                                   onchange="angular.element(this).scope().fileValidate()">
                                            <button type="button" style="float: left;" id="fileSelection"
                                                    ng-click="choseFile()">Chọn tập tin...
                                            </button>
                                            <a style="float: left;margin-left: 5px;margin-top: 3px;" id="link" ng-click="download(1)"><label
                                                    id="fileChose"></label></a>
                                            <label style="float:left;margin-left: 5px;margin-top: 3px;"
                                                   id="fileNotChose">Chưa
                                                chọn tập tin.</label>
                                            <button style="float: left; margin-left: 5px;margin-top: 3px;color: #c72f2f;background-color: white;border: medium none;"
                                                    id="rmv1" ng-click="removeFile()" type="button">x
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 2%; text-align: center">
                                    <a href="<%=request.getContextPath()%>/reqPayment/index.html"
                                       style="width:136px;border: 1px solid #222222; border-radius: 6px"
                                       class="btn btn-light">Quay lại</a>
                                    <a ng-show="info.status != 2 && info.status != 0" ng-click="editReqPayment(info)"
                                       id="editReqPayment"
                                       style="width:136px;border-radius: 6px"
                                       class="btn btn-secondary">Lưu</a>
                                </div>
                                <%--                                    <div class="row" style="margin-top: 2%; text-align: center"--%>
                                <%--                                         ng-show="info.status == 2">--%>
                                <%--                                        <a href="<%=request.getContextPath()%>/reqPayment/index.html"--%>
                                <%--                                           style="border: 1px solid #2563EB; border-radius: 6px"--%>
                                <%--                                           class="btn btn-export">Quay lại</a>--%>
                                <%--                                    </div>--%>
                            </div>

                        </section>
                    </div>
                </div>
            </form>
        </section>
    </section>
</section>
<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
<script type="text/javascript">
    // const input = document.getElementById('file');
    // input.addEventListener('change', function () {
    //     const file = this.files[0];
    //     $("#fileChose").text(file.name);
    //     $("#fileNotChose").hide()
    //     $('#rmv1').show();
    // });
</script>