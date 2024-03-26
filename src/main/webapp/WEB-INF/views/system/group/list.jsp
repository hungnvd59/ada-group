<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/groupSystem/index.js"></script>
<style>
    .left-search {
        text-align: left !important;
        font-weight: bold;
        font-size: 14px;
        line-height: 25px;
    }

    /*Ipad ngang(1024 x 768)*/
    @media screen and (max-width: 1024px){
        .mobile-hide{
            display: none;
        }
        .mobile-col{
            margin-top: 1rem;
        }
    }
    @media screen and (min-width: 1024px){
        .mobile-show{
            display: none;
        }
    }
</style>
<div class="container-fluid">
    <section style="color: #1F2937;" id="content" ng-app="ADAGROUP" ng-controller="groupListCtrl">
        <c:if test="${success.length()>0}">
            <div class="alert alert-success alert-dismissible bg-success text-white border-0 fade show" role="alert">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"
                        fdprocessedid="1s3b0q"></button>
                <strong>Chỉnh sửa nhóm quyền thành công</strong>
            </div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <div class="row" style="margin-bottom: 1rem; display: flex; align-items: center;">
                    <div class="col-6">
                        <h5 class="card-title fw-semibold mb-0" style="font-size: 28px;">Tìm kiếm</h5>
                    </div>
                    <div class="col-6">
                        <%--                    <sec:authorize--%>
                        <%--                            access="hasAnyRole('ROLE_CTV_USER_EXPORT_EXCEL')">--%>
                        <a class="btn btn-warning m-1"
                           href="<%=request.getContextPath()%>/system/group/them-moi-nhom-quyen.html"
                           style="float:right;margin-right: .5rem;"><i
                                class="ti ti-circle-plus"></i>&nbsp;Thêm mới</a>
                        <%--                    </sec:authorize>--%>
                    </div>
                </div>
                <div class="panel-body">
                    <form Class="form-horizontal" role="form" theme="simple">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="control-label color-label left-search">Tên nhóm quyền</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input style="border-radius: 6px" my-enter="search()"
                                               id="filterName" name="filterName"
                                               placeholder="Tên nhóm quyền" maxlength="50" ng-model="filterName"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="row" style="margin-top: 3rem;text-align: center">
                    <div class="col-md-12">
                        <a class="btn btn-info" ng-click="search()"><i
                                class="ti ti-search"></i>&nbsp;Tìm kiếm</a>
                    </div>
                </div>
                <br>
                <div class="panel-body" style="margin-top: 2rem;">
                    <div id="data-search" class="card w-100">
                        <div class="card-body p-4">
                            <div class="row mb-2" style="display: flex; align-items: center;">
                                <div class="col-md-6">
                                    <h5 class="fw-semibold mb-0">Danh sách nhóm quyền</h5>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table border text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4">
                                    <tr>
                                        <th class="mobile-hide">
                                            <h6 class="fw-semibold mb-0">STT</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Tên nhóm</h6>
                                        </th>
                                        <th>
                                            <h6 class="fw-semibold mb-0">Mô tả</h6>
                                        </th>
                                        <th class="mobile-hide">
                                            <h6 class="fw-semibold mb-0">Người tạo</h6>
                                        </th>
                                        <th class="mobile-hide">
                                            <h6 class="fw-semibold mb-0">Ngày tạo</h6>
                                        </th>
                                        <th class="mobile-hide">
                                            <h6 class="fw-semibold mb-0">Thao tác</h6>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="item in listData.items track by $index">
                                        <td class="border-bottom mobile-hide">
                                            <p class="mb-0 fw-normal">
                                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.groupName}}</p>
                                        </td>
                                        <td>
                                            <p class="mb-0 fw-normal">{{item.description}}</p>
                                        </td>
                                        <td class="mobile-hide">
                                            <p class="mb-0 fw-normal">{{item.createBy}}</p>
                                        </td>
                                        <td class="mobile-hide">
                                            <p class="mb-0 fw-normal">{{item.genDate | date:'dd-MM-yyyy | HH:mm:ss'}}</p>
                                        </td>
                                        <td>
                                            <div class="action-btn">
                                                <a style="cursor: pointer" href="<%=request.getContextPath()%>/system/group/edit/{{item.id}}"
                                                   class="text-primary edit" title="Xem chi tiết" alt="Xem chi tiết">
                                                    <i class="ti ti-eye fs-5"></i>
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
                            </div>
                        </div>
                        <div class="row">
                            <div style="padding-left: 40px;" class="p-r-0 col-sm-12 text-right text-center-xs row">
                                <div class="col-sm-6 text-left mobile-hide">
                                    <div class="d-flex align-items-center justify-content-start py-1">
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
                                    </div>
                                </div>
                                <div class="col-sm-6 ">
                                    <nav aria-label="Page navigation example" style="float: right">
                                        <ul class="pagination">
                                            <li class="page-item mobile-hide" ng-if="listData.pageNumber > 1">
                                                <a class="page-link link" href="javascript:void(0)"
                                                   style="background-color: #FFF;"
                                                   ng-click="loadPageData(1)"
                                                   aria-label="Previous">
                                                      <span aria-hidden="true">
                                                        <i class="ti ti-chevrons-left fs-4"></i>
                                                      </span>
                                                </a>
                                            </li>
                                            <li class="page-item mobile-show" ng-if="listData.pageNumber > 1">
                                                <a class="page-link link" href="javascript:void(0)"
                                                   style="background-color: #FFF;border-top-left-radius: 7px;border-bottom-left-radius: 7px"
                                                   ng-click="loadPageData(listData.pageNumber -1)"
                                                   aria-label="Previous">
                                                      <span aria-hidden="true">
                                                        <i class="ti ti-chevrons-left fs-4"></i>
                                                      </span>
                                                </a>
                                            </li>
                                            <li class="page-item" ng-repeat="item in listData.pageList">
                                                <a class="page-link link" href="javascript:void(0)"
                                                   style="background-color: #ffc13e;border: 1px solid #ffc13e"
                                                   ng-if="item == listData.pageNumber"> {{item}}</a>
                                                <a class="page-link link mobile-hide" href="javascript:void(0)"
                                                   ng-click="loadPageData(item)"
                                                   style="background-color: #FFF;"
                                                   ng-if="item != listData.pageNumber"> {{item}}</a>
                                            </li>
                                            <li class="page-item mobile-hide"
                                                ng-if="listData.pageNumber < listData.pageCount">
                                                <a class="page-link link" href="javascript:void(0)"
                                                   style="background-color: #FFF;border-top-right-radius: 7px;border-bottom-right-radius: 7px"
                                                   ng-click="loadPageData(listData.pageCount)" aria-label="Next">
                                                      <span aria-hidden="true">
                                                        <i class="ti ti-chevrons-right fs-4"></i>
                                                      </span>
                                                </a>
                                            </li>
                                            <li class="page-item mobile-show"
                                                ng-if="listData.pageNumber + 1 <= listData.pageCount">
                                                <a class="page-link link" href="javascript:void(0)"
                                                   style="background-color: #FFF;border-top-right-radius: 7px;border-bottom-right-radius: 7px"
                                                   ng-click="loadPageData(listData.pageNumber + 1)" aria-label="Next">
                                                      <span aria-hidden="true">
                                                        <i class="ti ti-chevrons-right fs-4"></i>
                                                      </span>
                                                </a>
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
        <div class="modal fade" id="mdDelete" role="dialog" aria-hidden="true" data-keyboard="false"
             data-backdrop="static" style="text-align: center">
            <div class="modal-dialog" id="c">
                <div class="modal-content" style="text-align: center;">
                    <div class="modal-header alert text-center"
                         style="padding: 7px; background: #172B4D;border-radius: 0">
                        <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                                class="close" data-dismiss="modal"
                                aria-hidden="true" ng-click="clearFormAdd()">&times;
                        </button>
                        <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                    </div>
                    <div>
                        <div class="modal-body">
                            <label>Bạn có chắc chắn muốn xóa nhóm quyền </label>
                            <span style="font-weight: bold">{{deleteObj.groupName}}</span>
                            <label>hay không?</label>
                        </div>
                        <div class="modal-footer" style="border: none;text-align: center">
                            <a class="btn btn-light"
                               type="button"
                               style="width:136px; border: 1px solid #172B4D;color: #172B4D; border-radius: 8px"
                               data-dismiss="modal">Hủy
                            </a>
                            <a class="btn btn-secondary"
                               style="width: 136px;background: #172B4D;border-radius: 8px;color: #FFFFFF;border: none"
                               type="button"
                               ng-click="deleteGroup(deleteObj)">Đồng ý
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>