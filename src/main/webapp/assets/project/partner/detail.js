app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$q', '$location', function ($scope, $http, $timeout, $q, $location) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};
    $scope.palaceTT = {data: "", code: "", message: ""};
    $scope.palaceQH = {data: "", code: "", message: ""};
    $scope.numberPerPage = 15;
    $scope.partnerName = "";
    $scope.dateBirth = "";
    $scope.identityType = 1;
    $scope.idNumber = "";
    $scope.identityDate = "";
    $scope.identityPlace = "";
    $scope.address = "";
    $scope.genDate = "";
    $scope.linkAvt = "";
    $scope.linkBackIdNumber = "";
    $scope.linkFrontIdNumber = "";

    $scope.editPartner = {};

    $scope.name = "";
    $scope.description = "";
    $scope.status = 1;
    $scope.statusConfig = 1;
    $scope.m_bl_pre_bonus = "";
    $scope.m_bl_pre_osp = "";
    $scope.m_bl_pre_ctv = "";
    $scope.m_bl_pre_ref = "";
    $scope.m_bl_post_bonus = "";
    $scope.m_bl_post_osp = "";
    $scope.m_bl_post_ctv = "";
    $scope.m_bl_post_ref = "";
    $scope.m_package_osp = "";
    $scope.m_package_ctv = "";
    $scope.m_package_ref = "";
    $scope.configId = "";
    $scope.linkSell = "";
    $scope.configContractEdit = {};
    $scope.flagReturnBase = false;
    $scope.districtId = -1;
    $scope.provinceId = -1;
    $scope.addressDetail = "";

    /*data tap balance history*/
    $scope.balanceHistory = {};
    $scope.balanceWithdraw = 0;
    $scope.linkImg = "";
    $scope.username = "";

    $scope.transType = -1;
    $scope.fromDateHis = "";
    $scope.toDateHis = "";


    $("#identityDate").datetimepicker({
        maxDate: new Date,
        minDate: new Date(1945, 8, 2),
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
            $scope.identityDate = $(this).val();
        }
    })

    $("#fromDateHis").datetimepicker({
        minDate: new Date(1945, 8, 2),
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
            $scope.fromDateHis = $(this).val();
        }
    })

    $("#toDateHis").datetimepicker({
        minDate: new Date(1945, 8, 2),
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
            $scope.toDateHis = $(this).val();
        }
    })

    $scope.checkSS = 0;
    $scope.checkGC = 0;

    var ssOpen = document.getElementById("ss-open");
    var ssClose = document.getElementById("ss-close");
    var gcOpen = document.getElementById("gc-open");
    var gcClose = document.getElementById("gc-close");

    $('#ss').click(function () {
        if ($scope.checkSS == 0) {
            ssOpen.style.display = "none";
            ssClose.style.display = "block";
            $scope.checkSS = 1;
        } else {
            ssOpen.style.display = "block";
            ssClose.style.display = "none";
            $scope.checkSS = 0;
        }
    });
    $('#gc').click(function () {
        if ($scope.checkGC == 0) {
            gcOpen.style.display = "none";
            gcClose.style.display = "block";
            $scope.checkGC = 1;
        } else {
            gcOpen.style.display = "block";
            gcClose.style.display = "none";
            $scope.checkGC = 0;
        }
    });

    $scope.params = getParameters($location.absUrl());
    console.log("param: " + $scope.params.id);

    // check param
    if ($scope.params.id.includes("#")) {
        $scope.params.id = $scope.params.id.split("#")[0];
        console.log("id: " + $scope.params.id);
    }

    $scope.init = function () {
        $("#collapseOne").collapse("show");
        $("#collapseTwo").collapse("show");
        console.log("DETAIL: " + $scope.params.id);
        $http.get(preUrl + "/partner/get", {
            params: {
                id: Number($scope.params.id)
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.partnerDetail = response.data;
                    $scope.status = response.data.status;
                    $scope.partnerName = response.data.partnerName;
                    $scope.palaceTT.data = response.data.palaceTT.data;
                    $scope.dateBirth = moment(response.data.dateBirth).format('DD/MM/YYYY');
                    $scope.identityType = response.data.identityType;
                    $scope.idNumber = response.data.idNumber;
                    $scope.identityDate = moment(response.data.identityDate).format('DD/MM/YYYY');
                    $scope.identityPlace = response.data.identityPlace;
                    $scope.address = response.data.address;
                    $scope.linkAvt = response.data.linkAvt;
                    $scope.linkBackIdNumber = response.data.linkBackIdNumber;
                    $scope.linkFrontIdNumber = response.data.linkFrontIdNumber;
                    $scope.configId = response.data.configId;
                    $scope.linkSell = response.data.linkSell;
                    $scope.genDate = moment(response.data.genDate).format('DD/MM/YYYY hh:mm:ss');
                    if (response.data.linkBackIdNumber != null) {
                        document.getElementById('uploadFrontIdNumber').style.display = "none";
                        document.getElementById('displayImageFrontId').style.display = "block";
                    }
                    if (response.data.linkBackIdNumber != null) {
                        document.getElementById('uploadBackIdNumber').style.display = "none";
                        document.getElementById('displayImageBackId').style.display = "block";
                    }
                    // $scope.provinceId = 9;
                    // $scope.districtId = 1046;
                    if (response.data.provinceId == null) {
                        $scope.provinceId = -1;
                        $scope.districtId = -1;
                    } else {
                        $scope.provinceId = response.data.provinceId;
                        $scope.getDistrict($scope.provinceId);
                        $scope.districtId = response.data.districtId;
                    }
                    $http.get(preUrl + "/config-contract/get", {
                        params: {
                            id: Number($scope.partnerDetail.configId)
                        }
                    })
                        .then(function (response) {
                            if (response != null && response != 'undefined' && response.status == 200) {
                                $scope.configDetail = response.data;
                                $scope.name = response.data.name;
                                $scope.description = response.data.description;
                                $scope.statusConfig = response.data.status;
                                $scope.m_bl_pre_bonus = response.data.m_bl_pre_bonus;
                                $scope.m_bl_pre_osp = response.data.m_bl_pre_osp;
                                $scope.m_bl_pre_ctv = response.data.m_bl_pre_ctv;
                                $scope.m_bl_pre_ref = response.data.m_bl_pre_ref;
                                $scope.m_bl_post_bonus = response.data.m_bl_post_bonus;
                                $scope.m_bl_post_osp = response.data.m_bl_post_osp;
                                $scope.m_bl_post_ctv = response.data.m_bl_post_ctv;
                                $scope.m_bl_post_ref = response.data.m_bl_post_ref;
                                $scope.m_package_osp = response.data.m_package_osp;
                                $scope.m_package_ctv = response.data.m_package_ctv;
                                $scope.m_package_ref = response.data.m_package_ref;
                                console.log($scope.configDetail);
                                if ($scope.m_bl_pre_bonus != null && $scope.m_bl_pre_bonus != "") {
                                    if ($scope.m_bl_pre_osp != null && $scope.m_bl_pre_osp != "") {
                                        $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
                                    }
                                    if ($scope.m_bl_pre_ctv != null && $scope.m_bl_pre_ctv != "") {
                                        $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
                                    }
                                }
                                if ($scope.m_bl_post_bonus != null && $scope.m_bl_post_bonus != "") {
                                    if ($scope.m_bl_post_osp != null && $scope.m_bl_post_osp != "") {
                                        $scope.m_bl_post_osp_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_osp / 100);
                                    }
                                    if ($scope.m_bl_post_ctv != null && $scope.m_bl_post_ctv != "") {
                                        $scope.m_bl_post_ctv_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_ctv / 100);
                                    }
                                }
                            }
                        });
                    $scope.getHistory();
                    $http.get(preUrl + "/payment/getBalanceWithdraw", {
                        params: {
                            username: $scope.partnerDetail.userName
                        }
                    })
                        .then(function (response) {
                            if (response != null && response != 'undefined' && response.status == 200) {
                                $scope.balanceWithdraw = Number(response.data);
                            }
                        });
                }

            });
    }

    $scope.getDistrict = function (id) {
        $http.get(preUrl + "/partner/getDistrict", {
            params: {
                id: id
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.palaceQH.data = response.data.data;

            }
        });
    }

    $scope.frontImg = '';
    $scope.backImg = '';
    $scope.changeFrontImage = false;
    $scope.changeBackImage = false;
    $scope.uploadFrontImage = function () {
        $scope.changeFrontImage = true;
        $('#img_upload').trigger('click');
        $('#img_upload').change(function () {
            var file = $('#img_upload').get(0).files[0];
            var reader = new FileReader();
            reader.onload = function () {
                document.getElementById('imageFrontIdNumberDefault').style.display = "none";
                document.getElementById('imageFrontIdNumberUpload').style.display = "block";
                $scope.linkImg = reader.result;
                $('#previewImg').attr("src", reader.result);
                $scope.frontImg = reader.result;
            }
            reader.readAsDataURL(file);
        });
    }
    $scope.uploadBackImg = function () {
        $scope.changeBackImage = true;
        $('#img_upload_back').trigger('click');
        $('#img_upload_back').change(function () {
            var file = $('#img_upload_back').get(0).files[0];
            const reader = new FileReader();
            reader.onload = function () {
                $scope.linkImg = reader.result;
                document.getElementById('imageBackIdNumberDefault').style.display = "none";
                document.getElementById('imageBackIdNumberUpload').style.display = "block";
                $('#previewImg1').attr("src", reader.result);
                $scope.backImg = reader.result;
            }
            reader.readAsDataURL(file);
        });
    }

    $scope.removeImg = function (param) {
        if (param == "frontIdNumber") {
            document.getElementById('imageFrontIdNumberDefault').style.display = "block";
            document.getElementById('imageFrontIdNumberUpload').style.display = "none";
            $scope.linkFrontIdNumber = "";
        }
        if (param == "backIdNumber") {
            document.getElementById('imageBackIdNumberDefault').style.display = "block";
            document.getElementById('imageBackIdNumberUpload').style.display = "none";
            $scope.linkBackIdNumber = "";
        }
    }

    $scope.removeImgOfPartner = function (param) {
        if (param == "frontIdNumber") {
            document.getElementById('uploadFrontIdNumber').style.display = "block";
            document.getElementById('displayImageFrontId').style.display = "none";
            $scope.linkFrontIdNumber = "";
        }
        if (param == "backIdNumber") {
            document.getElementById('uploadBackIdNumber').style.display = "block";
            document.getElementById('displayImageBackId').style.display = "none";
            $scope.linkBackIdNumber = "";
        }
    }

    $scope.update = function (id) {
        if ($scope.changeFrontImage == true) {
            var imgFront = document.getElementById('previewImg');
            var canvasFront = document.createElement('canvas');
            var ctxFront = canvasFront.getContext('2d');
            var dataURL;
            canvasFront.width = imgFront.naturalWidth;
            canvasFront.height = imgFront.naturalHeight;
            ctxFront.drawImage(imgFront, 0, 0);
            dataURL = canvasFront.toDataURL("image/png");
            $scope.linkFrontIdNumber = dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        }

        if ($scope.changeBackImage == true) {
            var imgBack = document.getElementById('previewImg1');
            var canvasBack = document.createElement('canvas');
            var ctxBack = canvasBack.getContext('2d');
            var dataURLBack;
            canvasBack.width = imgBack.naturalWidth;
            canvasBack.height = imgBack.naturalHeight;
            ctxBack.drawImage(imgBack, 0, 0);
            dataURLBack = canvasBack.toDataURL("image/png");
            $scope.linkBackIdNumber = dataURLBack.replace(/^data:image\/(png|jpg);base64,/, "");
        }

        if ($scope.partnerName == "" || $scope.partnerName == null) {
            toastr.error("Vui lòng nhập Họ và tên!")
            document.getElementById("partnerName").focus();
            return false;
        }
        if ($scope.identityType == -1 || $scope.identityType == null) {
            toastr.error("Vui lòng chọn Giấy tờ tùy thân!")
            document.getElementById("identityType").focus();
            return false;
        }
        if ($scope.idNumber == "" || $scope.idNumber == null) {
            toastr.error("Vui lòng nhập Số giấy tờ tùy thân!")
            document.getElementById("idNumber").focus();
            return false;
        }
        if ($scope.identityDate == "" || $scope.identityDate == null) {
            toastr.error("Vui lòng nhập Ngày cấp!")
            document.getElementById("identityDate").focus();
            return false;
        }
        if ($scope.identityPlace == "" || $scope.identityPlace == null) {
            toastr.error("Vui lòng nhập Nơi cấp!")
            document.getElementById("identityPlace").focus();
            return false;
        }
        if ($scope.identityPlace == "" || $scope.identityPlace == null) {
            toastr.error("Vui lòng nhập Nơi cấp!")
            document.getElementById("identityPlace").focus();
            return false;
        }
        if ($scope.provinceId == -1 || $scope.provinceId == null) {
            toastr.error("Vui lòng chọn Thành phố!")
            document.getElementById("provinceId").focus();
            return false;
        }
        if ($scope.districtId == -1 || $scope.districtId == null) {
            toastr.error("Vui lòng chọn Quận huyên!")
            document.getElementById("districtId").focus();
            return false;
        }
        if ($scope.address == "" || $scope.address == null) {
            toastr.error("Vui lòng chọn Địa chỉ!")
            document.getElementById("address").focus();
            return false;
        }
        if ($scope.linkFrontIdNumber == "" || $scope.linkFrontIdNumber == null) {
            toastr.error("Vui lòng upload ảnh Mặt trước giấy tờ!")
            document.getElementById("linkFrontIdNumber").focus();
            return false;
        }
        if ($scope.linkBackIdNumber == "" || $scope.linkBackIdNumber == null) {
            toastr.error("Vui lòng upload ảnh Mặt sau giấy tờ!")
            document.getElementById("linkBackIdNumber").focus();
            return false;
        }

        $scope.editPartner.id = id;
        $scope.editPartner.partnerName = $scope.partnerName;
        $scope.editPartner.mobile = $scope.partnerDetail.mobile;
        $scope.editPartner.identityType = $scope.identityType;
        $scope.editPartner.idNumber = $scope.idNumber;
        $scope.editPartner.identityDate = moment($scope.identityDate, 'DD/MM/YYYY')
        $scope.editPartner.identityPlace = $scope.identityPlace;
        $scope.editPartner.address = $scope.address;
        $scope.editPartner.status = $scope.status;
        $scope.editPartner.provinceId = $scope.provinceId;
        $scope.editPartner.districtId = $scope.districtId;

        $scope.editPartner.linkFrontIdNumber = $scope.linkFrontIdNumber;
        $scope.editPartner.linkBackIdNumber = $scope.linkBackIdNumber;

        var requestBody = JSON.parse(JSON.stringify($scope.editPartner));
        console.log("PREURL: " + preUrl);
        $http.post(preUrl + "/partner/update", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        $scope.init();
                        toastr.info("Cập nhập thông tin thành công")
                        break;
                    default:
                        toastr.error('Cập nhập thông tin không. Bạn vui lòng thử lại sau');
                        break;
                }
            });
    }

    $scope.returnBase = function () {
        $scope.flagReturnBase = true;
        $http.get(preUrl + "/config-contract/get", {
            params: {
                id: Number(1)
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.configDetail = response.data;
                    $scope.name = response.data.name;
                    $scope.description = response.data.description;
                    $scope.statusConfig = response.data.status;
                    $scope.m_bl_pre_bonus = response.data.m_bl_pre_bonus;
                    $scope.m_bl_pre_osp = response.data.m_bl_pre_osp;
                    $scope.m_bl_pre_ctv = response.data.m_bl_pre_ctv;
                    $scope.m_bl_pre_ref = response.data.m_bl_pre_ref;
                    $scope.m_bl_post_bonus = response.data.m_bl_post_bonus;
                    $scope.m_bl_post_osp = response.data.m_bl_post_osp;
                    $scope.m_bl_post_ctv = response.data.m_bl_post_ctv;
                    $scope.m_bl_post_ref = response.data.m_bl_post_ref;
                    $scope.m_package_osp = response.data.m_package_osp;
                    $scope.m_package_ctv = response.data.m_package_ctv;
                    $scope.m_package_ref = response.data.m_package_ref;
                    console.log($scope.configDetail);
                }
            });
    }

    $scope.updateConfigContract = function () {
        if ($scope.flagReturnBase != null && !$scope.flagReturnBase) {
            $scope.configContractEdit.partnerId = $scope.partnerDetail.id;
            $scope.configContractEdit.mobile = $scope.partnerDetail.mobile;
            $scope.configContractEdit.m_bl_pre_bonus = $scope.m_bl_pre_bonus;
            $scope.configContractEdit.m_bl_pre_osp = $scope.m_bl_pre_osp;
            $scope.configContractEdit.m_bl_pre_ctv = $scope.m_bl_pre_ctv;
            // $scope.configContractEdit.m_bl_pre_ref = $scope.m_bl_pre_ref;
            $scope.configContractEdit.m_bl_post_bonus = $scope.m_bl_post_bonus;
            $scope.configContractEdit.m_bl_post_osp = $scope.m_bl_post_osp;
            $scope.configContractEdit.m_bl_post_ctv = $scope.m_bl_post_ctv;
            // $scope.configContractEdit.m_bl_post_ref = $scope.m_bl_post_ref;
            $scope.configContractEdit.m_package_osp = $scope.m_package_osp;
            $scope.configContractEdit.m_package_ctv = $scope.m_package_ctv;
            $scope.configContractEdit.m_package_ref = $scope.m_package_ref;
            console.log($scope.configContractEdit)
            var requestBody = JSON.parse(JSON.stringify($scope.configContractEdit));
            $http.post(preUrl + "/config-contract/swapConfig", requestBody)
                .then(function (response) {
                    console.log("response " + response.data)
                    switch (Number(response.data)) {
                        case 0:
                            $scope.init();
                            toastr.info("Cập nhập thông tin cấu hình thành công")
                            break;
                        default:
                            toastr.error('Cập nhập thông tin không. Bạn vui lòng thử lại sau');
                            break;
                    }
                });
        } else {
            $scope.configContractEdit.partnerId = $scope.partnerDetail.id;
            $scope.configContractEdit.configId = "1";
            var requestBody = JSON.parse(JSON.stringify($scope.configContractEdit));
            $http.post(preUrl + "/config-contract/returnBase", requestBody)
                .then(function (response) {
                    console.log("response " + response.data)
                    switch (Number(response.data)) {
                        case 0:
                            $scope.init();
                            toastr.info("Cập nhập thông tin cấu hình thành công")
                            break;
                        default:
                            toastr.error('Cập nhập thông tin không. Bạn vui lòng thử lại sau');
                            break;
                    }
                });
        }
    }

    $scope.itemName = "";

     $scope.getHistory = function () {
        $scope.loadListBalanceHis();
    }

    $scope.loadListBalanceHis = function () {
        $http.get(preUrl + "/payment/getHistory", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                username: $scope.partnerDetail.userName,
                itemName: $scope.itemName,
                transType: $scope.transType,
                fromDate: $scope.fromDateHis,
                toDate: $scope.toDateHis,
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

    /*reload page*/
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/payment/getHistory", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                username: $scope.partnerDetail.userName,
                itemName: $scope.itemName,
                transType: $scope.transType,
                fromDate: $scope.fromDateHis,
                toDate: $scope.toDateHis,
            }
        })
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.listData = response.data;
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.listData.pageList = getPageList($scope.listData);
                }
            });
    };

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.getHistory($scope.partnerDetail.userName);
    }

    $scope.onchangeSwapConfig = function () {
        $scope.flagReturnBase = false;
    }
    $scope.showPopupImage = function (param) {
        if (param != null && param != '') {
            if (param == 'backIdNumber') {
                $('#popup-previewImg').attr("src", $scope.backImg);
                $('#modalShowImg').modal("show");
            } else if (param == 'frontIdNumber') {
                $('#popup-previewImg').attr("src", $scope.frontImg);
                $('#modalShowImg').modal("show");
            } else {
                $('#popup-previewImg').attr("src", 'https://ctv.osp.vn/cdn/' + param);
                $('#modalShowImg').modal("show");
            }
        }
    }

    $scope.genAccNumber = function (accNumber) {

    }

    setInterval(function () {
        $scope.checkTab()
    }, 20);
    $scope.checkTab = function () {
        let url = window.location.href;
        if (url.includes("balanceHis")) {
            $("#balanceHis1").click();
        }
        if (url.includes("configContract")) {
            $("#configContract1").click();
        }
        if (url.includes("#!#ctv")) {
            $("#ctvTab").click();
        }
    }

    $scope.numbersWithDots = function (x) {
        let temp = '';
        if (x != null)
            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        return temp;
    }

    /*-------INIT---------*/
    $scope.init();
}]);