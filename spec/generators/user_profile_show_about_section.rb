# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
include EnglishLanguage
include SpecGenerator

security_groups = {
    "the public": {
        show_attr_to_public?: true,
        show_attr_to_members_only?: false,
        allowed_visitors: [
            :the_owner, 
            :the_owners_organization, 
            :one_of_the_owners_members,
            :a_member_of_another_organization,
            :a_member_of_the_owners_organization,
            :another_organization,
        ]
    },
    "members of the organization": {
        show_attr_to_public?: false,
        show_attr_to_members_only?: true,
        allowed_visitors: [
            :the_owner, 
            :the_owners_organization, 
            :one_of_the_owners_members,
            :a_member_of_the_owners_organization,
        ]
    },
    "nobody": {
        show_attr_to_public?: false,
        show_attr_to_members_only?: false,
        allowed_visitors: [
            :the_owner, 
            :the_owners_organization, 
        ]
    }
}

visitors = {
    the_owner: {
        test_on_members?: true,
        test_on_organizations?: true,
        sign_in: "owner",
        can_edit_owner_profile: true
    },
    the_owners_organization: { # Only applicable when the owner is a member-type user
        test_on_members?: true,
        test_on_organizations?: false,
        sign_in: "owner.organization",
        can_edit_owner_profile: true
    },
    one_of_the_owners_members: { # Only applicable when the owner is an organization-type user
        test_on_members?: false,
        test_on_organizations?: true,
        sign_in: "owner.members.first",
        can_edit_owner_profile: false
    },
    a_member_of_the_owners_organization: { # Only applicable when the owner is a member-type user
        test_on_members?: true,
        test_on_organizations?: false,
        sign_in: "owner.organization.members.where.not(id: owner.id).first",
        can_edit_owner_profile: false
    },
    a_member_of_another_organization: {
        test_on_members?: true,
        test_on_organizations?: true,
        sign_in: "User.members.where.not(organization: [owner.organization, owner]).first",
        can_edit_owner_profile: false
    },
    another_organization: {
        test_on_members?: true,
        test_on_organizations?: true,
        sign_in: "User.organizations.without(owner.organization, owner).first",
        can_edit_owner_profile: false
    }
}

owners = {
    member: [
        "attorney",
        "adjuster"
    ],
    organization: [
        "law_firm",
        "insurance_company"
    ]
}

tested_attr = {
    last_name: {
        member_attr?: true,
        organization_attr?: false,
        has_label?: false,
        expected_label: nil,
        expected_value: "owner.profile.last_name",
        expected_location: "owner_name"
    },
    phone_number: {
        member_attr?: true,
        organization_attr?: true,
        has_label?: true,
        expected_label: "Phone number",
        expected_value: "ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)",
        expected_location: "user_profile_show_page"
    },
    date_of_birth: {
        member_attr?: true,
        organization_attr?: false,
        has_label?: true,
        expected_label: "Date of birth",
        expected_value: "owner.profile.date_of_birth.strftime('%B %-d, %Y')",
        expected_location: "user_profile_show_page"
    },
    address: {
        member_attr?: true,
        organization_attr?: true,
        has_label?: true,
        expected_label: "Address",
        expected_value: "owner.profile.address.to_s",
        expected_location: "user_profile_show_page"
    },
    relationship_to_business: {
        member_attr?: true,
        organization_attr?: false,
        has_label?: true,
        expected_label: "Relationship to business",
        expected_value: "owner.profile.relationship_to_business",
        expected_location: "user_profile_show_page"
    },
    percent_ownership: {
        member_attr?: true,
        organization_attr?: false,
        has_label?: true,
        expected_label: "Percent ownership",
        expected_value: '"#{owner.profile.percent_ownership}%"',
        expected_location: "user_profile_show_page"
    },
    last_4_of_ssn: {
        member_attr?: true,
        organization_attr?: false,
        has_label?: true,
        expected_label: "SSN",
        expected_value: '"###-##-#{owner.profile.last_4_of_ssn}"',
        expected_location: "user_profile_show_page"
    },
    legal_name: {
        member_attr?: false,
        organization_attr?: true,
        has_label?: true,
        expected_label: "Legal name",
        expected_value: "owner.profile.legal_name",
        expected_location: "user_profile_show_page"
    },
    mcc: {
        member_attr?: false,
        organization_attr?: true,
        has_label?: true,
        expected_label: "MCC",
        expected_value: "owner.profile.mcc",
        expected_location: "user_profile_show_page"
    },
    tax_id: {
        member_attr?: false,
        organization_attr?: true,
        has_label?: true,
        expected_label: "Tax ID",
        expected_value: "owner.profile.tax_id",
        expected_location: "user_profile_show_page"
    },
    product_description: {
        member_attr?: false,
        organization_attr?: true,
        has_label?: true,
        expected_label: "Product description",
        expected_value: "owner.profile.product_description",
        expected_location: "user_profile_show_page"
    },
}

