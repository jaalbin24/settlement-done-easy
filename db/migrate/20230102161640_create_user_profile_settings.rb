class CreateUserProfileSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profile_settings do |t|
      t.string      :public_id

      t.boolean     :show_tax_id_to_public
      t.boolean     :show_tax_id_to_members_only

      t.boolean     :show_product_description_to_public
      t.boolean     :show_product_description_to_members_only

      t.boolean     :show_mcc_to_public
      t.boolean     :show_mcc_to_members_only

      t.boolean     :show_last_name_to_public
      t.boolean     :show_last_name_to_members_only

      t.boolean     :show_legal_name_to_public
      t.boolean     :show_legal_name_to_members_only

      t.boolean     :show_phone_number_to_public
      t.boolean     :show_phone_number_to_members_only

      t.boolean     :show_email_to_public
      t.boolean     :show_email_to_members_only

      t.boolean     :show_address_to_public
      t.boolean     :show_address_to_members_only

      t.boolean     :show_date_of_birth_to_public
      t.boolean     :show_date_of_birth_to_members_only

      t.boolean     :show_relationship_to_business_to_public
      t.boolean     :show_relationship_to_business_to_members_only

      t.boolean     :show_percent_ownership_to_public
      t.boolean     :show_percent_ownership_to_members_only
      
      t.boolean     :show_last_4_of_ssn_to_public
      t.boolean     :show_last_4_of_ssn_to_members_only

      t.references  :user_settings,    foreign_key: {to_table: :user_settings}

      t.timestamps
    end
  end
end
