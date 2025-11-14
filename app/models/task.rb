class Task < ApplicationRecord
  belongs_to :user
  has_many :bids

  def assigned?
    state == 'assigned'
  end

  def public?
    state == 'posted'
  end
end
