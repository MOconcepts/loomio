class MembershipSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :volume_value, :admin
  has_one :group, serializer: GroupSerializer, root: 'groups'
  has_one :user, serializer: UserSerializer, root: 'users'
  has_one :inviter, serializer: UserSerializer, root: 'users'

  def include_inviter?
    [nil, true].include? (scope || {})[:include_inviter]
  end

  def volume_value
    object.volume
  end
end
