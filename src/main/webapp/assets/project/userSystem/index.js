app.controller('userListCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 5, pageNumber: 1, pageList: [], pageCount: 0};

    //search variable
    $scope.username = '';
    $scope.type = -1

    //object
    $scope.userDetail = {}

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search();
        }
    });

    $(document).ready(function () {//select 2 multi commune
        $scope.username = '';
        $scope.type = -1

    });

    /*SEARCH*/
    $scope.search = function () {
        document.getElementById("data-search").style.display = 'none';
        document.getElementById("loading").style.display = 'block';
        $scope.listData.pageNumber = 1;
        $scope.loadListData();
    }

    $scope.loadListData = function () {
        $http.get(preUrl + "/system/user/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                username: $scope.username,
                type: $scope.type

            }
        }).then(function (response) {
            if (response != null && response.status === 200) {
                document.getElementById("data-search").style.display = 'block';
                document.getElementById("loading").style.display = 'none';
                $scope.listData = response.data;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        })
    }

    /*reload page*/
    $scope.loadPageData = function (pageNumber) {
        if (pageNumber >= 1) {
            $http.get(preUrl + "/system/user/search", {
                params: {
                    p: pageNumber,
                    numberPerPage: $scope.listData.numberPerPage,
                    username: $scope.username,
                    type: $scope.type
                }
            }).then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    document.getElementById("data-search").style.display = 'block';
                    document.getElementById("loading").style.display = 'none';
                    $scope.listData = response.data;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            })
        }
    }

    $scope.export = function () {
        window.location.href = preUrl + "/system/user/export?p=" + $scope.listData.pageNumber
            + "&numberPerPage=" + $scope.listData.numberPerPage
            + "&username=" + $scope.username
            + "&type=" + $scope.type
    }
    //----------------show detail---------------------
    $scope.showDetail = function (item) {
        document.getElementById("btn-save").style.display = 'block';
        document.getElementById("btn-loading").style.display = 'none';
        $scope.userDetail = Object.assign({}, item);
        $("#mdDetail").modal("show");
    }

    $scope.editUser = function () {
        document.getElementById("btn-save").style.display = 'none';
        document.getElementById("btn-loading").style.display = 'block';
        var requestBody = JSON.parse(JSON.stringify($scope.userDetail));
        console.log(requestBody)
        $http.post(preUrl + "/system/user/update", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Cập nhật thông tin thành công")
                        document.getElementById("btn-save").style.display = 'block';
                        document.getElementById("btn-loading").style.display = 'none';
                        $("#mdDetail").modal("hide");
                        $scope.search();
                        break;
                    case -1:
                        toastr.error("Cập nhật không thành công!");
                        break;
                    default:
                        toastr.error('Cập nhật thông tin không thành công. Bạn vui lòng thử lại sau');
                        break;
                }
            });
    }
    //----------------UPDATE---------------------


    //----------------RESTORE---------------------
    $scope.restorePass = {};
    $scope.preRestorePass = function (item) {
        document.getElementById("btn-confirm").style.display = 'inline';
        document.getElementById("btn-loadConfirm").style.display = 'none';
        $scope.restorePass = Object.assign({}, item);
        $("#mdRestorePassword").modal("show");
    }

    $scope.restorePassword = function () {
        document.getElementById("btn-confirm").style.display = 'none';
        document.getElementById("btn-loadConfirm").style.display = 'inline';
        var requestBody = JSON.parse(JSON.stringify($scope.restorePass));
        $http.post(preUrl + "/system/user/restore-pass", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Khôi phục mật khẩu thành công")
                        document.getElementById("btn-confirm").style.display = 'inline';
                        document.getElementById("btn-loadConfirm").style.display = 'none';
                        $("#mdRestorePassword").modal("hide");
                        $scope.search();
                        break;
                    default:
                        toastr.error('Cập nhật thông tin không thành công. Bạn vui lòng thử lại sau');
                        break;
                }
            });
    }

    //----------------AUTHORITY--   -------------------
    $scope.authorityUser = {}
    $scope.preAuthority = function (item) {
        $scope.authorityUser = Object.assign({}, item);
        $("#mdAuthority").modal("show");
    }

    $scope.rsValidate = true;
    $scope.validateFormAdd = function () {
        if ($scope.add.fullName == null || $scope.add.fullName === '') {
            document.getElementById("add-fullName").style.border = '1px solid red';
            document.getElementById("fullNameAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.type == null || $scope.add.type === -1) {
            document.getElementById("add-type").style.border = '1px solid red';
            document.getElementById("typeAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.email == null || $scope.add.email === '') {
            document.getElementById("add-email").style.border = '1px solid red';
            document.getElementById("emailAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.email != null && !validateEmail($scope.add.email)) {
            document.getElementById("add-email").style.border = '1px solid red';
            document.getElementById("emailAddFormatErr").style.display = 'block';
            $scope.rsValidate = false
        }

        if ($scope.add.mobile == null || $scope.add.mobile === '') {
            document.getElementById("add-mobile").style.border = '1px solid red';
            document.getElementById("mobileAddErr").style.display = 'block';
        }
        if ($scope.add.provinceId == null || $scope.add.provinceId === -1) {
            document.getElementById("add-provinceId").style.border = '1px solid red';
            document.getElementById("provinceAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.districtId == null || $scope.add.districtId === -1) {
            document.getElementById("add-districtId").style.border = '1px solid red';
            document.getElementById("districtAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.wardId == null || $scope.add.wardId === -1) {
            document.getElementById("add-wardId").style.border = '1px solid red';
            document.getElementById("wardAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.empCode == null || $scope.add.empCode === '') {
            document.getElementById("add-empCode").style.border = '1px solid red';
            document.getElementById("empCodeAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        if ($scope.add.team == null || $scope.add.team === -1) {
            document.getElementById("add-team").style.border = '1px solid red';
            document.getElementById("teamAddErr").style.display = 'block';
            $scope.rsValidate = false
        }
        return $scope.rsValidate;
    }

    $scope.clearFormAdd = function () {
        document.getElementById("add-fullName").style.border = '1px solid #DFE5EF';
        document.getElementById("add-type").style.border = '1px solid #DFE5EF';
        document.getElementById("add-email").style.border = '1px solid #DFE5EF';
        document.getElementById("add-mobile").style.border = '1px solid #DFE5EF';
        document.getElementById("add-provinceId").style.border = '1px solid #DFE5EF';
        document.getElementById("add-districtId").style.border = '1px solid #DFE5EF';
        document.getElementById("add-empCode").style.border = '1px solid #DFE5EF';
        document.getElementById("add-team").style.border = '1px solid #DFE5EF';
        document.getElementById("add-wardId").style.border = '1px solid #DFE5EF';

        document.getElementById("fullNameAddErr").style.display = 'none';
        document.getElementById("typeAddErr").style.display = 'none';
        document.getElementById("emailAddErr").style.display = 'none';
        document.getElementById("emailAddFormatErr").style.display = 'none';
        document.getElementById("provinceAddErr").style.display = 'none';
        document.getElementById("mobileAddErr").style.display = 'none';
        document.getElementById("districtAddErr").style.display = 'none';
        document.getElementById("empCodeAddErr").style.display = 'none';
        document.getElementById("teamAddErr").style.display = 'none';
        document.getElementById("wardAddErr").style.display = 'none';


        $scope.add.fullName = ''
        $scope.add.type = -1
        $scope.add.email = ''
        $scope.add.mobile = ''
        $scope.add.provinceId = -1
        $scope.add.districtId = -1
        $scope.add.wardId = -1
        $scope.add.empCode = ''
        $scope.add.team = -1
    }


    //----------------HELPER---------------------
    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.search();
    }

    $scope.getTypeCtv = function (type) {
        return getTypeCtv(type);
    }
    $scope.getStatusCtv = function (status) {
        return getStatusCtv(status);
    }
    //----------------INIT---------------------
    $scope.search();
}])