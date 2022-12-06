# == Schema Information
#
# Table name: settlement_settings
#
#  id                                             :bigint           not null, primary key
#  alert_when_payment_requested                   :boolean
#  alert_when_settlement_ready_for_payment        :boolean
#  automatically_accept_payment_requests          :boolean
#  confirmation_before_document_rejection         :boolean
#  delete_my_documents_after_rejection            :boolean
#  generate_document_at_settlement_start          :boolean
#  replace_unsigned_document_with_signed_document :boolean
#  created_at                                     :datetime         not null
#  updated_at                                     :datetime         not null
#  public_id                                      :string
#  settlement_id                                  :bigint
#  user_id                                        :bigint
#
# Indexes
#
#  index_settlement_settings_on_settlement_id  (settlement_id)
#  index_settlement_settings_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (user_id => users.id)
#
class SettlementSettings < ApplicationRecord

    scope :for_user,    ->  (i) {where(user: i)}


    belongs_to(
        :user,
        class_name: "User",
        foreign_key: :user_id
    )

    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: :settlement_id,
        inverse_of: :settings
    )

    before_create do
        puts "❤️❤️❤️ SettlementSettings before_create block"
        sync_with_user_settings
    end

    def sync_with_user_settings
        user.settings.attributes.each do |attribute, attribute_value|
            unless attribute.to_s.in? ["created_at", "updated_at", "id", "public_id", "user_id"]
                write_attribute(attribute.to_sym, attribute_value)
            end
        end
    end
end
