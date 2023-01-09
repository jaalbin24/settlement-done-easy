# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
include EnglishLanguage
include SpecGenerator

visitors = {
    the_owner: {
        test_on_members?: true,
        test_on_organizations?: true,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: false,
        creation_code: "@owner",
        settlement_start_button: {
            label: "New settlement",
            expected_to_be_present?: true
        }
    },
    the_owners_organization: { # Only applicable when the owner is a member-type user
        test_on_members?: true,
        test_on_organizations?: false,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: false,
        creation_code: "@owner.organization",
        settlement_start_button: {
            label: nil,
            expected_to_be_present?: false
        }
    },
    one_of_the_owners_members: { # Only applicable when the owner is an organization-type user
        test_on_members?: false,
        test_on_organizations?: true,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: false,
        creation_code: "@owner.members.first",
        settlement_start_button: {
            label: nil,
            expected_to_be_present?: false
        }
    },
    a_member_of_the_owners_organization: { # Only applicable when the owner is a member-type user
        test_on_members?: true,
        test_on_organizations?: false,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: false,
        creation_code: "@owner.organization.members.where.not(id: owner.id).first",
        settlement_start_button: {
            label: nil,
            expected_to_be_present?: false
        }
    },
    an_attorney_from_another_law_firm: {
        test_on_members?: true,
        test_on_organizations?: true,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: true,
        creation_code: "User.attorneys.where.not(organization: [owner.organization, owner]).first",
        settlement_start_button: {
            label: '"Start a settlement with #{@owner.name}"',
            expected_to_be_present?: true
        }
    },
    an_adjuster_from_another_insurance_company: {
        test_on_members?: true,
        test_on_organizations?: true,
        can_have_settlement_with_attorney?: true,
        can_have_settlement_with_adjuster?: false,
        creation_code: "User.adjusters.where.not(organization: [owner.organization, owner]).first",
        settlement_start_button: {
            label: '"Start a settlement with #{@owner.name}"',
            expected_to_be_present?: true
        }
    },
    another_organization: {
        test_on_members?: true,
        test_on_organizations?: true,
        can_have_settlement_with_attorney?: false,
        can_have_settlement_with_adjuster?: false,
        creation_code: "User.organizations.without(owner.organization, owner).first",
        settlement_start_button: {
            label: nil,
            expected_to_be_present?: false
        }
    }
}

owners = {
    attorney: {
        type: :member,
        settlement_creation_code: "",
    },
    adjuster: {
        type: :member,
        settlement_creation_code: "",
    },
    law_firm: {
        type: :organization,
        settlement_creation_code: "",
    },
    insurance_company: {
        type: :organization,
        settlement_creation_code: "",
    },
}

settlement_requirements = {
    needs_document: {
        context_title: "needing a document",
        descriptor: {
            singular: "settlement needs a document",
            plural: "settlements need a document"
        },
    },
    ready_for_payment: {
        context_title: "ready for payment",
        descriptor: {
            singular: "settlement is ready for payment",
            plural: "settlements are ready for payment"
        },
    },
    document_needs_owner_approval: {
        context_title: "with a document needing the owners approval",
        descriptor: {
            singular: "document needs your approval",
            plural: "documents need your approval"
        },
    },
    document_needs_signature: {
        context_title: "with a document needing a signature",
        descriptor: {
            singular: "document needs a signature",
            plural: "documents need a signature"
        },
    },
    settlement_needs_owner_approval: {
        context_title: "needing the owners approval",
        descriptor: {
            singular: "settlement needs your approval",
            plural: "settlements need your approval"
        },
    }
}

