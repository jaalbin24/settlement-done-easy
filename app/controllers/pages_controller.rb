class PagesController < ApplicationController
    require 'stripe'
    before_action :authenticate_user!, except: :user_type_select

    def home
        render :home
    end

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def approve_or_reject
        @release_form = ReleaseForm.find(params[:id])
        @comment = Comment.new
        render :approve_or_reject
    end

    def testing
        payment_intent = Stripe::PaymentIntent.create(
            amount: 2400,
            currency: 'usd',
            automatic_payment_methods: {
                enabled: false,
            },
        )
        {
            clientSecret: payment_intent['client_secret']
        }.to_json

        render :testing
    end
end
