require "rails_helper"

RSpec.describe "A member rejecting a document", type: :system do
    include_context "devise"
    context "when the document author's settlement settings are set to delete their rejected documents automatically" do
        before(:each) do
            @document = create(:document, :from_the_ground_up)
            settlement = @document.settlement
            @user = @document.added_by.isAttorney? ? @user = settlement.insurance_agent : @user = settlement.attorney
            setting = settlement.settings_for(@document.added_by)
            setting.update(delete_my_documents_after_rejection: true)
        end
        it "will be shown a confirmation modal" do
            sign_in @user
            visit document_show_path(@document)
            expect(@document.settlement.settings_for(@document.added_by).delete_my_documents_after_rejection).to be_truthy
            click_on "open-document-reject-confirmation-button"
            expect(page).to have_text "Are you sure you want to reject #{@document.filename}?"
        end
        it "will not delete or reject the document if they click cancel in the modal window" do
            sign_in @user
            visit document_show_path(@document)
            expect(@document.settlement.settings_for(@document.added_by).delete_my_documents_after_rejection).to be_truthy
            click_on "open-document-reject-confirmation-button"
            expect(page).to have_text "Are you sure you want to reject #{@document.filename}?"
            sleep(0.5) # Give modal time to open. If you click Cancel before the modal has fully opened, it will not close like it is supposed to.
            click_on "Cancel"
            expect(page).to_not have_text "Are you sure you want to reject #{@document.filename}?"
            expect{Document.find(@document.id)}.to_not raise_error(ActiveRecord::RecordNotFound)
            expect(@document.rejected?).to be_falsey
        end
        it "will delete the document if they click reject in the modal window" do
            sign_in @user
            visit document_show_path(@document)
            expect(@document.settlement.settings_for(@document.added_by).delete_my_documents_after_rejection).to be_truthy
            click_on "open-document-reject-confirmation-button"
            expect(page).to have_text "Are you sure you want to reject #{@document.filename}?"
            click_link "Reject"
            expect(page).to have_text "The document was rejected and automatically deleted."
            expect{Document.find(@document.id)}.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
    context "when the document author's settlement settings are set to not delete their rejected documents automatically" do
        before(:each) do
            @document = create(:document, :from_the_ground_up)
            settlement = @document.settlement
            @user = @document.added_by.isAttorney? ? @user = settlement.insurance_agent : @user = settlement.attorney
            setting = settlement.settings_for(@document.added_by)
            setting.update(delete_my_documents_after_rejection: false)
        end
        it "will reject the document" do
            sign_in @user
            visit document_show_path(@document)
            expect(@document.settlement.settings_for(@document.added_by).delete_my_documents_after_rejection).to be_falsey
            click_on "Reject"
            expect(page).to have_text "The document was rejected."
            expect(page).to have_text "Unreject"
            @document.reload
            expect(@document.rejected?).to be_truthy
        end
    end
end