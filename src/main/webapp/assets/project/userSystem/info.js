app.controller('userInfoCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 5, pageNumber: 1, pageList: [], pageCount: 0};
    //object
    $scope.userDetail = {}
    $(document).ready(function () {//select 2 multi commune


    });

    $scope.init = function (){
        $http.get(preUrl + "/system/user/getInfo", {}).then(function (response) {
            $scope.userDetail = response.data
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
    $scope.init();
}])