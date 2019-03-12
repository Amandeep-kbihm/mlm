class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :body, :time

  def time
    object.created_at.strftime('%m/%d/%Y at %I:%M%p')
  end
end
