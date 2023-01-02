# == Schema Information
#
# Table name: user_settings
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
#  user_id                                        :bigint
#
# Indexes
#
#  index_user_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserSettings < ApplicationRecord
    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        inverse_of: :settings
    )
    has_one(
        :profile,
        class_name: "UserProfileSettings",
        foreign_key: "user_settings_id",
        inverse_of: :user_settings,
        dependent: :destroy
    )

    before_create do
        build_profile(UserProfileSettings.default_settings_for_user(user))
    end

    def self.default_settings
        {
            alert_when_settlement_ready_for_payment:        true,
            alert_when_payment_requested:                   true,
            confirmation_before_document_rejection:         false,
            delete_my_documents_after_rejection:            false,
            replace_unsigned_document_with_signed_document: true,
            automatically_accept_payment_requests:          false,
        }
    end
end
