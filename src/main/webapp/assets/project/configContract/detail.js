app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$location', '$q', function ($scope, $http, $timeout, $location, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 25, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.name = "";
    $scope.description = "";
    $scope.status = 1;
    $scope.mobilePartner = "";
    $scope.fromDate = "";
    $scope.toDate = "";
    $scope.partnerToConfigBody = {};

    $scope.logs = [];
    $scope.m_bl_pre_bonus = "";
    $scope.m_bl_pre_osp = "";
    $scope.m_bl_pre_ctv = "";
    $scope.m_bl_pre_ref = "";
    $scope.m_bl_pre_osp_value = 0;
    $scope.m_bl_pre_ctv_value = 0;
    $scope.m_bl_pre_ref_value = 0;

    $scope.m_bl_post_bonus = "";
    $scope.m_bl_post_osp = "";
    $scope.m_bl_post_ctv = "";
    $scope.m_bl_post_ref = "";
    $scope.m_bl_post_osp_value = 0;
    $scope.m_bl_post_ctv_value = 0;
    $scope.m_bl_post_ref_value = 0;

    $scope.m_package_osp = "";
    $scope.m_package_ctv = "";
    $scope.m_package_ref = "";

    $scope.vnp_package_osp = "";
    $scope.vnp_package_ctv = "";

    $scope.checkHH = 0;
    $scope.checkSS = 0;
    $scope.checkGC = 0;
    $scope.checkDS = 0;

    var hh1 = document.getElementById("hh1");
    var hh2 = document.getElementById("hh2");
    $('#HH').click(function () {
        if ($scope.checkHH == 0) {
            hh1.style.display = "none";
            hh2.style.display = "block";
            $scope.checkHH = 1;
        } else {
            hh2.style.display = "none";
            hh1.style.display = "block";
            $scope.checkHH = 0;
        }
    });

    var ss1 = document.getElementById("ss1");
    var ss2 = document.getElementById("ss2");
    $('#SS').click(function () {
        if ($scope.checkSS == 0) {
            ss1.style.display = "none";
            ss2.style.display = "block";
            $scope.checkSS = 1;
        } else {
            ss2.style.display = "none";
            ss1.style.display = "block";
            $scope.checkSS = 0;
        }
    });

    var gc1 = document.getElementById("gc1");
    var gc2 = document.getElementById("gc2");
    $('#GC').click(function () {
        if ($scope.checkGC == 0) {
            gc1.style.display = "none";
            gc2.style.display = "block";
            $scope.checkGC = 1;
        } else {
            gc2.style.display = "none";
            gc1.style.display = "block";
            $scope.checkGC = 0;
        }
    });

    var ds1 = document.getElementById("ds1");
    var ds2 = document.getElementById("ds2");
    $('#DS').click(function () {
        if ($scope.checkDS == 0) {
            ds1.style.display = "none";
            ds2.style.display = "block";
            $scope.checkDS = 1;
        } else {
            ds2.style.display = "none";
            ds1.style.display = "block";
            $scope.checkDS = 0;
        }
    });

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

    $scope.configDetail = {};
    $scope.addObj = {};
    $scope.editObj = {};
    $scope.listName = {};
    $scope.nameCount = 0;
    $scope.listPartner = {};
    $scope.objOld = {};
    $scope.udpateConfigId = {};
    $scope.listConfigFilter = []
    $scope.params = getParameters($location.absUrl());
    console.log("ID: " + $scope.params.id);

    $(document).ready(function () {
        $("#fromDate").datetimepicker({
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
                $scope.fromDate = $(this).val();
            }
        })

        $("#toDate").datetimepicker({
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
                $scope.toDate = $(this).val();
            }
        })
    });

    $scope.getTotal = function (pageNumber) {
        $http.get(preUrl + "/config-contract/getPartnerConfig", {
            params: {
                p: pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                mobilePartner: $scope.mobilePartner,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate,
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.totalPartner = response.data.rowCount;
            }
        });
    }

    $scope.getPartnerConfig = function (pageNumber) {
        $http.get(preUrl + "/config-contract/getPartnerConfig", {
            params: {
                p: pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                mobilePartner: $scope.mobilePartner,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate,
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listData = response.data;
                $scope.listPartner = $scope.listData.items;
                $scope.listPartnerBak = $scope.listData.items;
                $scope.totalPartner = $scope.listData.rowCount;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        });
    }

    /*reload page*/
    $scope.loadPage = function (index) {
        $scope.listData.pageNumber = index;
        $http.get(preUrl + "/config-contract/getPartnerConfig", {
            params: {
                p: $scope.listData.pageNumber,
                numberPerPage: $scope.listData.numberPerPage,
                mobilePartner: $scope.mobilePartner,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate,
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listData = response.data;
                $scope.listPartner = $scope.listData.items;
                $scope.totalPartner = $scope.listData.rowCount;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
            }
        });
    };

    $scope.getNameConfig = function () {
        $http.get(preUrl + "/config-contract/getNameConfig", {
            params: {
                mobilePartner: $scope.mobilePartner
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listName = response.data;
            }
        });
    }

    $scope.init = function () {
        $("#content").collapse("show");
        $("#collapseOne").collapse("show");
        $("#collapseTwo").collapse("show");
        $("#to-content").collapse("show");
        $http.get(preUrl + "/config-contract/get", {
            params: {
                id: Number($scope.params.id)
            }
        })
            .then(function (response) {
                    if (response != null && response != 'undefined' && response.status == 200) {
                        $scope.configDetail = response.data;
                        $scope.name = response.data.name;
                        $scope.description = response.data.description;
                        $scope.status = response.data.status;
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
                        $scope.vnp_package_osp = response.data.vnp_package_osp;
                        $scope.vnp_package_ctv = response.data.vnp_package_ctv;
                        $scope.m_package_ref = response.data.m_package_ref;
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
                        $http.get(preUrl + "/config-contract/getPartnerConfig", {
                            params: {
                                nameConfig: $scope.name,
                            }
                        }).then(function (response) {
                            if (response != null && response != 'undefined' && response.status == 200) {
                                $scope.listData = response.data;
                                $scope.listPartner = $scope.listData.items;
                                $scope.listData.pageCount = getPageCount($scope.listData);
                                $scope.listData.pageList = getPageList($scope.listData);
                                let objTrue = $scope.listData.items.filter(partner => partner.name == $scope.name);
                                for (let item of objTrue) {
                                    $("#checkboxLarge").prop('checked', true);
                                    item.checked = true;
                                }
                            }
                        });
                    }
                }
            );
    }

    $scope.getValueM_Pre = function (key) {
        $scope.return100();
        if ($scope.m_bl_pre_bonus == "") {
            $scope.m_bl_pre_bonus = 0;
        }
        if ($scope.m_bl_pre_ctv == "") {
            $scope.m_bl_post_ctv = 0;
        }
        if ($scope.m_bl_pre_osp == "") {
            $scope.m_bl_pre_osp = 0;
        }
        if (key == "m_bl_pre_osp") {
            $scope.m_bl_pre_ctv = 100 - Number($scope.m_bl_pre_osp);
            if ($scope.m_bl_pre_ctv <= 0) {
                $scope.m_bl_pre_ctv = 0;
            }
            $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
            $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
            if ($scope.m_bl_pre_ctv_value <= 0) {
                $scope.m_bl_pre_ctv_value = 0;
            }
            if ($scope.m_bl_pre_ctv_value >= $scope.m_bl_pre_bonus) {
                $scope.m_bl_pre_ctv_value = $scope.m_bl_pre_bonus;
            }
        } else if (key == "m_bl_pre_ctv") {
            $scope.m_bl_pre_osp = 100 - Number($scope.m_bl_pre_ctv);
            if ($scope.m_bl_pre_osp <= 0) {
                $scope.m_bl_pre_osp = 0;
            }
            $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
            $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
            if ($scope.m_bl_pre_osp_value <= 0) {
                $scope.m_bl_pre_osp_value = 0;
            }
            if ($scope.m_bl_pre_osp_value >= $scope.m_bl_pre_bonus) {
                $scope.m_bl_pre_osp_value = $scope.m_bl_pre_bonus;
            }
        } else {
            $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
            $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
        }
    }

    $scope.getValueM_Post = function (key) {
        $scope.return100();
        if ($scope.m_bl_post_bonus == "") {
            $scope.m_bl_post_bonus = 0;
        }
        if ($scope.m_bl_post_ctv == "") {
            $scope.m_bl_post_ctv = 0;
        }
        if ($scope.m_bl_post_osp == "") {
            $scope.m_bl_post_osp = 0;
        }
        if (key == "m_bl_post_osp") {
            $scope.m_bl_post_ctv = 100 - Number($scope.m_bl_post_osp);
            if ($scope.m_bl_post_ctv <= 0) {
                $scope.m_bl_post_ctv = 0;
            }
            $scope.m_bl_post_ctv_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_ctv / 100);
            $scope.m_bl_post_osp_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_osp / 100);
            if ($scope.m_bl_post_ctv_value <= 0) {
                $scope.m_bl_post_ctv_value = 0;
            }
            if ($scope.m_bl_post_ctv_value >= $scope.m_bl_post_bonus) {
                $scope.m_bl_post_ctv_value = $scope.m_bl_post_bonus;
            }
        } else if (key == "m_bl_post_ctv") {
            $scope.m_bl_post_osp = 100 - Number($scope.m_bl_post_ctv);
            if ($scope.m_bl_post_osp <= 0) {
                $scope.m_bl_post_osp = 0;
            }
            $scope.m_bl_post_osp_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_osp / 100);
            $scope.m_bl_post_ctv_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_ctv / 100);
            if ($scope.m_bl_post_osp_value <= 0) {
                $scope.m_bl_post_osp_value = 0;
            }
            if ($scope.m_bl_post_osp_value >= $scope.m_bl_post_bonus) {
                $scope.m_bl_post_osp_value = $scope.m_bl_post_bonus;
            }
        } else {
            $scope.m_bl_post_osp_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_osp / 100);
            $scope.m_bl_post_ctv_value = Math.round($scope.m_bl_post_bonus * $scope.m_bl_post_ctv / 100);
        }
    }

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.pageNumber = 1;
        $scope.listData.numberPerPage = numberPerPage;
        $scope.getPartnerConfig(1);
    }

    $scope.return100 = function (key) {
        $("input[name='percentage']").on('input', function () {
            $(this).val(function (i, v) {
                if (v > 100) {
                    v = 100;
                }
                return v;
            });
        });
        if ($scope.m_package_ctv == "") {
            $scope.m_package_ctv = 0;
        }
        if ($scope.m_package_osp == "") {
            $scope.m_package_osp = 0;
        }
        if ($scope.vnp_package_ctv == "") {
            $scope.vnp_package_ctv = 0;
        }
        if ($scope.vnp_package_osp == "") {
            $scope.vnp_package_osp = 0;
        }
        if (key == "m_package_osp") {
            $scope.m_package_ctv = 100 - $scope.m_package_osp;
            if ($scope.m_package_ctv < 0) {
                $scope.m_package_ctv = 0;
            }
        }
        if (key == "m_package_ctv") {
            $scope.m_package_osp = 100 - $scope.m_package_ctv;
            if ($scope.m_package_osp < 0) {
                $scope.m_package_osp = 0;
            }
        }
        if (key == "vnp_package_osp") {
            $scope.vnp_package_ctv = 100 - $scope.vnp_package_osp;
            if ($scope.vnp_package_ctv < 0) {
                $scope.vnp_package_ctv = 0;
            }
        }
        if (key == "vnp_package_ctv") {
            $scope.vnp_package_osp = 100 - $scope.vnp_package_ctv;
            if ($scope.vnp_package_osp < 0) {
                $scope.vnp_package_osp = 0;
            }
        }
    }

    $scope.clear = function () {
        $scope.name = "";
        $scope.description = "";
        $scope.status = 1;
    };

    $scope.update = function (id) {
        if ($scope.name == null || $scope.name === "") {
            toastr.error("Vui lòng nhập Tên cấu hình!");
            $("input[name='name']").each(function () {
                $(this).focus();
            })
            return false;
        }
        $scope.editObj.id = id;
        $scope.editObj.name = $scope.name;
        $scope.editObj.description = $scope.description;
        $scope.editObj.status = $scope.status;
        $scope.editObj.m_bl_pre_bonus = $scope.m_bl_pre_bonus;
        $scope.editObj.m_bl_pre_osp = $scope.m_bl_pre_osp;
        $scope.editObj.m_bl_pre_ctv = $scope.m_bl_pre_ctv;
        $scope.editObj.m_bl_pre_ref = $scope.m_bl_pre_ref;
        $scope.editObj.m_bl_post_bonus = $scope.m_bl_post_bonus;
        $scope.editObj.m_bl_post_osp = $scope.m_bl_post_osp;
        $scope.editObj.m_bl_post_ctv = $scope.m_bl_post_ctv;
        $scope.editObj.m_bl_post_ref = $scope.m_bl_post_ref;
        $scope.editObj.m_package_osp = $scope.m_package_osp;
        $scope.editObj.m_package_ctv = $scope.m_package_ctv;
        $scope.editObj.vnp_package_osp = $scope.vnp_package_osp;
        $scope.editObj.vnp_package_ctv = $scope.vnp_package_ctv;
        $scope.editObj.m_package_ref = $scope.m_package_ref;
        var requestBody = JSON.parse(JSON.stringify($scope.editObj));
        $http.post(preUrl + "/config-contract/detail.html", requestBody)
            .then(function (response) {
                console.log("response " + response.data)
                switch (Number(response.data)) {
                    case 0:
                        $scope.init();

                        if ($scope.selectedItem.length > 0) {
                            $scope.partnerToConfigBody.id = $scope.editObj.id;
                            $scope.partnerToConfigBody.affConfigContractViews = $scope.selectedItem;
                            var requestBody = JSON.parse(JSON.stringify($scope.partnerToConfigBody));
                            $http.post(preUrl + "/config-contract/udpateConfigForPartner", requestBody)
                                .then(function (response) {
                                    console.log("response " + response.data)
                                    switch (Number(response.data)) {
                                        case 0:
                                            toastr.info("Cập nhập thông tin thành công!");
                                            setTimeout(function () {
                                                $scope.returnIndex()
                                            }, 1000)
                                            break;
                                        default:
                                            toastr.error('Cập nhập thông tin không. Bạn vui lòng thử lại sau!');
                                            break;
                                    }
                                });
                        } else {
                            toastr.info("Cập nhập thông tin thành công!");
                            setTimeout(function () {
                                $scope.returnIndex()
                            }, 1000)
                            console.log("Update success but dont have any partner had been change config");
                        }
                        break;
                    default:
                        toastr.error('Cập nhập thông tin không. Bạn vui lòng thử lại sau!');
                        break;
                }
            });
    }

    $scope.selectedItem = [];
    $scope.checkAll = false;
    $scope.getListItems = function () {
        if ($scope.checkAll) {
            let arrIndex = [],
                listItems = [];

            let begin = Number($scope.listData.numberPerPage * ($scope.listData.pageNumber - 1)),
                end = begin + Number($scope.listData.numberPerPage);

            for (let i = begin; i <= end; i++) {
                arrIndex.push(i);
            }

            listItems = $scope.listData.items.filter((el, i) => arrIndex.some(j => i === j));
            for (let i = 0; i <= listItems.length - 1; i++) {
                $scope.selectedItem.push(listItems[i]);
            }
        }
    }

    $scope.addCheckItem = function (configContract) {
        console.log(configContract)
        if (configContract.checked) {
            $scope.selectedItem.push(configContract);
        } else {
            var toDel = $scope.selectedItem.indexOf(configContract);
            $scope.selectedItem.splice(toDel, 1);
        }
    }

