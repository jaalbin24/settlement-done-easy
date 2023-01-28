# == Schema Information
#
# Table name: bank_accounts
#
#  id                       :bigint           not null, primary key
#  default                  :boolean          default(FALSE), not null
#  last4                    :integer
#  nickname                 :string
#  status                   :string           default("New"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  public_id                :string
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
        inverse_of: :bank_accounts,
        autosave: true
    )

    has_many(
        :payments_out,
        class_name: "Payment",
        foreign_key: "source_id",
        inverse_of: :source,
        dependent: :nullify
    )

    has_many(
        :payments_in,
        class_name: "Payment",
        foreign_key: "destination_id",
        inverse_of: :destination,
        dependent: :nullify
    )

    validates :stripe_payment_method_id, presence: true
    validates :status, inclusion: {in: -> (i) {BankAccount.statuses}}
    validates :user, presence: true

    before_destroy do
        puts "❤️❤️❤️ BankAccount before_destroy block"
        if has_processing_payments?
            raise SafetyError::BankAccountSafetyError.new "You cannot delete this bank account because it has #{"processing payment".pluralize(num_processing_payments)}."
        end
        if user.bank_accounts.size == 1 && !user.mark_for_destruction
            raise SafetyError::BankAccountSafetyError.new "You must keep at least one bank account. Add another bank account before deleting this one."
        end
    end
    
    def has_processing_payments?
        Payment.processing.where(destination: self).or(Payment.processing.where(source: self)).exists?
    end

    def num_processing_payments
        Payment.processing.where(destination: self).or(Payment.processing.where(source: self)).count
    end

    # TODO: Add mechanic for bank account verification via microdeposits. Are other forms of verification needed?
    def verified?
        true
    end

    def self.statuses
        ["New", "Validated", "Verified", "Verification failed", "Errored"]
    end
end
