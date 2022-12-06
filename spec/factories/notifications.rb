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
