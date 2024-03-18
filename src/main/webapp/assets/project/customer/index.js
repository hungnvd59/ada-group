app.controller('customerUser', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    //search variable
    $scope.fullName = ''
    $scope.mobile = ''
    $scope.status = -1
    $scope.presenter = ''
    $scope.provinceId = -1
    $scope.districtId = -1
    //date time
    $scope.comingDate = ''
    $scope.leaveDate = ''

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search();
        }
    });

    $(document).ready(function () {//select 2 multi commune

        $scope.fullName = ''
        $scope.mobile = ''
        $scope.status = -1
        $scope.presenter = ''
        $scope.provinceId = -1
        $scope.districtId = -1
        //date time
        $scope.comingDate = ''
        $scope.leaveDate = ''
        /*date time handle*/
        $("#comingDate").datetimepicker({
            locale: 'vi-VN', format: 'DD-MM-YYYY', maxDate: d
        }).on('dp.change', function (e) {
            if (e != null) {
                $scope.comingDate = $(this).val();
            }
        });
        $("#leaveDate").datetimepicker({
            locale: 'vi-VN', format: 'DD-MM-YYYY', maxDate: d
        }).on('dp.change', function (e) {
            if (e != null) {
                $scope.leaveDate = $(this).val();
            }
        });
        $scope.clear();
    });

    $scope.districtListByUser = []
    $scope.provinceListAdd = []
    $(document).ready(function () {
        //region add
        $http.get(preUrl + "/common/getListProvince", {}).then(function (response) {
            $scope.provinceListAdd = response.data
            $('#firstNumber').trigger("chosen:updated");
        });
    });

    /*region handle*/
    $scope.onChangeCity = function () {
        $http.get(preUrl + "/common/getDistrictByProvince", {
            params: {
                province: $scope.provinceId
            }
        }).then(function (response) {
            $scope.districtList = response.data
        });
    }

    $scope.clear = function () {
        $scope.districtId = -1
        $scope.provinceId = -1
        $('#leaveDate').val('')
        $('#comingDate').val('')
        $scope.fullName = "";
        $scope.mobile = "";
        $scope.status = -1;
        $scope.presenter = ''
    }

    $scope.search = function () {
        $scope.listData.pageNumber = 1;
        $scope.loadListData();
    }

    $scope.loadListData = function () {
        $http.get(preUrl + "/customer/search", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                fullName: $scope.fullName,
                mobile: $scope.mobile,
                status: $scope.status,
                presenter: $scope.presenter,
                provinceId: $scope.provinceId,
                districtId: $scope.districtId,
                comingDate: $scope.comingDate,
                leaveDate: $scope.leaveDate
            }
        }).then(function (response) {
            if (response != null && response.status === 200) {
                $scope.listData = response.data;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        })
    }

    /*reload page*/
    $scope.loadPageData = function (pageNumber) {
        if (pageNumber >= 1) {
            $http.get(preUrl + "/customer/search", {
                params: {
                    pageNumber: pageNumber,
                    numberPerPage: $scope.listData.numberPerPage,
                    fullName: $scope.fullName,
                    mobile: $scope.mobile,
                    status: $scope.status,
                    presenter: $scope.presenter,
                    provinceId: $scope.provinceId,
                    districtId: $scope.districtId,
                    comingDate: $scope.comingDate,
                    leaveDate: $scope.leaveDate
                }
            }).then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            })
        }
    }

    $scope.export = function () {
        window.location.href = preUrl + "/customer/export?p=" + $scope.listData.pageNumber + "&numberPerPage=" + $scope.listData.numberPerPage + "&fullName=" + $scope.fullName + "&mobile=" + $scope.mobile + "&typeCtv=" + $scope.typeCtv + "&status=" + $scope.status + "&idNumber=" + $scope.idNumber + "&statusVerify=" + $scope.statusVerify + "&superiorName=" + $scope.superiorName + "&provinceId=" + $scope.provinceId + "&districtId=" + $scope.districtId + "&comingDate=" + $scope.comingDate + "&leaveDate=" + $scope.leaveDate;
    }

    //----------------ADD---------------------
    $scope.addCtv = {}
    $scope.addCtv.typeCtv = 3
    $scope.addCtv.provinceId = -1
    $scope.addCtv.districtId = -1
    $scope.addCtv.communeId = -1
    $scope.addCtv.communeIdList = []
    $scope.addCtv.districtIdList = []
    $scope.addCtv.status = 1
    $scope.addCtv.shopcodeSkynet = -1
    $scope.resultValidateFormAdd = true;
    $scope.districtListAdd = {}
    $scope.communeListAdd = {}

    $scope.listSkynet = []
    $scope.preAdd = function () {
        $scope.addCtv.smShopId = -1
        $scope.addCtv.typeCtv = 3
        $scope.addCtv.provinceId = -1
        $scope.addCtv.districtId = -1
        $scope.addCtv.communeId = -1
        $scope.addCtv.communeIdList = []
        $scope.addCtv.districtIdList = []
        $scope.addCtv.status = 1
        $scope.addCtv.shopcodeSkynet = -1
        $scope.resultValidateFormAdd = true;
        $scope.districtListAdd = {}
        $scope.communeListAdd = {}

        //get shopcode Skynet
        $http.get(preUrl + "/common/get-all-shopcode-skynet", {}).then(function (response) {
            $scope.listSkynet = response.data
        });
        $('#addCtv-communeId2').prop('disabled', false);
        $("#addCtvModal").modal("show");
    }

    $scope.clearFormAdd = function () {
        $scope.addCtv = {}
        $scope.addCtv.typeCtv = 3
        $scope.addCtv.provinceId = -1
        $scope.addCtv.districtId = -1
        $scope.addCtv.communeId = -1
        $scope.addCtv.shopcodeSkynet = -1
        $scope.addCtv.status = 1
        $scope.resultValidateFormAdd = true;
        $("#addCtv-mobile").css("border", "1px solid #E5E7EB")
        document.getElementById("mobileAddMsgErr").style.display = "none"
        document.getElementById("mobileAddLengthMsgErr").style.display = "none"
        $("#addCtv-fullName").css("border", "1px solid #E5E7EB")
        document.getElementById("fullNameAddMsgErr").style.display = "none"
        $("#addCtv-idNumber").css("border", "1px solid #E5E7EB")
        document.getElementById("idNumberAddMsgErr").style.display = "none"
        document.getElementById("idNumberFormatAddMsgErr").style.display = "none"
        $("#s2id_addCtv-provinceId").css("border", "1px solid #E5E7EB")
        document.getElementById("provinceIdAddMsgErr").style.display = "none"
        $("#s2id_addCtv-districtId").css("border", "1px solid #E5E7EB")
        document.getElementById("districtIdAddMsgErr").style.display = "none"
        $("#s2id_addCtv-communeId").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdAddMsgErr").style.display = "none"
        document.getElementById("mobileExistAddMsgErr").style.display = "none"
        document.getElementById("idNumberExistAddMsgErr").style.display = "none"
        if ($scope.addCtv.typeCtv == 1) {
            $("#addCtv-smShopId").css("border", "1px solid #E5E7EB")
            document.getElementById("codeMAddMsgErr").style.display = "none"
        }
        if ($scope.addCtv.typeCtv == 2) {
            $("#addCtv-salePointCode").css("border", "1px solid #E5E7EB")
            document.getElementById("salePointExistCodeMsgErr").style.display = "none"
        }
        if ($scope.addCtv.typeCtv == 2 || $scope.addCtv.typeCtv == 3) {
            $("#addCtv-refCode").css("border", "1px solid #E5E7EB")
            document.getElementById("refCodeMsgErr").style.display = "none"
            document.getElementById("refCodeNvbhMsgErr").style.display = "none"
        }
        if ($scope.addCtv.typeCtv == 7) {
            $("#addCtv-smShopId").css("border", "1px solid #E5E7EB")
            document.getElementById("codeMAddMsgErr").style.display = "none"
            $("#addCtv-codeSkynet").css("border", "1px solid #E5E7EB")
            document.getElementById("codeSkynetAddMsgErr").style.display = "none"
            $("#addCtv-empCode").css("border", "1px solid #E5E7EB")
            document.getElementById("empCodeAddMsgErr").style.display = "none"
            document.getElementById("empCodeExitsAddMsgErr").style.display = "none"
        }
    }

    $scope.validateFormAdd = function () {
        $scope.resultValidateFormAdd = true;
        if ($scope.addCtv.mobile == null || $scope.addCtv.mobile === '') {
            $("#addCtv-mobile").css("border", "1px solid #ff0000")
            document.getElementById("mobileAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }

        if ($scope.addCtv.mobile != null && !validateMobile($scope.addCtv.mobile)) {
            $("#addCtv-mobile").css("border", "1px solid #ff0000")
            document.getElementById("mobileAddLengthMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.fullName == null || $scope.addCtv.fullName === '') {
            $("#addCtv-fullName").css("border", "1px solid #ff0000")
            document.getElementById("fullNameAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.idNumber == null || $scope.addCtv.idNumber === '') {
            $("#addCtv-idNumber").css("border", "1px solid #ff0000")
            document.getElementById("idNumberAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.idNumber != null && $scope.addCtv.idNumber.length != 9 && $scope.addCtv.idNumber.length != 12) {
            $("#addCtv-idNumber").css("border", "1px solid #ff0000")
            document.getElementById("idNumberFormatAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.provinceId == null || $scope.addCtv.provinceId == -1) {
            $("#s2id_addCtv-provinceId").css("border", "1px solid #ff0000")
            document.getElementById("provinceIdAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.districtId == null || $scope.addCtv.districtId == -1) {
            $("#s2id_addCtv-districtId").css("border", "1px solid #ff0000")
            document.getElementById("districtIdAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.communeId == null || $scope.addCtv.communeId == -1) {
            $("#s2id_addCtv-communeId").css("border", "1px solid #ff0000")
            document.getElementById("communeIdAddMsgErr").style.display = "block"
            $scope.resultValidateFormAdd = false;
        }
        if ($scope.addCtv.typeCtv == 1) {
            if ($scope.addCtv.smShopId == null || $scope.addCtv.smShopId === -1) {
                $("#addCtv-smShopId").css("border", "1px solid #ff0000")
                document.getElementById("codeMAddMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
            if ($scope.addCtv.shopcodeSkynet == null || $scope.addCtv.shopcodeSkynet === -1) {
                $("#addCtv-codeSkynet").css("border", "1px solid #ff0000")
                document.getElementById("codeSkynetAddMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
        }
        if ($scope.addCtv.typeCtv == 2) {
            if ($scope.addCtv.salePointCode == null || $scope.addCtv.salePointCode === -1) {
                $("#addCtv-salePointCode").css("border", "1px solid #ff0000")
                document.getElementById("salePointCodeMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
        }
        if ($scope.addCtv.typeCtv == 3) {
        }
        if ($scope.addCtv.typeCtv == 7) {
            if ($scope.addCtv.districtIdList.length == 1 && ($scope.addCtv.communeIdList == null || $scope.addCtv.communeIdList.length == 0)) {
                $("#s2id_addCtv-communeId2").css("border", "1px solid #ff0000")
                document.getElementById("communeIdListMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
            if ($scope.addCtv.districtIdList == null || $scope.addCtv.districtIdList.length == 0) {
                $("#s2id_addCtv-districtId2").css("border", "1px solid #ff0000")
                document.getElementById("districtIdListMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
            if ($scope.addCtv.smShopId == null || $scope.addCtv.smShopId === -1) {
                $("#addCtv-smShopId").css("border", "1px solid #ff0000")
                document.getElementById("codeMAddMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
            if ($scope.addCtv.shopcodeSkynet == null || $scope.addCtv.shopcodeSkynet === -1) {
                $("#addCtv-codeSkynet").css("border", "1px solid #ff0000")
                document.getElementById("codeSkynetAddMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
            if ($scope.addCtv.empCode == null || $scope.addCtv.empCode === '') {
                $("#addCtv-empCode").css("border", "1px solid #ff0000")
                document.getElementById("empCodeAddMsgErr").style.display = "block"
                $scope.resultValidateFormAdd = false;
            }
        }

        return $scope.resultValidateFormAdd;
    }

    $scope.changeInput = function (param) {
        switch (param) {
            case 'mobileAddMsgErr':
                $("#addCtv-mobile").css("border", "1px solid #E5E7EB")
                document.getElementById("mobileAddMsgErr").style.display = "none"
                document.getElementById("mobileExistAddMsgErr").style.display = "none"
                document.getElementById("mobileAddLengthMsgErr").style.display = "none"
                break
            case 'fullNameAddMsgErr':
                $("#addCtv-fullName").css("border", "1px solid #E5E7EB")
                document.getElementById("fullNameAddMsgErr").style.display = "none"
                break
            case 'idNumberAddMsgErr':
                $("#addCtv-idNumber").css("border", "1px solid #E5E7EB")
                document.getElementById("idNumberAddMsgErr").style.display = "none"
                document.getElementById("idNumberFormatAddMsgErr").style.display = "none"
                document.getElementById("idNumberExistAddMsgErr").style.display = "none"
                break;
            case 'provinceIdAddMsgErr':
                $("#s2id_addCtv-provinceId").css("border", "1px solid #E5E7EB")
                document.getElementById("provinceIdAddMsgErr").style.display = "none"
                break;
            case 'districtIdAddMsgErr':
                $("#s2id_addCtv-districtId").css("border", "1px solid #E5E7EB")
                document.getElementById("districtIdAddMsgErr").style.display = "none"
                break;
            case 'communeIdAddMsgErr':
                $("#s2id_addCtv-communeId").css("border", "1px solid #E5E7EB")
                document.getElementById("communeIdAddMsgErr").style.display = "none"
                break;
            case 'codeMAddMsgErr':
                $("#addCtv-smShopId").css("border", "1px solid #E5E7EB")
                document.getElementById("codeMAddMsgErr").style.display = "none"
                break;
            case 'codeSkynetAddMsgErr':
                $("#addCtv-codeSkynet").css("border", "1px solid #E5E7EB")
                document.getElementById("codeSkynetAddMsgErr").style.display = "none"
                break;
            case 'empCodeAddMsgErr':
                $("#addCtv-empCode").css("border", "1px solid #E5E7EB")
                document.getElementById("empCodeAddMsgErr").style.display = "none"
                document.getElementById("empCodeExitsAddMsgErr").style.display = "none"
                break
            case 'salePointCodeMsgErr':
                $("#addCtv-salePointCode").css("border", "1px solid #E5E7EB")
                document.getElementById("salePointCodeMsgErr").style.display = "none"
                document.getElementById("salePointExistCodeMsgErr").style.display = "none"
                break
            case 'refCodeMsgErr':
                $("#addCtv-salePointCode").css("border", "1px solid #E5E7EB")
                document.getElementById("refCodeMsgErr").style.display = "none"
                document.getElementById("refCodeNvbhMsgErr").style.display = "none"
                break
        }
    }

    $scope.addChangeCity = function () {
        //set css
        $("#s2id_addCtv-provinceId").css("border", "1px solid #E5E7EB")
        document.getElementById("provinceIdAddMsgErr").style.display = "none"
        $("#s2id_addCtv-districtId").css("border", "1px solid #E5E7EB")
        document.getElementById("districtIdAddMsgErr").style.display = "none"
        $("#s2id_addCtv-communeId").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdAddMsgErr").style.display = "none"

        $scope.listSmShop = []
        $scope.communeListAdd = []
        $scope.districtListAdd = []
        $scope.addCtv.communeIdList = []
        $scope.addCtv.districtIdList = []
        $scope.addCtv.smShopId = -1
        $scope.addCtv.districtId = -1
        $scope.addCtv.communeId = -1

        if ($scope.addCtv.provinceId != null && $scope.addCtv.provinceId != -1) {
            $http.get(preUrl + "/common/getDistrictByBranch", {
                params: {provinceId: $scope.addCtv.provinceId}
            }).then(function (response) {
                $scope.districtListAdd = response.data.listDistrict
            });
        }

        if ($scope.addCtv.typeCtv == 7) {
            $("#s2id_addCtv-districtId2").css("border", "1px solid #E5E7EB")
            document.getElementById("districtIdListMsgErr").style.display = "none"
            $("#s2id_addCtv-communeId2").css("border", "1px solid #E5E7EB")
            document.getElementById("communeIdListMsgErr").style.display = "none"
        }
    }

    $scope.addChangeDistrict = function () {
        $("#s2id_addCtv-districtId").css("border", "1px solid #E5E7EB")
        document.getElementById("districtIdAddMsgErr").style.display = "none"
        $("#s2id_addCtv-communeId").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdAddMsgErr").style.display = "none"
        $scope.communeListAdd = []
        $scope.addCtv.communeId = -1;

        if ($scope.addCtv.typeCtv == 7) {
            $("#s2id_addCtv-districtId2").css("border", "1px solid #E5E7EB")
            document.getElementById("districtIdListMsgErr").style.display = "none"
            $("#s2id_addCtv-communeId2").css("border", "1px solid #E5E7EB")
            document.getElementById("communeIdListMsgErr").style.display = "none"
        }
        console.log("LENGTH: " + $scope.addCtv.districtIdList.length)
        if ($scope.addCtv.districtIdList.length >= 2) {
            $('#addCtv-communeId2').prop('disabled', true);
            console.log($scope.addCtv.districtIdList.toString())
            $http.get(preUrl + "/common/getShopByListDistrictId", {
                params: {
                    listDistrictId: $scope.addCtv.districtIdList.toString(), typeCtv: $scope.addCtv.typeCtv
                }
            }).then(function (response3) {
                $scope.addCtv.smShopId = -1
                $scope.listSmShop = response3.data
            });
        } else {
            if ($scope.addCtv.typeCtv == 7) {
            }
            if ($scope.addCtv.districtId != null && $scope.addCtv.districtId != -1) {
                $http.get(preUrl + "/common/getWardByDistrict", {
                    params: {
                        districtsId: $scope.addCtv.districtId
                    }
                }).then(function (response) {
                    $scope.communeListAdd = response.data
                });
                $http.get(preUrl + "/common/getShopByDistrictId", {
                    params: {
                        districtId: $scope.addCtv.districtId, typeCtv: $scope.addCtv.typeCtv
                    }
                }).then(function (response2) {
                    $scope.addCtv.smShopId = -1
                    $scope.listSmShop = response2.data
                });
            }
        }
    }

    $scope.changeCommuneAdd = function () {
        $("#s2id_addCtv-communeId").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdAddMsgErr").style.display = "none"
    }

    $scope.addChangeDistrictMul = function () {
        $scope.communeListAddMul = []
        $("#s2id_addCtv-districtId2").css("border", "1px solid #E5E7EB")
        document.getElementById("districtIdListMsgErr").style.display = "none"
        $("#s2id_addCtv-communeId2").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdListMsgErr").style.display = "none"
        if ($scope.addCtv.districtIdList.length >= 2) {
            $('#addCtv-communeId2').prop('disabled', true);
            $scope.communeListAddMul = [];
            console.log($scope.addCtv.districtIdList.toString())
            $http.get(preUrl + "/common/getShopByListDistrictId", {
                params: {
                    listDistrictId: $scope.addCtv.districtIdList.toString(), typeCtv: $scope.addCtv.typeCtv
                }
            }).then(function (response3) {
                $scope.addCtv.smShopId = -1
                $scope.listSmShop = response3.data
            });
        } else {
            $('#addCtv-communeId2').prop('disabled', false);
            if ($scope.addCtv.typeCtv == 7) {
            }
            if ($scope.addCtv.districtIdList[0] != null && $scope.addCtv.districtIdList[0] != -1) {
                $http.get(preUrl + "/common/getWardByDistrict", {
                    params: {
                        districtsId: $scope.addCtv.districtIdList[0]
                    }
                }).then(function (response) {
                    $scope.communeListAddMul = response.data
                });
                $http.get(preUrl + "/common/getShopByDistrictId", {
                    params: {
                        districtId: $scope.addCtv.districtIdList[0], typeCtv: $scope.addCtv.typeCtv
                    }
                }).then(function (response2) {
                    $scope.addCtv.smShopId = -1
                    $scope.listSmShop = response2.data
                });
            }
        }
    }

    $scope.addChangeCommuneMul = function () {
        $("#s2id_addCtv-communeId2").css("border", "1px solid #E5E7EB")
        document.getElementById("communeIdListMsgErr").style.display = "none"
    }

    $scope.addNewCtv = function () {
        if ($scope.validateFormAdd()) {
            let listCommune = $scope.addCtv.communeIdList.length > 0 ? $scope.addCtv.communeIdList : '';
            let listDistrict = $scope.addCtv.districtIdList.length > 0 ? $scope.addCtv.districtIdList : '';
            var bodyReq = {
                listStrCommune: listCommune.toString(), partner: $scope.addCtv, listStrDistrict: listDistrict.toString()
            }
            let requestBody = JSON.parse(JSON.stringify(bodyReq));
            console.log(requestBody)
            $http.post(preUrl + "/ctv/user/addNewCtv", requestBody, {
                headers: {'Content-Type': 'application/json'}
            })
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 1:
                            toastr.success("Thêm mới tài khoản thành công");
                            $scope.search();
                            $("#addCtvModal").modal("hide");
                            $scope.clearFormAdd();
                            setTimeout(function () {
                                location.reload();
                            }, 200)
                            break;
                        case -1:
                            toastr.error("Có lỗi xảy ra, vui lòng thử lại sau");
                            break;
                        case -2:
                            $("#addCtv-mobile").css("border", "1px solid #ff0000")
                            document.getElementById("mobileExistAddMsgErr").style.display = "block"
                            break;
                        case -3:
                            $("#addCtv-idNumber").css("border", "1px solid #ff0000")
                            document.getElementById("idNumberExistAddMsgErr").style.display = "block"
                            break;
                        case -4:
                            $("#addCtv-empCode").css("border", "1px solid #ff0000")
                            document.getElementById("empCodeExitsAddMsgErr").style.display = "block"
                            break;
                        case -5:
                            $("#addCtv-salePointCode").css("border", "1px solid #ff0000")
                            document.getElementById("salePointExistCodeMsgErr").style.display = "block"
                            break;
                        case -6:
                            $("#addCtv-refCode").css("border", "1px solid #ff0000")
                            document.getElementById("refCodeMsgErr").style.display = "block"
                            break;
                        case -7:
                            $("#addCtv-refCode").css("border", "1px solid #ff0000")
                            document.getElementById("refCodeNvbhMsgErr").style.display = "block"
                            break;
                    }
                });
        }
    }
    //----------------LOCK/UNLOCK/DELETE---------------------
    $scope.userLock = {}
    $scope.userUnLock = {}
    $scope.userDelete = {}
    $scope.preLockPartner = function (user) {
        $scope.userLock = Object.assign({}, user);
        $("#mdLockUser").modal("show");
    }
    $scope.preUnLockPartner = function (user) {
        $scope.userUnLock = Object.assign({}, user);
        $("#mdUnLockUser").modal("show");
    }
    $scope.preDeletePartner = function (user) {
        $scope.userDelete = Object.assign({}, user);
        $("#mdDeleteUser").modal("show");
    }

    $scope.lockUser = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userLock));
        $http.post(preUrl + "/system/user/lock-user", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 1:
                            toastr.success("Khóa tài khoản thành công!")
                            $scope.search()
                            $("#mdLockUser").modal("hide");
                            break;
                        default:
                            toastr.error('Khóa tài khoản không thành công!');
                            break;
                    }
                }
            });
    }

    $scope.unLockUser = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userUnLock));
        $http.post(preUrl + "/system/user/unLock-user", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 1:
                            $scope.search()
                            toastr.success("Mở khóa tài khoản thành công!")
                            $("#mdUnLockUser").modal("hide");
                            break;
                        default:
                            toastr.error('Mở khóa tài khoản không thành công!');
                            break;
                    }
                }
            });
    }

    $scope.deleteUserF = function () {
        var requestBody = JSON.parse(JSON.stringify($scope.userDelete));
        $http.post(preUrl + "/ctv/user/deletePartner", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    switch (Number(response.data)) {
                        case 0:
                            $scope.search()
                            toastr.success("Xóa tài khoản thành công!")
                            $("#mdDeleteUser").modal("hide");
                            break;
                        default:
                            toastr.error('Xóa tài khoản thất bại!');
                            break;
                    }
                }
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
    $scope.search();
}])