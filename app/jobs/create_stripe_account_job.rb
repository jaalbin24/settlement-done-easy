class CreateStripeAccountJob < ApplicationJob
    queue_as :urgent
    
    retry_on Stripe::APIConnectionError
    retry_on Stripe::RateLimitError
    retry_on Stripe::APIConnectionError

    def perform(user)
        if user.isOrganization? && user.stripe_account.nil?
            user.create_stripe_account
        end
    end
end
