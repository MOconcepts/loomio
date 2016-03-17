angular.module('loomioApp').factory 'ChangeVolumeForm', ->
  templateUrl: 'generated/components/change_volume_form/change_volume_form.html'
  controller: ($scope, model, setDefault, FormService, CurrentUser, FlashService) ->
    $scope.model = model.clone()
    $scope.volumeLevels = ["loud", "normal", "quiet"]
    $scope.buh = {}
    $scope.buh.volume = model.volume()
    $scope.setDefault = setDefault if setDefault

    $scope.translateKey =
      if setDefault
        "change_volume_form.set_membership_default"
      else
        "change_volume_form.#{$scope.model.constructor.singular}"

    $scope.title =
      if setDefault
        ''
      else
        model.title or model.groupName()


    $scope.submit = ->
      $scope.isDisabled = true
      model.saveVolume($scope.buh.volume, $scope.applyToAll, $scope.setDefault).then ->
        $scope.$close()
        translation =
          if $scope.applyToAll
            if $scope.model.constructor.singular == 'discussion'
              "change_volume_form.membership.messages.#{$scope.buh.volume}"
            else
              "change_volume_form.all_groups.messages.#{$scope.buh.volume}"
          else
            if $scope.model.constructor.singular == 'discussion'
              "change_volume_form.discussion.messages.#{$scope.buh.volume}"
            else
              "change_volume_form.membership.messages.#{$scope.buh.volume}"
        FlashService.success translation

    return
