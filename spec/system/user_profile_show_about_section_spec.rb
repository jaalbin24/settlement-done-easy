# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The about section of the user profile show page" do
    include_context 'devise'
    before :context do
        create(:attorney)
        create(:adjuster)
    end
    after :context do
        User.all.each {|u| u.destroy}
    end
    context "when the owner is a member-type user" do
        context "and the visitor is the owner" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is the owners organization" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is a member of the owners organization" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to_not have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0].organization)
                    create(:adjuster, organization: @owners[1].organization)
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.organization.members.where.not(id: owner.id).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is a member of another organization" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to_not have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to_not have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is another organization" do
            context "and the owner has profile settings set to show their last name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: true, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: true, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: true, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: true, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to the public" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: true, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to_not have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_name_to_public: false, show_last_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='owner_name']")).to_not have_text owner.profile.last_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their date of birth to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_date_of_birth_to_public: false, show_date_of_birth_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's date of birth" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Date of birth"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.date_of_birth.strftime('%B %-d, %Y')
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their relationship to business to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_relationship_to_business_to_public: false, show_relationship_to_business_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's relationship to business" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Relationship to business"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.relationship_to_business
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their percent ownership to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_percent_ownership_to_public: false, show_percent_ownership_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's percent ownership" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Percent ownership"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "#{owner.profile.percent_ownership}%"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their last 4 of ssn to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_attorney, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_adjuster, show_last_4_of_ssn_to_public: false, show_last_4_of_ssn_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's last 4 of ssn" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "SSN"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "###-##-#{owner.profile.last_4_of_ssn}"
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
    end
    context "when the owner is an organization-type user" do
        context "and the visitor is the owner" do
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is one of the owners members" do
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    create(:attorney, organization: @owners[0])
                    create(:adjuster, organization: @owners[1])
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's product description" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in owner.members.first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is a member of another organization" do
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.members.where.not(organization: [owner.organization, owner]).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
        context "and the visitor is another organization" do
            context "and the owner has profile settings set to show their phone number to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: true, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: true, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: true, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: true, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: true, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to the public" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: true, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to members of the organization" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: true)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their phone number to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_phone_number_to_public: false, show_phone_number_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's phone number" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Phone number"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their address to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_address_to_public: false, show_address_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's address" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Address"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.address.to_s
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their legal name to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_legal_name_to_public: false, show_legal_name_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's legal name" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Legal name"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.legal_name
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their mcc to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_mcc_to_public: false, show_mcc_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's mcc" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "MCC"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.mcc
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their tax id to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_tax_id_to_public: false, show_tax_id_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's tax id" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Tax ID"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.tax_id
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
            context "and the owner has profile settings set to show their product description to nobody" do
                before :context do
                    a = build(:user_profile_settings_for_law_firm, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                    a = build(:user_profile_settings_for_insurance_company, show_product_description_to_public: false, show_product_description_to_members_only: false)
                    a.save
                    (@owners ||= []).push a.user_settings.user
                end
                after :context do
                    @owners.each do |owner|
                        owner.organization.destroy if owner.isMember?
                        owner.destroy if owner.isOrganization?
                    end
                end
                it "must not have the owner's product description" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        click_on 'About'
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text "Product description"
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_text owner.profile.product_description
                    end
                end
                it "must not have a link to the user profile edit page" do
                    @owners.each do |owner|
                        sign_in User.organizations.without(owner.organization, owner).first
                        visit user_profile_show_path(owner.profile, section: 'about')
                        expect(find("[data-test-id='user_profile_show_page']")).to_not have_link "Edit profile"
                    end
                end
            end
        end
    end
end
