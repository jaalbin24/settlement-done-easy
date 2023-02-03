# == Schema Information
#
# Table name: payment_methods
#
#  id          :bigint           not null, primary key
#  bank_name   :string
#  country     :string
#  currency    :string
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
    self.inheritance_column = 'type'


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
end