// -----------FILTER-----------
    $scope.selectFilterMobile = function (event, name) {
        const tag = $(event.target)[0],
            classList = tag.classList,
            attribute_value = tag.attributes.getNamedItem('data-value'),
            value = (attribute_value !== null ? attribute_value.value : null);
        let flag = false;
        for (const className of classList) {
            if (className === "active-current") {
                flag = true;
            }
        }
        if (name === "all") {
            if (flag) {
                $(tag).removeClass("active-current");
            } else {
                $("#myBtnContainer").each(function () {
                    var btnTags = $(this).find(':button');
                    for (let i = 0; i < btnTags.length; i++) {
                        $(btnTags[i]).removeClass("active-current")
                    }
                });
                $(tag).addClass("active-current");
                $scope.getPartnerConfigByName("");
            }
            return;
        }
        if (flag) {
            $(tag).removeClass("active-current");
        } else {
            $("#myBtnContainer").each(function () {
                var btnTags = $(this).find(':button');
                for (let i = 0; i < btnTags.length; i++) {
                    $(btnTags[i]).removeClass("active-current")
                }
            });
            $(tag).addClass("active-current");
            $scope.getPartnerConfigByName(name);
        }
    }

    $scope.getPartnerConfigByName = function (name) {
        $http.get(preUrl + "/config-contract/getPartnerConfig", {
            params: {
                p: 1,
                numberPerPage: $scope.listData.numberPerPage,
                mobilePartner: $scope.mobilePartner,
                nameConfig: name,
                fromDate: $scope.fromDate,
                toDate: $scope.toDate,
            }
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.listData = response.data;
                $scope.listPartner = $scope.listData.items;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);
                let objTrue = $scope.listData.items.filter(partner => partner.name == $scope.name);
                for (let item of objTrue) {
                    item.checked = true;
                }
                if (name === $scope.name) {
                    $("#checkboxLarge").prop('checked', true);
                } else {
                    $("#checkboxLarge").prop('checked', false);
                }
            }
        });
    }

    $scope.selectChecked = function () {
        if ($scope.name == null || $scope.name == "") return;
        $("#myBtnContainer").each(function () {
            var btnTags = $(this).find(':button');
            for (let i = 0; i < btnTags.length; i++) {
                const tag = btnTags[i],
                    data_value = tag.attributes.getNamedItem('data-value'),
                    value_tag = (data_value !== null ? data_value.value : null);
                $(tag).removeClass("active-current");
                if (value_tag == $scope.name) {
                    $(tag).addClass("active-current");
                }
            }
        });
    }

    $scope.returnIndex = function () {
        window.location.replace(preUrl + "/config-contract/index.html");
    }
// -----------FILTER-END-----------

    /*--------------init------------*/
    $scope.init();
    $scope.getNameConfig();
    $scope.getTotal(1);
    setTimeout(function () {
        $scope.selectChecked()
    }, 1000)
}])
;