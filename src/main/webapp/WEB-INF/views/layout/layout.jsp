<%@ page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8"/>
    <title><tiles:insertAttribute name="title"/></title>
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/logos/favicon.png"/>
    <meta name="description" content="ada-group"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script src="<%=request.getContextPath()%>/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/sidebarmenu.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/app.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/libs/simplebar/dist/simplebar.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/libs/moment.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/js/toastr/toastr.min.css" type="text/css"/>
    <script src="<%= request.getContextPath()%>/assets/js/toastr/toastr.min.js"></script>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/angularjs/autocomplete/autocomplete.css"
          type="text/css"/>
    <script src="<%=request.getContextPath()%>/assets/angularjs/angular.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/angularjs/angular-sanitize.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/project/common.js"></script>
    <script src="<%=request.getContextPath()%>/assets/project/CommonFunction.js"></script>
    <script src="<%=request.getContextPath()%>/assets/angularjs/autocomplete/autocomplete.js"></script>


    <script>
        var preUrl = '<%=request.getContextPath()%>';
    </script>
</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
     data-sidebar-position="fixed" data-header-position="fixed">
    <section class="vbox">
        <section>
            <section class="hbox stretch">
                <tiles:insertAttribute name="leftpanel"/>
                <div class="body-wrapper">
                    <tiles:insertAttribute name="header"/>
                    <tiles:insertAttribute name="page"/>
                </div>
            </section>
        </section>
    </section>
</div>
</body>
</html>
<script>
    $(document).ready(function () {
        $('ol li a').click(function () {
            $('ol li a.active-1').removeClass('active-1');
            $('ol li a.active-1').addClass('font-weight-bold');
            $(this).closest('a').addClass('active-1');
        });
    });
</script>
