# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  activated                   :boolean          default(FALSE), not null
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  recreated_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  id             :bigint
#  public_id                   :string
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_id              (id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (id => users.id)
#
require 'rails_helper'

RSpec.describe "Users", type: :model do
    context "of every role" do
        before(:each) do
            law_firm = create(:law_firm)
            insurance_company = create(:insurance_company)
            attorney = create(:attorney)
            adjuster = create(:adjuster)
            @users = [law_firm, insurance_company, attorney, adjuster]
        end
        it "cannot have their role changed" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                case u.role
                when "Attorney"
                    u.role = "Insurance Agent"
                when "Insurance Agent"
                    u.role = "Attorney"
                when "Law Firm"
                    u.role = "Insurance Company"
                when "Insurance Company"
                    u.role = "Law Firm"
                else
                    fail "Unhandled role: #{u.role}"
                end
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have a valid role" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.role = "Invalid role"
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have a role" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.role = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have an email" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.email = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have an encrypted password" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.encrypted_password = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
    end
    context "with an organization role" do
        before(:each) do
            @users = [create(:law_firm), create(:insurance_company)]
        end
        it "must not have a first name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.first_name = "Ted"
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must not have a last name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.last_name = "Ted"
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have a business name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.business_name = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have a stripe account" do
            @users.each do |u|
                acct = u.stripe_account
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.stripe_account = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must not belong to an organization" do
            @users.each do |u|
                @users.each do |org|
                    u.organization = nil
                    expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                    u.organization = org
                    expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                end
            end
        end
        context "and an activated account" do
            before(:each) do
                @users = [create(:law_firm, activated: true), create(:insurance_company, activated: true)]
            end
            it "must have an onboarded stripe account" do
                @users.each do |u|
                    expect(u.activated?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                    expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                    expect(u.stripe_account.onboarded?).to be_truthy, "Object: #{u.stripe_account.to_json} Error message: #{u.errors.full_messages.inspect}"
                    u.stripe_account = build(:stripe_account)
                    u.save!
                    # expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                end
            end
            it "must have at least one bank account" do

            end
            it "must have 2FA enabled" do

            end
            it "must have a verified email" do

            end
            it "must have at least one member account" do

            end
        end

        context "when their account is not activated" do

        end
    end

    context "with a member role" do
        before(:each) do
            @users = [create(:attorney), create(:adjuster)]
        end
        it "must have a first name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.first_name = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must have a last name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.last_name = nil
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must not have a business name" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.business_name = "Business"
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
        it "must not have a stripe account" do
            @users.each do |u|
                expect(u.valid?).to be_truthy, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
                u.stripe_account = create(:stripe_account, user: u)
                expect(u.valid?).to be_falsey, "Object: #{u.to_json} Error message: #{u.errors.full_messages.inspect}"
            end
        end
    end
end
