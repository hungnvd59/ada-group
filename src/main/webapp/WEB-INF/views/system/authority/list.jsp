<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<script  type="text/javascript">--%>
<%--$("#response-status").show();--%>
<%--setTimeout(function() { $("#response-status").hide(); }, 3000);--%>
<%--</script>--%>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap-filestyle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/assets/project/system/authority/list.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/note/css/common.css" type="text/css"/>
<style>
    .btn-secondary {
        background-color: gray;
        color: white;
    }

    .btn-add {
        border-radius: 10px;
        color: #0c63e4;
        border-color: #0c63e4;
        margin: 0.5px;
    }

    .btn-cancel {
        border-radius: 10px;
        color: #282424;
        border-color: #282424;
    }

    .btn-cancel:hover {
        background-color: #eae6e6;
    }
</style>
<section style="color: #1F2937;" id="content" ng-app="ADAGROUP" ng-controller="authorityListCtrl">
    <section class="vbox">
        <section class="scrollable padder" style="background: #f4f4f4">
            <ul style="font-weight: 700;color: #2A2C54"
                class="bg-white breadcrumb no-border no-radius b-b b-light pull-in breadcrumb-common">
                <li>Quản trị hệ thống</li>
                <li>Chức năng hệ thống</li>
            </ul>
            <div class="m-b-md">
                <h3 class="m-b-none" id="response-status" style="color: #009900">
                    <c:if test="${success.length()>0}"><span style="color:red"><spring:message code="${success}"/>
                </c:if>
                    <c:if test="${messageError.length()>0}"><span style="color:red"><spring:message
                            code="${messageError}"/></span></c:if>
                </h3>
            </div>

            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="panel-body">
                    <form cssClass="form-inline padder" action="list" role="form" theme="simple">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-sm-8" style="padding-left: 0">
                                    <input style="border-radius: 10px;" name="authKey" ng-model="authKey"
                                           my-enter="search()"
                                           placeholder="<spring:message code='label.system.authority.key'/>"
                                           maxlength="100" class="form-control"/>
                                </div>
                                <div class="col-sm-4">
                                    <a type="button"
                                       ng-click="search()" class="btn btn-info btn-search-common"><spring:message
                                            code="label.button.search"/></a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <div class="row">
                <div class="col-md-6">
                </div>
                <div class="col-md-6">
<%--                    <sec:authorize access="hasRole('ROLE_SYSTEM_AUTHORITY_ADD')">--%>
                        <a class="btn btn-add btn-search-common"
                           style="float:right !important;"D
                           data-toggle="modal"
                           data-target="#updateAuthorityModal"
                           ng-click="onAddAuthority();">Thêm mới
                        </a>
<%--                    </sec:authorize>--%>
                </div>
            </div>
            <br>
            <section class="panel panel-default" style="border-radius: 20px;">
                <div class="table-responsive">
                    <table class="table b-t b-light table-bordered table-hover" style="margin-bottom: 0px;">
                        <thead class="bg-gray">
                        <tr style="background-color: #222222">
                            <th style="width: 1%;vertical-align: middle;"
                                class="text-white small_col text-center">STT
                            </th>
<%--                            <sec:authorize--%>
<%--                                    access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_EDIT','ROLE_SYSTEM_AUTHORITY_DETAIL')">--%>
                                <th style="width: 1%;vertical-align: middle;"
                                    class="text-white small_col text-center">Thao tác
                                </th>
<%--                            </sec:authorize>--%>
                            <th class="text-white small_col text-center"
                                style="width: 1%;vertical-align: middle;"><spring:message
                                    code="label.system.authority.key"/>
                            </th>
                            <th class="text-white small_col text-center"
                                style="width: 1%;vertical-align: middle;"><spring:message
                                    code="label.system.authority.name"/></th>
                            <th class="text-white small_col text-center"
                                style="width: 1%;vertical-align: middle;"><spring:message
                                    code="label.system.authority.description"/></th>
                            <th class="text-white small_col text-center"
                                style="width: 1%;vertical-align: middle;"><spring:message
                                    code="label.system.authority.timeCreate"/></th>
                            <th class="text-white small_col text-center"
                                style="width: 1%;vertical-align: middle;"><spring:message
                                    code="label.system.authority.timeModify"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="item in listData.items track by $index">
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                {{(listData.pageNumber - 1) * listData.numberPerPage + $index + 1}}
                            </td>
