class CreateUserProfiles < ActiveRecord::Migration[6.1]
    def change
        create_table :user_profiles do |t|
            t.string        :public_id

            t.string        :first_name
            t.string        :last_name
            t.integer       :phone_number
            t.date          :date_of_birth
            t.string        :relationship_to_business
            t.integer       :percent_ownership
            t.integer       :ssn_last_4
            t.integer       :mcc
            t.string        :tax_id
            t.string        :product_description
            t.references    :address,                   foreign_key: {to_table: :addresses}
            t.references    :user,                      foreign_key: {to_table: :users}

            t.timestamps
        end
    end
end
