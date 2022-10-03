module SafetyError
    class SafetyError < StandardError
        # These error messages are meant to be seen by the user. Only include info that is ok to be seen by anyone.
    end

    class PaymentSafetyError < SafetyError
    end

    class SettlementSafetyError < SafetyError
    end

    class DocumentSafetyError < SafetyError
    end

    module Settlements

    end

    module Documents
        
    end
    
    module Payments
        def self.raise_error_unless_safe_to_execute_inbound_transfer_on(payment)
            default_safety(payment)
            raise PaymentSafetyError.new "This settlement already has a payment processing."                            if payment.settlement.has_processing_payment?
            raise PaymentSafetyError.new "Payment cannot be sent without a document."                                   unless payment.settlement.documents.exists?
            raise PaymentSafetyError.new "Payment cannot be sent until all documents are approved."                     if payment.settlement.documents.unapproved.exists?
            raise PaymentSafetyError.new "Payment cannot be sent until all documents that need a signature are signed." if payment.settlement.documents.unsigned.need_signature.exists?
        end

        def self.raise_error_unless_safe_to_execute_outbound_payment_on(payment)
            default_safety(payment)
            raise PaymentSafetyError.new "Cannot execute outbound payment without an inbound transfer."     if payment.stripe_inbound_transfer_id.blank?
        end

        def self.raise_error_unless_safe_to_execute_outbound_transfer_on(payment)
            default_safety(payment)
            raise PaymentSafetyError.new "Cannot execute outbound transfer without an inbound transfer."     if payment.stripe_inbound_transfer_id.blank?
            raise PaymentSafetyError.new "Cannot execute outbound transfer without an outbound payment."     if payment.stripe_outbound_payment_id.blank?
        end

        def self.raise_error_unless_safe_to_complete(payment)
            raise PaymentSafetyError.new "Settlement already completed."                                     if payment.completed?
        end

        private

        def self.default_safety(payment)
            raise PaymentSafetyError.new "Payment cannot be sent until the sending bank account is verified."                               unless payment.source.verified?
            raise PaymentSafetyError.new "Payment cannot be sent until the receiving bank account is verified."                             unless payment.destination.verified?
            raise PaymentSafetyError.new "Payment cannot be sent until #{payment.source.user.business_name}'s account is activated."        unless payment.source.user.activated?
            raise PaymentSafetyError.new "Payment cannot be sent until #{payment.destination.user.business_name}'s account is activated."   unless payment.destination.user.activated?
            raise PaymentSafetyError.new "This settlement has already been paid."                                                           if payment.settlement.has_completed_payment?
            raise PaymentSafetyError.new "Payment cannot be sent unless settlement is locked."                                              unless payment.settlement.locked?
            # TODO: Payment cannot be sent because the bank account has been deleted.
        end
    end
end