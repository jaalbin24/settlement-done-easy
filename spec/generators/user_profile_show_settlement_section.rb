# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
require 'active_support/inflector'
require 'active_support/core_ext/array/conversions'
require 'humanize'
include EnglishLanguage
include SpecGenerator

policy = {
    # When the profile owner is an attorney
    attorney: {
        # then these visitors
        visitors: {
            # should see these specific settlements
            the_owner: {
                can_see: :all_settlements_involving_owner,
            },
            the_owners_organization:{
                can_see: :all_settlements_involving_owner,
            },
            a_member_of_the_owners_organization:{
                can_see: :all_settlements_involving_owner,
            },
            an_adjuster_from_another_insurance_company: {
                can_see: :all_settlements_involving_owner_and_visitor,
            },
            another_insurance_company: {
                can_see: :all_settlements_involving_owner_and_members_of_visitor,
            },
            an_attorney_from_another_law_firm: {
                can_see: :no_settlements,
            },
            another_law_firm: {
                can_see: :no_settlements,
            },
        },
    },
    adjuster: {
        visitors: {
            # should see these specific settlements
            the_owner: {
                can_see: :settlements_involving_owner,
                involved: [:owner]
            },
            the_owners_organization:{
                can_see: :settlements_involving_owner,
                involved: [:owner]
            },
            a_member_of_the_owners_organization:{
                can_see: :settlements_involving_owner,
                involved: [:owner]
            },
            an_adjuster_from_another_insurance_company: {
                can_see: :no_settlements,
                involved: []
            },
            another_insurance_company: {
                can_see: :no_settlements,
                involved: []
            },
            an_attorney_from_another_law_firm: {
                can_see: :settlements_involving_owner_and_visitor,
                involved: [:owner, :visitor]
            },
            another_law_firm: {
                can_see: :settlements_involving_owner_and_members_of_visitor,
                involved: [:owner, :member_of_visitor]
            },
        },
    },
    law_firm: {
        visitors: {
            # should see these specific settlements
            the_owner: {
                can_see: :settlements_involving_members_of_owner,
                involved: [:members_of_owner]
            },
            one_of_the_owners_members:{
                can_see: :settlements_involving_members_of_owner,
                involved: [:members_of_owner]
            },
            an_adjuster_from_another_insurance_company: {
                can_see: :settlements_involving_members_of_owner_and_visitor,
                involved: [:members_of_owner, :visitor]
            },
            another_insurance_company: {
                can_see: :settlements_involving_members_of_owner_and_members_of_visitor,
                involved: [:members_of_owner, :members_of_visitor]
            },
            an_attorney_from_another_law_firm: {
                can_see: :no_settlements,
                involved: []
            },
            another_law_firm: {
                can_see: :no_settlements,
                involved: []
            },
        },
    },
    insurance_company: {
        visitors: {
            # should see these specific settlements
            the_owner: {
                can_see: :settlements_involving_members_of_owner,
                involved: [:members_of_owner]
            },
            one_of_the_owners_members:{
                can_see: :settlements_involving_members_of_owner,
                involved: [:members_of_owner]
            },
            an_adjuster_from_another_insurance_company: {
                can_see: :no_settlements,
                involved: []
            },
            another_insurance_company: {
                can_see: :no_settlements,
                involved: []
            },
            an_attorney_from_another_law_firm: {
                can_see: :settlements_involving_members_of_owner_and_visitor,
                involved: [:members_of_owner, :visitor]
            },
            another_law_firm: {
                can_see: :settlements_involving_members_of_owner_and_members_of_visitor,
                involved: [:members_of_owner, :members_of_visitor]
            },
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
        attorney: {
            settles_with: [
                :an_adjuster_from_another_insurance_company
            ],
            can_have_settlements?: true,
            possible_visitors: [
                :the_owner,
                :the_owners_organization,
                :a_member_of_the_owners_organization,
                :an_attorney_from_another_law_firm,
                :an_adjuster_from_another_insurance_company,
                :another_law_firm,
                :another_insurance_company,
            ],
        },
        adjuster: {
            settles_with: [
                :an_attorney_from_another_law_firm
            ],
            can_have_settlements?: true,
            possible_visitors: [
                :the_owner,
                :the_owners_organization,
                :a_member_of_the_owners_organization,
                :an_attorney_from_another_law_firm,
                :an_adjuster_from_another_insurance_company,
                :another_law_firm,
                :another_insurance_company,
            ],
        },
    },
    organizations: {
        law_firm: {
            can_have_settlements_through_members?: true,
            possible_visitors: [
                :the_owner,
                :one_of_the_owners_members,
                :an_attorney_from_another_law_firm,
                :an_adjuster_from_another_insurance_company,
                :another_law_firm,
                :another_insurance_company,
            ],
        },
        insurance_company: {
            can_have_settlements_through_members?: true,
            possible_visitors: [
                :the_owner,
                :one_of_the_owners_members,
                :an_attorney_from_another_law_firm,
                :an_adjuster_from_another_insurance_company,
                :another_law_firm,
                :another_insurance_company,
            ],
        },
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

SpecGenerator::SystemSpec.new(name: "user_profile_show_settlement_section") do |s|
    s.describe "The settlement section of the user profile show page" do
        s.before :context do 
            "create(:attorney)
            create(:adjuster)"
        end
        s.after :context do
            "User.all.each {|u| u.destroy}"
        end
        # owners.keys.each do |type|
        #     owners[type].keys.each do |owner|
        #         puts "owner=#{owner}"
        #         s.context "when the owner is #{indefinite_articleize(word: owner.to_s)}" do
        #             [0, 1, 5].each do |num_settlements|
        #                 if owners[type][owner][:can_have_settlements?]
        #                     s.context "with #{num_settlements} #{'settlement'.pluralize(num_settlements)}" do
        #                         visitors.keys.each do |v|
        #                             next unless owners[type][owner][:possible_visitors].include?(v)
        #                             s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do
        #                                 if owners[type][owner][:settles_with].include?(v)
        #                                     [0, 1, 5].each do |i|
        #                                         s.context "with #{i} more settlements together" do
        #                                             s.it "must have #{policy[owner][v][:can_see]}" do
        #                                                 "sign_in @visitor
        #                                                 visit user_profile_show_path(@owner.profile)
        #                                                 click_on 'Settlements'
        #                                                 sleep 0.1 # Wait for javascript to fade in the settlements tab
        #                                                 expect(all('tr').count).to eq(#{i+1})
        #                                                 Settlement.belongs_to(@owner).merge(Setttlement.belongs_to(@visitor)).each do |s|
        #                                                     expect(page).to have_text p.public_number
        #                                                 end"
        #                                             end
        #                                         end
        #                                     end
        #                                 else
        #                                     s.it "must have #{policy[owner_name][v][:can_see]}" do
        #                                         "sign_in @visitor
        #                                         visit user_profile_show_path(@owner.profile)
        #                                         click_on 'Settlements'
        #                                         expect(all('tr').count).to eq(#{i+1})
        #                                         Settlement.belongs_to(@owner).merge(Setttlement.belongs_to(@visitor)).each do |s|
        #                                             expect(page).to have_text p.public_number
        #                                         end"
        #                                     end
        #                                 end
        #                             end                              
        #                         end
        #                     end
        #                 elsif owner[:can_have_settlements_through_members?]
        #                     s.context "with #{num_members} #{'member'.pluralize(num_members)}" do
        #                         s.context "and #{num_settlements} #{'settlement'.pluralize(num_members)} for each member" do
        #                             visitors.keys.each do |v|
        #                                 next unless owners[type][owner][:possible_visitors].include?(v)
        #                                 s.context "and the visitor is #{v.to_s.gsub("_"," ")}" do

        #                                 end                              
        #                             end
        #                         end  
        #                     end
        #                 end
        #             end
        #         end
        #     end
        # end
        s.context "in the active settlements card" do
            s.context "when the owner is an attorney" do
                s.before(:context) {'@owner = create(:attorney)'}
                s.after(:context) {'@owner.organization.destroy'}
                [0, 1, 5].each do |n_unrelated_for_owner|
                    s.context "with #{n_unrelated_for_owner} unrelated #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                        s.before(:context) {"@unrelated = create_list(:settlement, #{n_unrelated_for_owner}, attorney: @owner, adjuster: User.adjusters.sample)"}
                        s.after(:context) {'@unrelated.each {|s| s.destroy}'}
                        s.context "and the visitor is the owner" do
                            s.before(:context) {'@visitor = @owner'}
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile)
                                click_on 'Settlements'
                                sleep 0.1 # Wait for javascript to fade in the settlements tab
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end # DONE
                        s.context "and the visitor is a member of the owners organization" do
                            s.before(:context) {'@visitor = create(:attorney, organization: @owner.organization)'}
                            s.after(:context) {'@visitor.destroy'}
                            s.it "must not show any settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile)
                                click_on 'Settlements'
                                sleep 0.1 # Wait for javascript to fade in the settlements tab
                                expect(all('tr').count).to eq(0 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end # DONE
                        s.context "and the visitor is the owners organization" do
                            s.before(:context) {'@visitor = @owner.organization'}
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile)
                                click_on 'Settlements'
                                sleep 0.1 # Wait for javascript to fade in the settlements tab
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end # DONE
                        s.context "and the visitor is an adjuster from another insurance company" do
                            s.before(:context) {'@visitor = create(:adjuster)'}
                            s.after(:context) {'@visitor.organization.destroy'}
                            [0, 1, 5].each do |n_settlements|
                                s.context "that has #{n_settlements} #{'settlement'.pluralize(n_settlements)} with the owner" do
                                    s.before (:context) {"@visitor.settlements += create_list(:settlement, #{n_settlements}, adjuster: @visitor, attorney: @owner)"}
                                    s.after (:context) {"@visitor.settlements.each {|s| s.destroy}"}
                                    s.it "must have #{n_settlements} #{'settlement'.pluralize(n_settlements)}" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile)
                                        click_on 'Settlements'
                                        sleep 0.1 # Wait for javascript to fade in the settlements tab
                                        expect(all('tr').count).to eq(#{n_settlements} + 1) # +1 because the table header counts as a row
                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                            expect(page).to have_text s.public_number
                                        end"
                                    end
                                end
                            end
                        end # DONE
                        s.context "and the visitor is another insurance company" do
                            s.before(:context) {'@visitor = create(:insurance_company)'}
                            s.after(:context) {'@visitor.destroy'}
                            s.context "with 0 members" do
                                s.it "must have 0 settlements" do
                                    "pending 'Implementation'
                                    fail"
                                end
                            end
                            [1,3,5].each do |n_members|
                                # with x members
                                s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                                    s.before(:context) {"@visitor.members = create_list(:adjuster, #{n_members}, organization: @visitor)"}
                                    s.after(:context) {"@visitor.members.each {|m| m.destroy}"}
                                    [1,3,5].each do |n_unrelated_for_visitor|
                                        # that each have x unrelated settlements
                                        s.context "that #{n_members == 1 ? 'has': 'each have'} #{n_unrelated_for_visitor} unrelated #{'settlement'.pluralize(n_unrelated_for_visitor)}" do
                                            s.before(:context) do
                                                "@visitor.members.each do |m|
                                                    m.settlements = create_list(:settlement, #{n_unrelated_for_visitor}, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                                end"
                                            end
                                            s.after(:context) do
                                                "@visitor.members.each do |m|
                                                    m.settlements.each {|s| s.destroy}
                                                end"
                                            end
                                            # and x settlements with the owner
                                            s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owner" do
                                                s.before (:context) do
                                                    "@visitor.members.each_with_index do |m, i|
                                                        m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                                    end"
                                                end
                                                s.after (:context) {""}
                                                s.it "must have #{n_members*(n_members+1)/2} #{'settlement'.pluralize(n_members*(n_members+1)/2)}" do
                                                    "sign_in @visitor
                                                    visit user_profile_show_path(@owner.profile)
                                                    click_on 'Settlements'
                                                    sleep 0.1 # Wait for javascript to fade in the settlements tab
                                                    expect(all('tr').count).to eq(#{n_members*(n_members+1)/2} + 1) # +1 because the table header counts as a row
                                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                                        expect(page).to have_text s.public_number
                                                    end"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end # DONE
                        s.context "and the visitor is another law firm" do
                            s.before(:context) {'@visitor = create(:law_firm)'}
                            s.after(:context) {'@visitor.destroy'}
                            s.it "must not show any settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile)
                                click_on 'Settlements'
                                sleep 0.1 # Wait for javascript to fade in the settlements tab
                                expect(all('tr').count).to eq(0 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end # DONE
                        s.context "and the visitor is an attorney from another law firm" do
                            s.before(:context) {'@visitor = create(:attorney)'}
                            s.after(:context) {'@visitor.organization.destroy'}
                            s.it "must not show any settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile)
                                click_on 'Settlements'
                                sleep 0.1 # Wait for javascript to fade in the settlements tab
                                expect(all('tr').count).to eq(0 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end # DONE
                    end
                end
            end
            s.context "when the owner is a law firm" do
                s.before(:context) {'@owner = create(:law_firm)'}
                s.after(:context) {'@owner.destroy'}
                [1,3,5].each do |n_members|
                    # with x members
                    s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                        s.before(:context) {"@owner.members = create_list(:attorney, #{n_members}, organization: @owner)"}
                        s.after(:context) {"@owner.members.each {|m| m.destroy}"}
                        [1,3,5].each do |n_unrelated_for_members|
                            # that each have x unrelated settlements
                            s.context "that #{n_members == 1 ? 'has': 'each have'} #{n_unrelated_for_members} unrelated #{'settlement'.pluralize(n_unrelated_for_members)}" do
                                s.before(:context) do
                                    "@owner.members.each do |m|
                                        m.settlements = create_list(:settlement, #{n_unrelated_for_members}, attorney: m, adjuster: User.adjusters.sample)
                                    end"
                                end
                                s.after(:context) do
                                    "@owner.members.each do |m|
                                        m.settlements.each {|s| s.destroy}
                                    end"
                                end
                                s.context "and the visitor is the owner" do
                                end
                                s.context "and the visitor is one of the owners members" do
                                end
                                s.context "and the visitor is an adjuster from another insurance company" do
                                end
                                s.context "and the visitor is another insurance company" do
                                end
                                s.context "and the visitor is another law firm" do
                                    s.it "must have no settlements" do
                                        "pending 'Implementation'
                                        fail"
                                    end
                                end
                                s.context "and the visitor is an attorney from another law firm" do
                                    s.it "must have no settlements" do
                                        "pending 'Implementation'
                                        fail"
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        s.context "in the whats next card" do
        
        end
    end
end