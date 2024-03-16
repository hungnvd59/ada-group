app.controller('groupListCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 20, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.filterName = '';

    $(document).keypress(function(event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            $scope.search();
        }
    })

    $scope.loadPageData = function (pageNumber) {
        $http.get(preUrl + "/system/group/search", {
            params: {
                p: pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                filterName: $scope.filterName,
            }
        })
            .then(function (response) {

                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            });
    }


    $scope.deleteObj = {}
    $scope.preDeleteGroup = function (item) {
        $scope.deleteObj = Object.assign({}, item);
        $("#mdDelete").modal("show")
    }

    $scope.deleteGroup = function (item) {
        var requestBody = JSON.parse(JSON.stringify(item));
        $http.post(preUrl + "/system/group/delete", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 1:
                            $scope.search()
                            toastr.info("Xóa nhóm quyền thành công!")
                            $("#mdDelete").modal("hide")
                            break;
                        default:
                            toastr.error('Xóa nhóm quyền không thành công!');
                            break;
                    }
                }
            });
    }
    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.numberPerPage = numberPerPage;
        $scope.search();
    };

    $scope.search = function () {
        $scope.loadPageData(1);
    };

    $scope.redirectDetail = function (id) {
        window.location.replace(preUrl + "/system/group/edit/" + id);
    };

    //=========================== INIT ===========================
    $scope.search();
}]);