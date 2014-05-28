angular.module('myApp', [])
.directive '{{name}}', ($scope) ->
  $scope.foo = 'bar'