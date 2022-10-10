module StripeTestData
	def stripe_test_data_hash
		{
			law_firms: {
				reed_foster: {
					business_name: "Reed & Foster",
					stripe_id: "acct_1LrELPPpW3kV0cW6",
					stripe_financial_account_id: "fa_1LrELjPpW3kV0cW67r2sp6sb",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			},
			insurance_companies: {
				particular_insurance: {
					buisness_name: "Particular Insurance",
					stripe_id: "acct_1LrELkPqFnLT4rDC",
					stripe_financial_account_id: "fa_1LrELwPqFnLT4rDC8SPKzzeR",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			}
		}
	end
end