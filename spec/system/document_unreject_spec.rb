require "rails_helper"

RSpec.describe "A member unrejecting a document", type: :system do
    include_context "devise"
    context "when their settlement settings allow for it" do
        before(:each) do
            @document = create(:document, :from_the_ground_up)
            settlement = @document.settlement
            @user = @document.added_by.isAttorney? ? @user = settlement.adjuster : @user = settlement.attorney
            setting = settlement.settings_for(@document.added_by)
            setting.update(delete_my_documents_after_rejection: false)
            @document.reviews.by(@user).first.reject
            @document.save!
        end
        it "will unreject the document" do
            sign_in @user
            visit document_show_path(@document)
            expect(@document.rejected?).to be_truthy
            expect(@document.has_been_rejected_by?(@user)).to be_truthy
            click_on "Unreject"
            expect(page).to have_text "The document was unrejected."
            @document.reload
            expect(@document.rejected?).to be_falsey
            expect(@document.has_been_rejected_by?(@user)).to be_falsey
        end
    end
end