require "rails_helper"

RSpec.describe "A member uploading a document", type: :system do
    include_context "devise"

    context "from the settlement show page" do
        before(:each) do
            @members = [create(:attorney, num_settlements: 1), create(:adjuster, num_settlements: 1)]
        end
        it "will be shown the document upload page" do
            @members.each do |u|
                settlement = u.settlements.first
                sign_in u
                visit settlement_show_path(settlement)
                expect(page).to_not have_text "Filename: "
                expect(page).to have_text "Settlement ##{settlement.public_number}"
                expect(page).to have_text "The following requirements must be met to complete this settlement."
                click_on "Documents"
                expect(page).to have_text "Filename: "
                click_on "Upload"
                expect(page).to have_text "Choose a file"
                expect(page).to have_text "Settlement Done Easy currently only supports PDFs"
            end
        end
    end

    context "from the document upload page" do
        before(:each) do
            @members = [create(:attorney, num_settlements: 1), create(:adjuster, num_settlements: 1)]
        end
        it "will be shown the document show page" do
            @members.each do |u|
                settlement = u.settlements.first
                sign_in u
                visit document_new_path(settlement)
                expect(page).to have_text "Choose a file"
                expect(page).to have_text "Settlement Done Easy currently only supports PDFs"
                attach_file("document[pdf]", "dummy_document.pdf")
                click_on "Upload"
                expect(page).to have_text "Document uploaded! Click here to view it."
                click_on "here"
                expect(page).to have_text "Document Info"
                expect(page).to have_text "Approvals gathered"
            end
        end
    end

end