<%--                            <sec:authorize--%>
<%--                                    access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_DETAIL','ROLE_SYSTEM_AUTHORITY_DELETE')">--%>
                                <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                    <div class="btn-group" style="text-align: left">
                                        <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i
                                                class="fa fa-cog text-default"></i></a>
                                        <ul class="dropdown-menu pull-right"
                                            style="width: fit-content;text-align: left;">
<%--                                            <sec:authorize access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_DETAIL')">--%>
                                                <li class="li-ct3"><a href=""
                                                                      type="button" data-toggle="modal"
                                                                      data-target="#updateAuthorityModal"
                                                                      ng-click="onEditAuthority(item);"><i
                                                        class="fa fa-eye"></i>&nbsp;Xem&nbsp;chi tiết</a></li>
<%--                                            </sec:authorize>--%>
                                        </ul>
                                    </div>
                                </td>
<%--                            </sec:authorize>--%>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item[1]}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item[2]}}</td>
                            <td style="vertical-align: middle;" class="text-left v-inherit">{{item[3]}}</td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                {{item[6] | date:'dd/MM/yyyy | HH:mm:ss'}}
                            </td>
                            <td style="vertical-align: middle;text-align: center" class="text-left v-inherit">
                                {{item[7] | date:'dd/MM/yyyy | HH:mm:ss'}}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12" ng-if="listData.rowCount==0" class="text-center">Không có dữ liệu</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>
            <footer class="panel-footer">
                <div class="row">
                    <div class="col-sm-12 text-right text-center-xs">
                        <div class="col-sm-6 text-left">
                            <span style="color: black">Tổng số {{listData.rowCount}} dữ liệu</span>
                        </div>
                        <div class="col-sm-6">
                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                <li ng-if="listData.pageNumber > 1"><a href="javascript:void(0)"
                                                                       ng-click="loadPageData(1)">«</a>
                                </li>
                                <li ng-repeat="item in listData.pageList">
                                    <a href="javascript:void(0)" ng-if="item == listData.pageNumber"
                                       style="color:mediumvioletred;"> {{item}}</a>
                                    <a href="javascript:void(0)" ng-if="item != listData.pageNumber"
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

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>

    <div class="modal fade" id="updateAuthorityModal" tabindex="-1" role="dialog"
         aria-labelledby="updateAuthorityModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document" style="border-radius: 20px">
            <div class="modal-content">
                <div class="modal-header alert"
                     style="padding: 7px; background: #172B4D; text-align: center;vertical-align: center">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 style="font-size: 14pt;color: White;" id="exampleModalLabel" ng-if="labelTitle == 'Add'">
                        <spring:message code="label.modal.authority.add"/></h4>
                    <h4 style="font-size: 14pt;color: White;" id="exampleModalLabel1" ng-if="labelTitle == 'Edit'">
                        <spring:message code="label.modal.authority.edit"/></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="recipient-name" class="col-form-label" style="font-weight: bold"><spring:message
                                code="label.system.authority.key"/></label>
                        <input type="hidden" ng-model="authItem.id"/>
                        <div>
                            <input style="border-radius: 10px;" ng-if="labelTitle == 'Add'" ng-model="authItem.authKey"
                                   id="authKeyUpdate"
                                   name="authKeyUpdate" class="form-control"
                                   placeholder="<spring:message code='label.system.authority.key'/>"
                                   maxlength="100"
                            />
                            <input style="border-radius: 10px;" ng-if="labelTitle == 'Edit'" ng-model="authItem.authKey"
                                   id="authKeyUpdate1"
                                   name="authKeyUpdate" class="form-control" disabled
                                   placeholder="<spring:message code='label.system.authority.key'/>"
                                   maxlength="100"
                            />
                        </div>
                        <span class="text-danger">{{authKey_valid}}</span>
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="col-form-label" style="font-weight: bold"><spring:message
                                code="label.system.authority.name"/></label>
                        <div>
                            <input style="border-radius: 10px;" ng-model="authItem.authority" class="form-control"
                                   id="authNameUpdate"
                                   name="authNameUpdate"
                                   placeholder="<spring:message code='label.system.authority.name'/>"
                                   maxlength="100"
                            />
                        </div>
                        <span class="text-danger">{{authName_valid}}</span>
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="col-form-label" style="font-weight: bold"><spring:message
                                code="label.system.authority.authParrent"/></label>
                        <div>
                            <select class="select2-choice" id="authParentUpdate" name="authParentUpdate" ng-model="authItem.fid"
                                    style="width: 100%">
                                <option value="0" selected><spring:message
                                        code="label.system.authority.select.none"/></option>
                                <option ng-repeat="auth in authParent" value="{{auth.id}}">{{auth.authority}}
                                </option>
                            </select>
                        </div>
                        <span class="text-danger">{{authParent_valid}}</span>
                    </div>

                    <div class="form-group">
                        <label for="message-text" class="col-form-label" style="font-weight: bold"><spring:message
                                code="label.system.authority.description"/></label>
                        <div>
                            <textarea style="border-radius: 10px;" ng-model="authItem.description"
                                      id="authDescriptionUpdate"
                                      name="authDescriptionUpdate" class="form-control" placeholder="Mô tả" rows="5"
                                      maxlength="100"/></textarea>
                        </div>
                        <span class="text-danger">{{authDescription_valid}}</span>
                    </div>
                    <!--</form>-->
                </div>
                <div class="modal-footer" style="border: none;text-align: center">
                    <%--                    <sec:authorize access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_ADD')">--%>
                    <a style="width: 111px;background: #FFFFFF;border: 0.5px solid #172B4D;border-radius: 8px;color: #172B4D !important;"
                       type="button"
                       class="btn" ng-click="addOrUpdateAuthority()"
                       ng-if="labelTitle == 'Add'"><spring:message
                            code="label.button.save"/></a>
                    <%--                    </sec:authorize>--%>
                    <%--                    <sec:authorize access="hasAnyRole('ROLE_SYSTEM_AUTHORITY_EDIT')">--%>
                    <a style="width: 111px;background: #172B4D;border-radius: 8px;color: #FFFFFF;border: none"
                       type="button"
                       class="btn" ng-click="addOrUpdateAuthority()"
                       ng-if="labelTitle == 'Edit'"> <spring:message
                            code="label.button.update"/></a>
                    <%--                    </sec:authorize>--%>
                    <a style="width: 111px;color: #172B4D;background: #20B4BD;border-radius: 8px;color: white"
                       type="button"
                       class="btn" data-dismiss="modal">
                        <spring:message code="label.button.close"/></a>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="deleteAuthorityModal" role="dialog" aria-hidden="true" style="text-align: center">
        <div class="modal-dialog" id="b">
            <div class="modal-content" style="text-align: center;">
                <div class="modal-header alert text-center" style="padding: 7px; background: #172B4D;border-radius: 0">
                    <button style="color: #FFFFFF; opacity: 1;font-size: 24px;font-weight: 100;" type="button"
                            class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h5 class="modal-title" style="font-size: 14pt;color: White;">XÁC NHẬN</h5>
                </div>
                <div class="modal-body">
                    <label style="font-size: 14px"><spring:message code="message.modal.authority.delete"/></label>
                </div>
                <div class="modal-footer" style="border: none;text-align: center">
                    <a class="btn btn-light"
                       style="width:135px; border: 1px solid #172B4D;color: #172B4D; border-radius: 8px"
                       data-dismiss="modal">Quay lại
                    </a>
                    <a class="btn btn-secondary"
                       style="width: 136px;background: #172B4D;border-radius: 8px;color: #FFFFFF;border: none"
                       ng-click="deleteAuthority()">Xóa chức năng
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>