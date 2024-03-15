app.controller('partnerCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {    $scope.page = page;    $scope.listData = {items: "", rowCount: 0, numberPerPage: 15, pageNumber: 1, pageList: [], pageCount: 0};    $scope.firstSearch = true;    $scope.itemType = "";    $scope.itemName = "";    $scope.msisdnContract = "";    $scope.userName = "";    $scope.logs = [];    $scope.pageNumber = 1;    $scope.fromDate = moment(new Date(moment().startOf('month'))).format('DD/MM/YYYY');    $scope.toDate = moment(new Date()).format('DD/MM/YYYY');    $("#fromDate").datetimepicker({        locale: 'vi-VN',        format: 'DD-MM-YYYY',        icons: {            time: "fa fa-clock-o",            date: "fa fa-calendar",            up: "fa fa-chevron-up",            down: "fa fa-chevron-down",            previous: 'fa fa-chevron-left',            next: 'fa fa-chevron-right',            today: 'fa fa-screenshot',            clear: 'fa fa-trash',            close: 'fa fa-remove'        }    }).on('dp.change', function (e) {        if (e != null) {            $scope.fromDate = $(this).val();        }    })    $("#toDate").datetimepicker({        locale: 'vi-VN',        format: 'DD-MM-YYYY',        icons: {            time: "fa fa-clock-o",            date: "fa fa-calendar",            up: "fa fa-chevron-up",            down: "fa fa-chevron-down",            previous: 'fa fa-chevron-left',            next: 'fa fa-chevron-right',            today: 'fa fa-screenshot',            clear: 'fa fa-trash',            close: 'fa fa-remove'        }    }).on('dp.change', function (e) {        if (e != null) {            $scope.toDate = $(this).val();        }    })    $(document).ready(function () {    });    $scope.totalRecord = 0;    $scope.totalAmount = 0;    $scope.totalOspValue = 0;    $scope.totalShareValue = 0;    $scope.search = function (pageNumber) {        if(!$scope.firstSearch) {//xử lý thêm            $scope.fromDate = $("#fromDate").val();            $scope.toDate = $("#toDate").val();        }        $scope.totalRecord = 0;        $scope.totalAmount = 0;        $scope.totalOspValue = 0;        $scope.totalShareValue = 0;        $scope.listData.pageNumber = pageNumber;        $http.get(preUrl + "/transReport/searchByDay", {            params: {                p: $scope.listData.pageNumber,                numberPerPage: $scope.listData.numberPerPage,                itemType: $scope.itemType,                itemName: $scope.itemName,                msisdnContract: $scope.msisdnContract,                userName: $scope.userName,                fromDate: $scope.fromDate,                toDate: $scope.toDate            }        })            .then(function (response) {                if (response != null && response != 'undefined' && response.status == 200) {                    //$scope.page = response.data;                    $scope.listData = response.data;                    $scope.listData.pageCount = getPageCount(response.data);                    $scope.listData.pageList = getPageList(response.data);                    $scope.listData.items.forEach((item) => {                        $scope.totalRecord = Number($scope.totalRecord) + Number(item.totalTransSuccess);                        $scope.totalAmount = Number($scope.totalAmount) + Number(item.totalAmount);                        $scope.totalOspValue = Number($scope.totalOspValue) + Number(item.ospValue);                        $scope.totalShareValue = Number($scope.totalShareValue) + Number(item.shareValue);                    });                    console.log("total-record: " + $scope.totalRecord);                    console.log("total-amount: " + $scope.totalAmount);                    console.log("total-ospvalue: " + $scope.totalOspValue);                    console.log("total-sharevalue: " + $scope.totalShareValue);                }            });        $scope.firstSearch = false;    }    $scope.listProduct = "";    $scope.searchProduct = function (type) {        if (type == null || type == "") {            $scope.listProduct = "";        }        $http.get(preUrl + "/transReport/getProduct", {            params: {                itemType: type,            }        })            .then(function (response) {                if (response != null && response != 'undefined' && response.status == 200) {                    $scope.listProduct = response.data;                }            });    }    $scope.clear = function () {        $scope.msisdnContract = "";        $scope.userName = "";        $scope.itemType = "";        $scope.itemName = "";        $scope.fromDate = moment(new Date(moment().startOf('month'))).format('DD/MM/YYYY');        $scope.toDate = moment(new Date()).format('DD/MM/YYYY');        $("#itemType").select2("val", "");    };    $scope.ChangeFormateDate = function (oldDate)    {//convert date yyyy-mm-dd to dd/mm/yyyy        return oldDate.toString().split("-").reverse().join("/");    }    $scope.setNumberPerPage = function (numberPerPage) {        $scope.listData.pageNumber = 1;        $scope.listData.numberPerPage = numberPerPage;        $scope.search(1);    }    $scope.numbersWithDots = function (x) {        let temp = '';        if (x != null)            temp = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");        return temp;    }    // -------------------------Init----------------------------    $scope.search(1);}]);