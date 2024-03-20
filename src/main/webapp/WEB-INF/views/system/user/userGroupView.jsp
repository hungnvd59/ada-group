<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<%=request.getContextPath()%>/assets/js/checkbox.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/js/nestable/nestable.css" type="text/css" />
<div style="color: #1F2937;" class="panel-body">
    <h5 class="card-title fw-semibold mb-4">Hệ thống chức năng phân quyền</h5>
    <div style="color: #1F2937;" class="col-sm-12">
        <div class="dd" id="nestableGroup">
            <ol class="dd-list">
                <c:forEach var="group" items="${groups}" varStatus="stat">        
                    <div >              
                        <li class="dd-item" data-id="${group.parent.id}">
                            <div style="font-weight: 700" class="dd-handle font-bold">${group.parent.description}</div>
                            <ol class="dd-list">
                                <c:forEach var="children" items="${group.childrens}" varStatus="start">
                                    <li class="dd-item" data-id="${children.id}"><div class="dd-handle">${start.count}. ${children.description}</div></li>
                                    </c:forEach>
                            </ol>
                        </li>        
                    </div>
                </c:forEach> 
            </ol>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/nestable/jquery.nestable.js"></script>
<script>
    $(document).ready(function () {
        // activate Nestable for class #nestableGroup
        $('#nestableGroup').nestable({
        });

        var $expandAll = false;
        $('#nestable-menu').on('click', function (e)
        {
            if ($expandAll) {
                $expandAll = false;
                $('.dd').nestable('expandAll');
            } else {
                $expandAll = true;
                $('.dd').nestable('collapseAll');
            }
        });

        $('.dd').nestable('collapseAll');

    });
</script>