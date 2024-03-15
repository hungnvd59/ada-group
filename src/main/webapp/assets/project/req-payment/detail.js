app.controller('frameworkCtrl', ['$scope', '$http', '$locale', '$timeout', '$location', '$q', 'fileUpload', function ($scope, $http, $locale, $timeout, $location, $q, fileUpload) {
    $locale.NUMBER_FORMATS.GROUP_SEP = ".";
    $locale.NUMBER_FORMATS.DECIMAL_SEP = ",";
    $scope.labelPopup = "KIỂM DUYỆT YÊU CẦU THANH TOÁN";
    $scope.partnerName = '';
    $scope.type = '';
    $scope.flag = '';
    $scope.username = '';
    $scope.status = '';
    $scope.taxCode = '';
    $scope.mobile = '';
    $scope.fromGenDate = '';
    $scope.toGenDate = '';
    $scope.fromPaymentDate = '';
    $scope.toPaymentDate = '';
    $scope.numberPerPage = 10;
    $scope.frmDate = '';
    $scope.expDate = '';
    $scope.listDataType = {};
    $scope.radio = '';
    $scope.imageSelect = '';
    $scope.reqCode = '';
    $scope.flagDelete = 'false'

    $scope.partnerId = "";
    $scope.idPartner = "";

    $scope.totalRecord = "";
    $scope.showFlag = -1;
    $scope.fileSaveObj = {}
    $scope.fileDetail = {}

    $scope.listData = {
        items: "",
        rowCount: 0,
        numberPerPage: $scope.numberPerPage,
        pageNumber: 1,
        pageList: [],
        pageCount: 0,
        checkLast: 0
    };

    // -------------------partner--------------------------
    $scope.partner = {
        items: "",
        rowCount: 0,
        numberPerPage: $scope.numberPerPage,
        pageNumber: 1,
        pageList: [],
        pageCount: 0,
        checkLast: 0
    };

    // -----------------------------------------------------

    $scope.image = {
        idFile: "",
        fileName: "",
        linkFile: ""
    };

    /*hung nv start*/

    $("#info-paymentDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD-MM-YYYY HH:mm:ss',
        sideBySide: true,
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
            $scope.info.prePaymentDate = $(this).val();
        }
    })

    $scope.params = getParameters($location.absUrl());
    
    $scope.isDisabled = false;
    $scope.loadInfoReqPayment = function () {
        $scope.isDisabled = false;
        // $scope.partnerId = idReqPayment.partnerId;
        checkSesstionTimeOut();
        $http.get(preUrl + "/reqPayment/loadInfoReqPayment", {
            params: {
                id: $scope.params.id,
                status: $scope.params.status,
            }
        }).then(function (response) {
                if (response.data != "" && response.data != null && response.data != undefined) {
                    $scope.info = response.data;
                    $scope.info.preStatus = $scope.info.status;
                    if ($scope.info.payment != null && $scope.info.payment != undefined) {
                        $scope.info.prePaymentBy = $scope.info.payment.paymentBy;
                    }
                    $scope.info.prePaymentDate = moment($scope.info.genDate).format("DD/MM/YYYY HH:mm:ss");
                    $scope.info.preDescription = $scope.info.description;
                    $scope.info.payAmount = $scope.info.amount;
                    if ($scope.info.status == 1) {
                        $scope.info.preStatus = "";
                        $scope.showFlag = 1;
                        $scope.info.prePaymentBy = "";
                        $scope.info.prePaymentDate = "";
                        //$scope.info.payAmount = "";
                    }
                    if ($scope.info.status == 0) {
                        $scope.showFlag = 0;
                        $scope.info.prePaymentBy = "";
                        $scope.info.prePaymentDate = "";
                        $scope.info.preDescription = $scope.info.description;
                        $scope.info.payAmount = "";
                    }
                    if ($scope.info.status == 2 || $scope.info.status == 0) {
                        $scope.isDisabled = true;
                    }

                    if ($scope.info.genDate != null && $scope.info.genDate != "") {
                        $scope.info.genDate = moment(response.data.genDate).format("DD/MM/YYYY HH:mm:ss");
                    }
                    if ($scope.info.paymentDate != null && $scope.info.paymentDate != "") {
                        $scope.info.paymentDate = moment(response.data.paymentDate).format("DD/MM/YYYY HH:mm:ss");
                    }
                    // if ($scope.info.payment != null) {
                    //     $scope.info.payAmount = $scope.info.payment.amount;
                    //     $scope.info.paymentBy = $scope.info.payment.paymentBy;
                    //     $scope.info.paymentDate = moment($scope.info.payment.paymentDate).format("DD/MM/YYYY HH:mm:ss");
                    // }
                    if ($scope.info.bankInfoStatusVerify != null && $scope.info.bankInfoStatusVerify == "1") {
                        $('#bankInfoStatusVerify').prop('checked', true);
                    } else {
                        $('#bankInfoStatusVerify').prop('checked', false);
                    }
                    $scope.info.fileLst = response.data.fileLst;
                    if ($scope.info.fileLst != null) {
                        $scope.imageSelect = response.data.fileLst.fileName;
                        $("#fileChose").text($scope.imageSelect)
                        $("#fileNotChose").hide()
                        if($scope.isDisabled) {
                            $("#rmv1").hide()
                        } else {
                            $("#rmv1").show();
                        }
                    } else {
                        $("#fileChose").text('')
                        $("#fileNotChose").show()
                        $("#rmv1").hide()
                    }

                    if ($scope.info.filePayment != null) {
                        $scope.imageSelect2 = response.data.filePayment.fileName;
                        $("#messageFile").text($scope.imageSelect2).removeClass("text-danger");
                    } else {
                        $scope.imageSelect2 = null;
                        $("#messageFile").text("").addClass("text-danger");
                    }
                    if ($scope.info.status == 3) {
                        $scope.info.paymentDate = "";
                    }
                    $("#checkReqPaymentId").modal("show");
                } else {
                    toastr.error("Có lỗi ở đâu đó...");
                }

            }, function (response) {
                toastr.error("Error");
                $("#checkReqPaymentId").modal("hide");
            }
        );
    }


    $scope.fillData = function (preStatus) {
        if (preStatus == 2 || preStatus == 3) {
            $scope.showFlag = 1;
            $scope.info.prePaymentBy = $scope.info.authName;
            $scope.info.prePaymentDate = moment(new Date()).format("DD/MM/YYYY HH:mm:ss");
            $scope.info.payAmount = $scope.info.amount;
            $scope.info.preDescription = "Congtacvien MBF thanh toan hoa hong " + $scope.info.reqCode;

        }
        if (preStatus == 0) {
            $scope.showFlag = 0;
            $scope.info.preDescription = "";
            $scope.info.prePaymentBy = "";
            $scope.info.prePaymentDate = "";
            $scope.info.payAmount = "";
        }
    }

    $scope.editReqPaymentObj = {};
    $scope.editReqPayment = function (item) {
        checkSesstionTimeOut();
        document.getElementById("editReqPayment").disabled = true;
        if (item.preStatus == null || item.preStatus === '') {
            toastr.error("Vui lòng chọn Trạng thái!");
            document.getElementById("preStatus").focus();
            document.getElementById("editReqPayment").disabled = false;
            return false;
        }
        if ($scope.info.preStatus != 0 && $scope.info.payAmount != $scope.info.amount) {
            toastr.error("Số tiền thanh toán phải bằng số tiền yêu cầu! Vui lòng thử lại");
            document.getElementById("editReqPayment").disabled = false;
            return false;
        }
        $scope.editReqPaymentObj.id = $scope.info.id;
        $scope.editReqPaymentObj.paymentBy = $scope.info.prePaymentBy;
        $scope.editReqPaymentObj.amount = $scope.info.payAmount;
        $scope.editReqPaymentObj.payAmount = $scope.info.payAmount;
        $scope.editReqPaymentObj.description = $scope.info.preDescription;
        $scope.editReqPaymentObj.paymentDate = $scope.info.prePaymentDate

        if (item.status == 0) {
            $scope.editReqPaymentObj.paymentDate = "";
            $scope.editReqPaymentObj.paymentBy = "";
        } else {
            if ($scope.info.preStatus != 0) {
                if (item.payAmount == null || item.payAmount == '') {
                    toastr.error("Vui lòng nhập Số tiền thanh toán!");
                    document.getElementById("payAmount").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }
                if (item.prePaymentBy == null || item.prePaymentBy == '') {
                    toastr.error("Vui lòng nhập Người yêu cầu thanh toán!");
                    document.getElementById("prePaymentBy").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }
                if (item.prePaymentDate == null || item.prePaymentDate == '') {
                    toastr.error("Vui lòng nhập Thời gian yêu cầu!");
                    document.getElementById("prePaymentDate").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }

                var genDatePayment = new Date(item.genDate);

                if (compareDateStringDDMMYYYYHHMMSS($scope.info.prePaymentDate, moment(genDatePayment, 'DD/MM/YYYY HH:mm:ss')) < 0) {
                    toastr.error("Thời gian thanh toán phải lớn hơn Thời gian yêu cầu!");
                    document.getElementById("prePaymentDate").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }
                if (item.preDescription == null || item.preDescription == '') {
                    toastr.error("Vui lòng nhập Ghi chú!")
                    document.getElementById("description").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }
            } else {
                if (item.preDescription == null || item.preDescription == '') {
                    toastr.error("Vui lòng nhập Ghi chú!")
                    document.getElementById("description").focus();
                    document.getElementById("editReqPayment").disabled = false;
                    return false;
                }
            }
        }
        //$scope.editReqPaymentObj.amount = Number(item.amount);
        $scope.editReqPaymentObj.accBalance = Number(item.accBalance);
        $scope.editReqPaymentObj.status = item.preStatus;

        if ($scope.file != null) {
            var form = new FormData();
            form.append("file", $scope.file);
            form.append("type", 2);
            var settings = {
                "async": true,
                "crossDomain": true,
                "url": preUrl + "/common/uploadFiles",
                "method": "POST",
                "headers": {},
                "processData": false,
                "contentType": false,
                "mimeType": "multipart/form-data",
                "data": form
            };
        }
        $.ajax(settings).done(function (response) {
            if ($scope.file != null) {
                $scope.fileDetail = JSON.parse(response);
                $scope.fileDetail.fileName = $scope.fileDetail.name;
                $scope.fileDetail.linkFile = $scope.fileDetail.path;
            }

            var call = {
                reqPayment: $scope.editReqPaymentObj,
                detailFileUpload: $scope.fileDetail,
                flagDelete: $scope.flagDelete
            };
            var param = JSON.parse(JSON.stringify(call));
            $http.post(preUrl + "/reqPayment/update", param, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 0:
                            toastr.success("Xử lý yêu cầu thanh toán thành công!");
                            // setTimeout(function () {
                            //     window.location.replace(preUrl + "/reqPayment/index.html")
                            // }, 1000)
                            break;
                        case 1:
                            toastr.error("Có lỗi xảy ra vui lòng thử lại sau!");
                            break;
                        case 2:
                            toastr.error("Số tiền thanh toán tối thiểu phải lớn hơn 0 cho phương thức thanh toán này!");
                            break;
                        case 3:
                            toastr.error("Yêu cầu thanh toán không tồn tại !");
                            break;
                    }
                    $scope.loadInfoReqPayment();
                    document.getElementById("editReqPayment").disabled = false;
                });
        });

        // }
        // $scope.image.idFile = '';
        // $scope.image.fileName = '';
        // $scope.image.linkFile = '';
        /*if (flag) {
            $scope.info.paymentDate = "";
        }*/
    };

    $scope.file = null;
    $scope.fileValidate = function () {
        var files = event.target.files;
        var text = files[0].name;
        var idxDot = text.lastIndexOf(".") + 1;
        var extFile = text.substr(idxDot, text.length).toLowerCase();
        if (files[0].size / 1024 / 1024 > 10) {
            toastr.error("Chỉ cho phép upload file có dung lượng nhỏ hơn 10mb!");
            angular.element("input[name='file']").val(null);
            return false;
        } else {
            $scope.file = files[0];
        }
    };

    $scope.download = function (type) {
        if (type == 1) {
            if ($scope.info.fileLst == null) {
                toastr.errors("Không tìm thấy file!!");
            }
            const encoded = encodeURI(preUrl + "/common/download?name=" + $scope.info.fileLst.fileName + "&path=" + $scope.info.fileLst.linkFile);
            window.open(encoded, '_blank');
        } else {
            if ($scope.info.filePayment == null) {
                toastr.errors("Không tìm thấy file!!");
            }
            const encoded = encodeURI(preUrl + "/common/download?name=" + $scope.info.filePayment.fileName + "&path=" + $scope.info.filePayment.linkFile);
            window.open(encoded, '_blank');
        }
    }

    $scope.choseFile = function () {
        $('#file').trigger('click');
        $('#file').change(function () {
            var file = this.files[0];
            $("#fileChose").text(file.name);
            $("#fileNotChose").hide()
            $('#rmv1').show();
        })

    }

    $scope.removeFile = function () {
        $scope.file = null;
        $scope.flagDelete = 'true'
        angular.element("input[name='file']").val('');
        $("#fileChose").text('')
        $("#fileNotChose").show()
        $("#rmv1").hide()
    };

    /*--------------------------------------*/
    /*init*/
    $scope.loadInfoReqPayment();
}
]);

