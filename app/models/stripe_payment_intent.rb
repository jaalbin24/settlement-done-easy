# == Schema Information
#
# Table name: stripe_payment_intents
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :bigint           not null
#  stripe_id     :string           not null
#
# Indexes
#
#  index_stripe_payment_intents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#
class StripePaymentIntent < ApplicationRecord
    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id",
        inverse_of: :stripe_payment_intents
    )

    after_destroy do
        begin
            Stripe::PaymentIntent.cancel(stripe_id)
        rescue => e
            puts "⚠️ #{e.message}"
        end
    end
end
