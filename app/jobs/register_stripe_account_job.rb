class RegisterStripeAccountJob < ApplicationJob
    queue_as :urgent
    
    retry_on Stripe::APIConnectionError
    retry_on Stripe::RateLimitError
    retry_on Stripe::APIConnectionError

    def perform(stripe_account)
        if stripe_account.user.isOrganization? && !stripe_account.onboarded?
            unless Rails.env.test?
                account = Stripe::Account.create({
                    type: "custom",
                    country: "US",
                    capabilities: {
                        treasury: {requested: true},
                        us_bank_account_ach_payments: {requested: true},
                        card_payments: {requested: true},
                        transfers: {requested: true},
                    },
                    business_type: "company",
                    business_profile: {url: "http://settlementdoneeasy.com/"},
                })
                stripe_account.stripe_id = account.id
                stripe_account.sync_with(account)
                stripe_account.save
            end
        end
    end
end
