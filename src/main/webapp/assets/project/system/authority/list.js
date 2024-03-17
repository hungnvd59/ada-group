app.controller('authorityListCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.authKey = "";
    $scope.labelTitle = "Add";
    $scope.dataLoaded = false;
    $scope.authItem = {id: null, authKey: "", authority: "", description: "", fid: null, orderId: null};
    $scope.authItems = [];
    $scope.authParent = [];
    $scope.authKeyRegex = "^[A-Za-z0-9_]+$";
    $scope.page = page;

    $(document).keypress(function(event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            $scope.search();
        }
    })

    $scope.loadPageData = function (pageNumber) {
        $scope.listData.pageNumber = pageNumber
        if (pageNumber >= 1) {
            $http.get(preUrl + "/system/authority/search", {
                params: {
                    p: $scope.listData.pageNumber, numberPerPage: $scope.listData.numberPerPage, authKey: $scope.authKey
                }
            })
                .then(function (response) {
                    $scope.listData = response.data;
                    $scope.listData.pageList = getPageList($scope.listData);
                    $scope.listData.pageCount = getPageCount($scope.listData);
                    $scope.authItems = response.data.items;
                });
        }
    };

    $scope.getListAuthParent = function () {
        $http.get(preUrl + "/system/authority/get-list-auth-parent", {params: {authId: $scope.authItem.id}})
            .then(function (response) {
                if (response != null && response != 'undefined' && response.status == 200) {
                    $scope.authParent = response.data;
                }
            });
    };

    $scope.checkRegex = function (input, regex) {
        var result = false;
        if (input !== '') {
            var _pattern = regex;
            var _test = new RegExp(_pattern);
            if (_test.test(input)) result = true;
        } else {
            result = true;
        }
        return result;
    };

    $scope.validateData = function (item) {
        var check = true;
        $scope.authKey_valid = "";
        $scope.authName_valid = "";
        $scope.authDescription_valid = "";
        var focus = 0;

        if ($scope.labelTitle === 'Add' && (typeof item === "undefined" || typeof item.authKey === "undefined" || item.authKey === null || item.authKey === "" || item.authKey.length > 100 || !$scope.checkRegex(item.authKey, $scope.authKeyRegex))) {
            check = false;
            $scope.authKey_valid = "Mã chức năng không được để trống!";
            if (typeof item != "undefined" && typeof item.authKey != "undefined" && item.authKey != null && item.authKey != "" && item.authKey.length > 100) {
                $scope.authKey_valid = "Độ dài mã tham số không quá 100 kí tự!";
            }
            if (!$scope.checkRegex(item.authKey, $scope.authKeyRegex)) {
                $scope.authKey_valid = "Mã chức năng không hợp lệ (Mã chức năng chỉ được gồm các kí tự A - z, số và dấu gạch dưới.)";
            }
            if (focus === 0) {
                focus = 1;
                $("#authKeyUpdate").focus();
            }
        }

        if (typeof item === "undefined" || typeof item.authority === "undefined" || item.authority === null || item.authority === "" || item.authority.length > 200) {
            check = false;
            $scope.authName_valid = "Tên chức năng không được để trống!";
            if (typeof item != "undefined" && typeof item.authority != "undefined" && item.authority != null && item.authority != "" && item.authority.length > 200) {
                $scope.authName_valid = "Độ dài tên chức năng không quá 200 kí tự!";
            }
            if (focus === 0) {
                focus = 1;
                $("#authDescriptionUpdate").focus();
            }
        }

        if (typeof item != "undefined" && typeof item.description != "undefined" && item.description != null && item.description != "" && item.description.length > 500) {
            $scope.authDescription_valid = "Độ mô tả không quá 500 kí tự!";
            check = false;
            if (focus === 0) {
                focus = 1;
                $("#authDescriptionUpdate").focus();
            }
        }
        return check;

    };

    $scope.addOrUpdateAuthority = function () {
        var check = true;
        check = $scope.validateData($scope.authItem);
        if ($scope.labelTitle === 'Edit' && $scope.authItem.id !== "") {
            if (check) {
                var addAuthority = JSON.parse(JSON.stringify($scope.authItem));
                $http.post(preUrl + "/system/authority/edit", addAuthority, {headers: {'Content-Type': 'application/json'}})
                    .then(function (response) {
                        switch (Number(response.data)) {
                            case 0:
                                $("#updateAuthorityModal").modal("hide");
                                $scope.search();
                                toastr.success("Sửa thông tin thành công");
                                $scope.authItem.id = "";
                                $scope.authItem.authKey = '';
                                $scope.authItem.description = '';
                                break;
                            case 1:
                                $("#updateAuthorityModal").modal("hide");
                                toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại!");
                                break;
                            case 2:
                                //                                        $("#updateAuthorityModal").modal("hide");
                                toastr.error("Bạn cần nhập đầy đủ các thông tin bắt buộc !");
                                break;
                            case 3:
                                //                                        $("#updateAuthorityModal").modal("hide");
                                toastr.error("Chức năng không tồn tại!");

                                break;
                            case 4:
                                //                                        $("#updateAuthorityModal").modal("hide");
                                toastr.error("Không thể thay đổi thông tin chức năng cha. Do chức năng này đã có chức năng con!");

                                break;
                        }
                    });
            }
        } else {
            if (check) {
                var addAuthority = JSON.parse(JSON.stringify($scope.authItem));
                $http.post(preUrl + "/system/authority/add", addAuthority, {headers: {'Content-Type': 'application/json'}})
                    .then(function (response) {
                        switch (Number(response.data)) {
                            case 0:
                                $("#updateAuthorityModal").modal("hide");
                                $scope.search();
                                $scope.getListAuthParent();
                                toastr.success("Thêm mới thành công!");
                                $scope.authItem.id = "";
                                $scope.authItem.authKey = '';
                                $scope.authItem.description = '';
                                break;
                            case 1:
                                $("#updateAuthorityModal").modal("hide");
                                toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại!");
                                break;
                            case 2:
                                //                                        $("#updateAuthorityModal").modal("hide");
                                toastr.error("Bạn cần nhập đầy đủ các thông tin bắt buộc !");

                                break;
                            case 3:
                                //                                        $("#updateAuthorityModal").modal("hide");
                                toastr.error("Mã chức năng đã tồn tại!");
                                break;
                        }
                    });
            }

        }

    };


    $scope.onEditAuthority = function (auth) {
        $scope.labelTitle = "Edit";
        $scope.authItem.id = auth[0];
        $scope.authItem.authKey = auth[1];
        $scope.authItem.authority = auth[2];
        $scope.authItem.description = auth[3];
        $scope.authItem.fid = auth[5];
        $scope.getListAuthParent();
        setTimeout(function () {
            $("#authParentUpdate").select2();
            $("#authParentUpdate").select2("val", $scope.authItem.fid);
            $('#authParentUpdate').trigger('change')
        }, 100);


    };

    $scope.onAddAuthority = function () {
        $scope.labelTitle = "Add";
        $scope.authItem.id = "";
        $scope.authItem.authKey = '';
        $scope.authItem.authority = '';
        $scope.authItem.description = '';
        $scope.getListAuthParent();
        setTimeout(function () {
            $("#authParentUpdate").select2();
            $("#authParentUpdate").select2("val", '0')
            $('#authParentUpdate').trigger('change')
        }, 100);
    };

    $scope.onDeleteAuthority = function (id) {
        $scope.search.basic = 1;
        $scope.deleteId = id;
    };
    $scope.deleteAuthority = function () {
        var call = {id: $scope.deleteId};
        var auth = JSON.parse(JSON.stringify(call));
        $http.post(preUrl + "/system/authority/delete", auth, {headers: {'Content-Type': 'application/json'}})
            .then(function (response) {
                switch (Number(response.data)) {
                    case 0:
                        $("#deleteAuthorityModal").modal("hide");
                        $scope.search();
                        $scope.getListAuthParent();
                        toastr.success("Xóa thành công!");
                        break;
                    case 1:
                        $("#deleteAuthorityModal").modal("hide");
                        toastr.error("Có lỗi trong quá trình xử lý, vui lòng thử lại!");
                        break;
                    case 3:
                        $("#deleteAuthorityModal").modal("hide");
                        toastr.error("Chức năng không tồn tại!");
                        break;
                    case 4:
                        $("#deleteAuthorityModal").modal("hide");
                        toastr.error("Không thể xóa chức năng do chức năng đã được gán vào nhóm quyền!");
                        break;
                    case 5:
                        $("#deleteAuthorityModal").modal("hide");
                        toastr.error("Không thể xóa chức năng do chức năng trên có chức năng phụ thuộc!");
                        break;
                }
            });
    };

    $(document).ready(function () {
        $timeout(function () {
            $("#authParentUpdate").select2();
            $("#authParentUpdate").select2("val", '0');
        }, 0);
    });

    $scope.setNumberPerPage = function (numberPerPage) {
        $scope.listData.numberPerPage = numberPerPage;
        $scope.loadPageData($scope.listData.pageNumber);
    }

    $scope.search = function () {
        $scope.loadPageData(1);
    };
    //============================================================
    $scope.search();
    $scope.getListAuthParent();
}]);