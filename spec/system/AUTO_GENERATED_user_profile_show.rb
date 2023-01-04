# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The user profile show page" do
    include_context 'devise'
    context "when the owner is a member-type user" do
        context "and the visitor is the owner" do
        end
        context "and the visitor is the owner's organization" do
        end
        context "and the visitor is a member of another organization" do
            before :context do
                @visitors = [create(:attorney), create(:adjuster)]
            end
            after :context do
                @visitors.each {|v| v.destroy}
            end
            context "and the owner has profile settings set to show their last name to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_members_only: false, show_last_name_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_members_only: false, show_last_name_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Phone number"
                            expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Phone number"
                            expect(page).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_members_only: false, show_phone_number_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_members_only: false, show_phone_number_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Phone number"
                            expect(page).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Date of birth"
                            expect(page).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Date of birth"
                            expect(page).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_members_only: false, show_date_of_birth_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_members_only: false, show_date_of_birth_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Date of birth"
                            expect(page).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Address"
                            expect(page).to have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Address"
                            expect(page).to_not have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_members_only: false, show_address_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_members_only: false, show_address_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Address"
                            expect(page).to_not have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Relationship to business"
                            expect(page).to have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Relationship to business"
                            expect(page).to_not have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_members_only: false, show_relationship_to_business_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_members_only: false, show_relationship_to_business_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Relationship to business"
                            expect(page).to_not have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Percent ownership"
                            expect(page).to have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Percent ownership"
                            expect(page).to_not have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_members_only: false, show_percent_ownership_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_members_only: false, show_percent_ownership_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Percent ownership"
                            expect(page).to_not have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
        end
        context "and the visitor is a member of the same organization" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_last_name_to_members_only: false, show_last_name_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_last_name_to_members_only: false, show_last_name_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text owner.profile.last_name
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Phone number"
                            expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Phone number"
                            expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_phone_number_to_members_only: false, show_phone_number_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_phone_number_to_members_only: false, show_phone_number_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Phone number"
                            expect(page).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Date of birth"
                            expect(page).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Date of birth"
                            expect(page).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_date_of_birth_to_members_only: false, show_date_of_birth_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_members_only: false, show_date_of_birth_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Date of birth"
                            expect(page).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Address"
                            expect(page).to have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Address"
                            expect(page).to have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_address_to_members_only: false, show_address_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_address_to_members_only: false, show_address_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Address"
                            expect(page).to_not have_text owner.profile.address.to_s
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Relationship to business"
                            expect(page).to have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Relationship to business"
                            expect(page).to have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_members_only: false, show_relationship_to_business_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_members_only: false, show_relationship_to_business_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Relationship to business"
                            expect(page).to_not have_text owner.profile.relationship_to_business
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Percent ownership"
                            expect(page).to have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the same organization only" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_members_only: true)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_members_only: true)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Percent ownership"
                            expect(page).to have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :each do
                    attorney_profile_settings = build(:user_profile_settings_for_attorney, show_percent_ownership_to_members_only: false, show_percent_ownership_to_public: false)
                    attorney_profile_settings.save
                    adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_members_only: false, show_percent_ownership_to_public: false)
                    adjuster_profile_settings.save
                    @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                    @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        @visitors.each do |visitor|
                            sign_in visitor
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Percent ownership"
                            expect(page).to_not have_text owner.profile.percent_ownership
                        end
                    end
                end
            end
        end
        context "and the visitor is a separate organization" do
        end
    end
end
