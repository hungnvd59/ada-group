app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {
        items: "",
        rowCount: 0,
        numberPerPage: $scope.numberPerPage,
        pageNumber: 1,
        pageList: [],
        pageCount: 0
    };

    $scope.mobile = "";
    $scope.status = -1;
    $scope.fromDate = "";
    $scope.toDate = "";
    $scope.logs = [];
    $scope.pageNumber = 1;
    $scope.totalPartner = 0;
    $scope.detail = {};

    $scope.editPartner = "";
    $scope.numberPerPage = 5;

    $scope.searchFlag = false;

    $("#fromDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD-MM-YYYY',
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-chevron-up",
            down: "fa fa-chevron-down",
            previous: 'fa fa-chevron-left',
            next: 'fa fa-chevron-right',
            today: 'fa fa-screenshot',
            clear: 'fa fa-trash',
            close: 'fa fa-remove'
        }
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.fromDate = $(this).val();
        }
    })

    $("#toDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD-MM-YYYY',
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-chevron-up",
            down: "fa fa-chevron-down",
            previous: 'fa fa-chevron-left',
            next: 'fa fa-chevron-right',
            today: 'fa fa-screenshot',
            clear: 'fa fa-trash',
            close: 'fa fa-remove'
        }
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.toDate = $(this).val();
        }
    });

    // $(document).ready(function () {
    //
    // });

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search(1);
        }
    });


    $scope.search = function (key) {
        $scope.listData.pageNumber = 1;
        // $scope.fromDate=$("#fromDate").val();
        // $scope.toDate=$("#toDate").val();
        if (key != null && 0 == Number(key)) {
            $scope.loadListData(0);
        } else {
            $scope.loadListData(1);
        }
    }

    $scope.loadListData = function (key) {
        if (1 == Number(key)) {
            $scope.searchFlag = true;
        }
        console.log("SEARCH FLAG: " + $scope.searchFlag);
        $http.get(preUrl + "/partner/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                mobile: $scope.mobile,
                status: $scope.status,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listData = response.data;
                $scope.totalPartner = $scope.listData.items.length;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        });
    }

    /*reload page*/
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/partner/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                mobile: $scope.mobile,
                status: $scope.status,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.totalPartner = $scope.listData.items.length;
                    $scope.page.pageCount = getPageCount($scope.page);
                    $scope.page.pageList = getPageList($scope.page);
                }
            });
    };

    $scope.preConfirm = function (item) {
        $scope.editPartner = item;
        $('#mdConfirmPartner').modal('show');
    }

    $scope.preBlock = function (item) {
        $scope.editPartner = item;
        $('#mdBlockPartner').modal('show');
    }

    $scope.preDelete = function (item) {
        $scope.editPartner = item;
        $('#mdDeletePartner').modal('show');
    }
    $scope.restoreObj = {}
    $scope.preRestorePass = function (item) {
        $scope.restoreObj = item;
        $('#mdRestorePass').modal('show');
    }

    ///
    $scope.restorePass = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.restoreObj));
        $http.post(preUrl + "/partner/restore-password", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        toastr.success("Khôi phục mật khẩu thành công!")
                        $('#mdRestorePass').modal('hide');
                        $scope.search();
                        break;
                    default:
                        toastr.error('Khôi phục mật khẩu thất bại!');
                        $('#mdRestorePass').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    $scope.deletePartner = function (item) {
        $scope.editPartner.id = item.id;
        var requestBody = JSON.parse(JSON.stringify(item));
        $http.post(preUrl + "/partner/delete", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        toastr.info("Xóa thành công")
                        $('#mdDeletePartner').modal('hide');
                        $scope.search();
                        break;
                    default:
                        toastr.error('Xóa không thành công. Bạn vui lòng thử lại sau');
                        0
                        $('#mdDeletePartner').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    $scope.blockPartner = function (item) {
        $scope.editPartner.id = item.id;
        var requestBody = JSON.parse(JSON.stringify(item));
        $http.post(preUrl + "/partner/block", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        toastr.info("Cập nhật thông tin thành công!")
                        $('#mdBlockPartner').modal('hide');
                        $scope.search();
                        break;
                    default:
                        toastr.error('Cập nhật thông tin không thành công. Bạn vui lòng thử lại sau!');
                        $('#mdBlockPartner').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    $scope.activePartner = function (item) {
        $scope.editPartner.id = item.id;
        var requestBody = JSON.parse(JSON.stringify(item));
        $http.post(preUrl + "/partner/confirm", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        toastr.info("Cập nhật thông tin thành công!")
                        $('#mdConfirmPartner').modal('hide');
                        $scope.search();
                        break;
                    default:
                        toastr.error('Cập nhật thông tin không thành công. Bạn vui lòng thử lại sau!');
                        $('#mdConfirmPartner').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    //show detail partner
    $scope.showDetailTab = function (item) {
        $scope.detail = item;
    }

    $scope.loadPage = function (pageNumber) {
        if (pageNumber >= 1) {
            $scope.search(pageNumber);
        }
    }

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.search(0);
    }

    $scope.clear = function () {
        $scope.mobile = "";
        $scope.toDate = "";
        $scope.fromDate = "";
        $scope.status = -1;
        $("#status").select2("val", -1);
    };

    $scope.export = function () {
        checkSesstionTimeOut();
        window.location.href = preUrl + "/partner/export?p=" + $scope.listData.pageNumber
            + "&numberPerPage=" + $scope.listData.numberPerPage
            + "&mobile=" + $scope.mobile
            + "&status=" + $scope.status
            + "&fromDate=" + $scope.fromDate
            + "&toDate=" + $scope.toDate
            + "&searchFlag=" + $scope.searchFlag;
    }

    function checkSesstionTimeOut() {
        $.ajax({
            method: "GET",
            url: preUrl + "/common/checkSession",
            success: function (respData) {
                if (respData === '1')
                    location.href = preUrl + "/login";
            }
        });
    }

    // -------------------------Init----------------------------
    $scope.listData.pageNumber = 1;
    $scope.loadListData(0);
}]);