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
class Card < PaymentMethod

    attr_accessor :token
    # These^ values are used on the front end, but they are not stored in the database.
    
    
end
