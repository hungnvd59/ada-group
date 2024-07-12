 <%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<title><spring:message code="label.edit.info.account"/></title>
<section style="color: #1F2937;" id="content">
    <section class="vbox">
        <section class="scrollable padder" style="background: white">
            <ul class="bg-white breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<%=request.getContextPath()%>/"><i class="fa fa-home"></i>&nbsp;<spring:message code="label.system.home"></spring:message></a></li>
                <li><a href="#"><spring:message code="label.user"></spring:message></a></li>
                <li><a href="#"><spring:message code="label.edit.info"></spring:message></a></li>
                
                <li><a href="javascript:void(0)"></a></li>
            </ul>
            <c:if test="${messageError != null}">
                <div class="m-b-md">
                    <span style="color:red"><spring:message code="${messageError}"/></span>
                </div>
            </c:if>
            <section class="panel panel-default" style="border-radius: 20px;">
                <header class="panel-heading" style="border-top-right-radius: 20px;border-top-left-radius: 20px;"><h4><spring:message code="label.edit.info.account"></spring:message> <code>${item.username}</code></h4></header>
                <div class="panel-body">
                    <form method="post" action="<%=request.getContextPath()%>/system/user/edit"  enctype="multipart/form-data" class="form-horizontal"
                          name="myForm" onsubmit="return validateForm()" required>
                        <div class="form-group">
                            <div class="col-sm-10">
                                <div class="input-group m-b">
                                    <input type="hidden" name="id"  value="${item.id}" class="form-control"/>
                                    <input type="hidden" name="username"  value="${item.username}" class="form-control"/>
                                    <input type="hidden" name="password"  value="${item.password}" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div >
                            <label class="col-sm-2 control-label" style="line-height: 30px"><spring:message code="label.user.fullname"/><span style="color: red">*</span></label>
                            <div class="col-sm-10">
                                <div class="input-group m-b col-sm-4">
                                    <span class="input-group-addon">
                                        <i class="fa fa-envelope" style="font-size: 11px" aria-hidden="true"></i>
                                    </span>
                                    <input style="border-top-right-radius: 10px; border-bottom-right-radius: 10px" name="fullName" id="fullName" placeholder="<spring:message code="label.user.fullname"/>" value="${item.fullName}" style="width:100%;" class="form-control" maxlength="50"/>
                                </div>
                                <form:errors style="color: red" path="user.fullName" />
                            </div>
                        </div>
                        <div class="line line-dashed line-lg pull-in"></div>
                        <div>
                            <label class="col-sm-2 control-label"><spring:message code="label.system.parameter.description"/></label>
                            <div class="col-sm-10">
                                <div class="input-group m-b col-sm-4">
                                    <span class="input-group-addon">
                                        <i class="fa fa-pencil" aria-hidden="true" style="font-size: 10px"></i>
                                    </span>

                                    <input style="border-top-right-radius: 10px; border-bottom-right-radius: 10px" name="description" value="${item.description}" maxlength="200" style="width:100%;" placeholder="<spring:message code="label.system.parameter.description"/>" class="form-control" />
                                </div>

                            </div>
                        </div>


                        <div class="line line-dashed line-lg pull-in" style="clear:both ;margin-bottom: 30px"></div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-5">
                                <a style="border-radius: 10px; color: #282424; border-color: #282424" href="<%=request.getContextPath()%>/system/user/list" class="btn"><i class="fa fa-times"></i> <spring:message code="message.modal.cancel"/></a>
<%--                                <button style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4" type="submit" data-loading-text="Cập nhật" class="btn"><i class="fa fa-save"></i> <spring:message code="label.button.update"/></button>--%>
                                <button type="submit" style="border-radius: 10px; color: #0c63e4; border-color: #0c63e4" class="btn"><i class="fa fa-save"></i> Cập nhật</button>
                            </div>
                        </div>
                    </form>

                </div>
            </section>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
<script>
    function validateForm() {
        if (document.forms["myForm"]["fullName"].value == "") {
            toastr.error('Chưa nhập họ và tên');
            document.getElementById("fullName").focus();
            return false;
        }
    }
</script>
