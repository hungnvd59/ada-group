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

    .btn-secondary {
        background-color: #52525b;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #aaa;
        color: white;
    }
</style>

<script src="<%=request.getContextPath()%>/assets/project/req-payment/add.js"></script>

<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="giaosimCtrlId" ng-app="FrameworkBase" ng-controller="frameworkCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="<%=request.getContextPath()%>/reqPayment/index.html">Quản lý yêu cầu thanh toán</a></li>
            </ul>
            <div>
                <div class="row">
                    <div class="col-md-6">
                        <a href="<%=request.getContextPath()%>/reqPayment/index.html"><h3 style="font-weight: bold;">
                            <span class="fa fa-angle-left"></span> THÊM MỚI THÔNG TIN THANH TOÁN</h3></a>
                    </div>
                </div>
            </div>
            <form class="form-horizontal" role="form" theme="simple">
                <div class="row" style="margin-top: 0px;">
                    <div class="col-lg-5">
                        <div class="row">
                            <h4 style="font-weight: bold;color: #166AEB;padding: 15px 15px 5px 15px">Thông tin cộng tác
                                viên</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row"
                                     style="margin:auto;margin-bottom:5px;border-radius: 8px;">
                                    <div class="col-md-5">
                                        <label style="font-weight: bold" class="color-label left">Cộng tác viên<span
                                                style="color: red"> *</span></label></label>
                                    </div>
                                </div>
                                <div class="row"
                                     style="margin:auto;border-radius: 8px;">
                                    <div class="col-md-12">
                                        <select style="margin-bottom: 15px;border-radius: 10px;width: 100%"
                                                ng-model="newReq.partnerId"
                                                id="partnerId"
                                                class="select2-option"
                                                ng-change="searchPartnerDetail(newReq.partnerId)"
                                                ng-init="newReq.partnerId = '0'"
                                                ng-disabled="isDisabled">
                                            <option value="0" selected="true">Lựa chọn</option>
                                            <option ng-repeat="item in listPartner track by $index"
                                                    value="{{item.id}}">{{item.mobile}}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Cộng tác
                                        viên</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        {{partner.mobile == null ? '-' : partner.mobile}}
                                    </div>

                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Họ và
                                        tên</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        {{partner.partnerName == null ? '-' : partner.partnerName}}
                                    </div>
                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Số dư tài
                                        khoản</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        {{partner.accBalance == null ? '-' : partner.accBalance | currency:'':0 }} VNĐ
                                    </div>
                                </div>
                            </div>
                        </section>
                        <div class="row"
                             style="margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                            <h4 style="font-weight: bold;color: #166AEB;padding: 15px 15px 5px 15px">Thông tin chuyển
                                khoản</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Ngân
                                        hàng</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        <div class="">{{partner.accBank == null ? '-' : partner.accBank}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;ine-height: 30px">Chi
                                        nhánh</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        <div class="">{{partner.accBranch == null ? '-' : partner.accBranch}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 " style="text-align: left;line-height: 30px">Số
                                        tài khoản</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        <div class="">{{partner.accNumber == null ? '-' : partner.accNumber}}</div>
                                    </div>
                                </div>
                                <div class="row"
                                     style="width: 95%;margin:auto;margin-bottom:5px;background: #FAFAFA;border-radius: 8px;">
                                    <label class="col-sm-4 "
                                           style="text-align: left;line-height: 30px">Tên
                                        tài
                                        khoản</label>
                                    <div class="col-md-8" style="font-weight: bold;text-align: right;line-height: 30px">
                                        <div class="">{{partner.accName == null ? '-' : partner.accName}}</div>

                                    </div>
                                </div>
                            </div>
                        </section>

                    </div>
                    <div class="col-lg-7">
                        <div class="row">
                            <h4 style="font-weight: bold;color: #166AEB;padding: 15px 15px 5px 15px">Thông tin thanh
                                toán</h4>
                        </div>
                        <section class="panel panel-default" style="border-radius: 20px;">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="row"
                                         style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label class=" color-label left" style="font-weight: bold">Trạng thái thanh
                                                toán <span
                                                        style="color: red"> *</span></label></label>
                                        </div>
                                    </div>
                                    <div class="row"
                                         style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-12">
                                            <select style="margin-bottom: 15px;border-radius: 10px;"
                                                    id="newReq.status"
                                                    ng-model="newReq.status"
                                                    class="form-control"
                                                    disabled
                                                    ng-init="newReq.status = '1'"
                                                    data-parsley-required="true"
                                                    data-parsley-required-message="Trạng thái chưa được chọn">
                                                <option value="0">Từ chối</option>
                                                <option value="1">Chờ xử lý</option>
                                                <option value="3">Đang xử lý</option>
                                                <option value="2">Hoàn tất</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Số tiền thanh
                                                toán
                                                (VNĐ) <span
                                                        style="color: red"> *</span></label></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px"
                                                   type="text" name="newReq.amount" id="newReq.amount"
                                                   ng-model="newReq.amount" class="form-control currency"
                                                   data-type="currency"
                                                   onkeypress="if (this.value.length == 19 ) return false;return event.charCode &gt;= 48 &amp;&amp; event.charCode &lt;= 57"
                                                   placeholder="Số tiền thanh toán"
                                            />
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class="col-md-5">
                                            <label style="font-weight: bold" class=" color-label left">Người yêu cầu
                                                <span
                                                        style="color: red"> *</span></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:auto;border-radius: 8px;">
                                        <div class=" col-md-12">
                                            <input style="margin-bottom: 15px;border-radius: 10px" id="newReq.paymentBy"
                                                   ng-value="newReq.paymentBy"
                                                   ng-model="newReq.paymentBy" maxlength="100" class="form-control"
                                                   placeholder="Người thanh toán"
                                                   ng-init="newReq.paymentBy = 'admin'"
                                                   readonly/>
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
                                                   name="newReq.description" id="newReq.description"
                                                   ng-model="newReq.description" maxlength="128"
                                                   placeholder="Ghi chú"
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
                                            <a style="margin-bottom: 15px;cursor: pointer;" id="messageFiles1"
                                               ng-click="download(1)"></a>
                                            <input style="float: left; display: none;" ng-hide="isDisabled" type="file"
                                                   ng-model="flagFile" id="file"
                                                   file-model="file" custom-on-change="fileValidate"
                                                   ng-disabled="isDisabled"
                                                   name="file"
                                                   onchange="angular.element(this).scope().fileValidate()">
                                            <button style="float: left;" id="fileSelection">Chọn tập tin...</button>
                                            <a style="float: left;margin-left: 5px;margin-top: 3px;" id="link" download><label
                                                    id="lab"></label></a>
                                            <label style="float:left;margin-left: 5px;margin-top: 3px;" id="lab2">Chưa
                                                chọn tập tin.</label>
                                            <button style="float: left; margin-left: 5px;margin-top: 3px;color: #c72f2f;background-color: white;border: medium none;"
                                                    id="rmv1" type="button">x
                                            </button>
                                            <a style="cursor: pointer;" class="col-md-2" id="messageFile1"
                                               ng-click="download(2)"></a>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 2%; text-align: center">
                                        <a href="<%=request.getContextPath()%>/reqPayment/index.html"
                                           style="width:136px; border: 1px solid #222222; border-radius: 6px"
                                           class="btn btn-light">Quay lại</a>
                                        <a ng-click="addReqPayment(newReq)"
                                           id="addReqPayment"
                                           style="border-radius: 6px;width: 136px"
                                           class="btn btn-secondary">Lưu</a>
                                    </div>
                                    <%--                                    <div class="row" style="margin-top: 2%; text-align: center"--%>
                                    <%--                                         ng-show="info.status == 2">--%>
                                    <%--                                        <a href="<%=request.getContextPath()%>/reqPayment/index.html"--%>
                                    <%--                                           style="border: 1px solid #2563EB; border-radius: 6px"--%>
                                    <%--                                           class="btn btn-export">Quay lại</a>--%>
                                    <%--                                    </div>--%>
                                </div>
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
    document.getElementById('rmv1').onclick = function () {
        var file = document.getElementById("file");
        file.value = file.defaultValue;
        $("#lab").text('');
    }

    function yourFunction() {
        if (document.getElementById("file").files.length == 0) {
            $('#rmv1').hide();
            $("#lab2").show();
        } else {
            $('#rmv1').show();
            $('#lab2').hide();
        }

        setTimeout(yourFunction, 10);
    }

    yourFunction();

    const input = document.getElementById('file');
    const link = document.getElementById('link');
    let objectURL;

    input.addEventListener('change', function () {
        if (objectURL) {
            URL.revokeObjectURL(objectURL);
        }

        const file = this.files[0];
        objectURL = URL.createObjectURL(file);

        link.download = file.name;
        link.href = objectURL;
        $("#lab").text(file.name);
        $("#lab2").hide();
    });
    $('#fileSelection').click(function () {
        $('#file').click();

    });
</script>