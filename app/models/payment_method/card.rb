# == Schema Information
#
# Table name: payment_methods
#
#  id         :bigint           not null, primary key
#  bank_name  :string
#  country    :string
#  currency   :string
#  last4      :integer
#  nickname   :string
#  status     :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address_id :bigint
#  public_id  :string
#  stripe_id  :string
#  user_id    :bigint
#
# Indexes
#
#  index_payment_methods_on_address_id  (address_id)
#  index_payment_methods_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (user_id => users.id)
#
class Card < PaymentMethod

    attr_accessor :number
    attr_accessor :cvc
    attr_accessor :exp_month
    attr_accessor :exp_year
    attr_accessor :expiration
    # These^ values are used on the front end, but they are not stored in the database.
    
    
end