SpecGenerator::SystemSpec.new(name: "user_profile_show_about_section") do |s|
    s.describe "The about section of the user profile show page" do
        s.before :context do 
            "create(:attorney)
            create(:adjuster)"
        end
        s.after :context do
            "User.all.each {|u| u.destroy}"
        end
        owners.keys.each do |owner|
            s.context "when the owner is #{indefinite_articleize(word: owner.to_s)}-type user" do
                visitors.keys.each do |v|
                    next unless visitors[v]["test_on_#{owner}s?".to_sym]
                    s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                        security_groups.keys.each do |group|
                            tested_attr.keys.each do |a|
                                next unless tested_attr[a]["#{owner}_attr?".to_sym]
                                s.context "and the owner has profile settings set to show their #{a.to_s.gsub("_", " ")} to #{group}" do
                                    s.before :context do
                                        owners_array = []
                                        owners[owner].each do |owner|
                                            s.text do
                                                "a = build(:user_profile_settings_for_#{owner}, show_#{a}_to_public: #{security_groups[group][:show_attr_to_public?]}, show_#{a}_to_members_only: #{security_groups[group][:show_attr_to_members_only?]})
                                                a.save
                                                (@owners ||= []).push a.user_settings.user"
                                            end
                                        end
                                        case v
                                        when  :a_member_of_the_owners_organization
                                            "create(:attorney, organization: @owners[0].organization)
                                            create(:adjuster, organization: @owners[1].organization)"
                                        when :one_of_the_owners_members
                                            "create(:attorney, organization: @owners[0])
                                            create(:adjuster, organization: @owners[1])"
                                        else
                                            ""
                                        end
                                    end
                                    s.after :context do
                                        "@owners.each do |owner|
                                            owner.organization.destroy if owner.isMember?
                                            owner.destroy if owner.isOrganization?
                                        end"
                                    end
                                    s.it "must #{security_groups[group][:allowed_visitors].include?(v) ? "have" : "not have"} the owner's #{a.to_s.gsub("_", " ")}" do
                                        "@owners.each do |owner|
                                            sign_in #{visitors[v][:sign_in]}
                                            visit user_profile_show_path(owner.profile, section: 'about')
                                            click_on 'About'#{("
                                            expect(find(\"[data-test-id='#{tested_attr[a][:expected_location]}']\")).#{security_groups[group][:allowed_visitors].include?(v) ? "to": "to_not"} have_text \"#{tested_attr[a][:expected_label]}\"") if tested_attr[a][:has_label?]}
                                            expect(find(\"[data-test-id='#{tested_attr[a][:expected_location]}']\")).#{security_groups[group][:allowed_visitors].include?(v) ? "to": "to_not"} have_text #{tested_attr[a][:expected_value]}
                                        end"
                                    end
                                    s.it "must #{visitors[v][:can_edit_owner_profile] ? "have" : "not have"} a link to the user profile edit page" do
                                        "@owners.each do |owner|
                                            sign_in #{visitors[v][:sign_in]}
                                            visit user_profile_show_path(owner.profile, section: 'about')
                                            expect(find(\"[data-test-id='user_profile_show_page']\")).#{visitors[v][:can_edit_owner_profile] ? "to" : "to_not"} have_link \"Edit profile\"
                                        end"
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end