SpecGenerator::SystemSpec.new(name: "user_profile_show_about_section") do |s|
    s.describe "The settlement section of the user profile show page" do
        s.before :context do 
            "create(:attorney)
            create(:adjuster)"
        end
        s.after :context do
            "User.all.each {|u| u.destroy}"
        end
        owners.keys.each do |owner|
            s.context "when the owner is #{indefinite_articleize(word: owner.to_s)}" do
                [0, 1, 5].each do |num_settlements| do
                    s.context "with #{num_settlements} active settlements" do
                        s.before :each do
                            if owner[:type] == :organization
                                "@owner = create(:#{owner})
                                @owner.members.first.settlements = create_list(:settlement, #{num_settlements}, attorney: , adjuster: User.adjusters.first)"
                            else 

                            end
                        end
                        visitors.keys.each do |v|
                            next unless visitors[v]["test_on_#{owner[:type]}s?"]
                            s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                                s.before :each do
                                    "@owner = create(:#{owner})
                                    @visitor = #{visitors[v][:creation_code]}"
                                end
                                if visitor[v][:settlement_start_button][:expected_to_be_present?]
                                    s.it "must have a button labeled #{visitor[v][:settlement_start_button][:label]}" do

                                    end
                                end
                                if visitors[v]["can_have_settlement_with_#{owner[:type]}?"]
                                    0..num_settlements.each do |i|
                                        s.context "that has #{i} other settlements with the owner" do
                                            s.before :each do
                                                "#{i}.times do |i|
                                                    create(:settlement, #{owner}: @owner, #{owner==:attorney ? 'adjuster' : 'attorney'}: @visitor)
                                                end"
                                            end
                                            s.it "must have #{i} settlements in the active settlement index" do

                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end





                visitors.keys.each do |v|
                    next unless visitors[v]["test_on_#{owner[:type]}s?".to_sym]
                    s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                        s.context "in the active settlements card" do
                            if visitors[v]["can_have_settlement_with_#{owner[:type]}?"]
                                s.it "must have a button labeled start settlement with #{owner[:type]} name" do

                                end
                            end
                            [1,5,0].each do |num_settlements|
                                s.context "if the owner has #{num_settlements} #{'settlements'.pluralize(num_settlements)} with the visitor" do
                                    s.it "must show #{num_settlements} in the index" do

                                    end
                                end
                            end
                        end
                        s.context "in the whats next? card" do
                            s.context "when the user has no settlements" do
                                s.it "must not have any notices" do

                                end
                                s.it "must have a message saying the user should start a settlement" do

                                end
                                s.context "after clicking the link in the start a settlement message" do
                                    s.it "must take the user to the settlement new page" do

                                    end
                                end
                            end
                            settlement_requirements.keys.each do |key|
                                [1, 5, 0].each do |num_settlements|
                                    s.context "when the user has #{num_settlements} #{'settlements'.pluralize(num_settlements)} #{settlement_requirements[key][:context_title]}" do
                                        s.it "must have a notice saying #{num_settlements==1 ? "a" : num_settlements} #{settlement_requirements[key][descriptor][num_settlements==1 ? :singular : :plural]}" do
                                            
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
end

context "when the owner is a member-type user" do
    context "and the visitor is the owner" do
        context "in the active settlements card" do
            it "must have an index of all active settlements involving the owner" do
                pending "Implementation"
                fail
            end
        end
        context "in the whats next card" do
            context "when the user has no settlements" do
                it "must not have any notices" do
                    pending "Implementation"
                    fail
                end
                it "must have a message saying the user should start a settlement" do
                    pending "Implementation"
                    fail
                end
                context "after clicking the link in the start a settlement message" do
                    it "must take the user to the settlement new page" do
                        pending "Implementation"
                        fail
                    end
                end
            end
            context "when the user has 1 settlement that needs a document" do
                it "must have a notice saying a settlement needs a document" do
                    pending "Implementation"
                    fail
                end
                context "after clicking the needs document notice" do
                    it "must show only 1 settlement that needs a document in the active settlement index" do
                        pending "Implementation"
                        fail
                    end
                end
            end
            context "when the user has 5 settlements that need a document" do
                it "must have a notice saying 5 settlements need a document" do
                    pending "Implementation"
                    fail
                end
                context "after clicking the needs document notice" do
                    it "must show only 5 settlements that need a document in the active settlement index" do
                        pending "Implementation"
                        fail
                    end
                end
            end
            context "when the user has 0 settlements that need a document" do
                it "must not have a notice saying a settlement needs a document" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
    context "and the visitor is the owners organization" do

    end
    context "and the visitor is a member of the owners organization" do

    end
    context "and the visitor is a member of another organization" do

    end
    context "and the visitor is another organization" do

    end
end
context "when the owner is an organization-type user" do
    context "and the visitor is the owner" do

    end
    context "and the visitor is one of the owners members" do

    end
    context "and the visitor is a member of another organization" do

    end
    context "and the visitor is another organization" do

    end
end

