# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  activated                   :boolean          default(FALSE), not null
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  stripe_account_onboarded    :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  organization_id             :bigint
#  public_id                   :string
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_organization_id              (organization_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
