# This file is regularly overwritten by the rake task stripe_data:generate.
# Do not put anything in this file that you intend to be permanent.
module StripeTestData
	def stripe_test_data_hash
		{
			law_firms: {
				bass_berry_sims: {
					business_name: "Bass Berry & Sims",
					stripe_id: "acct_1MSaOtQ1bwwiWZUF",
					stripe_financial_account_id: "fa_1MSaP8Q1bwwiWZUFWMDHkVap",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				gkbm: {
					business_name: "GKBM",
					stripe_id: "acct_1MSaP9Pw90cBOic6",
					stripe_financial_account_id: "fa_1MSaPNPw90cBOic6QCnlcx5M",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				smith_doe: {
					business_name: "Smith & Doe",
					stripe_id: "acct_1MSaPOPxJ3j4bL9G",
					stripe_financial_account_id: "fa_1MSaPjPxJ3j4bL9Gd0cPWWYd",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				adams_reece: {
					business_name: "Adams & Reece",
					stripe_id: "acct_1MSaPkPsPvAlRtTq",
					stripe_financial_account_id: "fa_1MSaPyPsPvAlRtTqEz1djYJi",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			},
			insurance_companies: {
				progressive: {
					buisness_name: "Progressive",
					stripe_id: "acct_1MSaPzQ60bcMdMNu",
					stripe_financial_account_id: "fa_1MSaQCQ60bcMdMNuLr6A1ynA",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				allstate: {
					buisness_name: "Allstate",
					stripe_id: "acct_1MSaQDPtMFsOaX2C",
					stripe_financial_account_id: "fa_1MSaQSPtMFsOaX2Cksqsgaqc",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				geico: {
					buisness_name: "Geico",
					stripe_id: "acct_1MSaQTQ6wBERo5EO",
					stripe_financial_account_id: "fa_1MSaQgQ6wBERo5EOQ4UCk9lN",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				state_farm: {
					buisness_name: "State Farm",
					stripe_id: "acct_1MSaQhQ8w6gjyX5f",
					stripe_financial_account_id: "fa_1MSaQxQ8w6gjyX5fX9rYrlUR",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			}
		}
	end
end