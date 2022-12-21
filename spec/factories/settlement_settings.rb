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
FactoryBot.define do
    factory :settlement_settings do
        settlement
        trait :for_attorney do
            association :user, factory: :attorney
        end

        trait :for_adjuster do
            association :user, factory: :adjuster
        end
    end
end
