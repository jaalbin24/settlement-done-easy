require "rails_helper"

RSpec.describe "The settlement show page" do
    include_context "devise"

    context "when an attorney visits" do
        context "with an unactivated organization" do
            context "that lacks a bank account" do
                context "while the settlement is locked" do
                    context "due to an active payment request" do
                        context "and has settings set to" do
                            context "alert the user when the settlement is ready for payment" do
                                before(:each) do
                                    @user = create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                                    @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                                    expect(@settlement.settings_for(@user).alert_when_settlement_ready_for_payment).to be_truthy
                                    sign_in @user
                                    visit settlement_show_path(@settlement)
                                end
                                it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                                    expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
                                    expect(page).to_not have_css('div[name="payment-requested-modal"]')
                                end
                                it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-upload-document-button")
                                end
                                it "will display the right message when hovering over the 'Upload' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-upload-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-generate-document-button")
                                end
                                it "will display the right message when hovering over the 'Generate' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-generate-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Update settlement' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Details"
                                    expect(page).to have_button("disabled-update-settlement-button")
                                end
                                # it "will display the right message when hovering over the 'Update settlement' button" do
                                #     click_on "Details"
                                #     expect(page).to_not have_text "This settlement is locked"
                                #     find(:button, id: "disabled-update-settlement-button").hover
                                #     expect(page).to have_text "This settlement is locked"
                                # end
                                it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                                    expect(page).to have_button("disabled-request-payment-button")
                                end
                                it "will display the right message when hovering over the 'Request payment' button" do
                                    expect(page).to_not have_text "Complete the checklist first"
                                    find(:button, id: "disabled-request-payment-button").hover
                                    expect(page).to have_text "Complete the checklist first"
                                end
                                it "will not have a 'Send payment' button" do # Because this is an attorney
                                    expect(page).to_not have_button("Send payment")
                                end
                                # it "will display the right message when hovering over the 'Send payment' button" do
                                # end
                                it "will not have an 'Update bank account' button" do # Because the attorney's organization has no bank account
                                    click_on "Payment"
                                    expect(page).to_not have_text "Update bank account"
                                    expect(page).to have_text "There are no bank accounts to deposit into."
                                end
                                # it "will display the right message when hovering over the 'Update bank account' button" do
                                #     sign_in @user
                                #     visit settlement_show_path(@settlement)
                                #     click_on "Payment"
                                #     expect(page).to_not have_text "You can't change bank accounts on a locked settlement"
                                #     find(:button, id: "disabled-update-bank-account-button").hover
                                #     expect(page).to have_text "You can't change bank accounts on a locked settlement"
                                # end
                                it "will have an active link to each document's show page" do # Always
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        click_link "document-show-link-for-#{d.public_id}"
                                        expect(current_path).to eq(document_show_path(d))
                                    end
                                end
                                it "will display the right message when hovering over the 'View document' button" do
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "View this document"
                                        find(:link, id: "document-show-link-for-#{d.public_id}").hover
                                        expect(page).to have_text "View this document"
                                    end
                                end
                                it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                                    checklist = find(id: "settlement-checklist")
                                    expect(checklist).to have_text "#{@settlement.attorney.organization.full_name}'s account must be activated."
                                end
                                it "will not have a 'document needs your review' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-needs-your-review-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will not have a 'document rejected' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-rejected-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will display the right message when hovering over the 'document rejected' indicator" do
                                    @settlement.documents.rejected.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "Delete this document"
                                        find(:link, id: "document-rejected-indicator-for-#{d.public_id}").hover
                                        expect(page).to have_text "Delete this document"
                                    end
                                end
                                it "will not have a 'document requires signature' indicator" do
                                    pending "eSignature feature needs to be more flushed out"
                                    fail
                                end
                            end
                            context "not alert the user when the settlement is ready for payment" do
                                before(:each) do
                                    @user = create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account, :do_not_alert_when_settlement_ready_for_payment)
                                    @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                                    expect(@settlement.settings_for(@user).alert_when_settlement_ready_for_payment).to be_falsey
                                    sign_in @user
                                    visit settlement_show_path(@settlement)
                                end
                                it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                                    expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
                                    expect(page).to_not have_css('div[name="payment-requested-modal"]')
                                end
                                it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-upload-document-button")
                                end
                                it "will display the right message when hovering over the 'Upload' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-upload-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-generate-document-button")
                                end
                                it "will display the right message when hovering over the 'Generate' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-generate-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Update settlement' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Details"
                                    expect(page).to have_button("disabled-update-settlement-button")
                                end
                                # it "will display the right message when hovering over the 'Update settlement' button" do
                                #     click_on "Details"
                                #     expect(page).to_not have_text "This settlement is locked"
                                #     find(:button, id: "disabled-update-settlement-button").hover
                                #     expect(page).to have_text "This settlement is locked"
                                # end
                                it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                                    expect(page).to have_button("disabled-request-payment-button")
                                end
                                it "will display the right message when hovering over the 'Request payment' button" do
                                    expect(page).to_not have_text "Complete the checklist first"
                                    find(:button, id: "disabled-request-payment-button").hover
                                    expect(page).to have_text "Complete the checklist first"
                                end
                                it "will not have a 'Send payment' button" do # Because this is an attorney
                                    expect(page).to_not have_button("Send payment")
                                end
                                # it "will display the right message when hovering over the 'Send payment' button" do
                                # end
                                it "will not have an 'Update bank account' button" do # Because the attorney's organization has no bank account
                                    click_on "Payment"
                                    expect(page).to_not have_text "Update bank account"
                                    expect(page).to have_text "There are no bank accounts to deposit into."
                                end
                                # it "will display the right message when hovering over the 'Update bank account' button" do
                                #     sign_in @user
                                #     visit settlement_show_path(@settlement)
                                #     click_on "Payment"
                                #     expect(page).to_not have_text "You can't change bank accounts on a locked settlement"
                                #     find(:button, id: "disabled-update-bank-account-button").hover
                                #     expect(page).to have_text "You can't change bank accounts on a locked settlement"
                                # end
                                it "will have an active link to each document's show page" do # Always
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        click_link "document-show-link-for-#{d.public_id}"
                                        expect(current_path).to eq(document_show_path(d))
                                    end
                                end
                                it "will display the right message when hovering over the 'View document' button" do
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "View this document"
                                        find(:link, id: "document-show-link-for-#{d.public_id}").hover
                                        expect(page).to have_text "View this document"
                                    end
                                end
                                it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                                    checklist = find(id: "settlement-checklist")
                                    expect(checklist).to have_text "#{@settlement.attorney.organization.full_name}'s account must be activated."
                                end
                                it "will not have a 'document needs your review' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-needs-your-review-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will not have a 'document rejected' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-rejected-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will display the right message when hovering over the 'document rejected' indicator" do
                                    @settlement.documents.rejected.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "Delete this document"
                                        find(:link, id: "document-rejected-indicator-for-#{d.public_id}").hover
                                        expect(page).to have_text "Delete this document"
                                    end
                                end
                                it "will not have a 'document requires signature' indicator" do
                                    pending "eSignature feature needs to be more flushed out"
                                    fail
                                end
                            end
                            context "alert the user when payment is requested" do
                                before(:each) do
                                    @user = create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                                    @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                                    expect(@settlement.settings_for(@user).alert_when_payment_requested).to be_truthy
                                    sign_in @user
                                    visit settlement_show_path(@settlement)
                                end
                                it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                                    expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
                                    expect(page).to_not have_css('div[name="payment-requested-modal"]')
                                end
                                it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-upload-document-button")
                                end
                                it "will display the right message when hovering over the 'Upload' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-upload-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-generate-document-button")
                                end
                                it "will display the right message when hovering over the 'Generate' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-generate-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Update settlement' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Details"
                                    expect(page).to have_button("disabled-update-settlement-button")
                                end
                                # it "will display the right message when hovering over the 'Update settlement' button" do
                                #     click_on "Details"
                                #     expect(page).to_not have_text "This settlement is locked"
                                #     find(:button, id: "disabled-update-settlement-button").hover
                                #     expect(page).to have_text "This settlement is locked"
                                # end
                                it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                                    expect(page).to have_button("disabled-request-payment-button")
                                end
                                it "will display the right message when hovering over the 'Request payment' button" do
                                    expect(page).to_not have_text "Complete the checklist first"
                                    find(:button, id: "disabled-request-payment-button").hover
                                    expect(page).to have_text "Complete the checklist first"
                                end
                                it "will not have a 'Send payment' button" do # Because this is an attorney
                                    expect(page).to_not have_button("Send payment")
                                end
                                # it "will display the right message when hovering over the 'Send payment' button" do
                                # end
                                it "will not have an 'Update bank account' button" do # Because the attorney's organization has no bank account
                                    click_on "Payment"
                                    expect(page).to_not have_text "Update bank account"
                                    expect(page).to have_text "There are no bank accounts to deposit into."
                                end
                                # it "will display the right message when hovering over the 'Update bank account' button" do
                                #     sign_in @user
                                #     visit settlement_show_path(@settlement)
                                #     click_on "Payment"
                                #     expect(page).to_not have_text "You can't change bank accounts on a locked settlement"
                                #     find(:button, id: "disabled-update-bank-account-button").hover
                                #     expect(page).to have_text "You can't change bank accounts on a locked settlement"
                                # end
                                it "will have an active link to each document's show page" do # Always
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        click_link "document-show-link-for-#{d.public_id}"
                                        expect(current_path).to eq(document_show_path(d))
                                    end
                                end
                                it "will display the right message when hovering over the 'View document' button" do
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "View this document"
                                        find(:link, id: "document-show-link-for-#{d.public_id}").hover
                                        expect(page).to have_text "View this document"
                                    end
                                end
                                it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                                    checklist = find(id: "settlement-checklist")
                                    expect(checklist).to have_text "#{@settlement.attorney.organization.full_name}'s account must be activated."
                                end
                                it "will not have a 'document needs your review' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-needs-your-review-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will not have a 'document rejected' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-rejected-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will display the right message when hovering over the 'document rejected' indicator" do
                                    @settlement.documents.rejected.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "Delete this document"
                                        find(:link, id: "document-rejected-indicator-for-#{d.public_id}").hover
                                        expect(page).to have_text "Delete this document"
                                    end
                                end
                                it "will not have a 'document requires signature' indicator" do
                                    pending "eSignature feature needs to be more flushed out"
                                    fail
                                end
                            end
                            context "not alert the user when payment is requested" do
                                before(:each) do
                                    @user = create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account, :do_not_alert_when_payment_requested)
                                    @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                                    expect(@settlement.settings_for(@user).alert_when_payment_requested).to be_falsey
                                    sign_in @user
                                    visit settlement_show_path(@settlement)
                                end
                                it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                                    expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
                                    expect(page).to_not have_css('div[name="payment-requested-modal"]')
                                end
                                it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-upload-document-button")
                                end
                                it "will display the right message when hovering over the 'Upload' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-upload-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Documents"
                                    expect(page).to have_button("disabled-generate-document-button")
                                end
                                it "will display the right message when hovering over the 'Generate' button" do
                                    click_on "Documents"
                                    expect(page).to_not have_text "You can't add documents to a locked settlement"
                                    find(:button, id: "disabled-generate-document-button").hover
                                    expect(page).to have_text "You can't add documents to a locked settlement"
                                end
                                it "will have a disabled 'Update settlement' button" do # Because the settlement is locked (from the active payment request)
                                    click_on "Details"
                                    expect(page).to have_button("disabled-update-settlement-button")
                                end
                                # it "will display the right message when hovering over the 'Update settlement' button" do
                                #     click_on "Details"
                                #     expect(page).to_not have_text "This settlement is locked"
                                #     find(:button, id: "disabled-update-settlement-button").hover
                                #     expect(page).to have_text "This settlement is locked"
                                # end
                                it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                                    expect(page).to have_button("disabled-request-payment-button")
                                end
                                it "will display the right message when hovering over the 'Request payment' button" do
                                    expect(page).to_not have_text "Complete the checklist first"
                                    find(:button, id: "disabled-request-payment-button").hover
                                    expect(page).to have_text "Complete the checklist first"
                                end
                                it "will not have a 'Send payment' button" do # Because this is an attorney
                                    expect(page).to_not have_button("Send payment")
                                end
                                # it "will display the right message when hovering over the 'Send payment' button" do
                                # end
                                it "will not have an 'Update bank account' button" do # Because the attorney's organization has no bank account
                                    click_on "Payment"
                                    expect(page).to_not have_text "Update bank account"
                                    expect(page).to have_text "There are no bank accounts to deposit into."
                                end
                                # it "will display the right message when hovering over the 'Update bank account' button" do
                                #     sign_in @user
                                #     visit settlement_show_path(@settlement)
                                #     click_on "Payment"
                                #     expect(page).to_not have_text "You can't change bank accounts on a locked settlement"
                                #     find(:button, id: "disabled-update-bank-account-button").hover
                                #     expect(page).to have_text "You can't change bank accounts on a locked settlement"
                                # end
                                it "will have an active link to each document's show page" do # Always
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        click_link "document-show-link-for-#{d.public_id}"
                                        expect(current_path).to eq(document_show_path(d))
                                    end
                                end
                                it "will display the right message when hovering over the 'View document' button" do
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "View this document"
                                        find(:link, id: "document-show-link-for-#{d.public_id}").hover
                                        expect(page).to have_text "View this document"
                                    end
                                end
                                it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                                    checklist = find(id: "settlement-checklist")
                                    expect(checklist).to have_text "#{@settlement.attorney.organization.full_name}'s account must be activated."
                                end
                                it "will not have a 'document needs your review' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-needs-your-review-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will not have a 'document rejected' indicator" do # Because the settlement is locked, all documents should already be approved
                                    @settlement.documents.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_link("document-rejected-indicator-for-#{d.public_id}")
                                    end
                                end
                                it "will display the right message when hovering over the 'document rejected' indicator" do
                                    @settlement.documents.rejected.each do |d|
                                        visit settlement_show_path(@settlement)
                                        click_on "Documents"
                                        expect(page).to_not have_text "Delete this document"
                                        find(:link, id: "document-rejected-indicator-for-#{d.public_id}").hover
                                        expect(page).to have_text "Delete this document"
                                    end
                                end
                                it "will not have a 'document requires signature' indicator" do
                                    pending "eSignature feature needs to be more flushed out"
                                    fail
                                end
                            end
                        end
                    end
                    context "because it's completed" do
                        
                    end
                end
                context "while the settlement is unlocked" do
                    context "and ready for payment" do
                        context "and has settings set to" do
                            context "alert the user when the settlement is ready for payment" do
                                
                            end
                            context "not alert the user when the settlement is ready for payment" do
                                
                            end
                            context "alert the user when payment is requested" do
                                
                            end
                            context "not alert the user when payment is requested" do

                            end
                        end
                    end
                    context "and not ready for payment" do
                        context "and has settings set to" do
                            context "alert the user when the settlement is ready for payment" do

                            end
                            context "not alert the user when the settlement is ready for payment" do

                            end
                            context "alert the user when payment is requested" do

                            end
                            context "not alert the user when payment is requested" do

                            end
                        end
                        context "because it has no documents" do
                            it "will have a link to the document upload page on the checklist" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has rejected document(s)" do
                            it "will have a 'document has been rejected' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'document has been rejected' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has document(s) that must be approved by the current user" do
                            it "will have a 'document needs your approval' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'document needs your approval' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has document(s) that must be approved by another user" do
                            it "will have no indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has unsigned document(s) that should be signed" do
                            context "and the their signature requests have been sent" do

                            end
                            context "and the their signature requests have not been sent" do

                            end
                        end
                    end
                end
            end
            context "that has a bank account" do
                context "while the settlement is locked" do
                    context "due to an active payment request" do
                        context "and has settings set to" do
                            # context "alert the user when the settlement is ready for payment" do
                            #     before(:each) do
                            #         @user = create(:attorney, :with_unactivated_organization_due_to_unverified_email)
                            #         @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                            #     end
                            #     it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                            #     end
                            #     it "will not display a payment-requested modal" do # Because this is an attorney
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         expect(page).to_not have_css('div[name="payment-requested-modal"]')
                            #     end
                            #     it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Documents"
                            #         expect(page).to have_button("disabled-upload-document-button")
                            #     end
                            #     it "will display the right message when hovering over the 'Upload' button" do
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Documents"
                            #         find(:button, id: "disabled-upload-document-button").hover
                            #         expect(page).to have_text "You can't add documents to a locked settlement"
                            #     end
                            #     it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Documents"
                            #         expect(page).to have_button("disabled-generate-document-button")
                            #     end
                            #     it "will display the right message when hovering over the 'Generate' button" do
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Documents"
                            #         find(:button, id: "disabled-generate-document-button").hover
                            #         expect(page).to have_text "You can't add documents to a locked settlement"
                            #     end
                            #     it "will have a disabled 'Update details' button" do # Because the settlement is locked (from the active payment request)
                            #         pending "Can be implemented now"
                            #         fail
                            #     end
                            #     it "will display the right message when hovering over the 'Update details' button" do
                            #         pending "Can be implemented now"
                            #         fail
                            #     end
                            #     it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         expect(page).to have_button("disabled-request-payment-button")
                            #     end
                            #     it "will display the right message when hovering over the 'Request payment' button" do
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         find(:button, id: "disabled-request-payment-button").hover
                            #         expect(page).to have_text "Complete the checklist first"
                            #     end
                            #     it "will not have a 'Send payment' button" do # Because this is an attorney
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         expect(page).to_not have_button("Send payment")
                            #     end
                            #     it "will have a disabled 'Update bank account' button" do # Because the settlement is locked (from the active payment request)
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Payment"
                            #         expect(page).to have_button("disabled-update-bank-account-button")
                            #     end
                            #     it "will display the right message when hovering over the 'Update bank account' button" do
                            #         sign_in @user
                            #         visit settlement_show_path(@settlement)
                            #         click_on "Payment"
                            #         find(:button, id: "disabled-update-bank-account-button").hover
                            #         expect(page).to have_text "You can't change bank accounts on a locked settlement"
                            #     end
                            #     it "will have an active link to each document's show page" do # Always
                            #         sign_in @user
                            #         @settlement.documents.each do |d|
                            #             visit settlement_show_path(@settlement)
                            #             click_on "Documents"
                            #             click_link "document-show-link-for-#{d.public_id}"
                            #             expect(current_path).to eq(document_show_path(d))
                            #         end
                            #     end
                            #     it "will display the right message when hovering over the 'View document' button" do
                            #         pending "Can be implemented now"
                            #         fail
                            #     end
                            #     it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                            #         pending "Can be implemented now"
                            #         fail
                            #     end
                            # end
                            context "not alert the user when the settlement is ready for payment" do

                            end
                            context "alert the user when payment is requested" do

                            end
                            context "not alert the user when payment is requested" do

                            end
                        end
                    end
                    context "because it's completed" do
                        it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and the settlement is completed

                        end
                        it "will not display a payment-requested modal" do # Because this is an attorney, and the settlement is completed

                        end
                        it "will have a disabled 'Upload' button" do

                        end
                        it "will have a disabled 'Generate' button" do

                        end
                        it "will have a disabled 'Update details' button" do

                        end
                        it "will have a disabled 'Request payment' button" do

                        end
                        it "will have a disabled 'Update bank account' button" do

                        end
                        it "will have an active link to each document's show page" do

                        end
                    end
                    context "due to a processing payment" do
                        it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated

                        end
                        it "will not display a payment-requested modal" do # Because this is an attorney

                        end
                        it "will have a disabled 'Upload' button" do

                        end
                        it "will have a disabled 'Generate' button" do

                        end
                        it "will have a disabled 'Update details' button" do

                        end
                        it "will have a disabled 'Request payment' button" do

                        end
                        it "will have a disabled 'Update bank account' button" do

                        end
                        it "will have an active link to each document's show page" do

                        end
                    end
                end
                context "while the settlement is unlocked" do
                    context "and ready for payment" do
                        context "and has settings set to" do
                            context "alert the user when the settlement is ready for payment" do
                                it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated

                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
            
                                end
                                it "will have an 'Upload' button that takes the user to the document upload page" do
            
                                end
                                it "will have a 'Generate' button that generates a document" do
            
                                end
                                it "will have an 'Update details' button that updates the settlement details" do
            
                                end
                                it "will have a 'Request payment' button that leads to successful requesting of payment" do
            
                                end
                                it "will have an 'Update bank account' button that updates the destination bank account" do
            
                                end
                                it "will have an active link to each document's show page" do
                                    
                                end
                            end
                            context "not alert the user when the settlement is ready for payment" do
                                it "will not display a ready-for-payment modal" do

                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
            
                                end
                                it "will have an 'Upload' button that takes the user to the document upload page" do
            
                                end
                                it "will have a 'Generate' button that generates a document" do
            
                                end
                                it "will have an 'Update details' button that updates the settlement details" do
            
                                end
                                it "will have a 'Request payment' button that leads to successful requesting of payment" do
            
                                end
                                it "will have an 'Update bank account' button that updates the destination bank account" do
            
                                end
                                it "will have an active link to each document's show page" do
                                    
                                end
                            end
                            context "alert the user when payment is requested" do
                                it "will not display a ready-for-payment modal" do

                                end
                                it "will not display a payment-requested modal" do # Because this is an attorney
            
                                end
                                it "will have an 'Upload' button that takes the user to the document upload page" do
            
                                end
                                it "will have a 'Generate' button that generates a document" do
            
                                end
                                it "will have an 'Update details' button that updates the settlement details" do
            
                                end
                                it "will have a 'Request payment' button that leads to successful requesting of payment" do
            
                                end
                                it "will have an 'Update bank account' button that updates the destination bank account" do
            
                                end
                                it "will have an active link to each document's show page" do
                                    
                                end
                            end
                            context "not alert the user when payment is requested" do

                            end
                        end
                    end
                    context "and not ready for payment" do
                        context "and has settings set to" do
                            context "alert the user when the settlement is ready for payment" do

                            end
                            context "not alert the user when the settlement is ready for payment" do

                            end
                            context "alert the user when payment is requested" do

                            end
                            context "not alert the user when payment is requested" do

                            end
                        end
                        context "because it has no documents" do
                            it "will have a link to the document upload page on the checklist" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has rejected document(s)" do
                            it "will have a 'document has been rejected' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'document has been rejected' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has document(s) that must be approved by the current user" do
                            it "will have a 'document needs your approval' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'document needs your approval' indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has document(s) that must be approved by another user" do
                            it "will have no indicator" do
                                pending "Can be implemented now"
                                fail
                            end
                        end
                        context "because it has unsigned document(s) that should be signed" do
                            context "and the their signature requests have been sent" do

                            end
                            context "and the their signature requests have not been sent" do

                            end
                        end
                    end
                end
            end
        end
        context "with an activated organization" do

        end
    end
end