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
class UserProfile < ApplicationRecord

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: :user_id,
        inverse_of: :profile

    )
    belongs_to(
        :address,
        class_name: "Address",
        foreign_key: :address_id,
        dependent: :destroy
    )

    validates :first_name,  presence: {if: -> (i) {i.user.isMember?}}
    validates :last_name,   presence: {if: -> (i) {i.user.isMember?}}
    validates :public_name, presence: {if: -> (i) {i.user.isOrganization?}}

    accepts_nested_attributes_for :address
    
    before_validation do
        puts "❤️❤️❤️ UserProfile before_validation block"
        if address.nil?
            build_address
        end
        if email != user.email
            self.email = user.email
        end
    end

    def full_name
        if !first_name.blank?
            full = first_name
            if !last_name.blank?
                full += " #{last_name}"
            end
        elsif !last_name.blank?
            full = last_name
        end
        full
    end

    def name
        if user.isMember?
            full_name
        else
            public_name
        end
    end

    def settings
        user.settings.profile
    end
end
