angular.module('loomioApp').factory 'MembershipModel', (BaseModel, AppConfig) ->
  class MembershipModel extends BaseModel
    @singular: 'membership'
    @plural: 'memberships'
    @indices: ['id', 'userId', 'groupId']
    @searchableFields: ['userName', 'userUsername']
    @serializableAttributes: ['volume_value', 'apply_to_all', 'set_default']

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

    volume: ->
      @volumeValue

    saveVolume: (volume, applyToAll = false, setDefault = false) ->
      @volumeValue = volume
      @applyToAll = applyToAll
      @setDefault = setDefault
      @save().then =>
        if @applyToAll
          _.each @user().groups(), (group) ->
            _.each group.discussions(), (discussion) ->
              discussion.discussionReaderVolume = null
          _.each @user().memberships(), (membership) ->
            membership.volumeValue = volume
        else
          _.each @group().discussions(), (discussion) ->
            discussion.discussionReaderVolume = null


    isMuted: ->
      @volumeValue == 'mute'
