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
<div class="container-fluid">
    <section id="content" ng-app="ADAGROUP" ng-controller="customerUser">
        <div class="card">
            <div class="card-body">
                <div class="row" style="margin-bottom: 1rem">
                    <div class="col-md-6">
                        <h5 class="card-title fw-semibold mb-4">Thông tin tìm kiếm</h5>
                    </div>
                    <div class="col-md-6">
                        <%--                    <sec:authorize--%>
                        <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                        <a class="btn btn-warning m-1" ng-click="preAddCust()"
                           style="float:right;margin-right: .5rem;"><i
                                class="ti ti-circle-plus"></i>&nbsp;Thêm mới nhân viên</a>
                        <%--                    </sec:authorize>--%>
                    </div>
                </div>
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-left: 30px;margin-right: 30px;">
                            <div class="row" style="margin-top: 0px;">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">Họ và tên nhân
                                                viên</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="fullName" style="border-radius: 6px" my-enter="search()"
                                                   id="fullName"
                                                   placeholder="Họ và tên nhân viên" maxlength="100"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Số điện thoại nhân
                                                viên</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="mobile" style="border-radius: 6px" my-enter="search()"
                                                   id="mobile"
                                                   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                   maxlength="10"
                                                   placeholder="Số điện thoại nhân viên"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 1.5rem;">
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
                                                <option ng-repeat="city in provinceList track by $index"
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
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">Team</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select id="team" name="team" class="form-control"
                                                    style="width: 100% ;border-radius: 6px" ng-model="team">
                                                <option ng-value="-1">-- Tất cả --</option>
                                                <option ng-value="1">Kim cương 1</option>
                                                <option ng-value="2">Kim cương 2</option>
                                                <option ng-value="3">Kim cương 3</option>
                                                <option ng-value="4">Kim cương 4</option>
                                                <option ng-value="5">Kim cương 5</option>
                                                <option ng-value="6">Kim cương 6</option>
                                                <option ng-value="7">Kim cương 7</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>
                        </div>
                    </form>
                </div>
                <div class="row" style="margin-top: 3rem">
                    <div class="col-md-6">
                        <h5 style="font-weight: 700"></h5>
                    </div>
                    <div class="col-md-6">
                        <%--                    <sec:authorize--%>
                        <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                        <a class="btn btn-success m-1" ng-click="export()"
                           style="margin-right: 2rem; float: right"><i
                                class="ti ti-download"></i>&nbsp;Xuất excel</a>
                        <a class="btn btn-primary m-1" ng-click="import()"
                           style="float:right;margin-right: .5rem;">
                            <i class="ti ti-file-upload"></i>&nbsp;Tải lên danh sách nhân viên</a>
                    </div>
                </div>
                <div class="panel-body" style="margin-top: 2rem">
                    <div class="card w-100">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-4">Danh sách nhân viên</h5>
                            <div class="table-responsive">
                                <table class="table border text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4">
                                    <tr>
                                        <th>
                                            <h6 class="fw-semibold mb-0">STT</h6>
                                        </th>
                                        <%--<th>
                                            <h6 class="fw-semibold mb-0">Thao tác</h6>
                                        </th>--%>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Họ tên</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Chức danh</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Mã nhân viên</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Số điện thoại</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Team</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Trạng thái</h6>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr style="cursor: pointer" ng-repeat="item in listData.items track by $index"
                                        ng-click="showDetailCust(item)">
                                        <td class="border-bottom">
                                            <p class="mb-0 fw-normal">
                                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}</p>
                                        </td>
                                        <%--<td>
                                            <a ng-click="showDetailCust(item)"
                                               style="cursor: pointer"
                                               class="text-primary edit">
                                                <i class="ti ti-eye fs-5"></i>
                                            </a>
                                        </td>--%>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.fullName}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{getTypeCtv(item.type)}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.empCode}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.mobile}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">Kim cương {{item.team}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{getStatusCtv(item.status)}}</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="12" ng-if="listData.rowCount == 0" class="text-center">Không có dữ
                                            liệu
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="d-flex align-items-center justify-content-end py-1">
                                    <p class="mb-0 fs-2">Hiển thị:</p>
                                    <select class="form-select w-auto ms-0 ms-sm-2 me-8 me-sm-4 py-1 pe-7 ps-2 border-0"
                                            ng-init="numberPerPage = '5'"
                                            ng-model="numberPerPage" ng-change="setNumberPerPage(numberPerPage);">
                                        <option value="5">5</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                    </select>
                                    <p class="mb-0 fs-2">Tổng &nbsp;{{listData.rowCount | currency:"":0}}&nbsp; bản
                                        ghi</p>
                                    <nav aria-label="...">
                                        <ul class="pagination justify-content-center mb-0 ms-8 ms-sm-9">
                                            <%--TODO: page pagiation--%>
                                            <li class="page-item p-1">
                                                <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center"
                                                   href="#"><i class="ti ti-chevron-left"></i></a>
                                            </li>
                                            <li class="page-item p-1">
                                                <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center"
                                                   href="#"><i class="ti ti-chevron-right"></i></a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="mdAddCustomer" tabindex="-1" aria-labelledby="bs-example-modal-lg"
             aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header d-flex align-items-center">
                        <h4 class="modal-title">
                            Thêm mới nhân viên
                        </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="card" style="margin-bottom: 0">
                        <div class="card-body">
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-account" role="tabpanel"
                                     aria-labelledby="pills-account-tab" tabindex="0">
                                    <div class="row">
                                        <%--AVATA --%>
                                        <%--<div class="col-lg-12 d-flex align-items-stretch">
                                            <div class="card w-100 position-relative overflow-hidden">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Ảnh đại diện</h5>
                                                    <p class="card-subtitle mb-4">Thay đổi ảnh hồ sơ của bạn từ đây</p>
                                                    <div class="text-center">
                                                        <img src="<%=request.getContextPath()%>/assets/images/profile/user-1.jpg"
                                                             alt="" class="img-fluid rounded-circle" width="120"
                                                             height="120">
                                                        <div class="d-flex align-items-center justify-content-center my-4 gap-6">
                                                            <button class="btn btn-primary" fdprocessedid="nnyu7yr">Upload
                                                            </button>
                                                            <button class="btn bg-danger-subtle text-danger"
                                                                    fdprocessedid="jljpj5">Reset
                                                            </button>
                                                        </div>
                                                        <p class="mb-0">Cho phép file dạng JPG, GIF hoặc PNG và không lớn
                                                            hơn 5MB </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="col-12">
                                            <div class="card w-100 position-relative overflow-hidden mb-0">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Thông tin cá nhân</h5>
                                                    <form style="margin-top: 1rem" novalidate>
                                                        <div class="row">
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tên nhân viên &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <input type="text" class="form-control"
                                                                           id="add-fullName"
                                                                           required
                                                                           data-validation-required-message="Vui lòng nhập Tên nhân viên!"
                                                                           placeholder="Họ và tên nhân viên"
                                                                           ng-model="add.fullName">
                                                                    <div class="help-block"></div>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Chức danh &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <select id="add-type" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="add.type">
                                                                        <option ng-value="-1">-- Lựa chọn --</option>
                                                                        <option ng-value="3">Đại lý</option>
                                                                    </select>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Email &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <input type="text" class="form-control"
                                                                           placeholder="Email"
                                                                           id="add-email"
                                                                           ng-model="add.email">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tỉnh/ Thành phố
                                                                        &nbsp;<span class="text-danger">*</span></label>
                                                                    <select id="add-provinceId"
                                                                            name="add-provinceId"
                                                                            class="form-control"
                                                                            ng-change="changeCityAdd(add.provinceId)"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="add.provinceId">
                                                                        <option ng-value="-1">-- Lựa chọn --</option>
                                                                        <option ng-repeat="city in provinceListAdd track by $index"
                                                                                ng-value="{{city.id}}">
                                                                            {{city.name}}
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Quận/
                                                                        Huyện &nbsp;<span
                                                                                class="text-danger">*</span></label>
                                                                    <select id="add-districtId" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="add.districtId">
                                                                        <option ng-value="-1">-- Lựa chọn --</option>
                                                                        <option ng-repeat="d in districtListAdd track by $index"
                                                                                ng-value="{{d.id}}">
                                                                            {{d.name}}
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Số điện thoại &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <input maxlength="10"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           type="text" class="form-control"
                                                                           id="add-mobile"
                                                                           ng-model="add.mobile"
                                                                           placeholder="Số điện thoại">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Ngày sinh</label>
                                                                    <input type="text" class="form-control"
                                                                           id="add-birthday"
                                                                           placeholder="Ngày sinh"
                                                                           ng-model="add.birthday">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Mã nhân viên &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <input type="text" class="form-control"
                                                                           id="add-empCode"
                                                                           placeholder="Mã nhân viên"
                                                                           ng-model="add.empCode">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Team &nbsp;<span
                                                                            class="text-danger">*</span></label>
                                                                    <select id="add-team" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="add.team">
                                                                        <option ng-value="-1">-- Lựa chọn --</option>
                                                                        <option ng-value="1">Kim cương 1</option>
                                                                        <option ng-value="2">Kim cương 2</option>
                                                                        <option ng-value="3">Kim cương 3</option>
                                                                        <option ng-value="4">Kim cương 4</option>
                                                                        <option ng-value="5">Kim cương 5</option>
                                                                        <option ng-value="6">Kim cương 6</option>
                                                                        <option ng-value="7">Kim cương 7</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div>
                                                                <label class="form-label">Địa chỉ chi tiết</label>
                                                                <input type="text" class="form-control"
                                                                       id="add-address"
                                                                       placeholder="Địa chỉ chi tiết"
                                                                       ng-model="add.address">
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div style="gap: 0 !important; "
                                                                 class="d-flex align-items-center justify-content-end mt-4 gap-6">
                                                                <button class="btn btn-primary" type="submit"
                                                                        ng-click="addCustomer()">
                                                                    Lưu
                                                                </button>
                                                                <button class="btn btn-warning m-1"
                                                                        data-bs-dismiss="modal" aria-label="Close">Hủy
                                                                    bỏ
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>

                                        </div>
                                        <%--<div style="margin-top: 1rem" class="col-lg-6 d-flex align-items-stretch">
                                            <div class="card w-100 position-relative overflow-hidden">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Change Password</h5>
                                                    <p class="card-subtitle mb-4">To change your password please confirm
                                                        here</p>
                                                    <form>
                                                        <div class="mb-3">
                                                            <label for="exampleInputPassword1" class="form-label">Current
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword1" value="12345678910"
                                                                   fdprocessedid="thvw7m">
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="exampleInputPassword2" class="form-label">New
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword2" value="12345678910"
                                                                   fdprocessedid="4y09d5">
                                                        </div>
                                                        <div>
                                                            <label for="exampleInputPassword3" class="form-label">Confirm
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword3" value="12345678910"
                                                                   fdprocessedid="ywiahw">
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade" id="mdDetailCustomer" tabindex="-1" aria-labelledby="bs-example-modal-lg"
             aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header d-flex align-items-center">
                        <h4 class="modal-title">
                            Chi tiết nhân viên
                        </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="card" style="margin-bottom: 0">
                        <div class="card-body">
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-account" role="tabpanel"
                                     aria-labelledby="pills-account-tab" tabindex="0">
                                    <div class="row">
                                        <%--AVATA --%>
                                        <%--<div class="col-lg-12 d-flex align-items-stretch">
                                            <div class="card w-100 position-relative overflow-hidden">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Ảnh đại diện</h5>
                                                    <p class="card-subtitle mb-4">Thay đổi ảnh hồ sơ của bạn từ đây</p>
                                                    <div class="text-center">
                                                        <img src="<%=request.getContextPath()%>/assets/images/profile/user-1.jpg"
                                                             alt="" class="img-fluid rounded-circle" width="120"
                                                             height="120">
                                                        <div class="d-flex align-items-center justify-content-center my-4 gap-6">
                                                            <button class="btn btn-primary" fdprocessedid="nnyu7yr">Upload
                                                            </button>
                                                            <button class="btn bg-danger-subtle text-danger"
                                                                    fdprocessedid="jljpj5">Reset
                                                            </button>
                                                        </div>
                                                        <p class="mb-0">Cho phép file dạng JPG, GIF hoặc PNG và không lớn
                                                            hơn 5MB </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="col-12">
                                            <div class="card w-100 position-relative overflow-hidden mb-0">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Thông tin cá nhân</h5>
                                                    <p class="card-subtitle mb-4">Để thay đổi thông tin cá nhân của nhân
                                                        viên, hãy chỉnh sửa và lưu từ đây</p>
                                                    <form>
                                                        <div class="row">
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tên nhân viên</label>
                                                                    <input type="text" class="form-control"
                                                                           id="customerDetail-fullName"
                                                                           ng-model="customerDetail.fullName">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Chức danh</label>
                                                                    <select id="customerDetail-type" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="customerDetail.type">
                                                                        <option ng-value="3">Đại lý</option>
                                                                    </select>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Email</label>
                                                                    <input type="text" class="form-control"
                                                                           id="customerDetail-email"
                                                                           ng-model="customerDetail.email">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tỉnh/ Thành phố</label>
                                                                    <select id="customerDetail-provinceId"
                                                                            name="customerDetail-provinceId"
                                                                            class="form-control"
                                                                            ng-change="changeCityDetail(customerDetail.provinceId)"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="customerDetail.provinceId">
                                                                        <option ng-repeat="city in provinceListDetail track by $index"
                                                                                ng-value="{{city.id}}">
                                                                            {{city.name}}
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Quận/
                                                                        Huyện</label>
                                                                    <select id="customerDetail-districtId" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="customerDetail.districtId">
                                                                        <option ng-repeat="d in districtListDetail track by $index"
                                                                                ng-value="{{d.id}}">
                                                                            {{d.name}}
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Số điện thoại</label>
                                                                    <input maxlength="10"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           type="text" class="form-control"
                                                                           id="customerDetail-mobile"
                                                                           ng-model="customerDetail.mobile"
                                                                           fdprocessedid="mgl08o">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Ngày sinh</label>
                                                                    <input type="text" class="form-control"
                                                                           id="customerDetail-birthday"
                                                                           ng-model="customerDetail.birthday">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Mã nhân viên</label>
                                                                    <input type="text" class="form-control"
                                                                           id="customerDetail-empCode"
                                                                           ng-model="customerDetail.empCode">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Team</label>
                                                                    <select id="customerDetail-team" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="customerDetail.team">
                                                                        <%--                                                                        <option ng-value="-1">-- Tất cả --</option>--%>
                                                                        <option ng-value="1">Kim cương 1</option>
                                                                        <option ng-value="2">Kim cương 2</option>
                                                                        <option ng-value="3">Kim cương 3</option>
                                                                        <option ng-value="4">Kim cương 4</option>
                                                                        <option ng-value="5">Kim cương 5</option>
                                                                        <option ng-value="6">Kim cương 6</option>
                                                                        <option ng-value="7">Kim cương 7</option>
                                                                    </select>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div>
                                                                <label class="form-label">Địa chỉ chi tiết</label>
                                                                <input type="text" class="form-control"
                                                                       id="customerDetail-address"
                                                                       ng-model="customerDetail.address">
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="col-12">
                                                    <div style="gap: 0 !important;margin-top: 0;margin-bottom: 1rem;margin-right: 1rem;"
                                                         class="d-flex align-items-center justify-content-end mt-4 gap-6">
                                                        <button class="btn btn-primary"
                                                                ng-click="editCustomer()">
                                                            Lưu
                                                        </button>
                                                        <button class="btn btn-danger m-1"
                                                                ng-click="showDeletePopup(customerDetail)">Xóa
                                                            nhân viên
                                                        </button>
                                                        <button class="btn btn-warning m-1"
                                                                data-bs-dismiss="modal" aria-label="Close">Hủy
                                                            bỏ
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <%--<div style="margin-top: 1rem" class="col-lg-6 d-flex align-items-stretch">
                                            <div class="card w-100 position-relative overflow-hidden">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Change Password</h5>
                                                    <p class="card-subtitle mb-4">To change your password please confirm
                                                        here</p>
                                                    <form>
                                                        <div class="mb-3">
                                                            <label for="exampleInputPassword1" class="form-label">Current
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword1" value="12345678910"
                                                                   fdprocessedid="thvw7m">
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="exampleInputPassword2" class="form-label">New
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword2" value="12345678910"
                                                                   fdprocessedid="4y09d5">
                                                        </div>
                                                        <div>
                                                            <label for="exampleInputPassword3" class="form-label">Confirm
                                                                Password</label>
                                                            <input type="password" class="form-control"
                                                                   id="exampleInputPassword3" value="12345678910"
                                                                   fdprocessedid="ywiahw">
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div class="modal fade" id="mdConfirmDelete" tabindex="-1" aria-labelledby="danger-header-modalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-header modal-colored-header bg-danger text-white">
                        <h4 class="modal-title text-white" id="danger-header-modalLabel">
                            Xác nhận xóa
                        </h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa nhân viên <font
                                style="font-weight: 700">{{customerDelete.fullName}}</font>
                            với SĐT là <font style="font-weight: 700">{{customerDelete.mobile}}</font> hay không?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                            Hủy
                        </button>
                        <button type="button" class="btn bg-danger-subtle text-danger" ng-click="deleteCustomer()">
                            Xác nhận xóa
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </section>
</div>

