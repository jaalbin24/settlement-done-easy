# == Schema Information
#
# Table name: payment_methods
#
#  id          :bigint           not null, primary key
#  bank_name   :string
#  country     :string
#  currency    :string
#  default     :boolean
#  exp_month   :integer
#  exp_year    :integer
#  last4       :integer
#  nickname    :string
#  status      :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  added_by_id :bigint
#  address_id  :bigint
#  public_id   :string
#  stripe_id   :string
#
# Indexes
#
#  index_payment_methods_on_added_by_id  (added_by_id)
#  index_payment_methods_on_address_id   (address_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (address_id => addresses.id)
#
class PaymentMethod < ApplicationRecord
    require 'english_language'
    include EnglishLanguage # for the sentence_case method
    
    self.inheritance_column = 'type'

    scope :bank_accounts,           ->  {where(type: "BankAccount")}

    belongs_to(
        :added_by,
        class_name: "User",
        foreign_key: :added_by_id,
        inverse_of: :payment_methods
    )

    belongs_to(
        :billing_address,
        class_name: "Address",
        foreign_key: :address_id,
        dependent: :destroy,
        optional: true,
    )
    accepts_nested_attributes_for :billing_address

    
    before_create do
        self.nickname = default_nickname
        self.default = true if added_by.payment_methods.where(default: true).count == 0
    end

    private

    def default_nickname
        name = bank_name.blank? ? "New #{sentence_case(type.blank? ? "payment method" : type).downcase}" : bank_name
        title = last4.blank? ? nil : "****#{last4}"
        base_nickname = [name, title].reject(&:blank?).join(" ")
        final_nickname = base_nickname
        all_nicknames = added_by.payment_methods.pluck(:nickname)
        i = 0
        while final_nickname.in?(all_nicknames)
            final_nickname = [base_nickname, "(#{i += 1})"].join(" ")
        end
        final_nickname
    end
end
