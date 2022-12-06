class CreateSettlementAttributesReviews < ActiveRecord::Migration[6.1]
    def change
        create_table :settlement_attributes_reviews do |t|
            # Any attributes with a column name that contains "_approved" will be automatically set when a
            # SettlementAttributesReview object is saved to the DB.
            t.string        :public_id
            t.string        :status
            t.references    :settlement,    foreign_key: {to_table: :settlements}
            t.references    :user,          foreign_key: {to_table: :users}
            t.boolean       :amount_approved
            t.boolean       :claimant_name_approved
            t.boolean       :policy_holder_name_approved
            t.boolean       :claim_number_approved
            t.boolean       :policy_number_approved
            t.boolean       :incident_date_approved
            t.boolean       :incident_location_approved

            t.timestamps
        end
    end
end
