app.controller('frameworkCtrl', ['$scope', '$http', '$locale', '$timeout', '$q', 'fileUpload', function ($scope, $http, $locale, $timeout, $q, fileUpload) {
    $locale.NUMBER_FORMATS.GROUP_SEP = ".";
    $locale.NUMBER_FORMATS.DECIMAL_SEP = ",";
    $scope.labelPopup = "KIỂM DUYỆT YÊU CẦU THANH TOÁN";

    $scope.page = page;
    $scope.partnerName = '';
    $scope.file = '';
    $scope.type = '';
    $scope.flag = '';
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

    $scope.partnerId = "";
    $scope.idPartner = "";

    $scope.totalRecord = "";

    $scope.listData = {
        items: "",
        rowCount: 0,
        numberPerPage: $scope.numberPerPage,
        pageNumber: 1,
        pageList: [],
        pageCount: 0,
        checkLast: 0
    };

    // ------------------- partner--------------------------
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

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            $scope.search();
        }
    });

    $("#info-paymentDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY HH:mm:ss',
        maxDate: 'now',
        sideBySide: true
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.info.paymentDate = $(this).val();
        }
    });

    $("#paymentDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY HH:mm:ss',
        maxDate: 'now',
        sideBySide: true
    }).on('dp.change', function (e) {
        if (e != null) {
            $scope.newReq.paymentDate = $(this).val();
        }
    });

    $("#fromGenDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY',
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
            $scope.fromGenDate = $(this).val();
        }
    });

    $("#toGenDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY',
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
            $scope.toGenDate = $(this).val();
        }
    });

    $("#frmDate").datetimepicker({
        format: 'DD/MM/YYYY HH:mm',
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
//                    $scope.affCode.frmDate = $(this).val();
            if ($('#frmDate').val() != "")
                $('#expDate').data("DateTimePicker").minDate(moment($('#frmDate').val(), "DD/MM/YYYY HH:mm").toDate());
        }
    });

    $("#expDate").datetimepicker({
        format: 'DD/MM/YYYY HH:mm',
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
//                    $scope.affCode.expDate = $(this).val();
            if ($('#expDate').val() != "")
                $('#frmDate').data("DateTimePicker").maxDate(moment($('#expDate').val(), "DD/MM/YYYY HH:mm").toDate());
        }
    });

    $("#fromPaymentDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY',
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
            $scope.fromPaymentDate = $(this).val();
        }
    });

    $("#toPaymentDate").datetimepicker({
        locale: 'vi-VN',
        format: 'DD/MM/YYYY',
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
            $scope.toPaymentDate = $(this).val();
        }
    });
    $(document).ready(function () {

        $('input.currency').currencyInput();

    });


    $http.get(preUrl + "/reqPayment/search", {
        params: {
            pageNumber: $scope.listData.pageNumber,
            mobile: $scope.mobile,
            status: $scope.status,
            fromGenDate: $scope.fromGenDate,
            toGenDate: $scope.toGenDate,
            fromPaymentDate: $scope.fromPaymentDate,
            toPaymentDate: $scope.toPaymentDate,
            reqCode: $scope.reqCode
        }
    })
        .then(function (response) {
            $scope.listData = response.data;
            $scope.listData.amount = response.data.amount;
            $scope.totalRecord = response.data.items.length;
            $scope.listData.numberPerPage = $scope.numberPerPage;
            $scope.listData.pageCount = $scope.listData.pageCount;
            $scope.listData.pageList = $scope.listData.pageList;
            $scope.page = response.data;
        });

    $scope.search = function () {
        $scope.listData.pageNumber = 1;
        $scope.loadListData();
    };

    /*reload list*/
    $scope.loadListData = function () {
        $http.get(preUrl + "/reqPayment/search", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.numberPerPage,
                mobile: $scope.mobile,
                status: $scope.status,
                fromDate: $scope.fromGenDate,
                toDate: $scope.toGenDate,
                fromPaymentDate: $scope.fromPaymentDate,
                toPaymentDate: $scope.toPaymentDate,
                reqCode: $scope.reqCode
            }
        })
            .then(function (response) {
                $scope.listData = response.data;
                $scope.totalRecord = response.data.length;
                $scope.listData.amount = response.data.amount;
                $scope.listData.numberPerPage = $scope.numberPerPage;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
                $scope.page = response.data;
            }, function (response) {
                toastr.error("loi");
            });
    };

    /*reload page*/
    $scope.loadPageData = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/reqPayment/search", {
            params: {
                pageNumber: $scope.listData.pageNumber,
                numberPerPage: $scope.numberPerPage,
                mobile: $scope.mobile,
                status: $scope.status,
                fromDate: $scope.fromGenDate,
                toDate: $scope.toGenDate,
                fromPaymentDate: $scope.fromPaymentDate,
                toPaymentDate: $scope.toPaymentDate,
                reqCode: $scope.reqCode
            }
        })
            .then(function (response) {
                $scope.listData = response.data;
                $scope.totalRecord = response.data.length;
                $scope.listData.amount = response.data.amount;
                $scope.listData.numberPerPage = $scope.numberPerPage;
                $scope.listData.pageCount = $scope.listData.pageCount;
                $scope.listData.pageList = $scope.listData.pageList;
                $scope.page = response.data;
            }, function (response) {
                toastr.error("loi");
            });
    };

    $scope.loadView = function (idReqPayment) {
        $scope.labelPopup = "THÔNG TIN THANH TOÁN";
        checkSesstionTimeOut();
        $scope.isDisabled = true;
        $scope.loadInfoReqPayment(idReqPayment);
    }

    $scope.loadEdit = function (idReqPayment) {
        $scope.labelPopup = "THÔNG TIN YÊU CẦU THANH TOÁN";
        checkSesstionTimeOut();
        $scope.isDisabled = false;
        $scope.loadInfoReqPayment(idReqPayment);
    }

    $scope.loadInfoReqPayment = function (idReqPayment) {
        $scope.partnerId = idReqPayment.partnerId;
        checkSesstionTimeOut();
        angular.element("input[type='file']").val(null);
        $http.get(preUrl + "/reqPayment/loadInfoReqPayment", {
            params: {
                id: idReqPayment.id,
                status: idReqPayment.status,
            }
        }).then(function (response) {
                if (response.data != "" && response.data != null && response.data != undefined) {
                    $scope.info = response.data;
                    $scope.info.preStatus = $scope.info.status;
                    if ($scope.info.status == 1) {
                        $scope.info.status = "";
                        $scope.info.preStatus = "";
                        $scope.info.paymentBy = "";
                        $scope.info.paymentDate = "";
                        $scope.info.payAmount = "";
                    }
                    if ($scope.info.status == 0) {
                        $scope.info.paymentBy = "";
                        $scope.info.paymentDate = "";
                        $scope.info.preDescription = $scope.info.description;
                        $scope.info.payAmount = "";
                    }
                    if ($scope.info.genDate != null && $scope.info.genDate != "") {
                        $scope.info.genDate = moment(response.data.genDate).format("DD/MM/YYYY HH:mm:ss");
                    }
                    if ($scope.info.paymentDate != null && $scope.info.paymentDate != "") {
                        $scope.info.paymentDate = moment(response.data.paymentDate).format("DD/MM/YYYY HH:mm:ss");
                    }
                    if ($scope.info.payment != null) {
                        $scope.info.payAmount = $scope.info.payment.amount;
                        $scope.info.paymentBy = $scope.info.payment.paymentBy;
                        $scope.info.paymentDate = moment($scope.info.payment.paymentDate).format("DD/MM/YYYY HH:mm:ss");
                        ;
                    }
                    if ($scope.info.bankInfoStatusVerify != null && $scope.info.bankInfoStatusVerify == "1") {
                        $('#bankInfoStatusVerify').prop('checked', true);
                    } else {
                        $('#bankInfoStatusVerify').prop('checked', false);
                    }
                    $scope.info.fileLst = response.data.fileLst;
                    if ($scope.info.fileLst != null) {
                        $scope.imageSelect = response.data.fileLst.fileName;
                        $("#messageFiles").text($scope.imageSelect).removeClass("text-danger");
                    } else {
                        $scope.imageSelect = null;
                        $("#messageFiles").text("").addClass("text-danger");
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
                } else {
                    toastr.error("Có lỗi ở đâu đó...");
                }

            }, function (response) {
                toastr.error("Error");
            }
        );
    }

    $scope.preAddReqPayment = function () {
        $scope.newReq = {
            id: "",
            partnerId: "",
            reqPartnerName: "",
            accBalance: "",
            mobile: "",
            amount: "",
            content: "",
            sourceRequest: "",
            accBank: "",
            accBranch: "",
            accNumber: "",
            accName: "",
            status: "",
            paymentBy: "",
            paymentDate: "",
            description: "",
            totalAmount: ""
        };
        $scope.image = {
            idFile: "",
            fileName: "",
            linkFile: ""
        };

        $('#paymentDate').val("");
//        $('#bankInfoStatusVerify2').prop('checked',false);
        $scope.idPartner = "";
        angular.element("input[type='radio']").val(null);
        angular.element("input[type='file']").val(null);
    };

    $scope.getListPartner = function () {
        $http.get(preUrl + "/partner/search", {
            params: {
                pageNumber: $scope.partner.pageNumber,
                numberPerPage: $scope.numberPerPagePartner
            }
        })
            .then(function (response) {
                $scope.partner = response.data;
                $scope.partner.numberPerPage = $scope.numberPerPagePartner;
                $scope.partner.pageCount = getPageCount($scope.partner);
                $scope.partner.pageList = getPageList($scope.partner);
                $scope.page = response.data;
                var list = document.querySelectorAll('input[type="radio"]:checked');
                list.forEach(element => {
                        if (element.checked) {
                            element.checked = false
                        }
                    }
                );
            }, function (response) {
                toastr.error("Không thể lấy danh sách cộng tác viên");
                return;
            });
    }

    $scope.preSelectPartner = function (item) {
        $scope.idPartner = item.id;
    }

    $scope.setPartner = function () {
        if ($scope.idPartner == undefined || $scope.idPartner == null || $scope.idPartner === '') {
            toastr.error("Chọn cộng tác viên !!!");
            return;
        }
        $http.get(preUrl + "/partner/findById", {
            params: {
                id: $scope.idPartner
            }
        })
            .then(function (response) {
                $scope.newReq.partnerId = response.data.id;
                $scope.newReq.reqPartnerName = response.data.partnerName;
                $scope.newReq.accBalance = response.data.accBalance;
                $scope.newReq.mobile = response.data.mobile;
                $scope.newReq.accBank = response.data.accBank;
                $scope.newReq.accBranch = response.data.accBranch;
                $scope.newReq.accNumber = response.data.accNumber;
                $scope.newReq.accName = response.data.accName;
                $scope.newReq.totalAmount = response.data.totalAmount;
                $scope.fee = response.data.fee;
//                if (response.data.bankInfoStatusVerify != null && response.data.bankInfoStatusVerify == "1") {
//                    $('#bankInfoStatusVerify2').prop('checked',true);
//                } else {
//                    $('#bankInfoStatusVerify2').prop('checked',false);
//                }
            }, function (response) {
                toastr.error("Có lỗi khi chọn cộng tác viên!!");
                return;
            });
    }

    $scope.addReqPayment = function (newReq) {
        checkSesstionTimeOut();
        if ($("#addReqPaymentForm").parsley().validate()) {

            var sList = ["$", ",", "₫", ".", " "];
            var paymentDate = $("#paymentDate").val();

            if (newReq.partnerId == '' || newReq.reqPartnerName == '') {
                toastr.error('Bạn chưa chọn Cộng tác viên!')
                return false;
            }
            for (var i = 0; i < sList.length; i++) {
                if (newReq.accBalance.toString().indexOf(sList[i]) > 0) {
                    newReq.accBalance = (newReq.accBalance.replace(sList[i], ""));
                    if (i > 0) {
                        i--;
                    }
                }
                if (newReq.totalAmount.toString().indexOf(sList[i]) > 0) {
                    newReq.totalAmount = (newReq.totalAmount.replace(sList[i], ""));
                    if (i > 0) {
                        i--;
                    }
                }
                if (newReq.amount.toString().indexOf(sList[i]) > 0) {
                    newReq.amount = (newReq.amount.replace(sList[i], ""));
                    if (i > 0) {
                        i--;
                    }
                }
            }
            newReq.amount = Number(newReq.amount);
            newReq.accBalance = Number(newReq.accBalance);
            if (newReq.accBalance < newReq.amount) {
                toastr.error('Số dư tài khoản của bạn chưa đủ giá trị tối thiểu để thực hiện yêu cầu!!')
                return;
            }

            if ($scope.file != null) {
                var form = new FormData();
                form.append("file", $scope.file);
                form.append("type", 1);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": preUrl + "/common/upload",
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
                }
                var call = {
                    reqPayment: newReq,
                    detailFileUpload: $scope.fileDetail
                };

                var param = JSON.parse(JSON.stringify(call));
                $http.post(preUrl + "/reqPayment/addReqPayment", param, {headers: {'Content-Type': 'application/json'}})
                    .then(function (response) {
                        switch (Number(response.data)) {
                            case 0:
                                toastr.success("Thêm mới thành công!");
                                break;
                            case 1:
                                toastr.error("Có lỗi xảy ra vui lòng thử lại sau!");
                                break;
                            case 2:
                                toastr.error("Số tiền thanh toán > 0 VNĐ cho phương thức thanh toán này!");
                                break;
                            case 4:
                                toastr.error("Tạo yêu cầu thanh toán không thành công! Tài khoản chưa cập nhật đầy đủ thông tin CMND/CCCD và thông tin ngân hàng!");
                                break;
                            case 5:
                                toastr.error("Tên tài khoản ngân hàng và Họ tên trên CMND/CCCD khi đăng ký không trùng khớp");
                                break;
                            case 6:
                                toastr.error("Tạo yêu cầu thanh toán không thành công do đang có một yêu cầu trước đó chưa được xử lý!");
                                break;
                        }
                        $scope.resetFile();
                    });
            });
        }

        // if (flag) {
        //     $scope.newReq.paymentDate = "";
        // }
    };

    $scope.editReqPayment = function (info) {
        checkSesstionTimeOut();
        var flag = false;
        if (info.paymentDate == "" || info.paymentDate == null) {
            flag = true;
        }
        if (info.status == null || info.status === '') {
            toastr.error("Bạn chưa chọn trạng thái!");
            return false;
        }
        if (info.status == 0) {
            info.paymentDate = "";
            info.paymentBy = "";
        } else {
            if (info.payAmount == null || info.payAmount == '') {
                toastr.error("Số tiền thanh toán không được bỏ trống!");
                return false;
            }
            if (info.paymentBy == null || info.paymentBy == '') {
                toastr.error("Người thanh toán không được bỏ trống!");
                return false;
            }
            if (info.paymentDate == null || info.paymentDate == '') {
                toastr.error("Thời gian thanh toán không được bỏ trống!");
                return false;
            }

            if (compareDateStringDDMMYYYYHHMMSS(info.paymentDate, info.genDate) < 0) {
                toastr.error("Thời gian thanh toán phải lớn hơn Thời gian yêu cầu!");
                return false;
            }
        }
        info.amount = Number(info.amount);
        info.accBalance = Number(info.accBalance);
        info.genDate = Number(new Date(moment(info.genDate).format("DD/MM/YYYY HH:mm:ss")).getTime());

        if ($scope.file != null) {
            var form = new FormData();
            form.append("file", $scope.file);
            form.append("type", 1);
            var settings = {
                "async": true,
                "crossDomain": true,
                "url": preUrl + "/common/upload",
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
            }

            var call = {
                reqPayment: info,
                detailFileUpload: $scope.fileDetail
            };
            var param = JSON.parse(JSON.stringify(call));
            $http.post(preUrl + "/reqPayment/update", param, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 0:
                            toastr.success("Xử lý yêu cầu thanh toán thành công!!");
                            break;
                        case 1:
                            toastr.error("Có lỗi xảy ra vui lòng thử lại sau!");
                            break;
                        case 2:
                            toastr.error("Số tiền thanh toán tối thiểu 100.000 VNĐ cho phương thức thanh toán này!");
                            break;
                        case 3:
                            toastr.error("Yêu cầu thanh toán không tồn tại !");
                            break;
                    }
                    $scope.resetFile();
                });

        });
        // }
        // $scope.image.idFile = '';
        // $scope.image.fileName = '';
        // $scope.image.linkFile = '';
        if (flag) {
            $scope.info.paymentDate = "";
        }
    };

