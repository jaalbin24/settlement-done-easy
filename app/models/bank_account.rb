# == Schema Information
#
# Table name: bank_accounts
#
#  id                       :bigint           not null, primary key
#  default                  :boolean          default(FALSE), not null
#  fingerprint              :string
#  last4                    :integer
#  nickname                 :string
#  status                   :string           default("New"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  stripe_payment_method_id :string           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_stripe_payment_method_id  (stripe_payment_method_id) UNIQUE
#  index_bank_accounts_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BankAccount < ApplicationRecord

    scope :with_stripe_id,  -> (stripe_id)  {where(stripe_payment_method_id: stripe_id)}
    scope :default,         ->              {where(default: true)}

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

    validates :stripe_payment_method_id, presence: true
    validates :status, inclusion: {in: ["New", "Validated", "Verified", "Verification failed", "Errored"]}

    after_destroy do |bank_account|
        
    end

    before_destroy do
        if has_ongoing_payments?
            rollback
        end
    end
    
    def has_ongoing_payments?
        return Payment.processing.where(destination: self).or(Payment.where(source: self)).exists?
    end
end
