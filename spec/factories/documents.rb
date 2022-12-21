# == Schema Information
#
# Table name: documents
#
#  id              :bigint           not null, primary key
#  auto_generated  :boolean          default(FALSE), not null
#  needs_signature :boolean          default(FALSE), not null
#  nickname        :string
#  signed          :boolean          default(FALSE), not null
#  status          :string           default("Waiting for review"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  added_by_id     :bigint
#  ds_envelope_id  :string
#  log_book_id     :bigint
#  public_id       :string
#  settlement_id   :bigint
#
# Indexes
#
#  index_documents_on_added_by_id    (added_by_id)
#  index_documents_on_log_book_id    (log_book_id)
#  index_documents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
FactoryBot.define do
    factory :document, class: "Document" do
        settlement
        trait :added_by_adjuster do
            association :added_by, factory: :adjuster
        end
        trait :added_by_attorney do
            association :added_by, factory: :attorney
        end
        trait :approved do
            after(:create) do |d, e|
                puts "🤖🤖🤖 document:approved after(:create) block"
                d.reviews.each do |dr|
                    dr.approve
                end
            end
        end
        trait :rejected do
            after(:create) do |d, e|
                d.reviews.not_by(d.added_by).reject
            end
        end
        trait :from_the_ground_up do
            after(:create) do |d, e|
                d.settlement.documents.excluding(d).each do |destroy_me|
                    destroy_me.destroy!
                end
                d.added_by = rand(1..2).odd? ? d.settlement.attorney : d.settlement.adjuster if d.added_by.nil?

                noahs_ark = [d.settlement.attorney, d.settlement.adjuster, d.settlement.attorney.organization, d.settlement.adjuster.organization]
                User.all.excluding(noahs_ark).each do |u|
                    u.destroy!
                end
            end
            after(:build) do |d, e|
                d.added_by = rand(1..2).odd? ? d.settlement.attorney : d.settlement.adjuster if d.added_by.nil?
            end
        end
        after(:create) do |d, e|
            puts "🤖🤖🤖 document after(:create) block"
            d.reviews.destroy_all
            d.reviews = [build(:document_review, document: d, reviewer: d.settlement.adjuster), build(:document_review, document: d, reviewer: d.settlement.attorney)]
            d.reviews.each do |r|
                r.save
            end
        end
    end
end