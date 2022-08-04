# == Schema Information
#
# Table name: stripe_payment_methods
#
#  id         :bigint           not null, primary key
#  nickname   :string
#  preferred  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_stripe_payment_methods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class StripePaymentMethod < ApplicationRecord
    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        inverse_of: :stripe_payment_methods
    )

    after_destroy do
        Stripe::PaymentMethod.detach(stripe_id)
    end
end
