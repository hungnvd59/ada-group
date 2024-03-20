<%@ page isELIgnored="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en" class="bg-dark">
<head>
    <meta charset="utf-8"/>
    <title>Error</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
</head>
<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/assets/images/logos/favicon.png"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.min.css"/>
<body class="">
<style>
    .navbar-brand img {
        max-height: 50px;
    }
</style>
<section id="content" class="m-t-lg wrapper-md animated fadeInUp">
    <div id="main-wrapper">
        <div class="position-relative overflow-hidden min-vh-100 w-100 d-flex align-items-center justify-content-center">
            <div class="d-flex align-items-center justify-content-center w-100">
                <div class="row justify-content-center w-100">
                    <div class="col-lg-4">
                        <div class="text-center">
                            <img src="<%=request.getContextPath()%>/assets/images/backgrounds/errorimg.svg" alt=""
                                 class="img-fluid" width="500">
                            <h1 class="fw-semibold mb-7 fs-9">Error</h1>
                            <h4 class="fw-semibold mb-7">Trang bạn chọn có vẻ không tồn tại!</h4>
                            <a class="btn btn-warning"
                               href="<%=request.getContextPath()%>/" role="button">Trở về trang chủ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


</body>
</html>