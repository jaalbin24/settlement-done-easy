# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  canceled           :boolean          default(FALSE), not null
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_holder_name :string
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adjuster_id        :bigint
#  attorney_id        :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_adjuster_id    (adjuster_id)
#  index_settlements_on_attorney_id    (attorney_id)
#  index_settlements_on_log_book_id    (log_book_id)
#  index_settlements_on_started_by_id  (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (adjuster_id => users.id)
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#
FactoryBot.define do
    factory :settlement, class: "Settlement" do
        adjuster
        attorney
        amount {10.00}

        transient do
            num_documents {1}
        end

        trait :ready_for_payment do
            ready_for_payment {true}
            after(:build) do |s, e|
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
        end
        trait :needs_signature do
            after(:build) do |s, e|
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    needs_signature: true,
                    signed: false,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
        end
        trait :needs_document do
            transient do
                num_documents {0}
            end
            after(:build) do |s, e|
                s.amount = User.all.count
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
            after(:create) do |s, e|
                raise StandardError.new "Extra users created! Before=#{s.amount} | After=#{User.all.count}" if s.amount != User.all.count
            end
        end
        trait :needs_attr_approval_from_attorney do
            after(:build) do |s, e|
                s.started_by = s.adjuster
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :rejected, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
        end
        trait :needs_attr_approval_from_adjuster do
            after(:build) do |s, e|
                s.started_by = s.attorney
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :rejected, reviewer: s.adjuster),
                ]
            end
        end
        trait :needs_document_approval_from_attorney do
            after(:build) do |s, e|
                s.documents = build_list(:document, e.num_documents,
                    :needs_approval_from_attorney,
                    added_by: s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
        end
        trait :needs_document_approval_from_adjuster do
            after(:build) do |s, e|
                s.documents = build_list(:document, e.num_documents,
                    :needs_approval_from_adjuster,
                    added_by: s.adjuster,
                    settlement: s
                )
                s.attribute_reviews = [
                    build(:settlement_attributes_review_for_attorney, :approved, reviewer: s.attorney),
                    build(:settlement_attributes_review_for_adjuster, :approved, reviewer: s.adjuster),
                ]
            end
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
            s.settings = [create(:settlement_settings, :for_attorney, user: s.attorney, settlement: s), create(:settlement_settings, :for_adjuster, user: s.adjuster, settlement: s)]
            puts "🤖🤖🤖 settlement after(:create) block"
            puts "========> SETTLEMENT created!\n"+
                "========> adjuster: #{s.adjuster.name}\n"+
                "========> attorney: #{s.attorney.name}\n"+
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
                    source: s.adjuster.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
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
                s.attribute_reviews.each do |ar|
                    ar.approve_all
                    ar.save
                end
            end
        end
        trait :with_completed_payment do
            after(:build) do |s, e|
                puts "🤖🤖🤖 settlement:with_completed_payment after(:build) block"
                s.payments = build_list(:payment, 1, 
                    :completed,
                    source: s.adjuster.organization.default_bank_account,
                    destination: s.attorney.organization.default_bank_account,
                    settlement: s
                )
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
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
                s.attribute_reviews.each do |ar|
                    ar.approve_all
                    ar.save
                end
            end
        end
        trait :with_unanswered_payment_request do
            after(:build) do |s, e|
                puts "🤖🤖🤖 settlement:with_unanswered_payment_request after(:build) block"
                s.documents = build_list(:document, e.num_documents,
                    :approved,
                    added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
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
                s.payment_requests = [create(:payment_request, requester: s.attorney, accepter: s.adjuster, settlement: s)]
                s.attribute_reviews.each do |ar|
                    ar.approve_all
                    ar.save
                end
            end
        end
        after(:build) do |s, e|
            s.documents = build_list(:document, e.num_documents,
                added_by: rand(1..2).odd? ? s.attorney : s.adjuster,
                settlement: s
            )
            s.started_by = s.attorney if s.started_by.nil?
            puts "🤖🤖🤖 settlement before(:build) block"
            if e.adjuster.nil?
                s.adjuster = select_random_adjuster_or_create_one_if_none_exist
            end
            if e.attorney.nil?
                s.attorney = select_random_attorney_or_create_one_if_none_exist
            end
        end
    end
end
