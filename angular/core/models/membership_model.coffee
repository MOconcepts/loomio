angular.module('loomioApp').factory 'MembershipModel', (BaseModel, AppConfig) ->
  class MembershipModel extends BaseModel
    @singular: 'membership'
    @plural: 'memberships'
    @indices: ['id', 'userId', 'groupId']
    @searchableFields: ['userName', 'userUsername']
    @serializableAttributes: AppConfig.permittedParams.membership

    relationships: ->
      @belongsTo 'group'
      @belongsTo 'user'
      @belongsTo 'inviter', from: 'users'

    userName: ->
      @user().name

    userUsername: ->
      @user().username

    groupName: ->
      @group().name

    saveVolume: (volume) ->
      @volume = volume
      _.each @group().discussions(), (discussion) ->
        discussion.discussionReaderVolume = null 
      @save()

    isMuted: ->
      @volume == 'mute'
