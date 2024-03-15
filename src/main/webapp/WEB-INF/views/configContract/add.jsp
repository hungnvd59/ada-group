<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css">
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/configContract/add.js"></script>
<style>

    .control-active {
        background: linear-gradient(0deg, #FFFFFF, #FFFFFF), #C2C9D1;
        border-radius: 10px;
        min-width: 56px;
        height: 35px;
        /* left: calc(50% - 56px/2); */
        /* top: calc(50% - 35px/2); */
        box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
        margin-right: 15px;
        margin-bottom: 5px;
        border: none;
        padding: 0 10px;
        position: relative;
    }

    .control-active.active-current {
        border: 1.5px solid #007AFE;
        /* position: relative; */
    }

    .control-active.active-current::before {
        position: absolute;
        transform: translate(-50%, -50%);
        right: -10px;
        top: 0;
        border-radius: 50%;
        background: white;
        color: #007AFE;
        font-family: "Font Awesome 5 Free";
        content: '\f058';
    }

    .list-control-active {
        width: 100%;
        overflow-x: scroll;
        white-space: nowrap;
        padding: 10px 0;
    }

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

    .configHeader {
        padding: 15px;
        color: #166AEB;
        font-size: 18px;
    }

    .configContent {
        padding-left: 40px;
        color: #166AEB;
        font-size: 15px;
    }

    .headerTable {
        padding: 10px;
    }

    .viettel {
        border-left: 1px solid #F4F4F5;
        border-right: 1px solid #F4F4F5;
    }

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

    .error-border {
        border: 1px red solid;
    }
</style>

<title><spring:message code="label.list.user"/></title>
<section style="color: #3f3f46;" id="partnerSC" ng-app="FrameworkBase" ng-controller="partnerCtrl">
    <section class="vbox">
        <section class="scrollable padder">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                <li><a href="<%=request.getContextPath()%>/config-contract/index.html">Quản lý cấu hình hoa hồng</a></li>
            </ul>
            <div>
                <a href="<%=request.getContextPath()%>/config-contract/index.html"><h3 style="font-weight: bold"><span class="fa fa-angle-left"></span> THÊM MỚI CẤU HÌNH HOA HỒNG</h3></a>
            </div>
            </div>
            <form id="formadd" class="form-horizontal" role="form" theme="simple">
                <section class="panel panel-default" style="border-radius: 20px;">
                    <div class="panel-body">
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Tên cấu hình <font
                                                color="red">*</font> </label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="name" style="border-radius: 10px"
                                               id="name"
                                               maxlength="128"
                                               placeholder="Nhập tên cấu hình"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-5">
                                        <label class="control-label color-label left">Mô tả
                                        </label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input ng-model="description" style="border-radius: 10px"
                                               id="description"
                                               maxlength="500"
                                               placeholder="Nhập mô tả"
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
                                        <label class="control-label color-label left">Trạng thái <font
                                                color="red">*</font> </label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="status" name="status" class="form-control"
                                                style="width: 100% ;border-radius: 10px" ng-model="status">
                                            <option ng-value="1" selected>Áp dụng</option>
                                            <option ng-value="0">Không áp dụng</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>

                    </div>

                </section>
                <section class="panel panel-default" style="border-radius: 25px;">
                    <div class="accordion" id="config-contract">
                        <div class="card">
                            <div class="card-header" id="config-contract-header">
                                <a class="btn btn-link configHeader" type="button" data-toggle="collapse"
                                   id="configContractDropdown"
                                   data-target="#content" aria-expanded="true" aria-controls="content">
                                    <label id="configContractDropdown1" style="font-weight: bold"> <i
                                            class="fa fa-chevron-down"></i> CẤU
                                        HÌNH HOA HỒNG</label>
                                    <label id="configContractDropdown2" style="font-weight: bold; display: none;"> <i
                                            class="fa fa-chevron-right"></i> CẤU HÌNH HOA HỒNG</label>
                                </a>
                            </div>
                            <div id="content" class="collapse" aria-labelledby="config-contract-header"
                                 data-parent="#config-contract">
                                <div class="card-body">
                                    <div class="accordion" id="accordionExample">
                                        <div class="card">
                                            <div class="card-header" id="headingOne">
                                                <a class="btn btn-link collapsed configContent" type="button"
                                                   data-toggle="collapse" id="SS"
                                                   data-target="#collapseOne" aria-expanded="false"
                                                   aria-controls="collapseOne">
                                                    <label id="ss1"><i class="fa fa-chevron-down"></i> Dịch vụ Sim
                                                        số</label>
                                                    <label id="ss2" style="display: none;"><i
                                                            class="fa fa-chevron-right"></i> Dịch vụ Sim số</label>
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
                                                            <%--                                                            <div class="col-sm-2 headerTable">--%>
                                                            <%--                                                                <b>Hoa hồng PTTB trả trước tri trả CTV cấp trên</b>--%>
                                                            <%--                                                            </div>--%>
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
                                                                           id="m_bl_pre_bonus"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Pre()"
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
                                                                           name="percentage"
                                                                           id="m_bl_pre_osp"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Pre('m_bl_pre_osp')"
                                                                           style="margin-bottom: 5px"
                                                                           type="text"/>
                                                                    <label style="float:left;padding-top: 5px"><font
                                                                            color="#0065FF">{{m_bl_pre_osp_value | currency:"":0}}
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
                                                                           name="percentage"
                                                                           id="m_bl_pre_ctv"
                                                                           maxlength="18"
                                                                           style="margin-bottom: 5px"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Pre('m_bl_pre_ctv')"
                                                                           type="text"/>
                                                                    <label style="float:left;"><font color="#0065FF">{{m_bl_pre_ctv_value | currency:"":0}}
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
                                                            <%--                                                            <div class="col-sm-2 headerTable">--%>
                                                            <%--                                                                <b>Hoa hồng PTTB trả sau tri trả CTV cấp trên</b>--%>
                                                            <%--                                                            </div>--%>
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
                                                                           id="m_bl_post_bonus"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           style="margin-bottom: 5px"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Post()"
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
                                                                           name="percentage"
                                                                           id="m_bl_post_osp"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Post('m_bl_post_osp')"
                                                                           style="margin-bottom: 5px"
                                                                           class="form-control"
                                                                           type="text"/>
                                                                    <label style="float:left;"><font color="#0065FF">{{m_bl_post_osp_value | currency:"":0}}
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
                                                                           name="percentage"
                                                                           id="m_bl_post_ctv"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="getValueM_Post('m_bl_post_ctv')"
                                                                           class="form-control"
                                                                           type="text"/>
                                                                    <label style="float:left;"><font color="#0065FF">{{m_bl_post_ctv_value | currency:"":0}}
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
                                                   data-toggle="collapse" id="GC"
                                                   data-target="#collapseTwo" aria-expanded="false"
                                                   aria-controls="collapseTwo">
                                                    <label id="gc1"><i class="fa fa-chevron-down"></i> Dịch vụ Gói
                                                        cước</label>
                                                    <label style="display: none;" id="gc2"><i
                                                            class="fa fa-chevron-right"></i> Dịch vụ Gói cước</label>
                                                </a>
                                            </div>
                                            <div id="collapseTwo" class=" collapse" aria-labelledby="headingTwo"
                                                 data-parent="#accordionExample">
                                                <div class="card-body">
                                                    <div class="row" style="margin: 15px">
                                                        <div class="row" style="margin-left: 15px">
                                                            <label><b>Hoa hồng đăng ký gói cước</b></label>
                                                        </div>
                                                        <div class="row text-center"
                                                             style="background-color: #E4E4E7;margin-left: 15px; margin-right: 15px;border-radius: 10px 10px 0px 0px">
                                                            <div class="col-sm-3 headerTable">
                                                                <b>Telco</b>
                                                            </div>
                                                            <div class="col-sm-4 headerTable" style="width: 38%">
                                                                <b>Hoa hồng đăng ký gói cước OSP nhận/hoa hồng telco chi
                                                                    trả</b>
                                                            </div>
                                                            <div class="col-sm-4 headerTable" style="width: 37%">
                                                                <b>Hoa hồng đăng ký gói cước chi trả CTV/hoa hồng telco
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
                                                                           maxlength="18"
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
                                                                           ng-trim="true"
                                                                           maxlength="18"
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
                                                        <%-- end Mobi--%>
                                                        <%--                                                    VinaPhone--%>
                                                        <div class="row text-center"
                                                             style="margin-left: 15px; margin-right: 15px;background-color: #FAFAFA;border-bottom: 1px solid #F4F4F5;">
                                                            <div class="col-sm-3 headerTable">
                                                                <div class="col-sm-12 input-line">
                                                                    <b>VinaPhone</b>
                                                                </div>

                                                            </div>
                                                            <div class="col-sm-3 headerTable" style="width: 38%">
                                                                <div class="col-sm-8 input-line">
                                                                    <input ng-model="vnp_package_osp"
                                                                           name="percentage"
                                                                           id="vnp_package_osp"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="return100('vnp_package_osp')"
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
                                                                    <input ng-model="vnp_package_ctv"
                                                                           name="percentage"
                                                                           id="vnp_package_ctv"
                                                                           ng-trim="true"
                                                                           maxlength="18"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           ng-change="return100('vnp_package_ctv')"
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
                                                        <%-- end VinaPhone--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--           <div class="card">
                                                       <div class="card-header" id="headingThree">
                                                           <button class="btn btn-link collapsed configContent" type="button"
                                                                   data-toggle="collapse"
                                                                   data-target="#collapseThree" aria-expanded="false"
                                                                   aria-controls="collapseThree">
                                                               <i class="fa fa-angle-down"></i> Dịch vụ Vietlott
                                                           </button>
                                                       </div>
                                                       <div id="collapseThree" class="collapse" aria-labelledby="headingThree"
                                                            data-parent="#accordionExample">
                                                           <div class="card-body">
                                                               To be continue
                                                           </div>
                                                       </div>
                                                   </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="panel panel-default" style="border-radius: 25px;">
                    <div class="accordion" id="to-config-contract">
                        <div class="card">
                            <div class="card-header" id="to-config-contract-header">
                                <a class="btn btn-link configHeader" type="button" data-toggle="collapse"
                                   id="listApplyConfig"
                                   data-target="#to-content" aria-expanded="true" aria-controls="content">
                                    <label style="font-weight: bold" id="ds1"><i class="fa fa-chevron-down"></i> DANH
                                        SÁCH TÀI KHOẢN ÁP DỤNG CẤU HÌNH HOA HỒNG</label>
                                    <label style="font-weight: bold; display: none;" id="ds2"><i
                                            class="fa fa-chevron-right"></i> DANH SÁCH TÀI KHOẢN ÁP DỤNG CẤU HÌNH HOA
                                        HỒNG</label>
                                </a>
                            </div>
                            <div id="to-content" class=" collapse" aria-labelledby="content"
                                 data-parent="#to-config-contract">
                                <div class="card-body">
                                    <div class="row" style="margin: 15px">
                                        <div class="col-sm-4">
                                            <input ng-model="mobilePartner" style="border-radius: 10px"
                                                   placeholder="Tìm kiếm theo số điện thoại CTV"
                                                   class="form-control"/>
                                        </div>
                                        <div class="col-md-3">
                                            <input id="fromDate" name="fromDate" style="border-radius: 10px"
                                                   type="text"
                                                   class="form-control" data-date-format="DD/MM/YYYY"
                                                   placeholder="Thời gian đăng ký từ ngày"
                                                   ng-model="fromDate"/>
                                        </div>
                                        <div class="col-md-3">
                                            <input id="toDate" name="toDate" style="border-radius: 10px"
                                                   type="text"
                                                   class="form-control " data-date-format="DD/MM/YYYY"
                                                   placeholder="Thời gian đăng ký đến ngày"
                                                   ng-model="toDate"/>
                                        </div>
                                        <div class="col-md-2 ">
                                            <a ng-click="getPartnerConfig(1)" style="border-radius: 6px"
                                               class="btn btn-secondary">Tìm kiếm</a>
                                        </div>
                                    </div>
                                    <br>
                                    <form id="filterDiv">
                                        <div class="row" style="margin: 15px">
                                            <div id="list-active" class="list-control-active">
                                                <div id="myBtnContainer" class="button-control"
                                                     style="margin-left: 10px;">
                                                    <button class="btnFilter control-active active-current"
                                                            data-value="all"
                                                            style="font-weight: bold"
                                                            ng-click="selectFilterMobile($event, 'all')">
                                                        Tất cả
                                                        <font color="red">({{totalPartner}})</font>
                                                    </button>

                                                    <button class="btnFilter {{name.name}} control-active"
                                                            ng-repeat="(i,name) in listName track by $index"
                                                            data-value="{{name.name}}"
                                                            style="font-weight: bold"
                                                            ng-click="selectFilterMobile($event, name.name)">
                                                        {{name.name}}
                                                        <font color="red">({{name.count}})</font>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <br>
                                    <div class="row" style="margin:30px;margin-top: 10px">
                                        <table id="tbl" class="table table-striped table-bordered m-b-none b-light">
                                            <thead>
                                            <tr>
                                                <th class="box-shadow-inner small_col text-center" width="10%"><input
                                                        id="checkboxLarge"
                                                        type="checkbox"
                                                        value=""
                                                        ng-click="getListItems()"
                                                        ng-model="checkAll"
                                                        class="selected_item"
                                                        alt="chk">
                                                </th>
                                                <th class="box-shadow-inner small_col text-center" width="20%">Tài
                                                    khoản
                                                </th>
                                                <th class="box-shadow-inner small_col text-center" width="40%">Cấu hình
                                                    hoa hồng hiện tại
                                                </th>
                                                <th class="box-shadow-inner small_col text-center" width="30%">Thời gian
                                                    đăng ký
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="item in listData.items track by $index">
                                                <td class="text-center" style="text-align: center"><input
                                                        type="checkbox"
                                                        id="checkBox"
                                                        ng-model="item.checked"
                                                        ng-change="addCheckItem(item)"
                                                        class="selected_item"
                                                        alt="chk">
                                                </td>
                                                <td class="text-center">{{item.mobile}}</td>
                                                <td class="text-center">{{item.name}}</td>
                                                <td class="text-center">{{item.genDate | date:'dd/MM/yyyy HH:mm:ss'}}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="12" ng-if="listData.rowCount == 0" class="text-center">
                                                    Không có tài khoản nào được áp dụng cấu hình này
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <footer class="panel-footer">
                                        <div class="row">
                                            <div class="col-sm-12 text-right text-center-xs">
                                                <div class="col-sm-6 text-left">
                                                    <span>Tổng số <code>{{listData.rowCount | currency:"":0}}</code> dữ liệu</span>
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
                                                                                               ng-click="loadPage(1)">«</a>
                                                        </li>
                                                        <li ng-repeat="item in listData.pageList">
                                                            <a href="javascript:void(0)"
                                                               ng-if="item == listData.pageNumber"
                                                               style="color:mediumvioletred;"> {{item}}</a>
                                                            <a href="javascript:void(0)"
                                                               ng-if="item != listData.pageNumber"
                                                               ng-click="loadPage(item)"> {{item}}</a>
                                                        </li>
                                                        <li ng-if="listData.pageNumber < listData.pageCount"><a
                                                                href="javascript:void(0)"
                                                                ng-click="loadPage(listData.pageCount)">»</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </footer>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <br>
                <br>
                <br>
                <br>
                <br>
            </form>
        </section>
        <footer class="panel-footer">
            <div class="row" style="padding-top: 30px">
                <div class="col-lg-12 text-center">
                    <a style="border: 1px solid #222222; border-radius: 6px;width: 136px"
                       href="<%=request.getContextPath()%>/config-contract/index.html"
                       class="btn btn-light">Hủy</a>
                    <a ng-click="add()" style="border-radius: 6px ;width: 136px" class="btn btn-secondary">Lưu</a>
                </div>
            </div>
        </footer>
    </section>
</section>


