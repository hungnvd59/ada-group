<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/partner/detail.js"></script>
<style>
    .left {
        text-align: left !important;
        font-weight: bold;
    }


    .btn-secondary {
        background-color: #222222;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #aaa;
        color: white;
    }

    .btn-link:hover {

    }

    .configContent {
        padding-left: 40px;
        color: #166AEB;
        font-size: 15px;
    }

    .headerTable {
        padding: 10px;
    }

    /*.viettel {*/
    /*    border-left: 1px solid #F4F4F5;*/
    /*    border-right: 1px solid #F4F4F5;*/
    /*}*/

    .input-line {
        padding: 0px;
        margin-top: 10px;
    }

    form label {
        text-align: left !important;
    }

    .table > thead > tr > th {
        vertical-align: top;
    }

    .headTable {
        color: #0065FF;
        background-color: #F4F4F5;
    }

</style>
<title><spring:message code="label.list.user"/></title>
<section style="color: #1F2937;" id="partnerSC" ng-app="FrameworkBase" ng-controller="partnerCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Dashboard</a></li>
                <li><a href="<%=request.getContextPath()%>/partner/index.html">Quản lý cộng tác viên</a></li>
            </ul>
            <div>
                <a href="<%=request.getContextPath()%>/partner/index.html"><h3 style="font-weight: bold"><span
                        class="fa fa-angle-left"></span> THÔNG TIN CỘNG TÁC VIÊN</h3></a>
            </div>
            <ul class="nav nav-tabs">
                <li class="active text-center li-tap" style="">
                    <a class="btn btn-s-lg"
                       style="padding: 14px; border: 1px solid #ddd;border-radius: 15px 15px 0px 0px;" data-toggle="tab"
                       href="#ctv" id="ctvTab">
                        <b>Thông tin tài khoản CTV</b>
                    </a>
                </li>
                <li class="text_center li-tap" style="border-radius: 25px 25px 0px 0px;">
                    <a class="btn btn-s-lg "
                       style="padding: 14px; border: 1px solid #ddd;border-radius: 15px 15px 0px 0px;" data-toggle="tab"
                       href="#configContract" id="configContract1">
                        <b>Cấu hình hoa hồng</b>
                    </a>
                </li>
                <li class="text_center li-tap" style="border-radius: 25px 25px 0px 0px;">
                    <a class="btn btn-s-lg"
                       style="padding: 14px; border: 1px solid #ddd;border-radius: 15px 15px 0px 0px;" data-toggle="tab"
                       href="#balanceHis" id="balanceHis1">
                        <b>Lịch sử biến động số dư</b>
                    </a>
                </li>
            </ul>

            <!--Tab cộng tác viên-->
            <div class="tab-content">
                <div id="ctv" class="table-responsive tab-pane fade in active">
                    <section class="panel panel-default" style="border-radius: 0px 0px 25px 25px;">
                        <div class="panel-body">
                            <div class="row" style="padding: 15px">
                                <h3 class="panel-title" style="color: #0065FF">Tài khoản CTV</h3>
                            </div>
                            <div class="row">
                                <div class="col-6 col-md-2">
                                    <div class="row center" id="image_change" ng-show="partnerDetail.linkAvt != null">
                                        <img class="img col-sm-12" style="border-radius: 50%"
                                             src="https://ctv.osp.vn/cdn/{{partnerDetail.linkAvt}}"
                                             width="247px"
                                             height="247px"
                                             alt="">
                                    </div>
                                    <div class="row center" id="image_default" ng-show="partnerDetail.linkAvt == null">
                                        <img class="img col-sm-12" style="border-radius: 50%"
                                             src="<%=request.getContextPath()%>/assets/images/avt.jpg"
                                             alt="">
                                    </div>
                                </div>
                                <div class="col-12 col-md-10">
                                    <form method="post" action="javascript:void(0)" enctype="multipart/form-data"
                                          class="form-horizontal" id="detailForm" name="detailForm">
                                        <div class="row" style="margin-top: 0px;">
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Cộng tác
                                                            viên</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input readonly type="text" style="border-radius: 10px"
                                                               value="{{partnerDetail.mobile}}"
                                                               class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Thời gian đăng
                                                            ký</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input readonly type="text" style="border-radius: 10px"
                                                               ng-model="genDate"
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
                                                        <label class="control-label color-label left">Trạng thái</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <select ng-model="status"
                                                                id="status" name="status"
                                                                style="width: 100% ;border-radius: 10px"
                                                                class="form-control">
                                                            <option ng-value="0">Dừng hoạt động</option>
                                                            <option ng-value="1">Đang hoạt động</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Site bán
                                                            hàng</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input readonly type="text" style="border-radius: 10px"
                                                               value="{{partnerDetail.linkSell}}"
                                                               class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="row" style="padding: 15px">
                                <h3 class="panel-title" style="color: #0065FF">Tài khoản ngân hàng</h3>
                            </div>
                            <div class="row" ng-show="partnerDetail.accNumber != null">
                                <div class="col-6 col-md-4"
                                     style="border-radius: 16px;background-color: #FAFAFA; margin-left: 15px">
                                    <div class="row" style="padding: 5px 5px 5px 15px">
                                        <label class="font-bold">{{partnerDetail.accNumber}} </label>
                                        <label style="border-radius: 5px;background-color: #DBEAFE;color: #3B82F6;font-size: 11px;text-align: center;width: 10%"><span>Mặc định</span></label>
                                    </div>

                                    <div class="row" style="padding: 5px 5px 1px 15px">
                                        <label>Ngân hàng {{partnerDetail.accBank}}</label>
                                    </div>
                                    <div class="row" style="padding: 5px 5px 1px 15px;width: 60%">
                                        <label>Chi nhánh {{partnerDetail.accBranch}}</label>
                                    </div>
                                    <div class="row" style="padding: 5px 5px 1px 15px">
                                        <label>{{partnerDetail.accName}}</label>
                                    </div>
                                </div>

                            </div>
                            <div class="row" ng-show="partnerDetail.accNumber == null">
                                <div class="col-6 col-md-4"
                                     style="border-radius: 16px;background-color: #FAFAFA; margin-left: 15px">
                                    <div class="row" style="padding: 5px 5px 5px 15px">
                                        Chưa xác thực tài khoản ngân hàng
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="padding: 15px">
                                <h3 class="panel-title" style="color: #0065FF">Thông tin cá nhân</h3>
                            </div>
                            <div class="row">
                                <div class="col-12 col-md-12">
                                    <form method="post" action="javascript:void(0)" enctype="multipart/form-data"
                                          class="form-horizontal" id="formDetail" name="formDetail">
                                        <div class="row" style="margin-top: 0px;">
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Họ và tên <span
                                                                style="color: red"> *</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input ng-model="partnerName"
                                                               placeholder="Nhập họ và tên"
                                                               type="text" style="border-radius: 10px"
                                                               maxlength="128"
                                                               class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-6" style="padding-right: 5px">
                                                        <label class="control-label color-label left">Giấy tờ tùy
                                                            thân<span style="color: red"> *</span></label>
                                                    </div>
                                                    <div class="col-md-6" style="padding-left: 5px">
                                                        <label class="control-label color-label left">Số giấy tờ tùy
                                                            thân<span style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6" style="padding-right: 5px">
                                                        <select id="identityType" name="identityType"
                                                                style="width: 100% ;border-radius: 10px"
                                                                class="form-control"
                                                                ng-model="identityType">
                                                            <option ng-value="0">Chứng minh thư nhân dân</option>
                                                            <option ng-value="1">Căn cước công dân</option>
                                                            <option ng-value="2">Hộ chiếu</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6" style="padding-left: 5px">
                                                        <input ng-model="idNumber"
                                                               placeholder="Nhập số giấy tờ tùy thân"
                                                               type="text"
                                                               maxlength="12"
                                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                               style="border-radius: 10px"
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
                                                        <label class="control-label color-label left">Ngày cấp <span
                                                                style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input id="identityDate" name="identityDate"
                                                               placeholder="dd/mm/yyyy"
                                                               style="border-radius: 10px"
                                                               type="text"
                                                               class="form-control"
                                                               data-date-format="DD/MM/YYYY"
                                                               ng-model="identityDate"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Nơi cấp<span
                                                                style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input ng-model="identityPlace"
                                                               placeholder="Nhập nơi cấp"
                                                               maxlength="128"
                                                               type="text"
                                                               style="border-radius: 10px"
                                                               class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row" style="margin-top: 0px;">
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-6" style="padding-right: 5px">
                                                        <label class="control-label color-label left">Tỉnh thành<span
                                                                style="color: red"> *</span></label>
                                                    </div>
                                                    <div class="col-md-6" style="padding-left: 5px">
                                                        <label class="control-label color-label left">Quận huyện<span
                                                                style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6" style="padding-right: 5px">
                                                        <select id="provinceId" name="provinceId"
                                                                style="width: 100% ;border-radius: 10px"
                                                                class="form-control"
                                                                ng-model="provinceId"
                                                                ng-change="getDistrict(provinceId)">
                                                            <option ng-value="-1" selected="true">Tỉnh/ Thành phố
                                                            </option>
                                                            <option ng-repeat="city in palaceTT.data track by $index"
                                                                    ng-value="{{city.id}}">
                                                                {{city.name}}
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6" style="padding-left: 5px">
                                                        <select id="districtId" name="districtId"
                                                                style="width: 100% ;border-radius: 10px"
                                                                class="form-control"
                                                                ng-model="districtId">
                                                            <option ng-value="-1" selected="true">Quận/ Huyện
                                                            </option>
                                                            <option ng-repeat="district in palaceQH.data track by $index"
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
                                                        <label class="control-label color-label left">Địa chỉ<span
                                                                style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <input ng-model="address"
                                                               placeholder="Số nhà, tổ, thôn, xóm"
                                                               maxlength="128"
                                                               type="text"
                                                               style="border-radius: 10px"
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
                                                        <label class="control-label color-label left">Mặt trước giấy
                                                            tờ <span style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row" style="text-align: center !important;">
                                                    <div class="col-md-12">
                                                        <div class="col-sm-12 text-center"
                                                             style="width: 100%;border-style: dotted;border-radius: 16px;background-color: #FAFAFA;text-align: center !important;">
                                                            <div id="displayImageFrontId" class="preview-zone row"
                                                                 style="margin:auto;padding: 15px;"
                                                                 ng-show="partnerDetail.linkFrontIdNumber != null">
                                                                <div>
                                                                    <div class="col-sm-12"
                                                                         style="margin: auto;height: 280px">
                                                                        <div style="width: 400px;height: 280px;margin: auto">
                                                                            <img class="thumb-image"
                                                                                 src="https://ctv.osp.vn/cdn/{{partnerDetail.linkFrontIdNumber}}"
                                                                                 alt=""
                                                                                 ng-click="showPopupImage(partnerDetail.linkFrontIdNumber)"
                                                                                 style="width: 400px; height: 280px;">
                                                                            <button ng-click="removeImgOfPartner('frontIdNumber')"
                                                                                    type="button"
                                                                                    style="position: relative;top:  -100%;right: 2%"
                                                                                    class="close" aria-label="Close">
                                                                        <span style="font-size: 150%"
                                                                              aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="uploadFrontIdNumber" class="preview-zone row"
                                                                 style="margin:auto;">
                                                                <div id="imageFrontIdNumberDefault"
                                                                     class="preview-zone row"
                                                                     style="margin:auto;padding: 15px;">
                                                                    <div>
                                                                        <div class="col-sm-12"
                                                                             style="margin: auto;height: 280px">
                                                                            <div style="width: 400px;height: 280px;margin: auto; background-color: #dadada">
                                                                                <img class="thumb-image"
                                                                                     ng-click="uploadFrontImage()"
                                                                                     src="<%=request.getContextPath()%>/assets/images/add_image.jpg"
                                                                                     style="width: 160px;position: relative;top: 15%;left: 15%"
                                                                                     alt="">
                                                                                <span style="position: relative;top:  55%;left:-21%"
                                                                                      aria-hidden="true">Ảnh mặt trước giấy tờ</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <input style="display: none" type="file" id="img_upload"
                                                                       name="img_upload">
                                                                <canvas id='imageFront' style="display: none"></canvas>
                                                                <div id="imageFrontIdNumberUpload"
                                                                     class="preview-zone row"
                                                                     style="margin:auto;padding: 15px;display: none">
                                                                    <div id="image-holder" class="row center">
                                                                        <div class="col-sm-12"
                                                                             style="margin: auto;height: 280px">
                                                                            <div style="width: 400px;height: 280px;margin: auto">
                                                                                <img id="previewImg" src=""
                                                                                     class="thumb-image"
                                                                                     alt=""
                                                                                     ng-click="showPopupImage('frontIdNumber')"
                                                                                     style="width: 400px; height: 280px">
                                                                                <button ng-click="removeImg('frontIdNumber')"
                                                                                        type="button"
                                                                                        style="position: relative;top:  -100%;right: 2%"
                                                                                        class="close"
                                                                                        aria-label="Close">
                                                                            <span style="font-size: 150%"
                                                                                  aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label class="control-label color-label left">Mặt sau giấy
                                                            tờ <span style="color: red"> *</span></label>
                                                    </div>
                                                </div>
                                                <div class="row" style="text-align: center !important;">
                                                    <div class="col-md-12">
                                                        <div class="col-sm-12 text-center"
                                                             style="width: 100%;border-style: dotted;border-radius: 16px;background-color: #FAFAFA;text-align: center !important;">
                                                            <div id="displayImageBackId" class="preview-zone row"
                                                                 style="margin:auto;padding: 15px;display: block"
                                                                 ng-show="partnerDetail.linkBackIdNumber != null">
                                                                <div>
                                                                    <div class="col-sm-12"
                                                                         style="margin: auto;height: 280px">
                                                                        <div style="margin: auto;width: 400px;height: 280px">
                                                                            <img class="thumb-image"
                                                                                 src="https://ctv.osp.vn/cdn/{{partnerDetail.linkBackIdNumber}}"
                                                                                 alt=""
                                                                                 ng-click="showPopupImage(partnerDetail.linkBackIdNumber)"
                                                                                 style="width: 400px; height: 280px;">
                                                                            <button ng-click="removeImgOfPartner('backIdNumber')"
                                                                                    type="button"
                                                                                    style="position: relative;top:  -100%;right: 2%"
                                                                                    class="close" aria-label="Close">
                                                                                <span style="font-size: 150%"
                                                                                      aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="uploadBackIdNumber" class="preview-zone row"
                                                                 style="margin:auto;">
                                                                <div id="imageBackIdNumberDefault"
                                                                     class="preview-zone row"
                                                                     style="margin:auto;padding: 15px;display: block">
                                                                    <div>
                                                                        <div class="col-sm-12"
                                                                             style="margin: auto;height: 280px">
                                                                            <div style="width: 400px;height: 280px;margin: auto; background-color: #dadada">
                                                                                <img class="thumb-image"
                                                                                     ng-click="uploadBackImg()"
                                                                                     src="<%=request.getContextPath()%>/assets/images/add_image.jpg"
                                                                                     style="width: 160px;position: relative;top: 15%;left: 15%"
                                                                                     alt="">
                                                                                <span style="position: relative;top:  55%;left:-21%"
                                                                                      aria-hidden="true">Ảnh mặt sau giấy tờ</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <input style="display: none" type="file"
                                                                       id="img_upload_back"
                                                                       name="img_upload">
                                                                <canvas id='imageBack'
                                                                        style="display: none"></canvas>
                                                                <div id="imageBackIdNumberUpload"
                                                                     class="preview-zone row"
                                                                     style="margin:auto;padding: 15px;display: none">
                                                                    <div id="image-holder1" class="row center">
                                                                        <div class="col-sm-12"
                                                                             style="margin: auto;height: 280px">
                                                                            <div style="margin: auto;width: 400px;height: 280px;">
                                                                                <img id="previewImg1" src=""
                                                                                     class="thumb-image"
                                                                                     alt=""
                                                                                     ng-click="showPopupImage('backIdNumber')"
                                                                                     style="width: 400px; height: 280px">
                                                                                <button ng-click="removeImg('backIdNumber')"
                                                                                        type="button"
                                                                                        style="position: relative;top:  -100%;right: 2%"
                                                                                        class="close"
                                                                                        aria-label="Close">
                                                                            <span style="font-size: 150%"
                                                                                  aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <div class="row" style="padding-top: 30px">
                                            <div class="col-lg-12 text-center">
                                                <a href="<%=request.getContextPath()%>/partner/index.html"
                                                   style="border: 1px solid #222222; border-radius: 6px;width: 136px"
                                                   class="btn btn-light">Hủy</a>
                                                <a ng-click="update(partnerDetail.id)"
                                                   style=" border: 1px solid #222222;border-radius: 6px;width: 136px"
                                                   class="btn btn-secondary">Cập nhập</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <!--End tab cộng tác viên-->

                <!--Tab contrac config-->
                <div id="configContract" class="table-responsive tab-pane fade in">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <section class="panel panel-default" style="border-radius: 0px 0px 25px 25px;">
                            <div class="row" style="padding: 30px">
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-2" style="padding-right: 0px"><h2 class="panel-title"
                                                                                             style="color: #0065FF;padding-top: 10px;">
                                            <b>Cấu hình
                                                hoa hồng</b></h2></div>
                                        <div class="col-md-10" style="padding-left: 0px">
                                            <%--                                            <a style="color: #0065FF ;border: #0065FF 1px solid ;border-radius:--%>
                                            <%--                                   10px;background-color: #EFF6FF;text-align: center"--%>
                                            <%--                                               class="btn btn-light"></a>--%>
                                            <input readonly
                                                   style="color: #0065FF ;border: #0065FF 1px solid ;border-radius:
                                   10px;background-color: #EFF6FF;text-align: center;width: 40%"
                                                   class="form-control"
                                                   value="{{configDetail.name}}"
                                                   type="text"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-2" style="padding-left: 0px">
                                    <a href="<%=request.getContextPath()%>/config-contract/index.html"
                                       style="border: 1px solid #222222; border-radius: 6px"
                                       class="btn btn-light">Cập nhập cấu hình hoa hồng</a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" id="headingOne">
                                    <a class="btn btn-link collapsed configContent" type="button"
                                       data-toggle="collapse"
                                       id="ss"
                                       data-target="#collapseOne" aria-expanded="false"
                                       aria-controls="collapseOne">
                                        <label id="ss-open"><i class="fa fa-chevron-down"></i> Dịch vụ Sim số</label>
                                        <label style="display: none" id="ss-close"><i class="fa fa-chevron-right"></i>
                                            Dịch vụ Sim số</label>
                                    </a>
                                </div>
                                <div id="collapseOne" class="collapse" aria-labelledby="headingOne"
                                     data-parent="#accordionExample">
                                    <div class="card-body">
                                        <div class="row" style="margin: 15px">
                                            <div class="row" style="margin-left: 15px">
                                                <label><b>Hoa hồng phát triển thuê bảo trả trước</b></label>
                                            </div>
                                            <div class="row text-center"
                                                 style="background-color: #E4E4E7;margin-left: 15px; margin-right: 15px;border-radius: 10px 10px 0px 0px">
                                                <div class="col-sm-3 headerTable">
                                                    <b>Telco</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả trước</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả trước OSP hưởng</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả trước chi trả CTV</b>
                                                </div>
                                            </div>
                                            <%--                                                    Mobi--%>
                                            <div class="row text-center"
                                                 style="margin-left: 15px; margin-right: 15px;background-color: #FAFAFA;border-bottom: 1px solid #F4F4F5;">
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-12 input-line">
                                                        <b>MobiFone</b>
                                                    </div>

                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_pre_bonus"
                                                               class="form-control"
                                                               type="text"
                                                               readonly
                                                               ng-init="m_bl_pre_bonus = configDetail.m_bl_pre_bonus"
                                                        />
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="VNĐ" type="text"/>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_pre_osp" class="form-control"
                                                               ng-init="m_bl_pre_osp = configDetail.m_bl_pre_osp"
                                                               readonly
                                                               type="text"/>
                                                        <label style="float:left;"><font color="#0065FF">{{m_bl_pre_osp_value}}
                                                            VNĐ</font></label>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_pre_ctv" class="form-control"
                                                               ng-init="m_bl_pre_ctv = configDetail.m_bl_pre_ctv"
                                                               readonly
                                                               type="text"/>
                                                        <label style="float:left;"><font color="#0065FF">{{m_bl_pre_ctv_value}}
                                                            VNĐ</font></label>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row" style="margin: 15px">
                                            <div class="row" style="margin-left: 15px">
                                                <label><b>Hoa hồng phát triển thuê bảo trả sau</b></label>
                                            </div>
                                            <div class="row text-center"
                                                 style="background-color: #E4E4E7;margin-left: 15px; margin-right: 15px;border-radius: 10px 10px 0px 0px">
                                                <div class="col-sm-3 headerTable">
                                                    <b>Telco</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả sau</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả sau OSP hưởng</b>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <b>Hoa hồng PTTB trả sau chi trả CTV</b>
                                                </div>
                                            </div>
                                            <%--                                                    Mobi--%>
                                            <div class="row text-center"
                                                 style="margin-left: 15px; margin-right: 15px;background-color: #FAFAFA ;border-bottom: 1px solid #F4F4F5;">
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-12 input-line">
                                                        <b>MobiFone</b>
                                                    </div>

                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_post_bonus"
                                                               class="form-control"
                                                               ng-init="m_bl_post_bonus = configDetail.m_bl_post_bonus"
                                                               readonly
                                                               type="text"/>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="VNĐ" type="text"/>
                                                    </div>

                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_post_osp"
                                                               ng-init="m_bl_post_osp = configDetail.m_bl_post_osp"
                                                               readonly
                                                               class="form-control"
                                                               type="text"/>
                                                        <label style="float:left;"><font color="#0065FF">{{m_bl_post_osp_value}}
                                                            VNĐ</font></label>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_bl_post_ctv"
                                                               ng-init="m_bl_post_ctv = configDetail.m_bl_post_ctv"
                                                               readonly

                                                               class="form-control"
                                                               type="text"/>
                                                        <label style="float:left;"><font color="#0065FF">{{m_bl_post_ctv_value}}
                                                            VNĐ</font></label>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" id="headingTwo">
                                    <a class="btn btn-link collapsed configContent" type="button"
                                       data-toggle="collapse"
                                       id="gc"
                                       data-target="#collapseTwo" aria-expanded="false"
                                       aria-controls="collapseTwo">
                                        <label id="gc-open"><i class="fa fa-chevron-down"></i> Dịch vụ Gói cước</label>
                                        <label style="display: none" id="gc-close"><i class="fa fa-chevron-right"></i>
                                            Dịch vụ Gói
                                            cước</label>
                                    </a>
                                </div>
                                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
                                     data-parent="#accordionExample">
                                    <div class="card-body">
                                        <div class="row" style="margin: 15px">
                                            <div class="row" style="margin-left: 15px">
                                                <label><b>Hoa hồng đăng kí gói cước</b></label>
                                            </div>
                                            <div class="row text-center"
                                                 style="background-color: #E4E4E7;margin-left: 15px; margin-right: 15px;border-radius: 10px 10px 0px 0px">
                                                <div class="col-sm-3 headerTable">
                                                    <b>Telco</b>
                                                </div>
                                                <div class="col-sm-4 headerTable" style="width: 38%">
                                                    <b>Hoa hồng đăng kí gói cước OSP nhận/hoa hồng telco chi
                                                        trả</b>
                                                </div>
                                                <div class="col-sm-4 headerTable" style="width: 37%">
                                                    <b>Hoa hồng đăng kí gói cước chi trả CTV/hoa hồng telco
                                                        chi
                                                        trả</b>
                                                </div>
                                            </div>
                                            <%--                                                    Mobi--%>
                                            <div class="row text-center"
                                                 style="margin-left: 15px; margin-right: 15px;background-color: #FAFAFA;border-bottom: 1px solid #F4F4F5;">
                                                <div class="col-sm-3 headerTable">
                                                    <div class="col-sm-12 input-line">
                                                        <b>MobiFone</b>
                                                    </div>

                                                </div>
                                                <div class="col-sm-3 headerTable" style="width: 38%">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_package_osp"
                                                               name="percentage"
                                                               id="m_package_osp"
                                                               readonly
                                                               maxlength="22"
                                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                               ng-change="return100('m_package_osp')"
                                                               class="form-control"
                                                               type="text"/>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3 headerTable" style="width: 37%">
                                                    <div class="col-sm-8 input-line">
                                                        <input ng-model="m_package_ctv"
                                                               name="percentage"
                                                               id="m_package_ctv"
                                                               readonly
                                                               ng-trim="true"
                                                               maxlength="22"
                                                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                               ng-change="return100('m_package_ctv')"
                                                               class="form-control"
                                                               type="text"/>
                                                    </div>
                                                    <div class="col-sm-4 input-line">
                                                        <input class="form-control"
                                                               style="border-radius: 0px 10px 10px 0px; ;text-align: center"
                                                               readonly value="%" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </form>
                </div>

                <%--Tab history balance--%>
                <div id="balanceHis" class="table-responsive tab-pane fade in">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <section class="panel panel-default" style="border-radius: 0px 0px 25px 25px;">
                            <div class="panel-body">
                                <div class="row" style="padding: 30px">
                                    <div class="col-md-6">
                                        <div class="shadow p-3 mb-5 rounded"
                                             style="border: 1px solid #E4E4E7;border-radius: 12px;padding: 20px">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h4 style="font-weight: bold;">Số dư tài khoản</h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h1 style="color: #2563EB;font-weight: bold">
                                                        {{numbersWithDots(partnerDetail.accBalance)}}
                                                        VNĐ</h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="shadow p-3 mb-5 rounded"
                                             style="border: 1px solid #E4E4E7;border-radius: 12px;padding: 20px">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h4 style="font-weight: bold;">Số tiền đã rút</h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h1 style="color: #2563EB;font-weight: bold">
                                                        {{numbersWithDots(balanceWithdraw)}}
                                                        VNĐ</h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="padding-left: 30px; padding-right:30px">
                                    <div class="row">
                                        <div class="row" style="padding-left: 30px; padding-right:30px">
                                            <div class="col-md-12" padding-bottom: 10px;>
                                                <h3 style="color: #2563EB;margin-bottom: 30px;margin-top: 10px;">Lịch sử
                                                    biến động số dư</h3>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-left: 30px; padding-right:30px">
                                            <div class="col-lg-7">
                                                <div class="col-md-6">
                                                    <div class="row">
                                                        <div class="col-md-12" style="padding: 0px">
                                                            <span style="font-weight: bold">Số thuê bao</span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12" style="padding: 0px">
                                                            <input style="border-radius: 10px;" type="text"
                                                                   ng-model="itemName"
                                                                   class="form-control"
                                                                   placeholder="Tìm kiếm số thuê bao">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <span style="font-weight: bold">Loại hoa hồng</span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <select class="form-control" id="test" name="status"
                                                                    style="width: 100% ;border-radius: 10px"
                                                                    ng-model="transType">
                                                                <option ng-value="-1">-- Tất cả --
                                                                </option>
                                                                <option ng-value="1">Gói cước</option>
                                                                <option ng-value="2">Sim số</option>
                                                                <option ng-value="3">Rút tiền</option>
                                                                <option ng-value="4">Sự kiện</option>
                                                                <option ng-value="5">OSP điều chỉnh</option>
                                                                <option ng-value="6">Duy trì</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-5">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <span style="font-weight: bold">Thời gian</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-9">
                                                        <div class="col-md-6" style="padding: 0px">
                                                            <input id="fromDateHis" name="fromDateHis"
                                                                   placeholder="Từ ngày"
                                                                   style="border-radius: 10px"
                                                                   type="text"
                                                                   class="form-control"
                                                                   data-date-format="DD/MM/YYYY"
                                                                   ng-model="fromDateHis"/>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <input id="toDateHis" name="toDateHis"
                                                                   ng-model="toDateHis"
                                                                   style="border-radius: 10px"
                                                                   type="text" my-enter="search()" maxlength="10"
                                                                   class="form-control" data-date-format="DD/MM/YYYY"
                                                                   placeholder="Đến ngày"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3" style="padding-bottom: 20px">
                                                        <a ng-click="getHistory()"
                                                           style="border-radius: 10px;width: 100%"
                                                           class="btn btn-secondary">Tìm kiếm</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <table id="tbl" class="table table-hover"
                                               style="border-radius: 20px;padding-left: 30px; padding-right:30px">
                                            <thead>
                                            <tr class="headTable">
                                                <th style="border-top-left-radius: 20px;"
                                                    class="box-shadow-inner small_col text-center" width="15%">
                                                    Ngày
                                                </th>
                                                <th class="box-shadow-inner small_col text-left" width="15%">Loại giao
                                                    dịch
                                                </th>
                                                <th class="box-shadow-inner small_col text-left" width="25%">Mô tả</th>
                                                <th class="box-shadow-inner small_col text-right" width="15%">Số tiền
                                                    (VNĐ)
                                                </th>
                                                <th class="box-shadow-inner small_col text-center" width="15%">Số dư
                                                    (VNĐ)
                                                </th>
                                                <th style="border-top-right-radius: 20px;"
                                                    class="box-shadow-inner small_col text-center" width="15%">Trạng
                                                    thái
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody style="color: #1F2937">
                                            <tr ng-repeat="item in listData.items track by $index">
                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{item.genDate | date:'dd/MM/yyyy HH:mm:ss'}}
                                                </td>
                                                <td class="text-left" style="vertical-align: middle;">
                                                    {{item.transType == 1 || item.transType == 2 ? 'Hoa hồng kinh doanh' :
                                                        (item.transType == 3 ? 'Rút tiền' :
                                                                (item.transType == 4 ? 'Sự kiện' :
                                                                        (item.transType == 5 ? 'OSP điều chỉnh' :
                                                                                (item.transType == 6 ? 'Duy trì' : item.transType))))}}

                                                </td>
                                                <td ng-show="item.transType == 3" class="text-left"
                                                    style="vertical-align: middle;">
                                                    <div class="row"><span
                                                            style="font-weight: bold">{{item.itemName}}</span></div>
                                                    <div class="row">
                                                        <span>Tài khoản {{item.accBank}} - *******{{item.accNumber.substr(item.accNumber.length - 3);}}</span>
                                                    </div>
                                                </td>
                                                <td ng-show="item.transType == 4"
                                                    class="text-left">
                                                    <div class="row"><span
                                                            style="font-weight: bold">Giải thưởng sự kiện</span>
                                                    </div>
                                                    <div class="row">
                                                        <span>{{item.description}} </span>
                                                    </div>
                                                </td>
                                                <td ng-show="item.transType == 5"
                                                    class="text-left">
                                                    <div class="row"><span
                                                            style="font-weight: bold">Điều chỉnh bởi OSP</span>
                                                    </div>
                                                    <div class="row">
                                                        <span>{{item.description}} </span>
                                                    </div>
                                                </td>
                                                <td ng-show="item.transType == 6"
                                                    class="text-left">
                                                    <div class="row"><span
                                                            style="font-weight: bold">Duy trì</span>
                                                    </div>
                                                    <div class="row">
                                                        <span>{{item.description}} </span>
                                                    </div>
                                                </td>
                                                <td ng-show="item.transType == 1"
                                                    class="text-left">
                                                    <div class="row"><span
                                                            style="font-weight: bold">Hoa hồng kinh doanh</span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Gói cước | {{item.itemName}} | {{item.msisdnContact}} </span>
                                                    </div>
                                                </td>
                                                <td ng-show="item.transType == 2"
                                                    class="text-left">
                                                    <div class="row"><span
                                                            style="font-weight: bold">Hoa hồng kinh doanh</span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Sim số | {{item.shareType == 1 ? 'PTTB TS' :
                                                                (item.shareType == 0 ? 'PTTB TT' : item.shareType)}} | {{item.itemName}}</span>
                                                    </div>
                                                </td>
                                                <td class="text-right" style="vertical-align: middle;">
                                                    <span ng-show="item.transType == 3"
                                                          style="color: red"> -{{item.amount | currency:"":0}}</span>
                                                    <span ng-show="item.transType == 5"
                                                          style="color: red">{{item.amount | currency:"":0}}</span>
                                                    <span ng-show="item.transType != 3 && item.transType != 5"
                                                          style="color: green"> +{{item.amount | currency:"":0}}</span>
                                                </td>
                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{item.currentAmount | currency:"":0 }}
                                                </td>
                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{item.status == 0 ? 'Thất bại' :
                                                        (item.status == 1 ? 'Hoàn thành' : item.status)}}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="12" ng-if="listData.rowCount==0" class="text-center">Không
                                                    có
                                                    dữ liệu
                                                </td>
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
                                                    <select class="input-sm form-control input-s-sm inline"
                                                            style="width: 60px;"
                                                            ng-model="numberPerPage"
                                                            ng-change="setNumberPerPage(numberPerPage);"
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
                                                            <a href="javascript:void(0)"
                                                               ng-if="item == listData.pageNumber"
                                                               style="color:mediumvioletred;"> {{item}}</a>
                                                            <a href="javascript:void(0)"
                                                               ng-if="item != listData.pageNumber"
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
                                </div>
                            </div>
                        </section>
                    </form>
                </div>
            </div>
        </section>
    </section>
    <div class="modal fade" id="modalShowImg" role="dialog" aria-hidden="true" data-keyboard="false"
         data-backdrop="static" style="text-align: center">
        <div class="modal-dialog" style="width: 50%">
            <div class="modal-content">
                <div class="modal-header alert-info" style="background-color: #FFF;color: #000;border: none">
                    <button type="button" class="btn btn-default close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" style="text-align: center">Xem chi tiết</h4>
                </div>
                <div class="modal-body">
                    <canvas id='grabFrameCanvas' style="display: none"></canvas>
                    <div class="preview-zone row" style="width: 600px;margin: auto">
                        <div id="popup-image-holder" class="row center" style="margin: auto">
                            <img id="popup-previewImg" src="" class="thumb-image" alt=""
                                 style="width: 600px;height: 480px;">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border: none;text-align: center">
                    <button class="btn btn-add"
                            style="width:136px;color: #FFF;border: 1px solid #F43F5E;background-color: #F43F5E"
                            data-dismiss="modal">Quay lại
                    </button>
                </div>
            </div>
        </div>
    </div>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
