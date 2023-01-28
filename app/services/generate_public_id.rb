module GeneratePublicId
    def self.for(model)
        case model.class.name.demodulize
        when "Address"
            id_prefix = "addr"
        when "BankAccount"
            id_prefix = "bacc"
        when "DocumentReview"
            id_prefix = "drev"
        when "Document"
            id_prefix = "dcmt"
        when "LogBookEntry"
            id_prefix = "lben"
        when "LogBook"
            id_prefix = "lgbk"
        when "Notification"
            id_prefix = "notf"
        when "PaymentRequest"
            id_prefix = "preq"
        when "Payment"
            id_prefix = "pmnt"
        when "PaymentMethod"
            id_prefix = "pmet"
        when "Settlement"
            id_prefix = "sett"
        when "SettlementAttributesReview"
            id_prefix = "sare"
        when "SettlementSettings"
            id_prefix = "sset"
        when "StripeAccountRequirement"
            id_prefix = "sreq"
        when "StripeAccount"
            id_prefix = "sacc"
        when "UserProfile"
            id_prefix = "upro"
        when "UserProfileSettings"
            id_prefix = "upse"
        when "UserSettings"
            id_prefix = "uset"
        when "User"
            id_prefix = "user"
        else 
            raise StandardError.new "PublicId prefix not implemented for the class \"#{model.class.name.demodulize}\""
        end
        return "#{id_prefix}_#{generate_unique_alphanumeric_string_of_size(59)}"
    end

    private

    def self.generate_unique_alphanumeric_string_of_size(size)
      o = [("a".."z"), ("A".."Z"), (0..9)].map(&:to_a).flatten
      return string = (0...size-1).map { o[rand(o.length)] }.join
    end
end