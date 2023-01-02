require "rails_helper"
# The 'owner' refers to the user that the profile represents. If a profile page for John Smith is being accessed, John Smith is the owner.
RSpec.describe "The profile section of the user settings page", type: :system do
    include_context "devise"
    before :context do
        @law_firm = create(:law_firm)
        @insurance_company = create(:insurance_company)
        @attorney = @law_firm.members.first
        @adjuster = @insurance_company.members.first
        @organizations = [@law_firm, @insurance_company]
        @members = [@attorney, @adjuster]
        @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    end
    after :context do
        @users.each do |user|
            user.destroy
        end
    end

    before :each do
        @users.each do |user|
            sign_out
        end
    end

    it "must have a link to the user's profile show page" do
        pending "Implementation"
        fail
    end
    describe "in the privacy form" do
        it "must have a "
    end
end