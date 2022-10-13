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

        trait :delete_my_documents_after_rejection do
            after(:create) do |s, e|
                s.settings.each do |setting|
                    setting.delete_my_documents_after_rejection = true
                    setting.save
                end
            end
        end

        after(:create) do |s, e|
            s.settings = [create(:settlement_settings, :for_attorney, user: s.attorney, settlement: s), create(:settlement_settings, :for_adjuster, user: s.insurance_agent, settlement: s)]
            puts "🤖🤖🤖 settlement after(:create) block"
            puts "========> SETTLEMENT created!\n"+
                "========> adjuster: #{s.insurance_agent.full_name}\n"+
                "========> attorney: #{s.attorney.full_name}\n"+
                "========> s.to_json: #{s.to_json}\n"+
                "========> payments.active.size: #{s.payments.active.size}\n"+
                "========> payment status: #{s.payments.last.status}\n"+
                "========> Settlement.all.size: #{Settlement.all.size}\n"
        end

        trait :with_processing_payment do
            after(:build) do |s, e|
                puts "🤖🤖🤖 settlement:with_processing_payment after(:build) block"
                s.payments = build_list(:payment, 1, 
                    :processing,
                    source: s.insurance_agent.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.insurance_agent,
                    settlement: s
                )
            end
            after(:create) do |s, e|
                puts "🤖🤖🤖 settlement:with_processing_payment after(:create) block"
                s.documents.each do |d|
                    d.reviews.each do |dr|
                        dr.approve
                    end
                end
            end
        end
        trait :with_completed_payment do
            after(:build) do |s, e|
                puts "🤖🤖🤖 settlement:with_completed_payment after(:build) block"
                s.payments = build_list(:payment, 1, 
                    :completed,
                    source: s.insurance_agent.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.insurance_agent,
                    settlement: s
                )
            end
            after(:create) do |s, e|
                puts "🤖🤖🤖 settlement:with_completed_payment after(:create) block"
                s.documents.each do |d|
                    d.reviews.each do |dr|
                        dr.approve
                    end
                end
            end
        end

        trait :with_unanswered_payment_request do
            after(:build) do |s, e|
                puts "🤖🤖🤖 settlement:with_unanswered_payment_request after(:build) block"
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.insurance_agent,
                    settlement: s
                )
            end
            after(:create) do |s, e|
                puts "🤖🤖🤖 settlement:with_unanswered_payment_request after(:create) block"
                s.documents.each do |d|
                    d.reviews.each do |dr|
                        dr.approve
                    end
                end
                s.payment_requests = [create(:payment_request, requester: s.attorney, accepter: s.insurance_agent, settlement: s)]
            end
        end

        after(:build) do |s, e|
            s.documents = build_list(:document, e.num_documents,
                added_by: rand(1..2).odd? ? s.attorney : s.insurance_agent,
                settlement: s
            )
            puts "🤖🤖🤖 settlement before(:build) block"
            if e.insurance_agent.nil?
                s.insurance_agent = select_random_insurance_agent_or_create_one_if_none_exist
            end
            if e.attorney.nil?
                s.attorney = select_random_attorney_or_create_one_if_none_exist
            end
        end
    end
end