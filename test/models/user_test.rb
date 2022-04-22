# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  first_name               :string
#  last_name                :string
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  role                     :string
#  stripe_account_onboarded :boolean          default(FALSE), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  organization_id          :bigint
#  stripe_account_id        :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_organization_id       (organization_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "email must exist" do
    users.each do |u|
      assert u.valid?, u.errors.full_messages.inspect
      u.email = ""
      assert_not u.valid?, u.errors.full_messages.inspect
    end
  end

  test "password must exist" do
    users.each do |u|
      assert u.valid?, u.errors.full_messages.inspect
      u.password = ""
      assert_not u.valid?, u.errors.full_messages.inspect
    end
  end

  test "organization-type users must have organization=nil" do
    u = users(:law_firm)
    u.organization_id = nil
    assert u.valid?, u.errors.full_messages.inspect
    u.organization_id = users(:insurance_company).id
    assert_not u.valid?, u.errors.full_messages.inspect
  end




end
