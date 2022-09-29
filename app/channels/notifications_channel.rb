class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for current_user
    puts "🌐🌐🌐 User subscribed to notifications channel!"
  end

  def unsubscribed
    puts "🌐🌐🌐 User unsubscribed from notifications channel!"
    # Any cleanup needed when channel is unsubscribed
  end
end
