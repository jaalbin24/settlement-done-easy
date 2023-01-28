# This file is regularly overwritten by the rake task stripe_data:generate.
# Do not put anything in this file that you intend to be permanent.
module StripeTestData
	def stripe_test_data_hash
		{
			law_firms: {
				morgan_morgan: {
					business_name: "Morgan & Morgan",
					stripe_id: "acct_1MV3hSPp9UJWPGHL",
					stripe_financial_account_id: "fa_1MV3hiPp9UJWPGHLT8bbe49Q",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				gkbm: {
					business_name: "GKBM",
					stripe_id: "acct_1MV3hjQ1mwUvrEZn",
					stripe_financial_account_id: "fa_1MV3i3Q1mwUvrEZnt3xCaEYw",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				smith_doe: {
					business_name: "Smith & Doe",
					stripe_id: "acct_1MV3i5PvVO4gYjUl",
					stripe_financial_account_id: "fa_1MV3iNPvVO4gYjUlK0x82o6I",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				adams_reece: {
					business_name: "Adams & Reece",
					stripe_id: "acct_1MV3iOQ2oHcJrUO0",
					stripe_financial_account_id: "fa_1MV3icQ2oHcJrUO0tYB2VogR",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				bass_berry_sims: {
					business_name: "Bass Berry & Sims",
					stripe_id: "acct_1MV3idPqtW5mAIz4",
					stripe_financial_account_id: "fa_1MV3iyPqtW5mAIz4QPI2dD4Z",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			},
			insurance_companies: {
				geico: {
					buisness_name: "Geico",
					stripe_id: "acct_1MV3izQ54LyFkmwL",
					stripe_financial_account_id: "fa_1MV3jEQ54LyFkmwLpMOtLXv8",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				liberty_mutual: {
					buisness_name: "Liberty Mutual",
					stripe_id: "acct_1MV3jFPrEhJuLdit",
					stripe_financial_account_id: "fa_1MV3jXPrEhJuLditM7wISVXM",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				progressive: {
					buisness_name: "Progressive",
					stripe_id: "acct_1MV3jYPpr44tx523",
					stripe_financial_account_id: "fa_1MV3jpPpr44tx523PTOLVbxC",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				},
				state_farm: {
					buisness_name: "State Farm",
					stripe_id: "acct_1MV3jqQ6He3CSIrm",
					stripe_financial_account_id: "fa_1MV3k7Q6He3CSIrmryHaoVCK",
					external_accounts: {
						bank_account_1_payment_method_id: "",
						bank_account_2_payment_method_id: ""
					}
				}
			}
		}
	end
end