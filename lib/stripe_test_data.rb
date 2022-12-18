# This file is regularly overwritten by the rake task stripe_data:generate.
# Do not put anything in this file that you intend to be permanent.
module StripeTestData
	def stripe_test_data_hash
		{
			law_firms: {
				wright_morales_james: {
					business_name: "Wright Morales & James",
					stripe_id: "acct_1MG6AdQ19nw8xyxM",
					stripe_financial_account_id: "fa_1MG6AtQ19nw8xyxMZxvjMlqt",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				lee_green_a_cat: {
					business_name: "Lee Green & a Cat",
					stripe_id: "acct_1MG6AuQ9uNcUAL17",
					stripe_financial_account_id: "fa_1MG6BAQ9uNcUAL17mlHsZyKP",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				long_adams_hernandez: {
					business_name: "Long Adams & Hernandez",
					stripe_id: "acct_1MG6BBQ3A9wR1ily",
					stripe_financial_account_id: "fa_1MG6BRQ3A9wR1ilyO3bG1nuz",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				hernandez_hernandez_a_cheetah: {
					business_name: "Hernandez Hernandez & a Cheetah",
					stripe_id: "acct_1MG6BSPx4L3lcFhk",
					stripe_financial_account_id: "fa_1MG6BqPx4L3lcFhk4LxVJy9V",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				law_actions: {
					business_name: "Law Actions",
					stripe_id: "acct_1MG6BrQ96gd0JLGv",
					stripe_financial_account_id: "fa_1MG6CNQ96gd0JLGv5ffLzi5E",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			},
			insurance_companies: {
				very_original_insurance: {
					buisness_name: "Very Original Insurance",
					stripe_id: "acct_1MG6COPoGssm9nHx",
					stripe_financial_account_id: "fa_1MG6ChPoGssm9nHx37yjqvvr",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				high_insurance: {
					buisness_name: "High Insurance",
					stripe_id: "acct_1MG6CiPpAopd1QWE",
					stripe_financial_account_id: "fa_1MG6D3PpAopd1QWEBprlvWAe",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				very_regular_insurance: {
					buisness_name: "Very Regular Insurance",
					stripe_id: "acct_1MG6D4Pp9cLBcfoG",
					stripe_financial_account_id: "fa_1MG6DNPp9cLBcfoGaHSsMOZ4",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				cold_insurance: {
					buisness_name: "Cold Insurance",
					stripe_id: "acct_1MG6DOQ2bNICLuos",
					stripe_financial_account_id: "fa_1MG6DfQ2bNICLuosqb98SpcC",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				american_insurance: {
					buisness_name: "American Insurance",
					stripe_id: "acct_1MG6DhPqWsi7cAHC",
					stripe_financial_account_id: "fa_1MG6DvPqWsi7cAHCiml37ObY",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			}
		}
	end
end