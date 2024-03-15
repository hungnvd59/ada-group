app.controller('frameworkCtrl', ['$scope', '$http', '$locale', '$timeout', '$location', '$q', 'fileUpload', function ($scope, $http, $locale, $timeout, $location, $q, fileUpload) {

    $scope.listPartner = "";
    $scope.partner = "";
    $scope.image = {
        idFile: "",
        fileName: "",
        linkFile: ""
    };

    $scope.getPartner = function () {
        $http.get(preUrl + "/reqPayment/getPartner", {}).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listPartner = response.data;
            }
        });
    }

    $("input[data-type='currency']").on({
        keyup: function () {
            formatCurrency($(this));
        },
        blur: function () {
            formatCurrency($(this), "blur");
        }
    });

    function formatNumber(n)
    {
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

    $scope.searchPartnerDetail = function (id) {
        $http.get(preUrl + "/partner/get?id = " + id, {
            params: {
                id: id
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.partner = response.data;
            }
        });
    };

    $scope.addReqPayment = function (newReq) {
        checkSesstionTimeOut();
        document.getElementById("addReqPayment").disabled = true;
        if (newReq.partnerId == 0) {
            toastr.error('Bạn chưa chọn Cộng tác viên!')
            document.getElementById("partnerId").focus();
            $("#s2id_partnerId").css('border', '1px solid #4fc1c2');
            document.getElementById("addReqPayment").disabled = false;
            return false;
        }
        if (newReq.amount === '' || newReq.amount == null) {
            toastr.error("Bạn chưa nhập Số tiền thanh toán!");
            document.getElementById("newReq.amount").focus();
            document.getElementById("addReqPayment").disabled = false;
            return false;
        }
        if (newReq.description === '' || newReq.description == null) {
            toastr.error("Bạn chưa nhập Ghi chú!");
            document.getElementById("newReq.description").focus();
            document.getElementById("addReqPayment").disabled = false;
            return false;
        }
        newReq.amount = Number(parseFloat(newReq.amount.replace(/,/g,'')));
        $scope.partner.accBalance = Number($scope.partner.accBalance);
        if ($scope.partner.accBalance < newReq.amount) {
            toastr.error('Số dư tài khoản của bạn chưa đủ giá trị tối thiểu để thực hiện yêu cầu!!')
            document.getElementById("newReq.amount").focus();
            document.getElementById("addReqPayment").disabled = false;
            return;
        }

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
                reqPayment: newReq,
                detailFileUpload: $scope.fileDetail
            };

            var param = JSON.parse(JSON.stringify(call));
            $http.post(preUrl + "/reqPayment/addReqPayment", param, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                    switch (Number(response.data)) {
                        case 0:
                            toastr.success("Thêm mới thành công!");
                            setTimeout(function () {
                                $scope.returnIndex()
                            }, 1000)
                            break;
                        case 1:
                            toastr.error("Có lỗi xảy ra vui lòng thử lại sau!");
                            break;
                        case 2:
                            toastr.error("Số tiền thanh toán phải lớn hơn hoặc bằng 100.000 VNĐ cho phương thức thanh toán này!");
                            break;
                        case 4:
                            toastr.error("Tài khoản chưa cập nhật đầy đủ thông tin CMND/CCCD và thông tin ngân hàng!");
                            break;
                        case 5:
                            toastr.error("Tên tài khoản ngân hàng và Họ tên trên CMND/CCCD khi đăng ký không trùng khớp");
                            break;
                        case 6:
                            toastr.error(" CTV đang tồn tại yêu cầu thanh toán Chờ xử lý!");
                            break;
                        case 7:
                            toastr.error("CTV đang tồn tại yêu cầu thanh toán Đang xử lý!");
                            break;
                    }
                    $scope.resetFile();
                    document.getElementById("addReqPayment").disabled = false;
                });
        });

        // if (flag) {
        //     $scope.newReq.paymentDate = "";
        // }
    };
    $scope.resetFile = function () {
        $scope.image.idFile = '';
        $scope.image.fileName = '';
        $scope.image.linkFile = '';
        $scope.file = null;
        $scope.fileDetail = {};
        angular.element("input[type='file']").val(null);
    }

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

    $scope.removeFile = function () {
        $scope.file = null;
        angular.element("input[name='file']").val(null);
    };

    $scope.returnIndex = function () {
        window.location.replace(preUrl + "/reqPayment/index.html");
    }

    $scope.getPartner();
}
]);

