# == Schema Information
#
# Table name: bank_accounts
#
#  id          :bigint           not null, primary key
#  fingerprint :string
#  last4       :integer
#  nickname    :string
#  preferred   :boolean          default(FALSE), not null
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stripe_id   :string           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BankAccount < ApplicationRecord
    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        inverse_of: :bank_accounts
    )

    after_destroy do |bank_account|
        Stripe::Account.delete_external_account(
            user.stripe_account_id,
            stripe_id,
        )
    end

    def send_money_to(destination, amount)

    end

    def sync_with_stripe

    end
end