// ------------------- partner--------------------------

    $scope.searchPartner = function () {
        $scope.listData.pageNumber = 1;
        $scope.loadListPartner();
    };

    $scope.loadListPartner = function () {
        $http.get(preUrl + "/partner/search", {
            params: {
                partnerName: $scope.namePartner,
                pageNumber: $scope.partner.pageNumber,
                numberPerPage: $scope.numberPerPagePartner
            }
        })
            .then(function (response) {
                $scope.partner = response.data;
                $scope.partner.numberPerPage = $scope.numberPerPagePartner;
                $scope.partner.pageCount = getPageCount($scope.partner);
                $scope.partner.pageList = getPageList($scope.partner);
                $scope.page = response.data;
                if ($scope.partner.items.length == 0) {
                    $http.get(preUrl + "/partner/search", {
                        params: {
                            pageNumber: $scope.partner.pageNumber,
                            numberPerPage: $scope.numberPerPagePartner
                        }
                    })
                        .then(function (response) {
                            $scope.partner = response.data;
                            $scope.partner.numberPerPage = $scope.numberPerPagePartner;
                            $scope.partner.pageCount = getPageCount($scope.partner);
                            $scope.partner.pageList = getPageList($scope.partner);
                            $scope.page = response.data;
                        }, function (response) {
                            toastr.error("Có lỗi");
                        });
                }
            }, function (response) {
                toastr.error("Có lỗi");
            });
    };

    $scope.loadPagePartner = function (index) {
        $scope.partner.pageNumber = index;
        $http.get(preUrl + "/partner/search", {
            params: {
                partnerName: $scope.namePartner,
                pageNumber: $scope.partner.pageNumber,
                numberPerPage: $scope.numberPerPagePartner
            }
        })
            .then(function (response) {
                $scope.partner = response.data;
                $scope.partner.numberPerPage = $scope.numberPerPagePartner;
                $scope.partner.pageCount = getPageCount($scope.partner);
                $scope.partner.pageList = getPageList($scope.partner);
                $scope.page = response.data;
            }, function (response) {
                toastr.error("loi");
                return;
            });
    };

    $scope.setNumberPerPagePartner = function (numberPerPage) {
        $scope.numberPerPagePartner = numberPerPage;
        $scope.searchPartner();
    };

    $scope.isDisabledRadio = function (accBalance, status) {
        if (accBalance <= 0 || accBalance === null || status !== 1) {
            return true;
        } else {
            return false;
        }
    };

    $scope.isShowClearButton = function () {
        if ($scope.image.idFile == '' && $scope.image.fileName == '' && $scope.image.linkFile == '') {
            return false;
        } else {
            return true;
        }
    }

