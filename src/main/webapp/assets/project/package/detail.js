app.controller('packageCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.affPackage = {};
    $scope.affPackage.id = location.search.split('id=')[1];

    $scope.search = function () {
        $http.get(preUrl + "/package/detail", {
            params: {
                id: $scope.affPackage.id,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined') {
                    $scope.affPackage = response.data;
                    if($scope.affPackage != null){
                        $scope.affPackage.amount = $scope.numbersWithComma($scope.affPackage.amount);
                        $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
                    }
                }
            });
    }

    $scope.updatePackage = function () {
        checkSesstionTimeOut();
        if($scope.validatePackage()) {
            if (String($scope.affPackage.amount).includes(',')) {
                $scope.affPackage.amount = String($scope.affPackage.amount).replace(/,/g, '');
            }
            if (String($scope.affPackage.hhOsp).includes(',')) {
                $scope.affPackage.hhOsp = String($scope.affPackage.hhOsp).replace(/,/g, '');
            }
            var requestBody = JSON.parse(JSON.stringify($scope.affPackage));
            $http.post(preUrl + "/package/update", requestBody)
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 1:
                            toastr.success("Cập nhật sản phẩm thành công!")
                            setTimeout(function (){
                                window.location.replace(preUrl + "/package/index.html");
                            }, 1000);
                            break;
                        case 0:
                            toastr.error("Cập nhật sản phẩm thất bại!")
                            break;
                    }
                });
        }
    }

    $scope.formatAmount = function (flag){
        if(flag == 'amount') {
            if (String($scope.affPackage.amount).includes(',')) {
                $scope.affPackage.amount = String($scope.affPackage.amount).replace(/,/g, '');
            }
            $scope.affPackage.hhOsp = ($scope.affPackage.amount * $scope.affPackage.ratioValue) / 100;
            $scope.affPackage.amount = $scope.numbersWithComma($scope.affPackage.amount);
            $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
        } else if(flag == 'hhOsp'){
            if (String($scope.affPackage.hhOsp).includes(',')) {
                $scope.affPackage.hhOsp = String($scope.affPackage.hhOsp).replace(/,/g, '');
            }
            $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
        } else if(flag == 'ratioValue') {
            if($scope.affPackage.ratioValue == null || $scope.affPackage.ratioValue == ""){
                $scope.affPackage.ratioValue = 0;
            }else if($scope.affPackage.ratioValue > 100){
                $scope.affPackage.ratioValue = 100;
            }
            if (String($scope.affPackage.amount).includes(',')) {
                $scope.affPackage.amount = String($scope.affPackage.amount).replace(/,/g, '');
            }
            $scope.affPackage.hhOsp = ($scope.affPackage.amount * $scope.affPackage.ratioValue) / 100;
            $scope.affPackage.amount = $scope.numbersWithComma($scope.affPackage.amount);
            $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
        }
    }

    $scope.numbersWithComma = function (x) {
        let temp = '';
        if (x != null)
            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return temp;
    }

    $scope.validatePackage = function (){
        if($scope.affPackage.packCode == null || $scope.affPackage.packCode == ''){
            toastr.error("Mã sản phẩm không được để trống");
            $("#affPackage_packCode").focus();
            return false;
        } else if($scope.affPackage.packName == null || $scope.affPackage.packName == ''){
            toastr.error("Tên gói cước không được để trống");
            $("#affPackage_packName").focus();
            return false;
        } else if($scope.affPackage.type == -1){
            toastr.error("Chưa chọn loại Telco");
            $("#affPackage_type").focus();
            return false;
        } else if($scope.affPackage.amount == null || $scope.affPackage.amount == ''){
            toastr.error("Giá gói không được để trống");
            $("#affPackage_amount").focus();
            return false;
        } else if($scope.affPackage.amount <= 0){
            toastr.error("Giá gói phải lớn hơn 0");
            $("#affPackage_amount").focus();
            return false;
        } else if($scope.affPackage.packType == -1){
            toastr.error("Chưa chọn loại gói cước");
            $("#affPackage_packType").focus();
            return false;
        } else if($scope.affPackage.ratioValue == null || $scope.affPackage.ratioValue == ''){
            toastr.error("Tỷ lệ hoa hồng OSP không được để trống");
            $("#affPackage_ratioValue").focus();
            return false;
        } else if($scope.affPackage.numExpired == -1){
            toastr.error("Chưa chọn chu kỳ");
            $("#affPackage_numExpired").focus();
            return false;
        } else if($scope.affPackage.status != 0 && $scope.affPackage.status != 1){
            toastr.error("Chưa chọn loại trạng thái");
            $("#affPackage_status").focus();
            return false;
        } else if($scope.affPackage.hhOsp == null || $scope.affPackage.hhOsp == ''){
            toastr.error("Hoa hồng OSP không được để trống");
            $("#affPackage_hhOsp").focus();
            return false;
        } else if($scope.affPackage.packInfo == null || $scope.affPackage.packInfo == ''){
            toastr.error("Mô tả sản phẩm không được để trống");
            $("#affPackage_packInfo").focus();
            return false;
        } else {
            return true;
        }
    }

    $scope.numbersWithDots = function (x) {
        let temp = '';
        if (x != null)
            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        return temp;
    }

    $( "#affPackage_packCode" ).bind( "input", function() {
        $("#affPackage_packCode").val($("#affPackage_packCode").val().trim().toUpperCase());
    });

    // -------------------------Init----------------------------
    $scope.search();
}]);