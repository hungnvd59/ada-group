app.controller('packageCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.packCode = "";
    $scope.packName = "";
    $scope.status = -1
    $scope.itemType = "0";
    $scope.titleChangeStatus = "";

    $scope.fromGenDate = "";
    $scope.toGenDate = "";

    $scope.searchOption = "0";
    $scope.type = "-1";
    $scope.loaiGoiCuoc = "-1";
    $scope.giaGoi = "-1";
    $scope.chuKy = "-1";

    $scope.affPackage = {};

    $('#advancedFilter').hide();
    $('#dropDownSim').hide();
    $('#dropDownPackage').hide();
    $('#dropUp').hide();

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search(1);
        }
    });

    var d = new Date();
    $("#fromGenDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD-MM-YYYY',
        maxDate: d
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.fromGenDate = $(this).val();
            if ($('#fromGenDate').val() != "")
                $('#toGenDate').data("DateTimePicker").minDate(moment($('#fromGenDate').val(), "DD-MM-YYYY").toDate());
        }
    });
    $("#toGenDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD-MM-YYYY',
        maxDate: d
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.toGenDate = $(this).val();
            if ($('#toGenDate').val() != "")
                $('#fromGenDate').data("DateTimePicker").maxDate(moment($('#toGenDate').val(), "DD-MM-YYYY").toDate());
        }
    });

    $scope.search = function (pageNumber) {
        $scope.loadListData(pageNumber);
    }

    $scope.loadListData = function (pageNumber) {
        $http.get(preUrl + "/package/search", {
            params: {
                p: pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                packCode: $scope.packCode,
                packName: $scope.packName,
                status: $scope.status,
                fromGenDate: $scope.fromGenDate,
                toGenDate: $scope.toGenDate,
                type: $scope.type,
                loaiGoiCuoc: $scope.loaiGoiCuoc,
                chuKy: $scope.chuKy,
                giaGoi: $scope.giaGoi,
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
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index
        $http.get(preUrl + "/package/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                packCode: $scope.packCode,
                packName: $scope.packName,
                status: $scope.status,
                fromGenDate: $scope.fromGenDate,
                toGenDate: $scope.toGenDate,
                type: $scope.type,
                loaiGoiCuoc: $scope.loaiGoiCuoc,
                chuKy: $scope.chuKy,
                giaGoi: $scope.giaGoi,

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

    $scope.loadPage = function (pageNumber) {
        if (pageNumber >= 1) {
            $scope.search(pageNumber);
        }
    }

    $scope.clear = function () {
        $scope.packCode = "";
        $scope.packName = "";
        $scope.status = -1;
        $scope.fromGenDate = "";
        $scope.toGenDate = "";
        $scope.type = "-1";
        $scope.loaiGoiCuoc = "-1";
        $scope.chuKy = "-1";
        $scope.giaGoi = "-1";
        $("#fromGenDate").val("");
        $("#toGenDate").val("");
        $("#type").select2("val", "-1");
        $("#loaiGoiCuoc").select2("val", "-1");
        $("#chuKy").select2("val", "-1");
        $("#giaGoi").select2("val", "-1");
    };

    $scope.confirmChangeStatus = function (item, flag){
        if(flag == "lock"){
            $scope.titleChangeStatus = 'ẩn hiển thị';
        } else if(flag == "unlock"){
            $scope.titleChangeStatus = 'hiển thị';
        }
        $scope.affPackage = structuredClone(item);
        $('#mdConfirmChangeStatus').modal('show');
    }

    $scope.updateStatusPackage = function (flag) {
        checkSesstionTimeOut();
        if(flag == "lock"){
            $scope.affPackage.status = 0;
        } else if(flag == "unlock"){
            $scope.affPackage.status = 1;
        }
        var requestBody = JSON.parse(JSON.stringify($scope.affPackage));
        $http.post(preUrl + "/package/update", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        if(flag == "lock"){
                            toastr.success("Ẩn hiển thị sản phẩm thành công!")
                        } else if(flag == "unlock"){
                            toastr.success("Hiển thị sản phẩm thành công!")
                        }
                        $('#mdConfirmChangeStatus').modal('hide');
                        $scope.search();
                        break;
                    case 0:
                        toastr.error("Cập nhật trạng thái gói cước thất bại!")
                        $('#mdConfirmChangeStatus').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    $scope.deletePackage = function () {
        checkSesstionTimeOut();
        var requestBody = JSON.parse(JSON.stringify($scope.affPackage));
        $http.post(preUrl + "/package/delete", requestBody)
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        toastr.success("Xóa sản phẩm thành công!")
                        $('#mdConfirmDelete').modal('hide');
                        $scope.search();
                        break;
                    case 0:
                        toastr.error("Xóa sản phẩm thất bại!")
                        $('#mdConfirmDelete').modal('hide');
                        $scope.search();
                        break;
                }
            });
    }

    $scope.formatAmount = function (flag){
        if(flag == 'amount') {
            if (String($scope.affPackage.amount).includes(',')) {
                $scope.affPackage.amount = String($scope.affPackage.amount).replace(/,/g, '');
            }
            $scope.affPackage.amount = $scope.numbersWithComma($scope.affPackage.amount);
        } else if(flag == 'hhOsp'){
            if (String($scope.affPackage.hhOsp).includes(',')) {
                $scope.affPackage.hhOsp = String($scope.affPackage.hhOsp).replace(/,/g, '');
            }
            $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
        }
    }

    $scope.numbersWithComma = function (x) {
        let temp = '';
        if (x != null)
            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return temp;
    }


    $scope.showPopupDetail = function (item) {
        $scope.affPackage = structuredClone(item);
        $scope.affPackage.amount = $scope.numbersWithComma($scope.affPackage.amount);
        $scope.affPackage.hhOsp = $scope.numbersWithComma($scope.affPackage.hhOsp);
        $('#mdDetailPackage').modal('show')
    }

    $scope.showPopupDelete = function (item) {
        $scope.affPackage = structuredClone(item);
        $('#mdConfirmDelete').modal('show')
    }

    $scope.showPopupAdd = function () {
        $scope.affPackage = {};
        $scope.affPackage.status = 1;
        $scope.affPackage.type = -1;
        $scope.affPackage.packType = -1;
        $('#mdDetailPackage').modal('show');
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

    //------------------ TK nâng cao ------------------

    $scope.clearSim = function () {
        $scope.msisdnType = "-1";
        $scope.group_id = "-1";
        $scope.doiTuongGiuSo = "-1";
        $("#msisdnType").select2("val", "-1");
        $("#group_id").select2("val", "-1");
        $("#doiTuongGiuSo").select2("val", "-1");
    };

    $scope.clearPackage = function () {
        $scope.type = "-1";
        $scope.loaiGoiCuoc = "-1";
        $scope.giaGoi = "-1";
        $scope.chuKy = "-1";
        $("#type").select2("val", "-1");
        $("#loaiGoiCuoc").select2("val", "-1");
        $("#giaGoi").select2("val", "-1");
        $("#chuKy").select2("val", "-1");
    };

    const state1 = document.getElementById('itemType');
    const state2 = document.getElementById('searchOption');

    state1.onchange = function (e) {
        state2.value = e.target.value;
        if (e.target.value == -1)
            state2.value = 0;
        if ($scope.checkDropDown == 1)
            $scope.dropDown();
        $scope.itemType = e.target.value;
    };

    state2.onchange = function (e) {
        state1.value = e.target.value;
        $scope.itemType = e.target.value;
    };

    $scope.checkDropDown = 0;
    $scope.dropDown = function () {
        $scope.checkDropDown = 1;
        $('#advancedFilter').show();
        $('#dropUp').show();
        $('#dropDown').hide();
        if (state2.value == 0) {
            $('#dropDownPackage').show();
            $('#dropDownSim').hide();
            $scope.clearSim();
        } else {
            $('#dropDownPackage').hide();
            $('#dropDownSim').show();
            $("#group_id").select2("val", "-1");
            $scope.clearPackage();
        }
    };

    $('#searchOption').change(function () {
        $scope.searchOption = $('#searchOption').val();
        $scope.dropDown();
    });

    $scope.dropUp = function () {
        $scope.checkDropDown = 0;
        $('#dropUp').hide();
        $('#advancedFilter').hide();
        $('#dropDownSim').hide();
        $('#dropDownPackage').hide();
        $('#dropDown').show();
        $scope.checkSearch();
    };

    $scope.checkSearch = function () {
        if ($scope.type == "-1"
            & $scope.loaiGoiCuoc == "-1"
            & $scope.giaGoi == "-1"
            & $scope.chuKy == "-1")
            return 0;
        else return 1;
    }
    //----------------- end TK nâng cao -----------------

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.search(1);
    }

    // -------------------------Init----------------------------
    $scope.search(1);
}]);