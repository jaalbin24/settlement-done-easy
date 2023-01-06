# == Schema Information
#
# Table name: user_profiles
#
#  id                       :bigint           not null, primary key
#  date_of_birth            :date
#  email                    :string
#  first_name               :string
#  last_4_of_ssn            :integer
#  last_name                :string
#  legal_name               :string
#  mcc                      :integer
#  percent_ownership        :integer
#  phone_number             :bigint
#  product_description      :string
#  public_name              :string
#  relationship_to_business :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  address_id               :bigint
#  public_id                :string
#  tax_id                   :string
#  user_id                  :bigint
#
# Indexes
#
#  index_user_profiles_on_address_id  (address_id)
#  index_user_profiles_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (user_id => users.id)
#
include EnglishLanguage

FactoryBot.define do
    factory :user_profile do
        association :address, factory: :address
        phone_number {1234567890}

        factory :user_profile_for_member do
            first_name {random_first_name}
            last_name {random_last_name}
            last_4_of_ssn {rand(0000..9999)}
            date_of_birth {(27*12 + 2).months.ago} # Profile of a person aged 27 Years amd 2 months
            relationship_to_business {"Manager"}
            percent_ownership {0}

            factory :user_profile_for_attorney do
                association :user, factory: :attorney
            end
    
            factory :user_profile_for_adjuster do
                association :user, factory: :adjuster
            end
        end

        factory :user_profile_for_organization do
            legal_name {"LEGAL NAME"}
            mcc {8890}
            tax_id {"TAX-ID"}
            product_description {"PRODUCT DESCRIPTION"}

            factory :user_profile_for_law_firm do
                public_name {random_law_firm_name}
                association :user, factory: :law_firm
            end

            factory :user_profile_for_insurance_company do
                public_name {random_insurance_company_name}
                association :user, factory: :insurance_company
            end
        end
    end
end
