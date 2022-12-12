# This file is regularly overwritten by the rake task stripe_data:generate.
# Do not put anything in this file that you intend to be permanent.
module StripeTestData
	def stripe_test_data_hash
		{
			law_firms: {
				davis_evans: {
					business_name: "Davis & Evans",
					stripe_id: "acct_1LrP4mPsh2ldGS4P",
					stripe_financial_account_id: "fa_1LrP5HPsh2ldGS4PPMdwjYHJ",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				nguyen_allen: {
					business_name: "Nguyen & Allen",
					stripe_id: "acct_1LrP5KPotEvShOkb",
					stripe_financial_account_id: "fa_1LrP5ZPotEvShOkb8nKW7fCp",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				morgan_cruz_foster: {
					business_name: "Morgan Cruz & Foster",
					stripe_id: "acct_1LrP5aPviwwHJU4e",
					stripe_financial_account_id: "fa_1LrP6BPviwwHJU4exRLUajyl",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				miller_allen_walker: {
					business_name: "Miller Allen & Walker",
					stripe_id: "acct_1LrP6DPtJhrk3wVG",
					stripe_financial_account_id: "fa_1LrP6YPtJhrk3wVGzBQFXeUq",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				law_cards: {
					business_name: "Law Cards",
					stripe_id: "acct_1LrP6aPuUtsQnIYU",
					stripe_financial_account_id: "fa_1LrP6qPuUtsQnIYUqB8PQM0d",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			},
			insurance_companies: {
				common_insurance: {
					buisness_name: "Common Insurance",
					stripe_id: "acct_1LrP6rQ8xXGL9tUN",
					stripe_financial_account_id: "fa_1LrP7AQ8xXGL9tUNoXf1orRX",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				very_medical_insurance: {
					buisness_name: "Very Medical Insurance",
					stripe_id: "acct_1LrP7BPxvAzsTxQG",
					stripe_financial_account_id: "fa_1LrP7QPxvAzsTxQGif7sPWlv",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				additional_insurance: {
					buisness_name: "Additional Insurance",
					stripe_id: "acct_1LrP7RPxYm5JIL6u",
					stripe_financial_account_id: "fa_1LrP7mPxYm5JIL6uDMFY2388",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				insuraaccess: {
					buisness_name: "InsuraAccess",
					stripe_id: "acct_1LrP7oQ7RbxbEDk2",
					stripe_financial_account_id: "fa_1LrP8EQ7RbxbEDk2kgUmjHXY",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				very_individual_insurance: {
					buisness_name: "Very Individual Insurance",
					stripe_id: "acct_1LrP8GQ0EyEJYDWS",
					stripe_financial_account_id: "fa_1LrP8XQ0EyEJYDWStWaKce9F",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			}
		}
	end
end