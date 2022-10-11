require "rails_helper"

RSpec.describe "Generating a document", type: :system do
    include_context "devise"

    context "as an attorney" do
        before(:each) do
            @user = create(:attorney, num_settlements: 1)
        end
        it "will create a document added by that attorney with auto_generated set to true" do
            old_document_count = @user.settlements.first.documents.count
            sign_in @user
            visit settlement_show_path(@user.settlements.first)
            click_on "Documents"
            click_on "Generate"
            expect(page).to have_text "Generated new document! Click here to view it."
            @user.settlements.first.reload
            expect(old_document_count).to eq(@user.settlements.first.documents.count - 1)
            generated_document = @user.settlements.first.documents.last
            expect(generated_document.auto_generated?).to be_truthy
            expect(generated_document.added_by).to eq(@user)
        end
    end

    context "for a locked settlement" do
        before(:each) do
            @settlement = create(:settlement, :with_processing_payment)
            @user = @settlement.attorney
        end
        it "will show an error message and not create a document" do
            expect(@settlement.locked?).to be_truthy
            sign_in @user
            visit settlement_show_path(@settlement)
            click_on "Documents"
            click_on "Generate"
            expect(page).to have_text "You cannot add documents to this settlement right now because it is locked."
        end
    end
end