// ----------------- End partner------------------------

    $scope.exportExcelReqPayment = function () {
        checkSesstionTimeOut();
        window.open(preUrl + "/reqPayment/exportExcel?partnerName=" + $scope.partnerName + "&status=" + $scope.status + "&numberPer=" + $scope.listData.rowCount + "&fromDate=" + $scope.fromGenDate + "&toDate=" + $scope.toGenDate + "&type=0" + "&fromPaymentDate=" + $scope.fromPaymentDate + "&toPaymentDate=" + $scope.toPaymentDate + "&reqCode=" + $scope.reqCode, '_blank');
    }

    $scope.exportExcelReqPayment2 = function () {
        checkSesstionTimeOut();
        if ($scope.status === 2 || $scope.status === 0) {
            toastr.error("Chỉ xuất file thanh toán trạng thái chờ duyệt hoặc đang xử lý!");
            return false;
        }
        window.open(preUrl + "/reqPayment/exportExcel?partnerName=" + $scope.partnerName + "&status=" + $scope.status + "&numberPer=" + $scope.listData.rowCount + "&fromDate=" + $scope.fromGenDate + "&toDate=" + $scope.toGenDate + "&type=1" + "&fromPaymentDate=" + $scope.fromPaymentDate + "&toPaymentDate=" + $scope.toPaymentDate + "&reqCode=" + $scope.reqCode, '_blank');
    }

    $scope.fileValidate = function (event) {
        checkSesstionTimeOut();
        var files = event.target.files;
        var text = files[0].name;
        var idxDot = text.lastIndexOf(".") + 1;
        var extFile = text.substr(idxDot, text.length).toLowerCase();
        if (extFile == "jpeg" || extFile == "jpg" || extFile == "img" || extFile == "png" || extFile == "doc" || extFile == "docx" || extFile == "pdf" || extFile == "zip" || extFile == "rar" || extFile == "xls" || extFile == "xlsx") {
            //TO DO
            //check file size max 5mb
            if (files[0].size / 1024 / 1024 > 25) {
                toastr.error("Chỉ cho phép upload file có dung lượng nhỏ hơn 25mb!");
                $scope.resetFile();
                return false;
            } else {
                return true;
            }
        } else {
            toastr.error("Chỉ cho phép upload file định dạng jpeg, jpg, img, png, doc, docx, pdf, zip, rar, xls, xlsx!");
            $scope.resetFile();
            return false;
        }
    }

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

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.numberPerPage = numberPerPage;
        $scope.search();
    };

    $scope.resetFormAdd = function () {
        $scope.newReq = {
            id: "",
            partnerId: "",
            reqPartnerName: "",
            accBalance: "",
            mobile: "",
            amount: "",
            content: "",
            sourceRequest: "",
            accBank: "",
            accBranch: "",
            accNumber: "",
            accName: "",
            status: "",
            paymentBy: "",
            paymentDate: "",
            description: "",
            totalAmount: ""
        };
        $scope.image.idFile = '';
        $scope.image.fileName = '';
        $scope.image.linkFile = '';
        angular.element("input[type='radio']").val(null);
        angular.element("input[type='file']").val(null);
    }

    $scope.resetFormEdit = function () {
        $scope.info.paymentBy = "";
        $scope.info.payAmount = "";
        $scope.info.paymentDate = "";
        $scope.info.description = $scope.info.preDescription;
        $scope.info.status = $scope.info.preStatus;
        $scope.image.idFile = '';
        $scope.image.fileName = '';
        $scope.image.linkFile = '';
        angular.element("input[type='file']").val(null);
    }

    $scope.resetValue = function () {
        $scope.mobile = '';
        $scope.type = '';
        $scope.status = '';
        $scope.fromGenDate = '';
        $scope.toGenDate = '';
        $scope.fromPaymentDate = '';
        $scope.toPaymentDate = '';
        $scope.reqCode = '';
        $("#fromGenDate").val("");
        $("#toGenDate").val("");
        $("#fromPaymentDate").val("");
        $("#toPaymentDate").val("");
    }

    $scope.resetFile = function () {
        $scope.image.idFile = '';
        $scope.image.fileName = '';
        $scope.image.linkFile = '';
        $scope.file = null;
        $scope.fileDetail = {};
        angular.element("input[type='file']").val(null);
    }

