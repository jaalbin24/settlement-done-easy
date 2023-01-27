# == Schema Information
#
# Table name: settlement_attributes_reviews
#
#    id                                                    :bigint                     not null, primary key
#    amount_approved                         :boolean
#    claim_number_approved             :boolean
#    claimant_name_approved            :boolean
#    incident_date_approved            :boolean
#    incident_location_approved    :boolean
#    policy_holder_name_approved :boolean
#    policy_number_approved            :boolean
#    status                                            :string
#    created_at                                    :datetime                 not null
#    updated_at                                    :datetime                 not null
#    public_id                                     :string
#    settlement_id                             :bigint
#    user_id                                         :bigint
#
# Indexes
#
#    index_settlement_attributes_reviews_on_settlement_id    (settlement_id)
#    index_settlement_attributes_reviews_on_user_id                (user_id)
#
# Foreign Keys
#
#    fk_rails_...    (settlement_id => settlements.id)
#    fk_rails_...    (user_id => users.id)
#
FactoryBot.define do
    factory :settlement_attributes_review do
        settlement
        factory :settlement_attributes_review_for_attorney do
            association :reviewer, factory: :attorney
        end
        factory :settlement_attributes_review_for_adjuster do
            association :reviewer, factory: :adjuster
        end
        trait :approved do
            after(:build) do |sar, e|
                sar.approve_all
            end
            after(:create) do |sar, e|
                raise StandardError.new "SAR test fixture is not approved when it should be." unless sar.approved?
            end
        end
        trait :rejected do
            after(:build) do |sar, e|
                sar.reject_all
            end
            after(:create) do |sar, e|
                raise StandardError.new "SAR test fixture is approved when it should not be." if sar.approved?
            end
        end
    end
end
