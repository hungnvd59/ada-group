app.controller('customerUser', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    //search variable
    $scope.fullName = '';
    $scope.mobile = ''
    $scope.provinceId = -1
    $scope.districtId = -1
    $scope.team = -1

    //object
    $scope.customerDetail = {}

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search();
        }
    });

    $(document).ready(function () {//select 2 multi commune

        $scope.fullName = '';
        $scope.mobile = ''
        $scope.provinceId = -1
        $scope.districtId = -1
        $scope.team = -1

        /*date time handle*/
        // $("#comingDateAdd").datetimepicker({
        //     locale: 'vi-VN', format: 'DD-MM-YYYY', maxDate: d
        // }).on('dp.change', function (e) {
        //     if (e != null) {
        //         $scope.comingDate = $(this).val();
        //     }
        // });
        // $("#leaveDateAdd").datetimepicker({
        //     locale: 'vi-VN', format: 'DD-MM-YYYY', maxDate: d
        // }).on('dp.change', function (e) {
        //     if (e != null) {
        //         $scope.leaveDate = $(this).val();
        //     }
        // });
        $scope.clear();
    });

    $scope.districtListByUser = []
    $scope.provinceList = []
    $(document).ready(function () {
        //region add
        $http.get(preUrl + "/common/getListProvince", {}).then(function (response) {
            $scope.provinceList = response.data
        });
    });

    $scope.onChangeCity = function () {
        $http.get(preUrl + "/common/getDistrictByProvince", {
            params: {
                province: $scope.provinceId
            }
        }).then(function (response) {
            $scope.districtList = response.data
        });
    }

    $scope.clear = function () {
        $scope.fullName = '';
        $scope.mobile = ''
        $scope.provinceId = -1
        $scope.districtId = -1
        $scope.team = -1
    }

    /*SEARCH*/
    $scope.search = function () {
        document.getElementById("data-search").style.display = 'none';
        document.getElementById("loading").style.display = 'block';
        $scope.listData.pageNumber = 1;
        $scope.loadListData();
    }

    $scope.loadListData = function () {
        $http.get(preUrl + "/customer/search", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                fullName: $scope.fullName,
                mobile: $scope.mobile,
                provinceId: $scope.provinceId,
                districtId: $scope.districtId,
                team: $scope.team,
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
            $http.get(preUrl + "/customer/search", {
                params: {
                    pageNumber: pageNumber,
                    numberPerPage: $scope.listData.numberPerPage,
                    fullName: $scope.fullName,
                    mobile: $scope.mobile,
                    provinceId: $scope.provinceId,
                    districtId: $scope.districtId,
                    team: $scope.team,
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
        window.location.href = preUrl + "/customer/export?p=" + $scope.listData.pageNumber
            + "&numberPerPage=" + $scope.listData.numberPerPage
            + "&fullName=" + $scope.fullName
            + "&mobile=" + $scope.mobile
            + "&provinceId=" + $scope.provinceId
            + "&districtId=" + $scope.districtId
            + "&team=" + $scope.team
    }
    //----------------show detail---------------------
    $scope.showDetailCust = function (item) {
        $scope.customerDetail = Object.assign({}, item);
        $http.get(preUrl + "/common/getListProvince", {}).then(function (response) {
            $scope.provinceListDetail = response.data
        });

        $http.get(preUrl + "/common/getDistrictByProvince", {
            params: {
                province: item.provinceId
            }
        }).then(function (response) {
            $scope.districtListDetail = response.data
        });
        $http.get(preUrl + "/common/getWardByDistrict", {
            params: {
                districtId: item.districtId
            }
        }).then(function (response) {
            $scope.wardListDetail = response.data
        });
        $("#mdDetailCustomer").modal("show");
    }

    $scope.changeCityDetail = function (id) {
        $http.get(preUrl + "/common/getDistrictByProvince", {
            params: {
                province: id
            }
        }).then(function (response) {
            $scope.districtListDetail = response.data

        });
    }
    $scope.changeDistrictDetail = function (id) {
        $http.get(preUrl + "/common/getWardByDistrict", {
            params: {
                districtId: id
            }
        }).then(function (response) {
            $scope.wardListDetail = response.data
        });
    }


    $scope.editCustomer = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.customerDetail));
        console.log(requestBody)
        $http.post(preUrl + "/customer/update", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Cập nhật thông tin thành công")
                        $("#mdDetailCustomer").modal("hide");
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

    //----------------DELETE---------------------
    $scope.showDeletePopup = function (item) {
        $scope.customerDelete = Object.assign({}, item);
        $("#mdDetailCustomer").modal("hide");
        $("#mdConfirmDelete").modal("show");
    }
    $scope.deleteCustomer = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.customerDetail));
        console.log(requestBody)
        $http.post(preUrl + "/customer/delete", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Xóa nhân viên thành công")
                        $("#mdConfirmDelete").modal("hide");
                        $scope.search();
                        break;
                    default:
                        toastr.error('Cập nhật thông tin không thành công. Bạn vui lòng thử lại sau');
                        break;
                }
            });
    }

    //----------------ADD---------------------
    $scope.add = {};
    $scope.preAddCust = function () {
        $scope.add.team = -1
        $scope.add.type = -1
        $scope.add.provinceId = -1
        $scope.add.districtId = -1
        $scope.add.wardId = -1
        $http.get(preUrl + "/common/getListProvince", {}).then(function (response) {
            $scope.provinceListAdd = response.data
        });
        $("#mdAddCustomer").modal("show");
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

    $scope.addCustomer = function () {
        if ($scope.validateFormAdd()) {
            var requestBody = JSON.parse(JSON.stringify($scope.add));
            console.log(requestBody)
            $http.post(preUrl + "/customer/add", requestBody)
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 1:
                            toastr.success("Thêm mới nhân viên thành công")
                            $("#mdAddCustomer").modal("hide");
                            $scope.search();
                            break;
                        case -1:
                            toastr.error("Nhân viên đã tồn tại trong hệ thống!")
                            break;
                        default:
                            toastr.error('Thêm mới không thành công. Bạn vui lòng thử lại sau');
                            break;
                    }
                });
        }
    }


    $scope.changeCityAdd = function (id) {
        $http.get(preUrl + "/common/getDistrictByProvince", {
            params: {
                province: id
            }
        }).then(function (response) {
            $scope.districtListAdd = response.data
        });
    }

    $scope.changeDistrictAdd = function (id) {
        $http.get(preUrl + "/common/getWardByDistrict", {
            params: {
                districtId: id
            }
        }).then(function (response) {
            $scope.wardListAdd = response.data
        });
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