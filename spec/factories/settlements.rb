# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  defendant_name     :string
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attorney_id        :bigint
#  insurance_agent_id :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_log_book_id         (log_book_id)
#  index_settlements_on_started_by_id       (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#
FactoryBot.define do
    factory :settlement, class: "Settlement" do
        insurance_agent
        attorney
        amount {1000.00}
        transient do
            num_documents {1}
        end
        trait :with_processing_payment do
            after(:build) do |s, e|
                s.payments = build_list(:payment, 1, 
                    :processing,
                    source: s.insurance_agent.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
            end
        end

        trait :with_completed_payment do
            after(:build) do |s, e|
                s.payments = build_list(:payment, 1, 
                    :completed,
                    source: s.insurance_agent.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
            end
        end
        after(:build) do |s, e|
            s.documents = build_list(:document, e.num_documents,
                :added_by_insurance_agent,
                settlement: s
            )
        end
    end
end