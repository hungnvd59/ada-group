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

    /*region handle*/
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

    $scope.search = function () {
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
                    $scope.listData = response.data;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            })
        }
    }

    $scope.export = function () {
        window.location.href = preUrl + "/customer/export?p=" + $scope.listData.pageNumber + "&numberPerPage=" + $scope.listData.numberPerPage + "&fullName=" + $scope.fullName + "&mobile=" + $scope.mobile + "&typeCtv=" + $scope.typeCtv + "&status=" + $scope.status + "&idNumber=" + $scope.idNumber + "&statusVerify=" + $scope.statusVerify + "&superiorName=" + $scope.superiorName + "&provinceId=" + $scope.provinceId + "&districtId=" + $scope.districtId + "&comingDate=" + $scope.comingDate + "&leaveDate=" + $scope.leaveDate;
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

    $scope.editCustomer = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.customerDetail));
        console.log(requestBody)
        $http.post(preUrl + "/customer/update", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.info("Cập nhật thông tin thành công")
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
                        toastr.info("Xóa nhân viên thành công")
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
        $http.get(preUrl + "/common/getListProvince", {}).then(function (response) {
            $scope.provinceListAdd = response.data
        });
        $("#mdAddCustomer").modal("show");
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
    //----------------LOCK/UNLOCK/DELETE---------------------
    $scope.userLock = {}
    $scope.userUnLock = {}
    $scope.userDelete = {}
    $scope.preLockPartner = function (user) {
        $scope.userLock = Object.assign({}, user);
        $("#mdLockUser").modal("show");
    }
    $scope.preUnLockPartner = function (user) {
        $scope.userUnLock = Object.assign({}, user);
        $("#mdUnLockUser").modal("show");
    }
    $scope.preDeletePartner = function (user) {
        $scope.userDelete = Object.assign({}, user);
        $("#mdDeleteUser").modal("show");
    }

    $scope.lockUser = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userLock));
        $http.post(preUrl + "/system/user/lock-user", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 1:
                            toastr.success("Khóa tài khoản thành công!")
                            $scope.search()
                            $("#mdLockUser").modal("hide");
                            break;
                        default:
                            toastr.error('Khóa tài khoản không thành công!');
                            break;
                    }
                }
            });
    }

    $scope.unLockUser = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userUnLock));
        $http.post(preUrl + "/system/user/unLock-user", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 1:
                            $scope.search()
                            toastr.success("Mở khóa tài khoản thành công!")
                            $("#mdUnLockUser").modal("hide");
                            break;
                        default:
                            toastr.error('Mở khóa tài khoản không thành công!');
                            break;
                    }
                }
            });
    }

    $scope.deleteUserF = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userDelete));
        $http.post(preUrl + "/ctv/user/deletePartner", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 0:
                            $scope.search()
                            toastr.success("Xóa tài khoản thành công!")
                            $("#mdDeleteUser").modal("hide");
                            break;
                        default:
                            toastr.error('Xóa tài khoản thất bại!');
                            break;
                    }
                }
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