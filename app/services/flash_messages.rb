module FlashMessages
    module ErrorMessage
        def self.for(e)
            case e.class.name
            when 'Stripe::InvalidRequestError'
                for_stripe_invalid_request_error e
            when 'ActiveRecord::RecordNotFound'
                raise StandardError.new "Unhandled error type: #{e.class}"
            else
                raise e
                raise StandardError.new "Unhandled error type: #{e.class}"
            end
        end

        def self.for_stripe_invalid_request_error(e)
            case e.code.to_sym
            when :invalid_card_type
                {
                    heading: "That card is not a debit card.",
                    message: "Settlement Done Easy currently only supports non-prepaid debit cards. Credit cards and prepaid cards are not supported. Please provide a debit card instead."
                }
            when :instant_payouts_unsupported
                {
                    heading: "That card is not supported.",
                    message: "Most banks issue debit cards compatible with Settlement Done Easy, but your card is not. This is likely because the card is a prepaid debit card, but it could be something else. Please provide a different card instead."
                }
            else
                raise StandardError.new "Unhandled error code: #{e.code}"
            end

        end
    end

    module BankAccountMessage
        def self.for(status, options={})
            case status.to_sym
            when :succeeded
                "Your bank account was successfully added."
            when :canceled
                "No bank account was added."
            when :processing
                {
                    heading: "Your bank account is being verified.",
                    message: "Your bank account is being verified. After verification is complete, it will appear in the Bank Accounts tab on your home page."
                }
            when :requires_action
                "requires_action"
            when :requires_confirmation
                "requires_confirmation"
            when :requires_payment_method
                "requires_payment_method"
            else
                raise StandardError.new "Unhandled status code: #{status}"
            end
        end
    end
end