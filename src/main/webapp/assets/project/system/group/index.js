app.controller('contentCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.filterName = '';

    $scope.loadListData = function (pageNumber) {
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

    //=========================== INIT ===========================
    $scope.loadListData(1);
}]);