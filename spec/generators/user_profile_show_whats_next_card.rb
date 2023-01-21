# Assuming the SpecGenerator module is located in Rails.root/lib
$:.unshift("#{Pathname.new(__FILE__).parent.parent.parent.realpath}/lib")

require 'spec_generator'
require 'english_language'
require 'active_support/inflector'
require 'active_support/core_ext/array/conversions'
require 'humanize'
include EnglishLanguage
include SpecGenerator

SpecGenerator::SystemSpec.new(name: "whats_next_card", generated_file_location: "spec/system/user_profile/show/settlements/") do |s|
    s.describe "The whats next card in the settlement section of the user profile show page" do
        s.context "when the owner is an attorney" do
            s.before(:context) do
                "@owner = create(:law_firm, num_members: 2).members.first
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
            [0,1,2].each do |n_needs_document|
                s.context "with #{n_needs_document} #{'settlement'.pluralize(n_needs_document)} needing a document" do
                    s.before(:context) do
                        "@needs_documents = create_list(:settlement, #{n_needs_document}, :needs_document, attorney: @owner, adjuster: User.adjusters.sample)
                        @owner.settlements += @needs_documents"
                    end
                    s.after(:context) {"@needs_documents.each {|s| s.destroy}"}
                    [0,1,2].each do |n_needs_document_approval|
                        s.context "and #{n_needs_document_approval} #{'settlement'.pluralize(n_needs_document_approval)} needing document approval" do
                            s.before(:context) do
                                "@needs_doc_approval = create_list(:settlement, #{n_needs_document_approval}, :needs_document_approval_from_attorney, attorney: @owner, adjuster: User.adjusters.sample)
                                @owner.settlements += @needs_doc_approval"
                            end
                            s.after(:context) {"@needs_doc_approval.each {|s| s.destroy}"}
                            [0,1,2].each do |n_needs_attr_approval|
                                s.context "and #{n_needs_attr_approval} #{'settlement'.pluralize(n_needs_attr_approval)} needing attribute approval" do
                                    s.before :context do
                                        "@needs_attr_approval = create_list(:settlement, #{n_needs_attr_approval}, :needs_attr_approval_from_attorney, attorney: @owner, adjuster: User.adjusters.sample)
                                        @owner.settlements += @needs_attr_approval"
                                    end
                                    s.after(:context) {"@needs_attr_approval.each {|s| s.destroy}"}
                                    [0,1,2].each do |n_needs_signature|
                                        s.context "and #{n_needs_signature} #{'settlement'.pluralize(n_needs_signature)} with a document needing a signature" do
                                            s.before :context do
                                                "@needs_signature = create_list(:settlement, #{n_needs_signature}, :needs_signature, attorney: @owner, adjuster: User.adjusters.sample)
                                                @owner.settlements += @needs_signature"
                                            end
                                            s.after(:context) {"@needs_signature.each {|s| s.destroy}"}
                                            [0,1,2].each do |n_ready_for_payment|
                                                s.context "and #{n_ready_for_payment} #{'settlement'.pluralize(n_ready_for_payment)} ready for payment" do
                                                    s.before :context do
                                                        "@ready_for_payment = create_list(:settlement, #{n_ready_for_payment}, :ready_for_payment, attorney: @owner, adjuster: User.adjusters.sample)
                                                        @owner.settlements += @ready_for_payment"
                                                    end
                                                    s.after(:context) {"@ready_for_payment.each {|s| s.destroy}"}
                                                    s.context "and the visitor is the owner" do
                                                        s.before(:context) {'@visitor = @owner'}
                                                        if n_needs_document == 0
                                                            s.it "must not have the needs document message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_document_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_document} #{'settlement'.pluralize(n_needs_document)} #{n_needs_document == 1 ? 'needs' : 'need'} a document" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_document_message']\"
                                                                expect(find(\"[data-test-id='needs_document_message']\")).to have_text '#{n_needs_document == 1 ? 'A settlement needs': "#{n_needs_document} settlements need"} a document'"
                                                            end
                                                            s.context "after the needs document message is clicked" do
                                                                s.it "must show only the settlements that need a document in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_documents.size + 1) # +1 because the table header counts as a row
                                                                    @needs_documents.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                            end
                                                        end
                                                        if n_needs_document_approval == 0
                                                            s.it "must not have the needs document approval message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_document_approval_from_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_document_approval} #{'settlement'.pluralize(n_needs_document_approval)} #{n_needs_document_approval == 1 ? 'needs' : 'need'} document approval" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_document_approval_from_message']\"
                                                                expect(find(\"[data-test-id='needs_document_approval_from_message']\")).to have_text '#{n_needs_document_approval == 1 ? 'A settlement needs' : "#{n_needs_document_approval} settlements need"} document approval'"
                                                            end
                                                            s.context "after the needs document approval message is clicked" do
                                                                s.it "must show only the settlements that need document approval in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_doc_approval.size + 1) # +1 because the table header counts as a row
                                                                    @needs_doc_approval.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                            end
                                                        end
                                                        if n_needs_attr_approval == 0
                                                            s.it "must not have the needs attr approval message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_attr_approval_from_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_attr_approval} #{'settlement'.pluralize(n_needs_attr_approval)} #{n_needs_attr_approval == 1 ? 'needs' : 'need'} approval" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_attr_approval_from_message']\"
                                                                expect(find(\"[data-test-id='needs_attr_approval_from_message']\")).to have_text '#{n_needs_attr_approval == 1 ? 'A settlement needs' : "#{n_needs_attr_approval} settlements need"} your approval'"
                                                            end
                                                            s.context "after the needs attr approval message is clicked" do
                                                                s.it "must show only the settlements that need attribute approval from the owner in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_attr_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_attr_approval.size + 1) # +1 because the table header counts as a row
                                                                    @needs_attr_approval.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                            end
                                                        end
                                                        if n_needs_signature == 0
                                                            s.it "must not have the needs signature message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_signature_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_signature} #{'settlement'.pluralize(n_needs_signature)} #{n_needs_signature == 1 ? 'needs' : 'need'} a signature" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_signature_message']\"
                                                                expect(find(\"[data-test-id='needs_signature_message']\")).to have_text '#{n_needs_signature == 1 ? 'A document needs' : "#{n_needs_signature} documents need"} a signature'"
                                                            end
                                                            s.context "after the needs signature message is clicked" do
                                                                s.it "must show only the settlements that need a signature in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_signature_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_signature.size + 1) # +1 because the table header counts as a row
                                                                    @needs_signature.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                            end
                                                        end
                                                        if n_ready_for_payment == 0
                                                            s.it "must not have the ready for payment message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='ready_for_payment_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_ready_for_payment} #{'settlement'.pluralize(n_ready_for_payment)} #{n_ready_for_payment == 1 ? 'is' : 'are'} ready for payment" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='ready_for_payment_message']\"
                                                                expect(find(\"[data-test-id='ready_for_payment_message']\")).to have_text '#{n_ready_for_payment == 1 ? 'A settlement is': "#{n_ready_for_payment} settlements are"} ready for payment'"
                                                            end
                                                            s.context "after the ready for payment message is clicked" do
                                                                s.it "must show only the settlements that are ready for payment in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='ready_for_payment_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@ready_for_payment.size + 1) # +1 because the table header counts as a row
                                                                    @ready_for_payment.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
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
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            # [0,1,2].each do |n_awaiting_doc_approval|
            #     s.context "with n settlements awaiting document approval" do
            #         [0,1,2].each do |n_awaiting_attr_approval|
            #         s.context "and n settlements awaiting attr approval" do
            #             [0,1,2].each do |n_awaiting_payment_sending|
            #             s.context "and n settlements awaiting payment sending" do
            #                 [0,1,2].each do |n_awaiting_payment_posting|
            #                 s.context "and n settlements awaiting payment posting" do
            #                     [0,1,2].each do |n_awaiting_signatures|
            #                     s.context "and n settlements awaiting signatures" do
            #                         s.it "must show the correct messages" do

            #                         end
            #                     end
            #                 end
            #             end
            #         end
            #     end
            # end
        end
        s.context "when the owner is an adjuster" do
            s.before(:context) do
                "@owner = create(:insurance_company, num_members: 2).members.first
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
            [0,1,2].each do |n_needs_document|
                s.context "with #{n_needs_document} #{'settlement'.pluralize(n_needs_document)} needing a document" do
                    s.before(:context) do
                        "@needs_documents = create_list(:settlement, #{n_needs_document}, :needs_document, adjuster: @owner, attorney: User.attorneys.sample)
                        @owner.settlements += @needs_documents"
                    end
                    s.after(:context) {"@needs_documents.each {|s| s.destroy}"}
                    [0,1,2].each do |n_needs_document_approval|
                        s.context "and #{n_needs_document_approval} #{'settlement'.pluralize(n_needs_document_approval)} needing document approval" do
                            s.before(:context) do
                                "@needs_doc_approval = create_list(:settlement, #{n_needs_document_approval}, :needs_document_approval_from_adjuster, adjuster: @owner, attorney: User.attorneys.sample)
                                @owner.settlements += @needs_doc_approval"
                            end
                            s.after(:context) {"@needs_doc_approval.each {|s| s.destroy}"}
                            [0,1,2].each do |n_needs_attr_approval|
                                s.context "and #{n_needs_attr_approval} #{'settlement'.pluralize(n_needs_attr_approval)} needing attribute approval" do
                                    s.before :context do
                                        "@needs_attr_approval = create_list(:settlement, #{n_needs_attr_approval}, :needs_attr_approval_from_adjuster, adjuster: @owner, attorney: User.attorneys.sample)
                                        @owner.settlements += @needs_attr_approval"
                                    end
                                    s.after(:context) {"@needs_attr_approval.each {|s| s.destroy}"}
                                    [0,1,2].each do |n_needs_signature|
                                        s.context "and #{n_needs_signature} #{'settlement'.pluralize(n_needs_signature)} with a document needing a signature" do
                                            s.before :context do
                                                "@needs_signature = create_list(:settlement, #{n_needs_signature}, :needs_signature, adjuster: @owner, attorney: User.attorneys.sample)
                                                @owner.settlements += @needs_signature"
                                            end
                                            s.after(:context) {"@needs_signature.each {|s| s.destroy}"}
                                            [0,1,2].each do |n_ready_for_payment|
                                                s.context "and #{n_ready_for_payment} #{'settlement'.pluralize(n_ready_for_payment)} ready for payment" do
                                                    s.before :context do
                                                        "@ready_for_payment = create_list(:settlement, #{n_ready_for_payment}, :ready_for_payment, adjuster: @owner, attorney: User.attorneys.sample)
                                                        @owner.settlements += @ready_for_payment"
                                                    end
                                                    s.after(:context) {"@ready_for_payment.each {|s| s.destroy}"}
                                                    s.context "and the visitor is the owner" do
                                                        s.before(:context) {'@visitor = @owner'}
                                                        if n_needs_document == 0
                                                            s.it "must not have the needs document message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_document_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_document} #{'settlement'.pluralize(n_needs_document)} #{n_needs_document == 1 ? 'needs' : 'need'} a document" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_document_message']\"
                                                                expect(find(\"[data-test-id='needs_document_message']\")).to have_text '#{n_needs_document == 1 ? 'A settlement needs': "#{n_needs_document} settlements need"} a document'"
                                                            end
                                                            s.context "after the needs document message is clicked" do
                                                                s.it "must hide all other whats next messages" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_message']\").click
                                                                    sleep 0.1 # To allow time for the whats next card to update
                                                                    expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{n_needs_document == 1 ? 'A settlement needs': "#{n_needs_document} settlements need"} a document'"
                                                                end
                                                                s.it "must show only the settlements that need a document in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_documents.size + 1) # +1 because the table header counts as a row
                                                                    @needs_documents.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                                s.it "must show the reset button" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
                                                                end
                                                            end
                                                        end
                                                        if n_needs_document_approval == 0
                                                            s.it "must not have the needs document approval message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_document_approval_from_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_document_approval} #{'settlement'.pluralize(n_needs_document_approval)} #{n_needs_document_approval == 1 ? 'needs' : 'need'} document approval" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_document_approval_from_message']\"
                                                                expect(find(\"[data-test-id='needs_document_approval_from_message']\")).to have_text '#{n_needs_document_approval == 1 ? 'A settlement needs' : "#{n_needs_document_approval} settlements need"} document approval'"
                                                            end
                                                            s.context "after the needs document approval message is clicked" do
                                                                s.it "must hide all other whats next messages" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the whats next card to update
                                                                    expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{n_needs_document_approval == 1 ? 'A settlement needs' : "#{n_needs_document_approval} settlements need"} document approval'"
                                                                end
                                                                s.it "must show only the settlements that need document approval in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_doc_approval.size + 1) # +1 because the table header counts as a row
                                                                    @needs_doc_approval.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                                s.it "must show the reset button" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_document_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
                                                                end
                                                            end
                                                        end
                                                        if n_needs_attr_approval == 0
                                                            s.it "must not have the needs attr approval message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_attr_approval_from_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_attr_approval} #{'settlement'.pluralize(n_needs_attr_approval)} #{n_needs_attr_approval == 1 ? 'needs' : 'need'} approval" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_attr_approval_from_message']\"
                                                                expect(find(\"[data-test-id='needs_attr_approval_from_message']\")).to have_text '#{n_needs_attr_approval == 1 ? 'A settlement needs' : "#{n_needs_attr_approval} settlements need"} your approval'"
                                                            end
                                                            s.context "after the needs attr approval message is clicked" do
                                                                s.it "must hide all other whats next messages" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_attr_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the whats next card to update
                                                                    expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{n_needs_attr_approval == 1 ? 'A settlement needs' : "#{n_needs_attr_approval} settlements need"} your approval'"
                                                                end
                                                                s.it "must show only the settlements that need attribute approval from the owner in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_attr_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_attr_approval.size + 1) # +1 because the table header counts as a row
                                                                    @needs_attr_approval.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                                s.it "must show the reset button" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_attr_approval_from_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
                                                                end
                                                            end
                                                        end
                                                        if n_needs_signature == 0
                                                            s.it "must not have the needs signature message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='needs_signature_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_needs_signature} #{'settlement'.pluralize(n_needs_signature)} #{n_needs_signature == 1 ? 'needs' : 'need'} a signature" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='needs_signature_message']\"
                                                                expect(find(\"[data-test-id='needs_signature_message']\")).to have_text '#{n_needs_signature == 1 ? 'A document needs' : "#{n_needs_signature} documents need"} a signature'"
                                                            end
                                                            s.context "after the needs signature message is clicked" do
                                                                s.it "must hide all other whats next messages" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_signature_message']\").click
                                                                    sleep 0.1 # To allow time for the whats next card to update
                                                                    expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{n_needs_signature == 1 ? 'A document needs' : "#{n_needs_signature} documents need"} a signature'"
                                                                end
                                                                s.it "must show only the settlements that need a signature in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_signature_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@needs_signature.size + 1) # +1 because the table header counts as a row
                                                                    @needs_signature.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                                s.it "must show the reset button" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='needs_signature_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
                                                                end
                                                            end
                                                        end
                                                        if n_ready_for_payment == 0
                                                            s.it "must not have the ready for payment message" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to_not have_css \"[data-test-id='ready_for_payment_message']\""
                                                            end
                                                        else
                                                            s.it "must have a message saying #{n_ready_for_payment} #{'settlement'.pluralize(n_ready_for_payment)} #{n_ready_for_payment == 1 ? 'is' : 'are'} ready for payment" do
                                                                "sign_in @visitor
                                                                visit user_profile_show_path(@owner.profile, section: :settlements)
                                                                expect(page).to have_css \"[data-test-id='ready_for_payment_message']\"
                                                                expect(find(\"[data-test-id='ready_for_payment_message']\")).to have_text '#{n_ready_for_payment == 1 ? 'A settlement is': "#{n_ready_for_payment} settlements are"} ready for payment'"
                                                            end
                                                            s.context "after the ready for payment message is clicked" do
                                                                s.it "must hide all other whats next messages" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='ready_for_payment_message']\").click
                                                                    sleep 0.1 # To allow time for the whats next card to update
                                                                    expect(page).to_not have_css \"[data-test-id='whats_next_wait_list']\"
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\").all('form').count).to eq(1) # +1 because the table header counts as a row
                                                                    expect(find(\"[data-test-id='whats_next_action_list']\")).to have_text '#{n_ready_for_payment == 1 ? 'A settlement is': "#{n_ready_for_payment} settlements are"} ready for payment'"
                                                                end
                                                                s.it "must show only the settlements that are ready for payment in the active settlements card" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='ready_for_payment_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(all('tr').count).to eq(@ready_for_payment.size + 1) # +1 because the table header counts as a row
                                                                    @ready_for_payment.each do |s|
                                                                        expect(page).to have_text s.public_number
                                                                    end"
                                                                end
                                                                s.it "must show the reset button" do
                                                                    "sign_in @visitor
                                                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                                                    find(\"[data-test-id='ready_for_payment_message']\").click
                                                                    sleep 0.1 # To allow time for the active settlement table to update
                                                                    expect(page).to have_css \"button[data-test-id='reset_settlement_search_button']\""
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
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        s.context "when the owner is a law firm" do
            s.before(:context) do
                "@owner = create(:law_firm)
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
                    expect(page).to_not have_css \"[data-test-id='ready_for_payment_message']\"
                    expect(page).to_not have_css \"[data-test-id='needs_signature_message']\"
                    expect(page).to_not have_css \"[data-test-id='needs_signature_message']\"
                    expect(page).to_not have_css \"[data-test-id='needs_attr_approval_from_message']\"
                    expect(page).to_not have_css \"[data-test-id='needs_document_approval_from_message']\"
                    expect(page).to_not have_css \"[data-test-id='needs_document_message']\"
                end"
            end
        end
        s.context "when the owner is an insurance company" do
            s.before(:context) do
                "@owner = create(:insurance_company)
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