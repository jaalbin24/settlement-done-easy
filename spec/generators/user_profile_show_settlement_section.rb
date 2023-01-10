# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
include EnglishLanguage
include SpecGenerator

policy = {
    # When the profile owner is an attorney
    attorney: {
        # then these visitors
        visitors: {
            # should see these specific settlements
            can_see_settlements_involving_owner: [
                :the_owner,
                :the_owners_organization,
                :a_member_of_the_owners_organization,
            ],
            can_see_settlements_involving_owner_and_visitor: [
                :an_adjuster_from_another_insurance_company,
            ],
            can_see_settlements_involving_owner_and_members_of_visitor: [
                :another_insurance_company,
            ],
            can_see_no_settlements: [
                :an_attorney_from_another_law_firm,
                :another_law_firm,
            ],
            can_see_new_settlement_button: [
                :the_owner,
                :an_adjuster_from_another_insurance_company,
            ],
        },
    },
    adjuster: {
        these_visitors: {
            can_see_settlements_involving_owner: [
                :the_owner,
                :the_owners_organization,
                :a_member_of_the_owners_organization,
            ],
            can_see_settlements_involving_owner_and_visitor: [
                :an_attorney_from_another_law_firm,
            ],
            can_see_settlements_involving_owner_and_members_of_visitor: [
                :another_law_firm,
            ],
            can_see_no_settlements: [
                :an_adjuster_from_another_insurance_company,
                :another_insurance_company,
            ],
            can_see_new_settlement_button: [
                :the_owner,
                :an_attorney_from_another_law_firm,
            ],
        },
    },
    law_firm: {
        these_visitors: {
            can_see_settlements_involving_members_of_owner: {
                :the_owner,
                :one_of_the_owners_members,
            },
            can_see_settlements_involving_members_of_owner_and_members_of_visitor: [
                :another_insurance_company,
            ],
            can_see_settlements_involving_members_of_owner_and_visitor: [
                :an_adjuster_from_another_insurance_company,
            ],
            can_see_no_settlements: [
                :another_law_firm,
                :an_attorney_from_another_law_firm,
            ],
        },
    },
    insurance_company: {
        these_visitors: {
            can_see_settlements_involving_members_of_owner: {
                :the_owner,
                :one_of_the_owners_members,
            },
            can_see_settlements_involving_members_of_owner_and_members_of_visitor: [
                :another_law_firm,
            ],
            can_see_settlements_involving_members_of_owner_and_visitor: [
                :an_attorney_from_another_law_firm,
            ],
            can_see_no_settlements: [
                :another_insurance_company,
                :an_adjuster_from_another_insurance_company,
            ],
        },
    },
}

visitors = {
    the_owner: {
        creation_code: "@owner",
        settlement_start_button: {
            label: "New settlement",
        },
    },
    the_owners_organization: { # Only applicable when the owner is a member-type user
        creation_code: "@owner.organization",
    },
    one_of_the_owners_members: { # Only applicable when the owner is an organization-type user
        creation_code: "@owner.members.first",
    },
    a_member_of_the_owners_organization: { # Only applicable when the owner is a member-type user
        creation_code: "@owner.organization.members.where.not(id: owner.id).first",
    },
    an_attorney_from_another_law_firm: {
        creation_code: "User.attorneys.where.not(organization: [owner.organization, owner]).first",
        settlement_start_button: {
            label: '"Start a settlement with #{@owner.name}"',
        },
    },
    an_adjuster_from_another_insurance_company: {
        creation_code: "User.adjusters.where.not(organization: [owner.organization, owner]).first",
        settlement_start_button: {
            label: '"Start a settlement with #{@owner.name}"',
        },
    },
    another_law_firm: {
        creation_code: "User.law_firms.without(owner.organization, owner).first",
    },
    another_insurance_company: {
        creation_code: "User.insurance_companies.without(owner.organization, owner).first",
    }
}

owners = {
    members: {
        can_have_settlements?: true
        attorney: {
            testable?: true,
            settles_with: [
                :an_adjuster_from_another_insurance_company
            ],
        },
        adjuster: {
            testable?: true
            settles_with: [
                :an_attorney_from_another_law_firm
            ],
        },
        possible_visitors: [
            :the_owner,
            :the_owners_organization,
            :a_member_of_the_owners_organization,
            :an_attorney_from_another_law_firm,
            :an_adjuster_from_another_insurance_company,
            :another_law_firm,
            :another_insurance_company,
        ]
    },
    organizations: {
        can_have_settlements_through_members?: true
        law_firm: {testable?: true},
        insurance_company:  {testable?: true},
        possible_visitors: [
            :the_owner,
            :one_of_the_owners_members,
            :an_attorney_from_another_law_firm,
            :an_adjuster_from_another_insurance_company,
            :another_law_firm,
            :another_insurance_company,
        ]
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
        owners.each do |type, type_hash|
            type_hash.each do |owner_name, owner|
                next unless owner[:testable?]
                s.context "when the owner is #{indefinite_articleize(word: owner_name.to_s)}" do
                    [0, 1, 5].each do |num_settlements| do
                        if owner[:can_have_settlements?]
                            s.context "with #{num_settlements} #{'settlement'.pluralize(num_settlements)}" do
                                visitors.keys.each do |v|
                                    next unless type_hash[:possible_visitors].include?(v)
                                    s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                                        if owner[:settles_with].include?(v)
                                            [0, 1, 5].each do |i|
                                                s.context "with #{i} more settlements together" do
                                                    if policy[owner_name][:visitors][:can_see_settlements_involving_owner][v]

                                                    end
                                                end
                                            end
                                        end
                                    end                              
                                end
                            end
                        elsif owner[:can_have_settlements_through_members?]
                            s.context "with #{num_members} #{'member'.pluralize(num_members)}" do
                                s.context "and #{num_settlements} #{'settlement'.pluralize(num_members)} for each member" do
                                    visitors.keys.each do |v|
                                        next unless type_hash[:possible_visitors].include?(v)
                                        s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do

                                        end                              
                                    end
                                end  
                            end
                        end











                    [0, 1, 5].each do |num_settlements| do
                    if owner[:type] == :organization
                        [0, 1, 3].each
                        s.context "with #{num_members} #{'member'.pluralize(num_members)}" do
                            s.context "and #{num_settlements} #{'settlement'.pluralize(num_members)} for each member" do
                                visitors.keys.each do |v|
                                    next unless visitors[v]["test_on_#{owner[:type]}s?"]
                                    s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                                        s.before :each do
                                            "@owner = create(:#{owner})
                                            @visitor = #{visitors[v][:creation_code]}"
                                        end
                                        if policy[owner][]
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
                    else


                        end
                        s.context "with #{num_settlements} active settlements" do
                            s.before :each do
                                "@owner = create(:#{owner})
                                @owner.members.first.settlements = create_list(:settlement, #{num_settlements}, attorney: , adjuster: User.adjusters.first)"
                            end
                            visitors.keys.each do |v|
                                next unless visitors[v]["test_on_#{owner[:type]}s?"]
                                s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
                                    s.before :each do
                                        "@owner = create(:#{owner})
                                        @visitor = #{visitors[v][:creation_code]}"
                                    end
                                    s.it "must have " do

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

