app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 25, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.name = "";
    $scope.mobilePartner = "";
    $scope.status = -1;
    $scope.fromDate = "";
    $scope.toDate = "";
    $scope.logs = [];
    $scope.pageNumber = 1;
    $scope.totalPartner = 0;
    $scope.detail = {};
    $scope.create_by = "";
    $scope.gen_date = "";
    $scope.update_by = "";
    $scope.last_updated = "";

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
            $scope.search();
        }
    });

    $scope.search = function () {
        $scope.listData.pageNumber = 1;
        // $scope.fromDate=$("#fromDate").val();
        // $scope.toDate=$("#toDate").val();
        $scope.loadListData(1);
    }

    $scope.loadListData = function (pageNumber) {
        $http.get(preUrl + "/config-contract/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                name: $scope.name,
                mobilePartner: $scope.mobilePartner,
                status: $scope.status,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.totalPartner = $scope.page.items.length;
                    $scope.page.pageCount = getPageCount($scope.listData);
                    $scope.page.pageList = getPageList($scope.listData);
                }
            });
    }

    /*reload page*/
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/config-contract/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                name: $scope.name,
                mobilePartner: $scope.mobilePartner,
                status: $scope.status,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.totalPartner = $scope.page.items.length;
                    $scope.page.pageCount = getPageCount($scope.listData);
                    $scope.page.pageList = getPageList($scope.listData);
                }
            });
    };

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

    //show detail partner
    $scope.showDetailTab = function (item) {
        $scope.detail = item;
    }

    $scope.editConfig = ""

    $scope.preDelete = function (item) {
        $scope.editConfig = item;
        $('#mdDeleteConfig').modal('show');
    }

    $scope.deleteConfig = function (item) {
        $scope.editConfig.id = item.id;
        var requestBody = JSON.parse(JSON.stringify(item));
        $http.post(preUrl + "/config-contract/delete", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        toastr.info("Xóa thành công")
                        $('#mdDeleteConfig').modal('hide');
                        $scope.search(1);
                        break;
                    default:
                        toastr.error('Khóa không thành công. Bạn vui lòng thử lại sau');
                        $('#mdDeleteConfig').modal('hide');
                        $scope.search(1);
                        break;
                }
            });
    }

    $scope.clear = function () {
        $scope.name = "";
        $scope.mobilePartner = "";
        $scope.fromDate = "";
        $scope.toDate = "";
        $("#fromDate").val("");
        $("#toDate").val("");
        $scope.status = -1;
        // $scope.loadPageData(1);
    };

    // -------------------------Init----------------------------
    $scope.search(1);
}]);