# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  stripe_account_onboarded    :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  organization_id             :bigint
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_organization_id              (organization_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
    
    test "fixtures are valid" do
        assert !users.empty?, "There are no User fixtures to test!"
        users.each do |u|
            assert u.valid?, u.errors.full_messages.inspect
        end
    end

    test "first name must have valid characters" do
        users.each do |u|
            if !u.isOrganization?
                assert u.valid?, u.errors.full_messages.inspect
                u.first_name = "$haggy"
                assert_not u.valid?
                u.first_name = "Shaggy"
                assert u.valid?, u.errors.full_messages.inspect
            end
        end
    end

    test "last name must have valid characters" do
        users.each do |u|
            if !u.isOrganization?
                assert u.valid?, u.errors.full_messages.inspect
                u.last_name = "L@stn4me"
                assert_not u.valid?
                u.last_name = "Lastname"
                assert u.valid?
            end
        end
    end

    test "business name must have valid characters" do
        users.each do |u|
            if u.isOrganization?
                assert u.valid?, u.errors.full_messages.inspect
                u.business_name = "Invl!d #usiness"
                assert_not u.valid?
                u.business_name = "Valid Business"
                assert u.valid?
            end
        end
    end
    
    test "email must exist" do
        users.each do |u|
            assert u.valid?, u.errors.full_messages.inspect
            u.email = ""
            assert_not u.valid?
        end
    end

    test "password must exist" do
        users.each do |u|
            assert u.valid?, u.errors.full_messages.inspect
            u.password = ""
            assert_not u.valid?
        end
    end

    test "organization-type users must have nil organization" do
        u = users(:gkbm)
        assert u.valid?, u.errors.full_messages.inspect
        u.organization = users(:state_farm)
        assert_not u.valid?
    end

    test "member-type users must not have an onboarded stripe account" do
        u = users(:gkbm_attorney)
        assert u.valid?, u.errors.full_messages.inspect
        u.stripe_account_onboarded = true
        assert_not u.valid?
    end

    test "role must match organization type" do
        u = users(:gkbm_attorney)
        u.organization = users(:gkbm)
        assert u.valid?, u.errors.full_messages.inspect
        u.role = "Insurance Agent"
        assert_not u.valid?

        u = users(:state_farm_insurance_agent)
        u.organization = users(:state_farm)
        assert u.valid?, u.errors.full_messages.inspect
        u.role = "Attorney"
        assert_not u.valid?
    end
end