// ------------------Format value-----------------
    $.fn.currencyInput = function () {
        this.each(function () {
            var wrapper = $("<div class='currency-input'/>");
            $(this).wrap(wrapper);
            $(this).before("<span class='currency-symbol' style='float: right'>VNĐ</span>");
        });
    };

    $("input[data-type='currency']").on({
        keyup: function () {
            formatCurrency($(this));
        },
        blur: function () {
            formatCurrency($(this), "blur");
        }
    });

    function formatNumber(n) {
        // format number 1000000 to 1,234,567
        return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }

    function formatCurrency(input, blur) {
        // appends $ to value, validates decimal side
        // and puts cursor back in right position.
        // get input value
        var input_val = input.val();
        // don't validate empty input
        if (input_val === "") {
            return;
        }
        // original length
        var original_len = input_val.length;
        // initial caret position
        var caret_pos = input.prop("selectionStart");
        // check for decimal
        if (input_val.indexOf(".") >= 0) {
            // get position of first decimal
            // this prevents multiple decimals from
            // being entered
            var decimal_pos = input_val.indexOf(".");
            // split number by decimal point
            var left_side = input_val.substring(0, decimal_pos);
            var right_side = input_val.substring(decimal_pos);
            // add commas to left side of number
            left_side = formatNumber(left_side);
            // validate right side
            right_side = formatNumber(right_side);
            // On blur make sure 2 numbers after decimal
            if (blur === "blur") {
                right_side += "00";
            }
            // Limit decimal to only 2 digits
            right_side = right_side.substring(0, 2);
            // join number by .
            input_val = left_side + "." + right_side;
        } else {
            // no decimal entered
            // add commas to number
            // remove all non-digits
            input_val = formatNumber(input_val);
        }
        // send updated string to input
        input.val(input_val);
        // put caret back in the right position
        var updated_len = input_val.length;
        caret_pos = updated_len - original_len + caret_pos;
        input[0].setSelectionRange(caret_pos, caret_pos);
    }

    $scope.uploadFile = function () {
        if (event.target.files[0] != undefined) {
            var file = event.target.files[0];
            var uploadUrl = preUrl + "/common/uploadFiles";
            fileUpload.uploadFileToUrl(file, uploadUrl)
                .then(function (response) {
                        if (response.data != null && response.data != undefined && response.status == 200) {
                            $scope.image.idFile = response.data.idFile;
                            $scope.image.fileName = response.data.name;
                            $scope.image.linkFile = response.data.path;
                        } else {
                            toastr.error("Có lỗi, xin vui lòng thử lại sau!!");
                            angular.element("input[type='file']").val(null);
                            $scope.image.idFile = '';
                            $scope.image.fileName = '';
                            $scope.image.linkFile = '';
                        }
                    },
                    function (response) {
                        toastr.error("Có lỗi, xin vui lòng thử lại sau!!");
                        angular.element("input[type='file']").val(null);
                        $scope.image.idFile = '';
                        $scope.image.fileName = '';
                        $scope.image.linkFile = '';
                    }
                );
        }
    };

    $scope.file = null;

    $scope.fileChange = function (event) {
        checkSesstionTimeOut();

        var files = event.target.files;
        $scope.file = files;
        var text = files[0].name;

        var idxDot = text.lastIndexOf(".") + 1;
        var extFile = text.substr(idxDot, text.length).toLowerCase();
        if (text.lastIndexOf(".") <= 0) {
            toastr.error("File không hợp lệ!");
            return false;
        }
        if (extFile == "xlsx") {
            //check file size max 5mb
            if (files[0].size / 1024 / 1024 > 5) {
                toastr.error("Chỉ cho phép upload file excel có dung lượng nhỏ hơn 5mb!");
                return false;
            } else {
                // $('#file-selected').text(text);
            }
        } else {
            toastr.error("Chỉ cho phép upload file định dạng: xlsx! ");
            return false;
        }

    };

    $scope.importPaymentFile = function () {
        if ($scope.file != null) {
            var fd = new FormData();
            fd.append('multipartFile', $scope.file[0]);
            $('#btnImportFile').attr('disabled', 'disabled');
            $http.post(preUrl + "/reqPayment/uploadFile", fd, {
                transformRequest: angular.identity,
                contentType: false,
                processData: false,
                headers: {'Content-Type': undefined}
            })
                .then(function (response) {
                    if (response.data != null && response.data != undefined) {
                        toastr.success("Import thành công: " + response.data.rowSuccess + " dòng");
                        $scope.search();
                        $('#btnImportFile').removeAttr('disabled');
                    } else {
                        toastr.error("Import không thành công: ", response.data.rowError + " dòng");
                        $scope.search();
                        $('#btnImportFile').removeAttr('disabled');
                    }
                });
        } else {
            toastr.error("Bạn chưa chọn file import!");
        }
    }

