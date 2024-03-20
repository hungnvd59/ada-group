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
                                                <label for="exampleInputPassword1" class="form-label">Mật khẩu cũ</label>
                                                <input type="password" placeholder="Nhập mật khẩu cũ" class="form-control" id="exampleInputPassword1" fdprocessedid="ehaaui">
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputPassword2" class="form-label">Mật khẩu mới</label>
                                                <input type="password" placeholder="Nhập mật khẩu mới" class="form-control" id="exampleInputPassword2" fdprocessedid="r7w1s">
                                            </div>
                                            <div>
                                                <label for="exampleInputPassword3" class="form-label">Nhập lại mật khẩu</label>
                                                <input type="password" placeholder="Nhập lại mật khẩu mới" class="form-control" id="exampleInputPassword3" fdprocessedid="4waiiy">
                                            </div>
                                            <div>
                                                <button id="btn-changePass" style="margin-top: 0.5rem;float: right;" class="btn btn-warning" fdprocessedid="djkdy">Thay đổi</button>
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
                                                        <label for="exampleInputtext" class="form-label">Tài khoản</label>
                                                        <input readonly type="text" ng-model="userDetail.username" class="form-control" id="exampleInputtext" placeholder="Mathew Anderson" fdprocessedid="chsexc">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Chức danh</label>
                                                        <select id="type" name="type" class="form-control"
                                                                style="width: 100% ;border-radius: 6px" ng-model="userDetail.type">
                                                            <option ng-value="-1">-- Tất cả --</option>
                                                            <option ng-value="0">Hỗ trợ kỹ thuật</option>
                                                            <option ng-value="1">CEO - ADA GROUP</option>
                                                            <option ng-value="2">CEO - Kim cương</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext1" class="form-label">Email</label>
                                                        <input type="email" class="form-control" ng-model="userDetail.email" id="exampleInputtext1" placeholder="info@modernize.com" fdprocessedid="vr0pt">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext" class="form-label">Họ và tên</label>
                                                        <input type="text" class="form-control" ng-model="userDetail.fullName" id="exampleInputtext" placeholder="Mathew Anderson" fdprocessedid="chsexc">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext2" class="form-label">Số điện thoại</label>
                                                        <input type="text" class="form-control" ng-model="userDetail.phone" id="exampleInputtext2" placeholder="Maxima Studio" fdprocessedid="32a6lp">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Trạng thái</label>
                                                        <select id="userDetail-status" name="status"
                                                                class="form-control"
                                                                style="width: 100% ;border-radius: 6px"
                                                                ng-model="userDetail.status">
                                                            <option ng-value="1">Đang hoạt động</option>
                                                            <option ng-value="2">Ngưng hoạt động</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="d-flex align-items-center justify-content-end mt-4 gap-6">
                                                        <button class="btn btn-warning" fdprocessedid="djkdy">Lưu</button>
                                                        <a class="btn bg-danger-subtle text-danger" href="<%=request.getContextPath()%>/" fdprocessedid="9clq8c">Hủy bỏ</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-notifications" role="tabpanel" aria-labelledby="pills-notifications-tab" tabindex="0">
                        <div class="row justify-content-center">
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Notification Preferences</h4>
                                        <p>
                                            Select the notificaitons ou would like to receive via email. Please note that you cannot opt
                                            out of receving service
                                            messages, such as payment, security or legal notifications.
                                        </p>
                                        <form class="mb-7">
                                            <label for="exampleInputtext5" class="form-label">Email Address*</label>
                                            <input type="text" class="form-control" id="exampleInputtext5" placeholder="" required="">
                                            <p class="mb-0">Required for notificaitons.</p>
                                        </form>
                                        <div>
                                            <div class="d-flex align-items-center justify-content-between mb-4">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                        <i class="ti ti-article text-dark d-block fs-7" width="22" height="22"></i>
                                                    </div>
                                                    <div>
                                                        <h5 class="fs-4 fw-semibold">Our newsletter</h5>
                                                        <p class="mb-0">We'll always let you know about important changes</p>
                                                    </div>
                                                </div>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked">
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mb-4">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                        <i class="ti ti-checkbox text-dark d-block fs-7" width="22" height="22"></i>
                                                    </div>
                                                    <div>
                                                        <h5 class="fs-4 fw-semibold">Order Confirmation</h5>
                                                        <p class="mb-0">You will be notified when customer order any product</p>
                                                    </div>
                                                </div>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked1" checked="">
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mb-4">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                        <i class="ti ti-clock-hour-4 text-dark d-block fs-7" width="22" height="22"></i>
                                                    </div>
                                                    <div>
                                                        <h5 class="fs-4 fw-semibold">Order Status Changed</h5>
                                                        <p class="mb-0">You will be notified when customer make changes to the order</p>
                                                    </div>
                                                </div>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked2" checked="">
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mb-4">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                        <i class="ti ti-truck-delivery text-dark d-block fs-7" width="22" height="22"></i>
                                                    </div>
                                                    <div>
                                                        <h5 class="fs-4 fw-semibold">Order Delivered</h5>
                                                        <p class="mb-0">You will be notified once the order is delivered</p>
                                                    </div>
                                                </div>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked3">
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                        <i class="ti ti-mail text-dark d-block fs-7" width="22" height="22"></i>
                                                    </div>
                                                    <div>
                                                        <h5 class="fs-4 fw-semibold">Email Notification</h5>
                                                        <p class="mb-0">Turn on email notificaiton to get updates through email</p>
                                                    </div>
                                                </div>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked4" checked="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Date &amp; Time</h4>
                                        <p>Time zones and calendar display settings.</p>
                                        <div class="d-flex align-items-center justify-content-between mt-7">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                    <i class="ti ti-clock-hour-4 text-dark d-block fs-7" width="22" height="22"></i>
                                                </div>
                                                <div>
                                                    <p class="mb-0">Time zone</p>
                                                    <h5 class="fs-4 fw-semibold">(UTC + 02:00) Athens, Bucharet</h5>
                                                </div>
                                            </div>
                                            <a class="text-dark fs-6 d-flex align-items-center justify-content-center bg-transparent p-2 fs-4 rounded-circle" href="javascript:void(0)" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Download">
                                                <i class="ti ti-download"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Ignore Tracking</h4>
                                        <div class="d-flex align-items-center justify-content-between mt-7">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                    <i class="ti ti-player-pause text-dark d-block fs-7" width="22" height="22"></i>
                                                </div>
                                                <div>
                                                    <h5 class="fs-4 fw-semibold">Ignore Browser Tracking</h5>
                                                    <p class="mb-0">Browser Cookie</p>
                                                </div>
                                            </div>
                                            <div class="form-check form-switch mb-0">
                                                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked5">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center justify-content-end gap-6">
                                    <button class="btn btn-primary">Save</button>
                                    <button class="btn bg-danger-subtle text-danger">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-bills" role="tabpanel" aria-labelledby="pills-bills-tab" tabindex="0">
                        <div class="row justify-content-center">
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Billing Information</h4>
                                        <form>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext6" class="form-label">Business
                                                            Name*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext6" placeholder="Visitor Analytics">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext7" class="form-label">Business
                                                            Address*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext7" placeholder="">
                                                    </div>
                                                    <div>
                                                        <label for="exampleInputtext8" class="form-label">First Name*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext8" placeholder="">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext9" class="form-label">Business
                                                            Sector*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext9" placeholder="Arts, Media &amp; Entertainment">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="exampleInputtext10" class="form-label">Country*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext10" placeholder="Romania">
                                                    </div>
                                                    <div>
                                                        <label for="exampleInputtext11" class="form-label">Last Name*</label>
                                                        <input type="text" class="form-control" id="exampleInputtext11" placeholder="">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Current Plan : <span class="text-success">Executive</span></h4>
                                        <p>Thanks for being a premium member and supporting our development.</p>
                                        <div class="d-flex align-items-center justify-content-between mt-7 mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                    <i class="ti ti-package text-dark d-block fs-7" width="22" height="22"></i>
                                                </div>
                                                <div>
                                                    <p class="mb-0">Current Plan</p>
                                                    <h5 class="fs-4 fw-semibold">750.000 Monthly Visits</h5>
                                                </div>
                                            </div>
                                            <a class="text-dark fs-6 d-flex align-items-center justify-content-center bg-transparent p-2 fs-4 rounded-circle" href="javascript:void(0)" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Add">
                                                <i class="ti ti-circle-plus"></i>
                                            </a>
                                        </div>
                                        <div class="d-flex align-items-center gap-3">
                                            <button class="btn btn-primary">Change Plan</button>
                                            <button class="btn bg-danger-subtle text-danger">Reset Plan</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Payment Method</h4>
                                        <p>On 26 December, 2023</p>
                                        <div class="d-flex align-items-center justify-content-between mt-7">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="text-bg-light rounded-1 p-6 d-flex align-items-center justify-content-center">
                                                    <i class="ti ti-credit-card text-dark d-block fs-7" width="22" height="22"></i>
                                                </div>
                                                <div>
                                                    <h5 class="fs-4 fw-semibold">Visa</h5>
                                                    <p class="mb-0 text-dark">*****2102</p>
                                                </div>
                                            </div>
                                            <a class="text-dark fs-6 d-flex align-items-center justify-content-center bg-transparent p-2 fs-4 rounded-circle" href="javascript:void(0)" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Edit">
                                                <i class="ti ti-pencil-minus"></i>
                                            </a>
                                        </div>
                                        <p class="my-2">If you updated your payment method, it will only be dislpayed here after your
                                            next billing cycle.</p>
                                        <div class="d-flex align-items-center gap-3">
                                            <button class="btn bg-danger-subtle text-danger">Cancel Subscription</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center justify-content-end gap-6">
                                    <button class="btn btn-primary">Save</button>
                                    <button class="btn bg-danger-subtle text-danger">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-security" role="tabpanel" aria-labelledby="pills-security-tab" tabindex="0">
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <h4 class="fw-semibold mb-3">Two-factor Authentication</h4>
                                        <div class="d-flex align-items-center justify-content-between pb-7">
                                            <p class="mb-0">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Corporis sapiente
                                                sunt earum officiis laboriosam ut.</p>
                                            <button class="btn btn-primary">Enable</button>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between py-3 border-top">
                                            <div>
                                                <h5 class="fs-4 fw-semibold mb-0">Authentication App</h5>
                                                <p class="mb-0">Google auth app</p>
                                            </div>
                                            <button class="btn bg-primary-subtle text-primary">Setup</button>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between py-3 border-top">
                                            <div>
                                                <h5 class="fs-4 fw-semibold mb-0">Another e-mail</h5>
                                                <p class="mb-0">E-mail to send verification link</p>
                                            </div>
                                            <button class="btn bg-primary-subtle text-primary">Setup</button>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between py-3 border-top">
                                            <div>
                                                <h5 class="fs-4 fw-semibold mb-0">SMS Recovery</h5>
                                                <p class="mb-0">Your phone number or something</p>
                                            </div>
                                            <button class="btn bg-primary-subtle text-primary">Setup</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-body p-4">
                                        <div class="text-bg-light rounded-1 p-6 d-inline-flex align-items-center justify-content-center mb-3">
                                            <i class="ti ti-device-laptop text-primary d-block fs-7" width="22" height="22"></i>
                                        </div>
                                        <h5 class="fs-5 fw-semibold mb-0">Devices</h5>
                                        <p class="mb-3">Lorem ipsum dolor sit amet consectetur adipisicing elit Rem.</p>
                                        <button class="btn btn-primary mb-4">Sign out from all devices</button>
                                        <div class="d-flex align-items-center justify-content-between py-3 border-bottom">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="ti ti-device-mobile text-dark d-block fs-7" width="26" height="26"></i>
                                                <div>
                                                    <h5 class="fs-4 fw-semibold mb-0">iPhone 14</h5>
                                                    <p class="mb-0">London UK, Oct 23 at 1:15 AM</p>
                                                </div>
                                            </div>
                                            <a class="text-dark fs-6 d-flex align-items-center justify-content-center bg-transparent p-2 fs-4 rounded-circle" href="javascript:void(0)">
                                                <i class="ti ti-dots-vertical"></i>
                                            </a>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between py-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="ti ti-device-laptop text-dark d-block fs-7" width="26" height="26"></i>
                                                <div>
                                                    <h5 class="fs-4 fw-semibold mb-0">Macbook Air</h5>
                                                    <p class="mb-0">Gujarat India, Oct 24 at 3:15 AM</p>
                                                </div>
                                            </div>
                                            <a class="text-dark fs-6 d-flex align-items-center justify-content-center bg-transparent p-2 fs-4 rounded-circle" href="javascript:void(0)">
                                                <i class="ti ti-dots-vertical"></i>
                                            </a>
                                        </div>
                                        <button class="btn bg-primary-subtle text-primary w-100 py-1">Need Help ?</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center justify-content-end gap-6">
                                    <button class="btn btn-primary">Save</button>
                                    <button class="btn bg-danger-subtle text-danger">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
