# == Schema Information
#
# Table name: settlement_settings
#
#  id                                             :bigint           not null, primary key
#  alert_when_settlement_ready_for_payment        :boolean
#  confirmation_before_document_rejection         :boolean
#  delete_my_documents_after_rejection            :boolean
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
require 'rails_helper'

RSpec.describe SettlementSettings, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
