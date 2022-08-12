# == Schema Information
#
# Table name: bank_accounts
#
#  id                       :bigint           not null, primary key
#  fingerprint              :string
#  last4                    :integer
#  nickname                 :string
#  preferred                :boolean          default(FALSE), not null
#  status                   :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  stripe_payment_method_id :string           not null
#  user_id                  :bigint           not null
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

    has_many(
        :payments_out,
        class_name: "Payment",
        foreign_key: "source_id",
        inverse_of: :source
    )

    has_many(
        :payments_in,
        class_name: "Payment",
        foreign_key: "destination_id",
        inverse_of: :destination
    )

    after_destroy do |bank_account|
        
    end

    def send_money_to(destination, amount)

    end

    def sync_with_stripe

    end
end
