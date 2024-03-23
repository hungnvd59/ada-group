<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/userSystem/info.js"></script>
<style>
    .left-search {
        text-align: left !important;
        font-weight: bold;
        font-size: 14px;
        line-height: 25px;
    }
</style>

<div class="container-fluid">
    <section id="content" ng-app="ADAGROUP" ng-controller="userInfoCtrl">
        <div class="card">
            <div class="card-body">
                <div class="row" style="margin-bottom: 1rem">
                    <div class="col-md-6">
                        <h5 class="card-title fw-semibold mb-4">Thông tin cá nhân</h5>
                    </div>
                </div>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-account" role="tabpanel" aria-labelledby="pills-account-tab" tabindex="0">
                        <div class="row">
                            <div class="col-lg-6 d-flex align-items-stretch">
                                <div class="card w-100 position-relative overflow-hidden">
                                    <div class="card-body p-4">
                                        <h5 class="card-title fw-semibold">Ảnh đại diện</h5>
                                        <p class="card-subtitle mb-4">Thay đổi ảnh đại diện tại đây</p>
                                        <div class="text-center">
                                            <img src="<%=request.getContextPath()%>/assets/images/profile/user-1.jpg" alt="" class="img-fluid rounded-circle" width="120" height="120">
                                            <div class="d-flex align-items-center justify-content-center my-4 gap-6">
                                                <button class="btn btn-primary" fdprocessedid="7tofno">Tải lên</button>
<%--                                                <button class="btn bg-danger-subtle text-danger" fdprocessedid="9o7ord">Reset</button>--%>
                                            </div>
                                            <p class="mb-0">Chỉ chấp nhận định dạng JPG, GIF hoặc PNG. Kích cỡ không quá 5 MB</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 d-flex align-items-stretch">
                                <div class="card w-100 position-relative overflow-hidden">
                                    <div class="card-body p-4">
                                        <h5 class="card-title fw-semibold">Thay đổi mật khẩu</h5>
                                        <p class="card-subtitle mb-4">Thay đổi mật khẩu của tài khoản tại đây</p>
                                        <form>
                                            <div class="mb-3">
                                                <label for="passOld" class="form-label">Mật khẩu cũ &nbsp;<span
                                                        class="text-danger">*</span></label>
                                                <input type="password" required placeholder="Nhập mật khẩu cũ" class="form-control" ng-model="passOld" id="passOld" >
                                            </div>
                                            <div class="mb-3">
                                                <label for="passNew" class="form-label">Mật khẩu mới&nbsp;<span
                                                        class="text-danger">*</span></label>
                                                <input type="password" required placeholder="Nhập mật khẩu mới" class="form-control" ng-model="passNew" id="passNew">
                                            </div>
                                            <div>
                                                <label for="rePassNew" class="form-label">Nhập lại mật khẩu&nbsp;<span
                                                        class="text-danger">*</span></label>
                                                <input type="password" required placeholder="Nhập lại mật khẩu mới" class="form-control" ng-model="rePassNew" id="rePassNew">
                                            </div>
                                            <div>
                                                <button id="btn-changePass" style="margin-top: 0.5rem;float: right;" class="btn btn-warning" ng-click="changePass()">Thay đổi</button>
                                                <button id="btn-loading" disabled style="margin-top: 0.5rem;float: right;display: none" class="btn btn-warning" >
                                                    <span class="spinner-border spinner-border-sm" role="status"
                                                          aria-hidden="true"></span>
                                                    Vui lòng chờ...
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="card w-100 position-relative overflow-hidden mb-0">
                                    <div class="card-body p-4">
                                        <h5 class="card-title fw-semibold">Thông tin chi tiết</h5>
                                        <p class="card-subtitle mb-4">Thay đổi thông tin chi tiết của tài khoản</p>
                                        <form>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Tài khoản</label>
                                                        <input readonly type="text" ng-model="userDetail.username" class="form-control">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Chức danh</label>
                                                        <select id="type" name="type" class="form-control"
                                                                style="width: 100% ;border-radius: 6px" ng-model="userDetail.type" disabled>
                                                            <option ng-value="-1">-- Tất cả --</option>
                                                            <option ng-value="0">Hỗ trợ kỹ thuật</option>
                                                            <option ng-value="1">CEO - ADA GROUP</option>
                                                            <option ng-value="2">CEO - Kim cương</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Email</label>
                                                        <input type="email" class="form-control" ng-model="userDetail.email" >
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Họ và tên</label>
                                                        <input type="text" class="form-control" ng-model="userDetail.fullName">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Số điện thoại</label>
                                                        <input type="text" class="form-control" ng-model="userDetail.phone">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Mô tả</label>
                                                        <input type="text" class="form-control" ng-model="userDetail.description">
                                                    </div>
<%--                                                    <div class="mb-3">--%>
<%--                                                        <label class="form-label">Trạng thái</label>--%>
<%--                                                        <select id="userDetail-status" name="status"--%>
<%--                                                                class="form-control"--%>
<%--                                                                style="width: 100% ;border-radius: 6px"--%>
<%--                                                                ng-model="userDetail.status">--%>
<%--                                                            <option ng-value="1">Đang hoạt động</option>--%>
<%--                                                            <option ng-value="2">Ngưng hoạt động</option>--%>
<%--                                                        </select>--%>
<%--                                                    </div>--%>
                                                </div>
                                                <div class="col-12">
                                                    <div class="d-flex align-items-center justify-content-end mt-4 gap-6">
                                                        <button id="btn-save" class="btn btn-warning" ng-click="editUser()">Lưu</button>
                                                        <button class="btn btn-warning" type="button"
                                                                style="display: none" disabled="" id="btn-loading-change">
                                                            <span class="spinner-border spinner-border-sm" role="status"
                                                                  aria-hidden="true"></span>
                                                            Vui lòng chờ...
                                                        </button>
                                                        <a class="btn bg-danger-subtle text-danger" href="<%=request.getContextPath()%>/" >Hủy bỏ</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
