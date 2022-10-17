# == Schema Information
#
# Table name: settlement_attributes_reviews
#
#  id                         :bigint           not null, primary key
#  amount_approved            :boolean
#  claim_number_approved      :boolean
#  claimant_name_approved     :boolean
#  defendant_name_approved    :boolean
#  incident_date_approved     :boolean
#  incident_location_approved :boolean
#  policy_number_approved     :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  public_id                  :string
#  settlement_id              :bigint
#  user_id                    :bigint
#
# Indexes
#
#  index_settlement_attributes_reviews_on_settlement_id  (settlement_id)
#  index_settlement_attributes_reviews_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (user_id => users.id)
#
class SettlementAttributesReview < ApplicationRecord

    scope :by,      ->  (i) {where(reviewer: i)}
    scope :not_by,  ->  (i) {where.not(reviewer: i)}
    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: :settlement_id,
        inverse_of: :attribute_reviews
    )

    belongs_to(
        :reviewer,
        class_name: "User",
        foreign_key: :user_id
    )

    before_create do
        puts "❤️❤️❤️ SettlementAttributesReview before_create block"
        if reviewer == settlement.added_by
            attributes.each do |attribute|
                if [TrueClass, FalseClass].include?(attribute.class)
                    write_attribute(attribute.to_sym, true)
                end
            end
        else
            attributes.each do |attribute|
                if [TrueClass, FalseClass].include?(attribute.class)
                    write_attribute(attribute.to_sym, false)
                end
            end
        end
    end
end
