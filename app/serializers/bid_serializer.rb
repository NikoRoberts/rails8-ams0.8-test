class BidSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :amount, :state
  has_one :user, serializer: UserSerializer
end
