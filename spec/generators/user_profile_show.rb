# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
include SpecGenerator

titleless_attr = [
    :last_name
]

alternate_values = {
    address: "owner.profile.address.to_s",
    date_of_birth: "owner.profile.date_of_birth.strftime('%B %-d, %Y')",
    phone_number: "ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)"
}

hidable_member_profile_attr = [
    :last_name,
    :phone_number,
    :date_of_birth,
    :address,
    :relationship_to_business,
    :percent_ownership
]

hidable_organization_profile_attr = [
    :legal_name,
    :phone_number,
    :mcc,
    :address,
    :tax_id,
    :product_description,
]


SpecGenerator::SystemSpec.new(name: "user_profile_show") do |s|
    s.describe "The user profile show page" do
        s.context "when the owner is a member-type user" do
            s.context "and the visitor is the owner" do
                
            end
            s.context "and the visitor is the owner's organization" do

            end
            s.context "and the visitor is a member of another organization" do
                s.before :context do
                    "@visitors = [create(:attorney), create(:adjuster)]"
                end
                s.after :context do
                    "@visitors.each {|v| v.destroy}"
                end
                hidable_member_profile_attr.each do |a|
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to the public" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_public: true)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_public: true)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]"
                        end
                        s.it "must have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to members of the same organization only" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_members_only: true)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_members_only: true)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]"
                        end
                        s.it "must not have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to_not have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to_not have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to nobody" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_members_only: false, show_#{a.to_s}_to_public: false)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_members_only: false, show_#{a.to_s}_to_public: false)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]"
                        end
                        s.it "must not have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to_not have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to_not have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                end
            end
            s.context "and the visitor is a member of the same organization" do
                hidable_member_profile_attr.each do |a|
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to the public" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_public: true)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_public: true)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                            @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]"
                        end
                        s.it "must have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to members of the same organization only" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_members_only: true)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_members_only: true)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                            @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]"
                        end
                        s.it "must have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                    s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to nobody" do
                        s.before :each do
                            "attorney_profile_settings = build(:user_profile_settings_for_attorney, show_#{a.to_s}_to_members_only: false, show_#{a.to_s}_to_public: false)
                            attorney_profile_settings.save
                            adjuster_profile_settings = build(:user_profile_settings_for_adjuster, show_#{a.to_s}_to_members_only: false, show_#{a.to_s}_to_public: false)
                            adjuster_profile_settings.save
                            @owners = [attorney_profile_settings.user_settings.user, adjuster_profile_settings.user_settings.user]
                            @visitors = [create(:attorney, organization: attorney_profile_settings.user_settings.user.organization), create(:adjuster, organization: adjuster_profile_settings.user_settings.user.organization)]"
                        end
                        s.it "must not have the owner's #{a.to_s.gsub("_", " ")}" do
                            "@owners.each do |owner|
                                @visitors.each do |visitor|
                                    sign_in visitor
                                    visit user_profile_show_path(owner.profile)#{("
                                    expect(page).to_not have_text \"" + a.to_s.gsub("_", " ").capitalize + "\"") unless titleless_attr.include?(a)}
                                    expect(page).to_not have_text #{alternate_values.keys.include?(a) ? alternate_values[a] : "owner.profile.#{a.to_s}"}
                                end
                            end"
                        end
                    end
                end
            end
            s.context "and the visitor is a separate organization" do

            end
        end
    end
end