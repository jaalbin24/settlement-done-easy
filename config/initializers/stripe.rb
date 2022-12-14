if Rails.env.production?
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
else
    Stripe.api_key = Rails.configuration.STRIPE_SECRET_KEY
end