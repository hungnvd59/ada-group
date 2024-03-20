<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/userSystem/index.js"></script>
<style>
    .left-search {
        text-align: left !important;
        font-weight: bold;
        font-size: 14px;
        line-height: 25px;
    }
</style>

<div class="container-fluid">
    <section id="content" ng-app="ADAGROUP" ng-controller="userListCtrl">
        <c:if test="${success.length()>0}">
            <div class="alert alert-success alert-dismissible bg-success text-white border-0 fade show" role="alert">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"
                        fdprocessedid="1s3b0q"></button>
                <strong>Phân quyền tài khoản thành công</strong>
            </div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <div class="row" style="margin-bottom: 1rem">
                    <div class="col-md-6">
                        <h5 class="card-title fw-semibold mb-4">Thông tin tìm kiếm</h5>
                    </div>
                </div>
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row" style="margin-left: 30px;margin-right: 30px;">
                            <div class="row" style="margin-top: 0px;">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <label class="control-label color-label left-search">Tài khoản</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input ng-model="username" style="border-radius: 6px" my-enter="search()"
                                                   id="username"
                                                   placeholder="Tài khoản" maxlength="100"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="control-label color-label left-search">Chức danh</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <select id="type" name="type" class="form-control"
                                                    style="width: 100% ;border-radius: 6px" ng-model="type">
                                                <option ng-value="-1">-- Tất cả --</option>
                                                <option ng-value="0">Hỗ trợ kỹ thuật</option>
                                                <option ng-value="1">CEO - ADA GROUP</option>
                                                <option ng-value="2">CEO - Kim cương</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="row" style="margin-top: 3rem;text-align: center">
                    <div class="col-md-12">
                        <a class="btn btn-light" ng-click="search()"><i
                                class="ti ti-search"></i>&nbsp;Tìm kiếm</a>
                    </div>
                </div>
                <div class="row" style="margin-top: 3rem;">
                    <div class="col-md-6">
                        <h5 style="font-weight: 700"></h5>
                    </div>
                    <div class="col-md-6">
                        <%--                    <sec:authorize--%>
                        <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                        <a class="btn btn-success m-1" ng-click="export()"
                           style="margin-right: 2rem; float: right"><i
                                class="ti ti-download"></i>&nbsp;Xuất excel</a>
                    </div>
                </div>
                <div class="panel-body" style="margin-top: 3rem">
                    <div id="data-search" class="card w-100">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-4">Danh sách người dùng</h5>
                            <div class="table-responsive">
                                <table class="table border text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4">
                                    <tr>
                                        <th>
                                            <h6 class="fw-semibold mb-0">STT</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Tài khoản</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Họ tên</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Chức danh</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Số điện thoại</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Trạng thái</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Thao tác</h6>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="item in listData.items track by $index">
                                        <td class="border-bottom">
                                            <p class="mb-0 fw-normal">
                                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}</p>
                                        </td>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.username}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.fullName}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{getTypeCtv(item.type)}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.phone}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{getStatusCtv(item.status)}}</p>
                                        </td>
                                        <td>
                                            <div class="action-btn">
                                                <a style="cursor: pointer" ng-click="showDetail(item)"
                                                   class="text-primary edit" title="Xem chi tiết" alt="Xem chi tiết">
                                                    <i class="ti ti-eye fs-5"></i>
                                                </a>
                                                <a style="cursor: pointer"
                                                   href="<%=request.getContextPath()%>/system/user/phan-quyen-nguoi-dung.html/{{item.id}}"
                                                   class="text-dark delete ms-2" title="Phân quyền tài khoản"
                                                   alt="Phân quyền tài khoản">
                                                    <i class="ti ti-key fs-5"></i>
                                                </a>
                                                <a style="cursor: pointer" ng-click="preRestorePass(item)"
                                                   class="text-dark delete ms-2" title="Khôi phục mật khẩu"
                                                   alt="Khôi phục mật khẩu">
                                                    <i class="ti ti-recycle fs-5"></i>
                                                </a>
                                            </div>
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
                    <div id="loading" style="display: none" class="card w-100">
                        <div class="card-body">
                            <div class="text-center">
                                <div class="spinner-border" role="status">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="mdDetail" tabindex="-1" aria-labelledby="bs-example-modal-lg"
             aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header d-flex align-items-center">
                        <h4 class="modal-title">
                            Thông tin chi tiết
                        </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="card" style="margin-bottom: 0">
                        <div class="card-body">
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-account" role="tabpanel"
                                     aria-labelledby="pills-account-tab" tabindex="0">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="card w-100 position-relative overflow-hidden mb-0">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title fw-semibold">Thông tin người dùng</h5>
                                                    <p class="card-subtitle mb-4">Để thay đổi thông tin người dùng, hãy
                                                        chỉnh sửa và lưu từ đây</p>
                                                    <form>
                                                        <div class="row">
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tài khoản</label>
                                                                    <input type="text" class="form-control"
                                                                           id="userDetail-username"
                                                                           readonly
                                                                           ng-model="userDetail.username">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Chức danh</label>
                                                                    <select id="userDetail-type" name="team"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="userDetail.type">
                                                                        <option ng-value="0">Hỗ trợ kỹ thuật</option>
                                                                        <option ng-value="1">CEO - ADA GROUP</option>
                                                                        <option ng-value="2">CEO - Kim cương</option>
                                                                    </select>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Email</label>
                                                                    <input type="text" class="form-control"
                                                                           id="userDetail-email"
                                                                           ng-model="userDetail.email">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Họ tên</label>
                                                                    <input type="text" class="form-control"
                                                                           id="userDetail-fullName"
                                                                           ng-model="userDetail.fullName">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Số điện thoại</label>
                                                                    <input maxlength="10"
                                                                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                           type="text" class="form-control"
                                                                           id="userDetail-mobile"
                                                                           ng-model="userDetail.phone">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Trạng thái</label>
                                                                    <select id="userDetail-status" name="status"
                                                                            class="form-control"
                                                                            style="width: 100% ;border-radius: 6px"
                                                                            ng-model="userDetail.status">
                                                                        <%--                                                                        <option ng-value="-1">-- Tất cả --</option>--%>
                                                                        <option ng-value="1">Đang hoạt động</option>
                                                                        <option ng-value="2">Ngưng hoạt động</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="col-12">
                                                    <div style="gap: 0 !important;margin-top: 0;margin-bottom: 1rem;margin-right: 1rem;"
                                                         class="d-flex align-items-center justify-content-end mt-4 gap-6">
                                                        <button id="btn-save" class="btn btn-primary"
                                                                ng-click="editUser()">
                                                            Lưu
                                                        </button>
                                                        <button class="btn btn-primary" type="button"
                                                                style="display: none" disabled="" id="btn-loading">
                                                            <span class="spinner-border spinner-border-sm" role="status"
                                                                  aria-hidden="true"></span>
                                                            Vui lòng chờ...
                                                        </button>
                                                        <button class="btn btn-warning m-1"
                                                                data-bs-dismiss="modal" aria-label="Close">Hủy
                                                            bỏ
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
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div class="modal fade" id="mdRestorePassword" tabindex="-1" aria-labelledby="danger-header-modalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-header modal-colored-header bg-danger text-white">
                        <h4 class="modal-title text-white" id="danger-header-modalLabel">
                            Khôi phục mật khẩu
                        </h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn khôi phục mật khẩu cho <font
                                style="font-weight: 700">{{restorePass.username}}</font>
                            về mặc định hay không?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                            Hủy
                        </button>
                        <button id="btn-confirm" class="btn bg-danger-subtle text-danger" ng-click="restorePassword()">
                            Xác nhận
                        </button>
                        <button class="btn bg-danger-subtle text-danger" style="display: none" disabled=""
                                id="btn-loadConfirm">
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            Vui lòng chờ...
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div class="modal fade" id="mdAuthority" tabindex="-1" aria-labelledby="bs-example-modal-lg"
             aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header d-flex align-items-center">
                        <h4 class="modal-title">
                            Phân quyền tài khoản
                        </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="card" style="margin-bottom: 0">
                        <div class="card-body">
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal-dialog -->
        </div>


    </section>
</div>