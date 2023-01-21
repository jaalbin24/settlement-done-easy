# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
require 'active_support/inflector'
require 'active_support/core_ext/array/conversions'
require 'humanize'
include EnglishLanguage
include SpecGenerator

SpecGenerator::SystemSpec.new(name: "active_settlements_card", generated_file_location: "spec/system/user_profile/show/settlements/") do |s|
    s.describe "The active settlements card in the settlement section of the user profile show page" do
        s.before :context do 
            "create(:attorney)
            create(:adjuster)"
        end
        s.after :context do
            "User.all.each {|u| u.destroy}"
        end
        s.context "when the owner is an attorney" do
            s.before(:context) {'@owner = create(:attorney)'}
            s.after(:context) {'@owner.organization.destroy'}
            [0, 1, 3].each do |n_unrelated_for_owner|
                s.context "with #{n_unrelated_for_owner} unrelated #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                    s.before(:context) {"@unrelated = create_list(:settlement, #{n_unrelated_for_owner}, attorney: @owner, adjuster: User.adjusters.sample)"}
                    s.after(:context) {'@unrelated.each {|s| s.destroy}'}
                    s.context "and the visitor is the owner" do
                        s.before(:context) {'@visitor = @owner'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements. Click here to start one.\""                               
                            end
                            s.context "after 'here' is clicked" do
                                s.it "must take the user to the settlement new page" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    find(\"[data-test-id='empty_active_settlement_link']\").click
                                    sleep 0.1 # Pause test to allow active settlement table to load rows
                                    expect(current_path).to eq(settlement_new_path)"
                                end
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is a member of the owners organization" do
                        s.before(:context) {'@visitor = create(:attorney, organization: @owner.organization)'}
                        s.after(:context) {'@visitor.destroy'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"\#{@owner.name} does not have any active settlements.\""                               
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is the owners organization" do
                        s.before(:context) {'@visitor = @owner.organization'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"\#{@owner.name} does not have any active settlements.\""                               
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is an adjuster from another insurance company" do
                        s.before(:context) {'@visitor = create(:adjuster)'}
                        s.after(:context) {'@visitor.organization.destroy'}
                        s.context "that has no settlements with the owner" do
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the visitor has no settlements with the owner" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}. Click here to start one.\""                               
                            end
                            s.context "after 'here' is clicked" do
                                s.it "must take the user to the settlement new page" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    find(\"[data-test-id='empty_active_settlement_link']\").click
                                    sleep 0.1 # Pause test to allow active settlement table to load rows
                                    expect(current_path).to eq(settlement_new_path)"
                                end
                            end
                        end
                        [1, 3].each do |n_settlements|
                            s.context "that has #{n_settlements} #{'settlement'.pluralize(n_settlements)} with the owner" do
                                s.before (:context) {"@visitor.settlements += create_list(:settlement, #{n_settlements}, adjuster: @visitor, attorney: @owner)"}
                                s.after (:context) {"@visitor.settlements.each {|s| s.destroy}"}
                                s.it "must have #{n_settlements} #{'settlement'.pluralize(n_settlements)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
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
                            s.before(:context) {'@visitor.members.each {|m| m.destroy}'}
                            s.it "must have 0 settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the visitor has no settlements with the owner" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}.\""                               
                            end
                        end
                        [1,3].each do |n_members|
                            # with x members
                            s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                                s.before(:context) {"@visitor.members = create_list(:adjuster, #{n_members}, organization: @visitor)"}
                                s.after(:context) {"@visitor.members.each {|m| m.destroy}"}
                                s.context "that each have 0 settlements with the owner" do
                                    s.it "must have 0 settlements" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(all('tr').count).to eq(0)
                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                            expect(page).to have_text s.public_number
                                        end"
                                    end
                                    s.it "must show a message saying the visitor has no settlements with the owner" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}.\""                               
                                    end
                                end
                                [1,3].each do |n_unrelated_for_visitor|
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
                                        s.context "and 0 settlements with the owner" do
                                            s.it "must have 0 settlements" do
                                                "pending 'Implementation'
                                                fail"
                                            end
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
                                                visit user_profile_show_path(@owner.profile, section: 'settlements')
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
                        s.it "must have no settlements" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end"
                        end
                        s.it "must show a message saying the visitor cannot have settlements with the owner" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You cannot have settlements with \#{@owner.name} because they are \#{indefinite_articleize(word: @owner.role.downcase)}\""                               
                        end
                    end # DONE
                    s.context "and the visitor is an attorney from another law firm" do
                        s.before(:context) {'@visitor = create(:attorney)'}
                        s.after(:context) {'@visitor.organization.destroy'}
                        s.it "must have no settlements" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end"
                        end
                        s.it "must show a message saying the visitor cannot have settlements with the owner" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You cannot have settlements with \#{@owner.name} because they are \#{indefinite_articleize(word: @owner.role.downcase)}\""                               
                        end
                    end # DONE
                end # DONE
            end
        end
        s.context "when the owner is an adjuster" do
            s.before(:context) {'@owner = create(:adjuster)'}
            s.after(:context) {'@owner.organization.destroy'}
            [0, 1, 3].each do |n_unrelated_for_owner|
                s.context "with #{n_unrelated_for_owner} unrelated #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                    s.before(:context) {"@unrelated = create_list(:settlement, #{n_unrelated_for_owner}, attorney: User.attorneys.sample, adjuster: @owner)"}
                    s.after(:context) {'@unrelated.each {|s| s.destroy}'}
                    s.context "and the visitor is the owner" do
                        s.before(:context) {'@visitor = @owner'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements. Click here to start one.\""                               
                            end
                            s.context "after 'here' is clicked" do
                                s.it "must take the user to the settlement new page" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    find(\"[data-test-id='empty_active_settlement_link']\").click
                                    sleep 0.1 # Pause test to allow active settlement table to load rows
                                    expect(current_path).to eq(settlement_new_path)"
                                end
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is a member of the owners organization" do
                        s.before(:context) {'@visitor = create(:adjuster, organization: @owner.organization)'}
                        s.after(:context) {'@visitor.destroy'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"\#{@owner.name} does not have any active settlements.\""                               
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is the owners organization" do
                        s.before(:context) {'@visitor = @owner.organization'}
                        if n_unrelated_for_owner == 0
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the owner has no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"\#{@owner.name} does not have any active settlements.\""                               
                            end
                        else
                            s.it "must show #{n_unrelated_for_owner} #{'settlement'.pluralize(n_unrelated_for_owner)}" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(#{n_unrelated_for_owner} + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                        end
                    end # DONE
                    s.context "and the visitor is an attorney from another law firm" do
                        s.before(:context) {'@visitor = create(:attorney)'}
                        s.after(:context) {'@visitor.organization.destroy'}
                        s.context "that has 0 settlements with the owner" do
                            s.it "must have 0 settlements" do
                                "pending 'Implementation'
                                fail"
                            end
                        end
                        s.context "that has no settlements with the owner" do
                            s.it "must have no settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the visitor has no settlements with the owner" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}. Click here to start one.\""                               
                            end
                            s.context "after 'here' is clicked" do
                                s.it "must take the user to the settlement new page" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    find(\"[data-test-id='empty_active_settlement_link']\").click
                                    sleep 0.1 # Pause test to allow active settlement table to load rows
                                    expect(current_path).to eq(settlement_new_path)"
                                end
                            end
                        end
                        [1, 3].each do |n_settlements|
                            s.context "that has #{n_settlements} #{'settlement'.pluralize(n_settlements)} with the owner" do
                                s.before (:context) {"@visitor.settlements += create_list(:settlement, #{n_settlements}, adjuster: @owner, attorney: @visitor)"}
                                s.after (:context) {"@visitor.settlements.each {|s| s.destroy}"}
                                s.it "must have #{n_settlements} #{'settlement'.pluralize(n_settlements)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(#{n_settlements} + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end
                        end
                    end # DONE
                    s.context "and the visitor is another law firm" do
                        s.before(:context) {'@visitor = create(:law_firm)'}
                        s.after(:context) {'@visitor.destroy'}
                        s.context "with 0 members" do
                            s.before(:context) {'@visitor.members.each {|m| m.destroy}'}
                            s.it "must have 0 settlements" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(0)
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end"
                            end
                            s.it "must show a message saying the visitor has no settlements with the owner" do
                                "sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}.\""                               
                            end
                        end
                        [1,3].each do |n_members|
                            # with x members
                            s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                                s.before(:context) {"@visitor.members = create_list(:attorney, #{n_members}, organization: @visitor)"}
                                s.after(:context) {"@visitor.members.each {|m| m.destroy}"}
                                s.context "that each have 0 settlements with the owner" do
                                    s.it "must have 0 settlements" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(all('tr').count).to eq(0)
                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                            expect(page).to have_text s.public_number
                                        end"
                                    end
                                    s.it "must show a message saying the visitor has no settlements with the owner" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You do not have any active settlements with \#{@owner.name}.\""                               
                                    end
                                end
                                [1,3].each do |n_unrelated_for_visitor|
                                    # that each have x unrelated settlements
                                    s.context "that #{n_members == 1 ? 'has': 'each have'} #{n_unrelated_for_visitor} unrelated #{'settlement'.pluralize(n_unrelated_for_visitor)}" do
                                        s.before(:context) do
                                            "@visitor.members.each do |m|
                                                m.settlements = create_list(:settlement, #{n_unrelated_for_visitor}, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                                            end"
                                        end
                                        s.after(:context) do
                                            "@visitor.members.each do |m|
                                                m.settlements.each {|s| s.destroy}
                                            end"
                                        end
                                        s.context "and 0 settlements with the owner" do
                                            s.it "must have 0 settlements" do
                                                "pending 'Implementation'
                                                fail"
                                            end
                                        end
                                        # and x settlements with the owner
                                        s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owner" do
                                            s.before (:context) do
                                                "@visitor.members.each_with_index do |m, i|
                                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                                end"
                                            end
                                            s.after (:context) {""}
                                            s.it "must have #{n_members*(n_members+1)/2} #{'settlement'.pluralize(n_members*(n_members+1)/2)}" do
                                                "sign_in @visitor
                                                visit user_profile_show_path(@owner.profile, section: 'settlements')
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
                    end
                    s.context "and the visitor is another insurance company" do
                        s.before(:context) {'@visitor = create(:insurance_company)'}
                        s.after(:context) {'@visitor.destroy'}
                        s.it "must have no settlements" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end"
                        end
                        s.it "must show a message saying the visitor cannot have settlements with the owner" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You cannot have settlements with \#{@owner.name} because they are \#{indefinite_articleize(word: @owner.role.downcase)}\""                               
                        end
                    end # DONE
                    s.context "and the visitor is an adjuster from another insurance company" do
                        s.before(:context) {'@visitor = create(:adjuster)'}
                        s.after(:context) {'@visitor.organization.destroy'}
                        s.it "must have no settlements" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end"
                        end
                        s.it "must show a message saying the visitor cannot have settlements with the owner" do
                            "sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find(\"[data-test-id='empty_active_settlement_message']\")).to have_text \"You cannot have settlements with \#{@owner.name} because they are \#{indefinite_articleize(word: @owner.role.downcase)}\""                               
                        end
                    end # DONE
                end
            end
        end
        s.context "when the owner is a law firm" do
            s.before(:context) {'@owner = create(:law_firm)'}
            s.after(:context) {'@owner.destroy'}
            [1,3].each do |n_members|
                # with x members
                s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                    s.before(:context) {"@owner.members = create_list(:attorney, #{n_members}, organization: @owner)"}
                    s.after(:context) {"@owner.members.each {|m| m.destroy}"}
                    [1,3].each do |n_unrelated_for_members|
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
                                s.before(:context) {"@visitor = @owner"}
                                s.it "must have #{n_members * n_unrelated_for_members} #{'settlement'.pluralize(n_members * n_unrelated_for_members)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(#{n_members * n_unrelated_for_members} + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is one of the owners members" do
                                s.before(:context) {"@visitor = @owner.members.first"}
                                s.it "must have #{n_members * n_unrelated_for_members} #{'settlement'.pluralize(n_members * n_unrelated_for_members)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(#{n_members * n_unrelated_for_members} + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is an adjuster from another insurance company" do
                                s.before(:context) {"@visitor = create(:adjuster)"}
                                s.after(:context) {"@visitor.organization.destroy"}
                                [0, 1, 3].each do |unrelated_for_visitor|
                                    s.context "that has #{unrelated_for_visitor} unrelated settlements" do
                                        s.before(:context) {"@visitor.settlements = create_list(:settlement, #{unrelated_for_visitor}, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)"}
                                        s.after(:context) {"@visitor.settlements.each {|s| s.destroy}"}
                                        s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owners #{'member'.pluralize(n_members)}" do
                                            s.before(:context) do
                                                "@owner.members.each_with_index do |m, i|
                                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                                end"
                                            end
                                            s.after(:context) {"@related_settlements.each {|s| s.destroy}"}
                                            s.it "must have #{n_members*(n_members+1)/2} #{'settlement'.pluralize(n_members*(n_members+1)/2)}" do
                                                "sign_in @visitor
                                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                expect(all('tr').count).to eq(#{n_members*(n_members+1)/2} + 1) # +1 because the table header counts as a row
                                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                                    expect(page).to have_text s.public_number
                                                end"
                                            end
                                        end
                                    end
                                end
                            end # DONE
                            s.context "and the visitor is another insurance company" do
                                s.before(:context) {"@visitor = create(:insurance_company)"}
                                s.after(:context) {"@visitor.destroy"}
                                s.context "with no members" do
                                    s.before(:context) {"@visitor.members.each {|m| m.destroy}"}
                                    s.it "must have no settlements" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(all('tr').count).to eq(0)
                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                            expect(page).to have_text s.public_number
                                        end"
                                    end
                                end
                                [1,3].each do |n_visitor_members|
                                    # with x members
                                    s.context "with #{n_visitor_members} #{'member'.pluralize(n_visitor_members)}" do
                                        s.before(:context) {"@visitor.members = create_list(:adjuster, #{n_visitor_members}, organization: @visitor)"}
                                        s.after(:context) {"@visitor.members.each {|m| m.destroy}"}
                                        [1,3].each do |n_unrelated_for_visitor_members|
                                            # that each have x unrelated settlements
                                            s.context "that #{n_visitor_members == 1 ? 'has': 'each have'} #{n_unrelated_for_visitor_members} unrelated #{'settlement'.pluralize(n_unrelated_for_visitor_members)}" do
                                                s.before(:context) do
                                                    "@visitor.members.each do |m|
                                                        m.settlements = create_list(:settlement, #{n_unrelated_for_visitor_members}, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                                    end"
                                                end
                                                s.after(:context) do
                                                    "@visitor.members.each do |m|
                                                        m.settlements.each {|s| s.destroy}
                                                    end"
                                                end
                                                s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owners #{'member'.pluralize(n_members)}" do
                                                    s.before(:context) do
                                                        "@visitor.members.each do |vm|
                                                            @owner.members.each_with_index do |om, i|
                                                                (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                                            end
                                                        end"
                                                    end
                                                    s.after(:context) {"@related_settlements.each {|s| s.destroy}"}
                                                    s.it "must have #{n_visitor_members*n_members*(n_members+1)/2} #{'settlement'.pluralize(n_visitor_members*n_members*(n_members+1)/2)}" do
                                                        "sign_in @visitor
                                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                        expect(all('tr').count).to eq(#{n_visitor_members*n_members*(n_members+1)/2} + 1) # +1 because the table header counts as a row
                                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                                            expect(page).to have_text s.public_number
                                                        end"
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            s.context "and the visitor is another law firm" do
                                s.before(:context) {"@visitor = create(:law_firm)"}
                                s.after(:context) {"@visitor.destroy"}
                                s.it "must have no settlements" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(0)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is an attorney from another law firm" do
                                s.before(:context) {"@visitor = create(:attorney)"}
                                s.after(:context) {"@visitor.organization.destroy"}
                                s.it "must have no settlements" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(0)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                        end
                    end
                end
            end
        end
        s.context "when the owner is an insurance company" do
            s.before(:context) {'@owner = create(:insurance_company)'}
            s.after(:context) {'@owner.destroy'}
            [1,3].each do |n_members|
                # with x members
                s.context "with #{n_members} #{'member'.pluralize(n_members)}" do
                    s.before(:context) {"@owner.members = create_list(:adjuster, #{n_members}, organization: @owner)"}
                    s.after(:context) {"@owner.members.each {|m| m.destroy}"}
                    [1,3].each do |n_unrelated_for_members|
                        # that each have x unrelated settlements
                        s.context "that #{n_members == 1 ? 'has': 'each have'} #{n_unrelated_for_members} unrelated #{'settlement'.pluralize(n_unrelated_for_members)}" do
                            s.before(:context) do
                                "@owner.members.each do |m|
                                    m.settlements = create_list(:settlement, #{n_unrelated_for_members}, adjuster: m, attorney: User.attorneys.sample)
                                end"
                            end
                            s.after(:context) do
                                "@owner.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end"
                            end
                            s.context "and the visitor is the owner" do
                                s.before(:context) {"@visitor = @owner"}
                                s.it "must have #{n_members * n_unrelated_for_members} #{'settlement'.pluralize(n_members * n_unrelated_for_members)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(#{n_members * n_unrelated_for_members} + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is one of the owners members" do
                                s.before(:context) {"@visitor = @owner.members.first"}
                                s.it "must have #{n_members * n_unrelated_for_members} #{'settlement'.pluralize(n_members * n_unrelated_for_members)}" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(#{n_members * n_unrelated_for_members} + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is an attorney from another law firm" do
                                s.before(:context) {"@visitor = create(:attorney)"}
                                s.after(:context) {"@visitor.organization.destroy"}
                                [0, 1, 3].each do |unrelated_for_visitor|
                                    s.context "that has #{unrelated_for_visitor} unrelated settlements" do
                                        s.before(:context) {"@visitor.settlements = create_list(:settlement, #{unrelated_for_visitor}, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)"}
                                        s.after(:context) {"@visitor.settlements.each {|s| s.destroy}"}
                                        s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owners #{'member'.pluralize(n_members)}" do
                                            s.before(:context) do
                                                "@owner.members.each_with_index do |m, i|
                                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                                end"
                                            end
                                            s.after(:context) {"@related_settlements.each {|s| s.destroy}"}
                                            s.it "must have #{n_members*(n_members+1)/2} #{'settlement'.pluralize(n_members*(n_members+1)/2)}" do
                                                "sign_in @visitor
                                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                expect(all('tr').count).to eq(#{n_members*(n_members+1)/2} + 1) # +1 because the table header counts as a row
                                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                                    expect(page).to have_text s.public_number
                                                end"
                                            end
                                        end
                                    end
                                end
                            end # DONE
                            s.context "and the visitor is another law firm" do
                                s.before(:context) {"@visitor = create(:law_firm)"}
                                s.after(:context) {"@visitor.destroy"}
                                s.context "with no members" do
                                    s.before(:context) {"@visitor.members.each {|m| m.destroy}"}
                                    s.it "must have no settlements" do
                                        "sign_in @visitor
                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                        expect(all('tr').count).to eq(0)
                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                            expect(page).to have_text s.public_number
                                        end"
                                    end
                                end
                                [1,3].each do |n_visitor_members|
                                    # with x members
                                    s.context "with #{n_visitor_members} #{'member'.pluralize(n_visitor_members)}" do
                                        s.before(:context) {"@visitor.members = create_list(:attorney, #{n_visitor_members}, organization: @visitor)"}
                                        s.after(:context) {"@visitor.members.each {|m| m.destroy}"}
                                        [1,3].each do |n_unrelated_for_visitor_members|
                                            # that each have x unrelated settlements
                                            s.context "that #{n_visitor_members == 1 ? 'has': 'each have'} #{n_unrelated_for_visitor_members} unrelated #{'settlement'.pluralize(n_unrelated_for_visitor_members)}" do
                                                s.before(:context) do
                                                    "@visitor.members.each do |m|
                                                        m.settlements = create_list(:settlement, #{n_unrelated_for_visitor_members}, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                                    end"
                                                end
                                                s.after(:context) do
                                                    "@visitor.members.each do |m|
                                                        m.settlements.each {|s| s.destroy}
                                                    end"
                                                end
                                                s.context "and #{(1..n_members).to_a.to_sentence} #{'settlement'.pluralize(n_members)} with the owners #{'member'.pluralize(n_members)}" do
                                                    s.before(:context) do
                                                        "@visitor.members.each do |vm|
                                                            @owner.members.each_with_index do |om, i|
                                                                (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                                            end
                                                        end"
                                                    end
                                                    s.after(:context) {"@related_settlements.each {|s| s.destroy}"}
                                                    s.it "must have #{n_visitor_members*n_members*(n_members+1)/2} #{'settlement'.pluralize(n_visitor_members*n_members*(n_members+1)/2)}" do
                                                        "sign_in @visitor
                                                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                        expect(all('tr').count).to eq(#{n_visitor_members*n_members*(n_members+1)/2} + 1) # +1 because the table header counts as a row
                                                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                                            expect(page).to have_text s.public_number
                                                        end"
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            s.context "and the visitor is another insurance company" do
                                s.before(:context) {"@visitor = create(:insurance_company)"}
                                s.after(:context) {"@visitor.destroy"}
                                s.it "must have no settlements" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(0)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                            s.context "and the visitor is an adjuster from another insurance company" do
                                s.before(:context) {"@visitor = create(:adjuster)"}
                                s.after(:context) {"@visitor.organization.destroy"}
                                s.it "must have no settlements" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(0)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end"
                                end
                            end # DONE
                        end
                    end
                end
            end
        end
    end
end