class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :email, :badge_name

  # Custom method
  def badge_name
    object.active? ? "Active Member" : "Inactive"
  end

  # Conditional attribute
  def include_email?
    # Only include email if user is active
    object.active?
  end
end