//    const checkbox = document.getElementById('bankInfoStatusVerify');
//    const checkbox2 = document.getElementById('bankInfoStatusVerify2');
//    checkbox.addEventListener('change', (event) => {
//        if (event.currentTarget.checked) {
//        $scope.bankInfoStatusVerify = 1;
//    } else {
//        $scope.bankInfoStatusVerify = 0;
//    }
//
//    $http.get(preUrl + "/reqPayment/xac-thuc-thong-tin-ngan-hang", {params: {bankInfoStatusVerify: $scope.bankInfoStatusVerify, partnerId: $scope.partnerId}})
//        .then(function (response) {
//            switch (Number(response.data)) {
//                case 0:
//                    toastr.warning("Hủy xác thực thông tin thành công!");
//                    break;
//                case 1:
//                    toastr.success("Xác thực thông tin thành công!");
//                    break;
//                case 2:
//                    toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại sau!");
//                    break;
//            }
//        }, function (response) {
//            toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại sau!");
//        });
//});
//    checkbox2.addEventListener('change', (event) => {
//    if (event.currentTarget.checked) {
//        $scope.bankInfoStatusVerify2 = 1;
//    } else {
//        $scope.bankInfoStatusVerify2 = 0;
//    }
//
//
//    if ($scope.idPartner == null || $scope.idPartner == "") {
//        toastr.error("Bạn chưa chọn CTV!");
//        $('#bankInfoStatusVerify2').prop('checked',false);
//        return false;
//    }
//    $http.get(preUrl + "/reqPayment/bankInfoStatusVerify", {params: {bankInfoStatusVerify: $scope.bankInfoStatusVerify2, partnerId: $scope.idPartner}})
//        .then(function (response) {
//            switch (Number(response.data)) {
//                case 0:
//                    toastr.warning("Hủy xác nhận thông tin thành công!");
//                    break;
//                case 1:
//                    toastr.success("Xác nhận thông tin thành công!");
//                    break;
//                case 2:
//                    toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại sau!");
//                    break;
//            }
//        }, function (response) {
//            toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại sau!");
//        });
//});


    $scope.linkDetailCtv = function (info) {
        window.location = preUrl + "/ctv/detail/" + info.partnerId;
    };

    $scope.reqProcess = {};
    $scope.preConfirmPayment = function (item) {
        checkSesstionTimeOut();
        $scope.reqProcess = item;
        $('#mdConfirmPayment').modal('show');
    }

    $scope.confirmPayment = function (item) {
        $http.get(preUrl + "/reqPayment/confirmPayment", {params: {id: item.id}})
            .then(function (response) {
                switch (Number(response.data)) {
                    case 1:
                        $('#mdConfirmPayment').modal('hide');
                        toastr.success("Xác nhận thanh toán thành công!");
                        $scope.reqProcess = {};
                        break;
                    case 2:
                        toastr.error("Hệ thống đang bận vui lòng thử lại sau!");
                        break;
                    case 3:
                        toastr.error("Hệ thống đang bận vui lòng thử lại sau!");
                        break;
                }
            }, function (response) {
                toastr.error("Hệ thống đang bận vui lòng thử lại sau!");
            });
    }

    $scope.importPaymentFile = function () {
        if ($scope.file != null) {
            var fd = new FormData();
            fd.append('multipartFile', $scope.file[0]);
            $('#btnImportFile').attr('disabled', 'disabled');
            $http.post(preUrl + "/reqPayment/uploadFile", fd, {
                transformRequest: angular.identity,
                contentType: false,
                processData: false,
                headers: {'Content-Type': undefined}
            })
                .then(function (response) {
                    if (response.data != null && response.data != undefined) {
                        toastr.success("Import thành công: " + response.data.rowSuccess + " dòng");
                        $scope.search();
                    } else {
                        toastr.error("Import không thành công: ", response.data.rowError + " dòng");
                        $scope.search();
                    }
                });
        } else {
            toastr.error("Bạn chưa chọn file import!");
        }
    }
}]);

