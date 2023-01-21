# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
require 'active_support/inflector'
require 'active_support/core_ext/array/conversions'
require 'humanize'
include EnglishLanguage
include SpecGenerator

members = {
    attorney: {
        organization: :law_firm,
        opposite: :adjuster
    },
    adjuster:{
        organization: :insurance_company,
        opposite: :attorney
    }
}
organizations = [
    :law_firm,
    :insurance_company
]

action = {
    needs_document: {
        context_string: "needing a document",
        test_id: "needs_document_message",
        expected_text: "%settlement% %needs% a document",
    },
    needs_document_approval_from_: {
        context_string: "needing document approval",
        test_id: "needs_document_approval_from_message",
        expected_text: "%document% %needs% your approval",
    },
    needs_attr_approval_from_: {
        context_string: "needing attr approval",
        test_id: "needs_attr_approval_from_message",
        expected_text: "%settlement% %needs% your approval",
    },
    needs_signature: {
        context_string: "needing at least one signature",
        test_id: "needs_signature_message",
        expected_text: "%document% %needs% a signature",
    },
    ready_for_payment: {
        context_string: "ready for payment",
        test_id: "ready_for_payment_message",
        expected_text: "%settlement% %is% ready for payment",
    },
}

waiting = {
    document_approval: {
        expected_text: "%document% to be approved",
        test_id: "BLAH",
    },
    attr_approval: {
        expected_text: "%settlement% to be approved",
        test_id: "BLAH",
    },
    payment_sending: {
        expected_text: "%payment% to post",
        test_id: "BLAH",
    },
    payment_posting: {
        expected_text: "%payment% to be sent",
        test_id: "BLAH",
    },
    signature: {
        expected_text: "%signature%",
        test_id: "BLAH",
    },
}

