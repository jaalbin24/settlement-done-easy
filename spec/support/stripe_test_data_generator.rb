require 'rails_helper'

module StripeTestDataGenerator

    class InsuranceCompany
        
    end

    class LawFirm

    end

    class BankAccount
        def payment_method_id=(value)
            @payment_method_id = value
        end
    end

    def onboard_insurance_company(stripe_id)

    end

    def onboard_law_firm(stripe_id)
        
    end

    def generate_law_firm_stripe_id
        
    end

    def generate_insurance_company_stripe_id

    end

    def generate_bank_account_payment_method_id
        RSpec.describe "automatically fill in bank account info" do

        end
    end

    def generate_ecosystem
        NUM_LAW_FIRMS = 1
        NUM_INSURANCE_COMPANIES = 1
        ATTORNEYS_PER_LAW_FIRM = 1
        ADJUSTERS_PER_INSURANCE_COMPANY = 1
        BANK_ACCOUNTS_PER_ORGANIZATION = 1
        ecosystem = {}
        NUM_LAW_FIRMS.times do |i|
            onboard_law_firm(generate_law_firm_stripe_id)
        end
        return ecosystem
    end
end