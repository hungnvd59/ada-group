app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
    $scope.page = page;
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.name = "";
    $scope.description = "";
    $scope.status = 1;
    $scope.mobilePartner = "";
    $scope.fromDate = "";
    $scope.toDate = "";

    $scope.logs = [];
    $scope.partnerToConfigBody = {};
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
    $scope.showDropdownFlag = 0; // 0:show 1:hide

    var hh1 = document.getElementById("configContractDropdown1");
    var hh2 = document.getElementById("configContractDropdown2");
    $('#configContractDropdown').click(function () {
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
    $('#listApplyConfig').click(function () {
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

    $scope.configDetail = {};
    $scope.addObj = {};
    $scope.editObj = {};
    $scope.listName = {};
    $scope.nameCount = 0;
    $scope.listPartner = {};
    $scope.objOld = {};
    $scope.listConfigFilter = []
    $scope.base = "";

    $scope.addObj = {};

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

    $scope.getValueM_Pre = function (key) {
        $scope.return100();
        if (key == "m_bl_pre_osp") {
            $scope.m_bl_pre_ctv = 100 - Number($scope.m_bl_pre_osp);
            if ($scope.m_bl_pre_ctv < 0) {
                $scope.m_bl_pre_ctv = 0;
            }
            $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
            $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
            if ($scope.m_bl_pre_ctv_value < 0) {
                $scope.m_bl_pre_ctv_value = 0;
            }
            if ($scope.m_bl_pre_ctv_value >= $scope.m_bl_pre_bonus) {
                $scope.m_bl_pre_ctv_value = $scope.m_bl_pre_bonus;
            }
        } else if (key == "m_bl_pre_ctv") {
            $scope.m_bl_pre_osp = 100 - Number($scope.m_bl_pre_ctv);
            if ($scope.m_bl_pre_osp < 0) {
                $scope.m_bl_pre_osp = 0;
            }
            $scope.m_bl_pre_osp_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_osp / 100);
            $scope.m_bl_pre_ctv_value = Math.round($scope.m_bl_pre_bonus * $scope.m_bl_pre_ctv / 100);
            if ($scope.m_bl_pre_osp_value < 0) {
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

    $scope.init = function () {
        $("#content").collapse("show");
        $("#collapseOne").collapse("show");
        $("#collapseTwo").collapse("show");
        $("#to-content").collapse("show");
        $http.get(preUrl + "/config-contract/getBase", {
            params: {}
        }).then(function (response) {
            if (response != null && response != 'undefined' && response.status == 200) {
                $scope.base = response.data;
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
            $scope.getPartnerConfigByName("");
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
            }
            return;
        }
        $scope.getPartnerConfigByName(name);
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
    // -----------FILTER-END-----------

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

    $scope.add = function () {
        if ($scope.name == null || $scope.name == "") {
            toastr.error("Vui lòng nhập Tên cấu hình!");
            document.getElementById("name").focus();
            return false;
        }
        if ($scope.m_bl_pre_bonus == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả trước!");
            document.getElementById("m_bl_pre_bonus").focus();
            return false;
        }
        if ($scope.m_bl_pre_osp == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả trước OSP hưởng!");
            document.getElementById("m_bl_pre_osp").focus();
            return false;
        }
        if ($scope.m_bl_pre_ctv == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả trước chi trả CTV!");
            document.getElementById("m_bl_pre_ctv").focus();
            return false;
        }
        if ($scope.m_bl_post_bonus == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả sau!");
            document.getElementById("m_bl_post_bonus").focus();
            return false;
        }
        if ($scope.m_bl_post_osp == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả sau OSP hưởng!");
            document.getElementById("m_bl_post_osp").focus();
            return false;
        }
        if ($scope.m_bl_post_ctv == null) {
            toastr.error("Vui lòng nhập Hoa hồng PTTB trả sau chi trả CTV !");
            document.getElementById("m_bl_post_ctv").focus();
            return false;
        }
        if ($scope.m_package_ctv == null) {
            toastr.error("Vui lòng nhập Hoa hồng đăng kí gói cước OSP nhận/hoa hồng telco chi trả!");
            document.getElementById("m_package_ctv").focus();
            return false;
        }
        if ($scope.m_package_ref == null) {
            toastr.error("Vui lòng nhập Hoa hồng đăng kí gói cước chi trả CTV/hoa hồng telco chi trả!");
            document.getElementById("m_package_ref").focus();
            return false;
        }
        $scope.addObj.name = $scope.name;
        $scope.addObj.description = $scope.description;
        $scope.addObj.status = $scope.status;
        $scope.addObj.m_bl_pre_bonus = $scope.m_bl_pre_bonus;
        $scope.addObj.m_bl_pre_osp = $scope.m_bl_pre_osp;
        $scope.addObj.m_bl_pre_ctv = $scope.m_bl_pre_ctv;
        $scope.addObj.m_bl_pre_ref = $scope.m_bl_pre_ref;
        $scope.addObj.m_bl_post_bonus = $scope.m_bl_post_bonus;
        $scope.addObj.m_bl_post_osp = $scope.m_bl_post_osp;
        $scope.addObj.m_bl_post_ctv = $scope.m_bl_post_ctv;
        $scope.addObj.m_bl_post_ref = $scope.m_bl_post_ref;
        $scope.addObj.m_package_osp = $scope.m_package_osp;
        $scope.addObj.m_package_ctv = $scope.m_package_ctv;
        $scope.addObj.vnp_package_osp = $scope.vnp_package_osp;
        $scope.addObj.vnp_package_ctv = $scope.vnp_package_ctv;
        $scope.addObj.m_package_ref = $scope.m_package_ref;

        var requestBody = JSON.parse(JSON.stringify($scope.addObj));
        $http.post(preUrl + "/config-contract/add", requestBody)
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    if ($scope.selectedItem.length > 0) {
                        $scope.partnerToConfigBody.id = response.data;
                        $scope.partnerToConfigBody.affConfigContractViews = $scope.selectedItem;
                        var requestBody = JSON.parse(JSON.stringify($scope.partnerToConfigBody));
                        $http.post(preUrl + "/config-contract/udpateConfigForPartner", requestBody)
                            .then(function (response) {
                                console.log("response " + response.data)
                                switch (Number(response.data)) {
                                    case 0:
                                        toastr.info("Thêm mới thông tin thành công!");
                                        console.log("Add and change config success");
                                        setTimeout(function () {
                                            $scope.returnIndex()
                                        }, 1000)
                                        break;
                                    default:
                                        toastr.info("Thay đổi cấu hình hoa hồng cho CTV không thành công!");
                                        break;
                                }
                            });
                    } else {
                        toastr.info("Thêm mới thông tin thành công!");
                        setTimeout(function () {
                            $scope.returnIndex()
                        }, 1000)
                        console.log("Add success but dont have any partner had been change config");
                    }
                } else {
                    toastr.info("Thêm mới thông tin không thành công!");
                    return false;
                }
            });
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

    $scope.returnIndex = function () {
        window.location.replace(preUrl + "/config-contract/index.html");
    }
    /*---------------init----------------*/
    $scope.getPartnerConfig(1);
    $scope.getNameConfig();
    $scope.init();
    setTimeout(function () {
        $scope.selectChecked()
    }, 1000)
}]);