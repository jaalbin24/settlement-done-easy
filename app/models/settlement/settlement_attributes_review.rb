# == Schema Information
#
# Table name: settlement_attributes_reviews
#
#  id                          :bigint           not null, primary key
#  amount_approved             :boolean
#  claim_number_approved       :boolean
#  claimant_name_approved      :boolean
#  incident_date_approved      :boolean
#  incident_location_approved  :boolean
#  policy_holder_name_approved :boolean
#  policy_number_approved      :boolean
#  status                      :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  public_id                   :string
#  settlement_id               :bigint
#  user_id                     :bigint
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

    scope :by,                  ->  (i) {where(reviewer: i)}
    scope :not_by,              ->  (i) {where.not(reviewer: i)}
    scope :not_fully_approved,  ->      {where(status: "Needs approval")}
    scope :not_approved,        ->      {where.not(status: "Approved")}
    scope :approved,            ->      {where(status: "Approved")}

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

    validates :status, inclusion: {in: ["Approved", "Needs approval"]}, on: :update

    after_commit do
        puts "❤️❤️❤️ SettlementAttributesReview after_commit block"
        unless frozen?
            update_status_attribute
            if changed?
                self.save
                settlement.save unless settlement.frozen?
            end
        end
    end
    
    before_create do
        puts "❤️❤️❤️ SettlementAttributesReview before_create block"
        if reviewer == settlement.started_by
            attributes.each do |attribute|
                if attribute[0].to_s.include?("_approved")
                    write_attribute(attribute[0].to_sym, true)
                end
            end
        else
            attributes.each do |attribute|
                if attribute[0].to_s.include?("_approved")
                    write_attribute(attribute[0].to_sym, false) if read_attribute(attribute[0]).nil?
                end
            end
        end
    end

    def update_status_attribute
        attributes.each do |attribute|
            if attribute[0].to_s.include?("_approved")
                unless attribute[1]
                    self.status = "Needs approval"
                    return
                end
            end
        end
        self.status = "Approved"
    end

    def approve_all
        attributes.each do |attribute|
            if attribute[0].to_s.include?("_approved")
                write_attribute(attribute[0].to_sym, true)
            end
        end
    end

    def reject_all
        attributes.each do |attribute|
            if attribute[0].to_s.include?("_approved")
                write_attribute(attribute[0].to_sym, false)
            end
        end
    end

    def approved?
        attributes.each do |attribute|
            if attribute[0].to_s.include?("_approved")
                return false unless read_attribute(attribute[0].to_sym)
            end
        end
        true
    end
end
