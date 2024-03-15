// app.controller('addGroupCtrl', ['$scope', '$http', '$timeout', '$q', function ($scope, $http, $timeout, $q) {
//     $scope.listData = '';
//
//     $scope.loadListData = function () {
//         $http.get(preUrl + "/system/group/list-group")
//             .then(function (response) {
//                 if (response != null && response != 'undefined' && response.status == 200) {
//                     $scope.listData = response.data;
//                 }
//             });
//     }
//
//     $scope.loadListData();
// }]);