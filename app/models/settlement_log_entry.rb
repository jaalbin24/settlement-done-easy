# == Schema Information
#
# Table name: settlement_log_entries
#
#  id            :bigint           not null, primary key
#  message       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_settlement_log_entries_on_settlement_id  (settlement_id)
#  index_settlement_log_entries_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (user_id => users.id)
#
class SettlementLogEntry < ApplicationRecord
    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id",
        inverse_of: :log_entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
