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
require 'rails_helper'

RSpec.describe UserSettings, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