SpecGenerator::SystemSpec.new(name: "scratchpad", generated_file_location: "spec/system/") do |s|
    s.describe "The whats next card in the settlements section of the user profile show page" do
        members.keys.each do |mk|
            s.context "when the owner is an #{mk}" do
                s.before(:context) do
                    "@owner = create(:#{members[mk][:organization]}, num_members: 2).members.first
                    another_law_firm = create(:law_firm)
                    another_insurance_company = create(:insurance_company)
                    another_adjuster = another_insurance_company.members.first
                    another_attorney = another_law_firm.members.first
                    organization = @owner.organization
                    member_of_organization = organization.members.last
                    @non_owner_users = [organization, member_of_organization, another_attorney, another_adjuster, another_law_firm, another_insurance_company]"
                end
                s.after :context do
                    "User.all.each {|u| u.destroy}"
                end
                action.keys.each do |ak|
                    [0,1,2].each do |i|
                        s.context "with #{i} #{'settlement'.pluralize(i)} #{action[ak][:context_string]}" do
                            s.before(:context) do
                                "@#{ak} = create_list(:settlement, #{i}, :#{ak}, #{mk}: @owner, #{members[mk][:opposite]}: User.#{members[mk][:opposite]}s.sample)
                                @owner.settlements += @#{ak}"
                            end
                            s.after(:context) {"@#{ak}.each {|s| s.destroy}"}
                            s.context "and the visitor is the owner" do
                                s.before(:context) {'@visitor = @owner'}
                                s.it "must#{i == 0 ? " not" : ""} have the #{ak.to_s.gsub("_", " ")} message" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to#{i == 0 ? "_not" : ""} have_css \"[data-test-id='#{action[ak][:test_id]}']\"
                                    expect(page).to#{i == 0 ? "_not" : ""} have_text '#{action[ak][:expected_text].sub('%settlement%', 'settlement'.pluralize(i)).sub('%document%', 'document'.pluralize(i)).sub('%needs%', i == 1 ? 'needs' : 'need').sub('%is%', i == 1 ? 'is' : 'are')}'"
                                end
                                unless i == 0
                                    s.context "after the #{ak.to_s.gsub("_", " ")} message is clicked" do
                                        s.it "must hide all other whats next messages" do
                                            "sign_in @visitor
                                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                                            find(\"[data-test-id='#{action[ak][:test_id]}']\").click
                                            sleep 0.1 # To allow time for the whats next card to update
                                            expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                            expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                            expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{i == 1 ? 'A settlement needs': "#{i} settlements need"} a document'"
                                        end
                                        s.it "must show only the settlements #{action[ak][:context_string]} in the active settlements card" do
                                            "sign_in @visitor
                                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                                            find(\"[data-test-id='#{action[ak][:test_id]}']\").click
                                            sleep 0.1 # To allow time for the active settlement table to update
                                            expect(all('tr').count).to eq(@#{ak}.size + 1) # +1 because the table header counts as a row
                                            @#{ak}.each do |s|
                                                expect(page).to have_text s.public_number
                                            end"
                                        end
                                        s.it "must show the reset button" do
                                            "sign_in @visitor
                                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                                            find(\"[data-test-id='#{action[ak][:test_id]}']\").click
                                            sleep 0.1 # To allow time for the active settlement table to update
                                            expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
                                        end
                                        s.context "and the reset button is clicked" do
                                            s.it "must show all the owners settlements again" do
                                                "sign_in @visitor
                                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                find(\"[data-test-id='#{action[ak][:test_id]}']\").click
                                                sleep 0.1 # To allow time for the active settlement table to update
                                                click_on 'Reset'
                                                sleep 0.1 # To allow time for the active settlement table to update
                                                expect(all('tr').count).to eq(@owner.settlements.count + 1) # +1 because the table header counts as a row
                                                @owner.settlements.each do |s|
                                                    expect(page).to have_text s.public_number
                                                end"
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                waiting.keys.each do |wk|
                    [0,1,2].each do |i|
                        s.context "with #{i} #{'settlement'.pluralize(i)} awaiting #{wk.to_s.gsub("_", " ")}" do
                            s.before(:context) do
                                "@#{wk} = create_list(:settlement, #{i}, :awaiting_#{wk}, #{wk}: @owner, #{members[mk][:opposite]}: User.#{members[mk][:opposite]}s.sample)
                                @owner.settlements += @#{wk}"
                            end
                            s.after(:context) {"@#{wk}.each {|s| s.destroy}"}
                            s.context "and the visitor is the owner" do
                                s.before(:context) {'@visitor = @owner'}
                                s.it "must#{i == 0 ? " not" : " "} have the waiting for #{wk.to_s.gsub("_", " ")} message" do
                                    "sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to#{i == 0 ? "_not" : ""} have_css \"[data-test-id='#{waiting[wk][:test_id]}']\"
                                    expect(page).to#{i == 0 ? "_not" : ""} have_text '#{waiting[wk][:expected_text].sub('%settlement%', 'settlement'.pluralize(i)).sub('%document%', 'document'.pluralize(i)).sub('%payment%', 'payment'.pluralize(i))}'"
                                end
                            end
                        end
                    end
                end
                s.context "and the visitor is not the owner" do
                    s.it "must not be shown" do
                        "@non_owner_users.each do |u|
                            sign_in u
                            visit user_profile_show_path(@owner.profile, section: :settlements)
                            expect(page).to_not have_css \"[data-test-id='whats_next_card']\"
                            expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                            expect(page).to_not have_css \"[data-test-id='ready_for_payment_message']\"
                            expect(page).to_not have_css \"[data-test-id='needs_signature_message']\"
                            expect(page).to_not have_css \"[data-test-id='needs_signature_message']\"
                            expect(page).to_not have_css \"[data-test-id='needs_attr_approval_from_message']\"
                            expect(page).to_not have_css \"[data-test-id='needs_document_approval_from_message']\"
                            expect(page).to_not have_css \"[data-test-id='needs_document_message']\"
                        end"
                    end
                end
            end
        end
        organizations.each do |ok|
            s.context "when the owner is #{indefinite_articleize(word: ok.to_s)}" do
                s.before(:context) do
                    "@owner = create(:#{ok})
                    another_law_firm = create(:law_firm)
                    another_insurance_company = create(:insurance_company)
                    another_adjuster = another_insurance_company.members.first
                    another_attorney = another_law_firm.members.first
                    member_of_organization = @owner.members.first
                    @every_possible_visitor = [@owner, member_of_organization, another_attorney, another_adjuster, another_law_firm, another_insurance_company]"
                end
                s.after :context do
                    "User.all.each {|u| u.destroy}"
                end
                s.it "must never be shown" do
                    "@every_possible_visitor.each do |u|
                        sign_in u
                        visit user_profile_show_path(@owner.profile, section: :settlements)
                        expect(page).to_not have_css \"[data-test-id='whats_next_card']\"
                    end"
                end
            end
        end
    end
end