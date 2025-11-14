class TaskSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :description, :price, :state, :formatted_price, :status_message
  
  has_one :user, serializer: UserSerializer
  has_many :bids, serializer: BidSerializer

  # Custom method
  def formatted_price
    "$#{object.price}"
  end

  # Conditional method
  def status_message
    return nil unless object.assigned?
    "This task has been assigned"
  end

  # Conditional attribute inclusion
  def include_status_message?
    object.assigned?
  end

  # Conditional attribute based on state
  def include_price?
    object.public? || object.assigned?
  end
end
