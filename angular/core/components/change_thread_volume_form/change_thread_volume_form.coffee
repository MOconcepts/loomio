angular.module('loomioApp').factory 'ChangeThreadVolumeForm', ->
  templateUrl: 'generated/components/change_thread_volume_form/change_thread_volume_form.html'
  controller: ($scope, thread, FormService, CurrentUser, FlashService) ->
    $scope.thread = thread.clone()
    $scope.volumeLevels = ["loud", "normal", "quiet"]
    $scope.buh = {}
    $scope.buh.volume = thread.volume()

    $scope.submit = ->
      $scope.isDisabled = true
      if $scope.applyToAllThreads
        membership = $scope.thread.group().membershipFor(CurrentUser)
        membership.saveVolume($scope.buh.volume).then ->
          $scope.$close()
          FlashService.success "group_volume_form.messages.#{$scope.buh.volume}"
      else
        $scope.thread.saveVolume($scope.buh.volume).then ->
          $scope.$close()
          FlashService.success "thread_volume_form.messages.#{$scope.buh.volume}"

    # $scope.groupSubmit = FormService.submit $scope, $scope.thread,
    #   membership = $scope.thread.group().membershipFor(CurrentUser)
    #   submitFn: membership.update($scope.thread.discussionReaderVolume)
    #   flashSuccess: -> "group_volume_form.messages.#{$scope.membership.volume}"
    #   flashOptions:
    #     name: $scope.thread.groupName()

    # $scope.threadSubmit = FormService.submit $scope, $scope.thread,
    #   submitFn: $scope.thread.changeVolume
    #   flashSuccess: -> "thread_volume_form.messages.#{$scope.thread.discussionReaderVolume}"
    #   flashOptions:
    #     name: $scope.thread.title

    # $scope.submit = ->
    #   if $scope.applyToAllThreads
    #     $scope.groupSubmit($scope.thread)
    #   else
    #     $scope.threadSubmit($scope.thread)

    return
