# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  message    :string
#  seen       :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#  user_id    :bigint
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        inverse_of: :notifications
    )

    after_create do
        broadcast_to_user
    end

    def broadcast_to_user
        NotificationsChannel.broadcast_to(
            user, 
            title: title,
            message: message
        )
    end
end
