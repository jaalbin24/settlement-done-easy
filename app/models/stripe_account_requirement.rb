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
class StripeAccountRequirement < ApplicationRecord
    scope :past_due,                    ->      {where(status: "past_due")}
    scope :currently_due,               ->      {where(status: "currently_due")}
    scope :eventually_due,              ->      {where(status: "eventually_due")}
    scope :pending_verification,        ->      {where(status: "pending_verification")}
    scope :with_required_item,          ->  (i) {where(required_item: i)}
    scope :besides_external_account,    ->      {where.not(required_item: "external_account")}

    validates :status, inclusion: {in: ["past_due", "currently_due", "eventually_due", "pending_verification"]}

    belongs_to(
        :stripe_account,
        class_name: "StripeAccount",
        foreign_key: "stripe_account_id",
        inverse_of: :requirements
    )
end
