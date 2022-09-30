# == Schema Information
#
# Table name: stripe_account_requirements
#
#  id                :bigint           not null, primary key
#  required_item     :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  public_id         :string
#  stripe_account_id :bigint
#
# Indexes
#
#  index_stripe_account_requirements_on_stripe_account_id  (stripe_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (stripe_account_id => stripe_accounts.id)
#
