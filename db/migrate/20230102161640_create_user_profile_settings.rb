class CreateUserProfileSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profile_settings do |t|
      t.string      :public_id

      t.boolean     :hide_tax_id_from_public
      t.boolean     :hide_tax_id_from_members

      t.boolean     :hide_product_description_from_public
      t.boolean     :hide_product_description_from_members

      t.boolean     :hide_mcc_from_public
      t.boolean     :hide_mcc_from_members

      t.boolean     :hide_last_name_from_public
      t.boolean     :hide_last_name_from_members

      t.boolean     :hide_phone_number_from_public
      t.boolean     :hide_phone_number_from_members

      t.boolean     :hide_email_from_public
      t.boolean     :hide_email_from_members

      t.boolean     :hide_address_from_public
      t.boolean     :hide_address_from_members

      t.boolean     :hide_date_of_birth_from_public
      t.boolean     :hide_date_of_birth_from_members

      t.boolean     :hide_relationship_to_business_from_public
      t.boolean     :hide_relationship_to_business_from_members

      t.boolean     :hide_percent_ownership_from_public
      t.boolean     :hide_percent_ownership_from_members
      
      t.boolean     :hide_last_4_of_ssn_from_public
      t.boolean     :hide_last_4_of_ssn_from_members

      t.references  :user_settings,    foreign_key: {to_table: :user_settings}

      t.timestamps
    end
  end
end
