app.controller('systemParametersCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 20, pageNumber: 1, pageList: [], pageCount: 0};
    $scope.paramKey = '';
    $scope.detailObj = {};

    $(document).keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            $scope.search();
        }
    })

    $scope.clean = function () {
        $scope.paramKey = '';
    }

    $scope.search = function () {
        $scope.loadPageData(1);
    };

    /*reload page*/
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/system/parameters/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                paramKey: $scope.paramKey
            }
        }).then(function (response) {
            if (response != null && response.status == 200) {
                $scope.listData = response.data;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        });
    };

    $scope.showDetail = function (item) {
        $scope.detailObj = structuredClone(item);
        $("#detailObjValue").css("border", "1px solid #E5E7EB")
        $("#detailParametersValueErr").css("display", "none")
        $('#mdDetailParameters').modal('show');
    };

    $scope.updateParameters = function () {
        if ($scope.validateFormEdit()) {
            const updateParameter = JSON.parse(JSON.stringify($scope.detailObj));
            $http.post(preUrl + "/system/parameters/update", updateParameter)
                .then(function (response) {
                    if (response != null && response.status == 200) {
                        switch (Number(response.data)) {
                            case 1:
                                toastr.success("Cập nhật thành công!");
                                $('#mdDetailParameters').modal('hide');
                                $scope.search();
                                break;
                            case -1:
                                toastr.error("Có lỗi xảy ra trong quá trình xử lý!");
                                break;
                            default:
                                toastr.error("Có lỗi xảy ra trong quá trình xử lý!");
                                break;
                        }
                    }
                });
        }
    }

    $scope.resultValidate = true;
    $scope.validateFormEdit = function () {
        $scope.resultValidate = true;
        if ($scope.detailObj.value == null || $scope.detailObj.value == "") {
            $("#detailObjValue").css("border", "1px solid #ff0000")
            document.getElementById("detailParametersValueErr").style.display = "block"
            $scope.resultValidate = false;
        }
        return $scope.resultValidate;
    }

    $scope.changeInput = function (key) {
        switch (key) {
            case 'detailParametersValueErr':
                $("#detailObjValue").css("border", "1px solid #E5E7EB")
                document.getElementById("detailParametersValueErr").style.display = "none"
                break
            default:
                break;
        }
    }

    //=========================init===============================
    $scope.search();
}]);