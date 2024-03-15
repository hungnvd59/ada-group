app.controller('transactionCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.itemType = "-1";
    $scope.itemName = "";
    $scope.msisdnContact = "";
    $scope.mobile = "";
    $scope.status = "-1";
    $scope.type = "-1";
    $scope.transCode = "";
    $scope.searchOption = "0";
    $scope.fromGenDate = "";
    $scope.toGenDate = "";

    $scope.msisdnType = "-1";
    $scope.group_id = "-1";
    $scope.doiTuongGiuSo = "-1";

    $scope.loaiGoiCuoc = "-1";
    $scope.giaGoi = "-1";
    $scope.chuKy = "-1";

    $scope.detailSim = {};
    $scope.detailPackage = {};
    $scope.detailApi = {};
    $scope.groupMsisdn = [];

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
    // $(document).ready(function () {
    // //datetimepicker
    // });

    $scope.search = function (pageNumber) {
        $scope.loadListData(pageNumber);
    }

    $scope.loadListData = function (pageNumber) {
        $http.get(preUrl + "/transaction/search", {
            params: {
                p: pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                itemType: $scope.itemType,
                itemName: $scope.itemName,
                msisdnContact: $scope.msisdnContact,
                mobile: $scope.mobile,
                status: $scope.status,
                type: $scope.type,
                transCode: $scope.transCode,
                fromGenDate: $scope.fromGenDate,
                toGenDate: $scope.toGenDate,

                msisdnType: $scope.msisdnType,
                group_id: $scope.group_id,
                doiTuongGiuSo: $scope.doiTuongGiuSo,

                loaiGoiCuoc: $scope.loaiGoiCuoc,
                giaGoi: $scope.giaGoi,
                chuKy: $scope.chuKy,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.totalTransaction = $scope.listData.items.length;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            });
    }
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index
        $http.get(preUrl + "/transaction/search", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                itemType: $scope.itemType,
                itemName: $scope.itemName,
                msisdnContact: $scope.msisdnContact,
                mobile: $scope.mobile,
                status: $scope.status,
                type: $scope.type,
                transCode: $scope.transCode,
                fromGenDate: $scope.fromGenDate,
                toGenDate: $scope.toGenDate,

                msisdnType: $scope.msisdnType,
                group_id: $scope.group_id,
                doiTuongGiuSo: $scope.doiTuongGiuSo,

                loaiGoiCuoc: $scope.loaiGoiCuoc,
                giaGoi: $scope.giaGoi,
                chuKy: $scope.chuKy,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.totalTransaction = $scope.listData.items.length;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            });
    }

    //show detail
    $scope.showDetailTab = function (item) {
        $scope.detail = item;
    }

    $scope.loadPage = function (pageNumber) {
        if (pageNumber >= 1) {
            $scope.search(pageNumber);
        }
    }

    $scope.clear = function () {
        $scope.itemType = "-1";
        $scope.itemName = "";
        $scope.msisdnContact = "";
        $scope.mobile = "";
        $scope.transCode = "";
        $scope.fromGenDate = "";
        $scope.toGenDate = "";
        $scope.status = "-1";
        $scope.type = "-1";
        $("#itemType").select2("val", "-1");
        $("#status").select2("val", "-1");
        $("#type").select2("val", "-1");
        $("#fromGenDate").val("");
        $("#toGenDate").val("");

        $scope.clearSim();
        $scope.clearPackage();
    };

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
        if ($scope.msisdnType == "-1"
            & $scope.group_id == "-1"
            & $scope.doiTuongGiuSo == "-1"
            & $scope.type == "-1"
            & $scope.loaiGoiCuoc == "-1"
            & $scope.giaGoi == "-1"
            & $scope.chuKy == "-1")
            return 0;
        else return 1;
    }

    $scope.getStatus = function (status) {
        let statusStr = "";
        switch (status) {
            case 0:
            case 1:
            case 2:
                statusStr = "Thất bại";
                break;
            case 3:
                statusStr = "Thành công";
                break;
            case 4:
            case 5:
            case 7:
                statusStr = "Chưa đủ điều kiện";
                break;
            case 6:
                statusStr = "Đủ điều kiện";
                break;
            default:
                statusStr = "-";
                break;
        }
        return statusStr;
    };

    $scope.getStatusSim = function (status) {
        let statusStr = "";
        switch (status) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 7:
                statusStr = "Chờ xử lý";
                break;
            case 6:
                statusStr = "Đã hòa mạng";
                break;
            default:
                statusStr = "-";
                break;
        }
        return statusStr;
    };

    $scope.getShareType = function (shareType) {
        let shareTypeStr = "";
        switch (shareType) {
            case 0:
                shareTypeStr = "Hoa hồng phát triển thuê bao trả trước";
                break;
            case 1:
                shareTypeStr = "Hoa hồng phát triển thuê bao trả sau";
                break;
            case 2:
                shareTypeStr = "Hoa hồng đăng ký gói cước";
                break;
            default:
                shareTypeStr = "-";
                break;
        }
        return shareTypeStr;
    };

    $scope.getItemType = function (itemType) {
        let itemTypeStr = "";
        switch (itemType) {
            case 'SIMSO':
                itemTypeStr = "Sim số";
                break;
            case 'GOICUOC':
                itemTypeStr = "Gói cước";
                break;
            default:
                itemTypeStr = "-";
                break;
        }
        return itemTypeStr;
    };

    $scope.getPackageType = function (type) {
        let typeStr = "";
        switch (type) {
            case 0:
                typeStr = "MobiFone";
                break;
            case 1:
                typeStr = "Viettel";
                break;
            case 2:
                typeStr = "Reddi";
                break;
            case 3:
                typeStr = "Vinaphone";
                break;
            default:
                typeStr = "-";
                break;
        }
        return typeStr;
    };

    $scope.getSimType = function (type) {
        let typeStr = "";
        switch (type) {
            case 0:
                typeStr = "Chọn số";
                break;
            case 1:
                typeStr = "Viettel";
                break;
            case 2:
                typeStr = "Reddi";
                break;
            case 3:
                typeStr = "Vinaphone";
                break;
            default:
                typeStr = "-";
                break;
        }
        return typeStr;
    };

    $scope.getStatusPackage = function (status) {
        let statusStr = "";
        switch (status) {
            case 0:
            case 1:
            case 2:
            case 4:
            case 5:
            case 6:
            case 7:
                statusStr = "Thất bại";
                break;
            case 3:
                statusStr = "Thành công";
                break;
            default:
                statusStr = "-";
                break;
        }
        return statusStr;
    };

    $scope.getReviewStatus = function (reviewStatus) {
        let reviewStatusStr = "";
        switch (reviewStatus) {
            case 0:
                reviewStatusStr = "Chưa đối soát";
                break;
            case 1:
                reviewStatusStr = "Đã đối soát nhưng không ghi nhận";
                break;
            case 2:
                reviewStatusStr = "Đã đối soát";
                break;
            default:
                reviewStatusStr = "-";
                break;
        }
        return reviewStatusStr;
    };

    $scope.showPopupDetail = function (item) {
        $scope.getDetailTransaction(item);
        $scope.getDetailAPi(item);

    };

    $scope.getGroupMsisdn = function () {
        $http.get(preUrl + "/transaction/getGroupMsisdn")
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.groupMsisdn = response.data;
                }
            });
    }

    $scope.getDtailGroupMsisdn = function (group_id) {
        let gName = '-';
        angular.forEach($scope.groupMsisdn, function (value, index) {
            if (group_id == value.id)
                gName = value.groupName;
        })
        return gName;
    }

    $scope.getDetailTransaction = function (item) {
        $http.get(preUrl + "/transaction/detail", {
            params: {
                itemType: item.item_type,
                transCode: item.trans_code,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    if (item.item_type == 'SIMSO') {
                        $scope.detailSim = response.data;
                    } else {
                        $scope.detailPackage = response.data;
                    }
                }

            });
    }

    $scope.getDetailAPi = function (item) {
        $http.get(preUrl + "/transaction/detailApi", {
            params: {
                itemType: item.item_type,
                transCode: item.trans_code,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.detailApi = response.data;
                }
            });
    }

    $scope.numbersWithDots = function (x) {
        let temp = '';
        if (x != null)
            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        return temp;
    }

    $scope.exportExcel = function () {
        checkSesstionTimeOut();
        window.open(preUrl + "/transaction/export?" +
            "itemType=" + $scope.itemType +
            "&itemName=" + $scope.itemName +
            "&msisdnContact=" + $scope.msisdnContact +
            "&mobile=" + $scope.mobile +
            "&status=" + $scope.status +
            "&type=" + $scope.type +
            "&transCode=" + $scope.transCode +
            "&fromGenDate=" + $scope.fromGenDate +
            "&toGenDate=" + $scope.toGenDate +

            "&msisdnType=" + $scope.msisdnType +
            "&group_id=" + $scope.group_id +
            "&doiTuongGiuSo=" + $scope.doiTuongGiuSo +

            "&loaiGoiCuoc=" + $scope.loaiGoiCuoc +
            "&giaGoi=" + $scope.giaGoi +
            "&chuKy=" + $scope.chuKy);
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

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.search(1);
    }

    // -------------------------Init----------------------------
    $scope.search(1);
    $scope.getGroupMsisdn();//lấy DS loại số- Api
}]);