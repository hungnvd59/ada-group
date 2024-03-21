app.controller('userInfoCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 5, pageNumber: 1, pageList: [], pageCount: 0};
    //object
    $scope.userDetail = {}

    $scope.passOld = ''
    $scope.passNew = ''
    $scope.rePassNew = ''
    $(document).ready(function () {
        $scope.init();

    });

    $scope.init = function () {
        $http.get(preUrl + "/system/user/getInfo", {}).then(function (response) {
            $scope.userDetail = response.data
        });
    }

    $scope.dto = {}
    $scope.changePass = function () {
        if ($scope.passNew != '' && $scope.passOld != ''  &&$scope.rePassNew != ''){
            document.getElementById("btn-changePass").style.display = 'none';
            document.getElementById("btn-loading").style.display = 'block';
            $scope.dto.passwordNew = $scope.passNew
            $scope.dto.passwordCurrent = $scope.passOld
            var requestBody = JSON.parse(JSON.stringify($scope.dto));
            console.log(requestBody)
            $http.post(preUrl + "/system/info/change-my-pass", requestBody)
                .then(function (response) {
                    if (response != null && response != 'underfined' && response.status == 200) {
                        switch (response.data) {
                            case 1:
                                toastr.success("Đổi mật khẩu thành công!")
                                document.getElementById("btn-changePass").style.display = 'block';
                                document.getElementById("btn-loading").style.display = 'none';
                                break
                            case 2:
                                toastr.error("Mật khẩu không đúng với mật khẩu hiện tại!")
                                break
                            default:
                                toastr.error("Có lỗi xảy ra, hãy thử lại sau!")
                                break
                        }

                    } else {
                        toastr.error("Có lỗi xảy ra, hãy thử lại sau!")
                    }
                    document.getElementById("btn-changePass").style.display = 'block';
                    document.getElementById("btn-loading").style.display = 'none';
                }, function (response) {
                    toastr.error("Có lỗi xảy ra, hãy thử lại sau!")
                });
        }
    }

    $scope.editUser = function () {
        document.getElementById("btn-save").style.display = 'none';
        document.getElementById("btn-loading-change").style.display = 'block';
        var requestBody = JSON.parse(JSON.stringify($scope.userDetail));
        console.log(requestBody)
        $http.post(preUrl + "/system/user/update", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Cập nhật thông tin thành công")
                        document.getElementById("btn-save").style.display = 'block';
                        document.getElementById("btn-loading-change").style.display = 'none';
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
                document.getElementById("btn-save").style.display = 'block';
                document.getElementById("btn-loading-change").style.display = 'none';
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