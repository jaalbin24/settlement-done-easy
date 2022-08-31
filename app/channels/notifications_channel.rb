class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_from "user#{current_user.public_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
