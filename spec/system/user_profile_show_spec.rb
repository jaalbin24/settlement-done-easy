require "rails_helper"
# The 'owner' refers to the user that the profile represents. If a profile page for John Smith is being accessed, John Smith is the owner.
RSpec.describe "The user profile page", type: :system do
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

    context "when the owner is an organization-type user" do
        context "with profile settings set to show the MCC to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {mcc: true}), create(:insurance_company, show_members_only: {mcc: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's MCC" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_mcc_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "MCC"
                        expect(page).to have_text owner.profile.mcc
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's MCC" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "MCC"
                            expect(page).to_not have_text owner.profile.mcc
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the MCC to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {mcc: true}), create(:insurance_company, show_public: {mcc: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's MCC" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "MCC"
                        expect(page).to have_text owner.profile.mcc
                    end
                end
            end
        end
        
        context "with profile settings set to show the Legal name to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {legal_name: true}), create(:insurance_company, show_members_only: {legal_name: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Legal name" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_legal_name_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Legal name"
                        expect(page).to have_text owner.profile.legal_name
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Legal name" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Legal name"
                            expect(page).to_not have_text owner.profile.legal_name
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Legal name to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {legal_name: true}), create(:insurance_company, show_public: {legal_name: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Legal name" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Legal name"
                        expect(page).to have_text owner.profile.legal_name
                    end
                end
            end
        end

        context "with profile settings set to show the Email to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {email: true}), create(:insurance_company, show_members_only: {email: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Email" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_email_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Email"
                        expect(page).to have_text owner.profile.email
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Email" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Email"
                            expect(page).to_not have_text owner.profile.email
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Email to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {email: true}), create(:insurance_company, show_public: {email: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Email" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Email"
                        expect(page).to have_text owner.profile.email
                    end
                end
            end
        end

        context "with profile settings set to show the Phone number to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {phone_number: true}), create(:insurance_company, show_members_only: {phone_number: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Phone number" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_phone_number_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Phone number"
                        expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Phone number" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Phone number"
                            expect(page).to_not have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Phone number to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {phone_number: true}), create(:insurance_company, show_public: {phone_number: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Phone number" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Phone number"
                        expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(owner.profile.phone_number, area_code: true)
                    end
                end
            end
        end

        context "with profile settings set to show the Address to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {address: true}), create(:insurance_company, show_members_only: {address: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Address" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_address_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Address"
                        expect(page).to have_text owner.profile.address.to_s
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Address" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Address"
                            expect(page).to_not have_text owner.profile.address.to_s
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Address to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {address: true}), create(:insurance_company, show_public: {address: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Address" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Address"
                        expect(page).to have_text owner.profile.address.to_s
                    end
                end
            end
        end

        context "with profile settings set to show the Tax ID to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {tax_id: true}), create(:insurance_company, show_members_only: {tax_id: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Tax ID" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_tax_id_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Tax ID"
                        expect(page).to have_text owner.profile.tax_id
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Tax ID" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Tax ID"
                            expect(page).to_not have_text owner.profile.tax_id
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Tax ID to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {tax_id: true}), create(:insurance_company, show_public: {tax_id: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Tax ID" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Tax ID"
                        expect(page).to have_text owner.profile.tax_id
                    end
                end
            end
        end

        context "with profile settings set to show the Product description to its members only" do
            before :context do
                @owners = [create(:law_firm, show_members_only: {product_description: true}), create(:insurance_company, show_members_only: {product_description: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            context "and the user is a member belonging to that organization" do
                it "must have the owner's Product description" do
                    @owners.each do |owner|
                        expect(owner.settings.profile.show_product_description_to_members_only).to eq true
                        user = owner.members.first
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Product description"
                        expect(page).to have_text owner.profile.product_description
                    end
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's Product description" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Product description"
                            expect(page).to_not have_text owner.profile.product_description
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Product description to the public" do
            before :context do
                @owners = [create(:law_firm, show_public: {product_description: true}), create(:insurance_company, show_public: {product_description: true})]
            end
            after :context do
                @owners.each do |owner|
                    owner.destroy
                end
            end
            it "must have the owner's Product description" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text "Product description"
                        expect(page).to have_text owner.profile.product_description
                    end
                end
            end
        end 
    end

    context "when the owner is a member-type user" do
        
    end

    context "when accessed by anyone other than the owner or the owner's organization" do
        it "must not have an edit button" do
            pending "Implementation"
            fail
        end
        context "if the owner has settings set to hide their email" do
            it "must not show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must not show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must not show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must not show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must not show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must not show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when accessed by the owner" do
        it "must have an edit button that leads to the user profile edit page" do
            @users.each do |user|
                sign_in user
                visit user_profile_show_path(user.profile)
                expect(page).to have_css "a.btn.btn-secondary[href='#{user_profile_edit_path(user.profile, continue_path: user_profile_show_path(user.profile))}']"
                expect(page).to have_link "Edit profile"
                click_on "Edit profile"
                sleep 0.05
                expect(current_path).to eq user_profile_edit_path(user.profile)
            end
        end
        context "if the owner has settings set to hide their email" do
            it "must still show the owner's email" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must still show the owner's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must still show the owner's address" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must still show the owner's birthday" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must still show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when accessed by the owner's organization" do
        it "must have an edit button that leads to the user profile edit page" do
            @users.each do |user|
                sign_in user
                visit user_profile_show_path(user.profile)
                expect(page).to have_css "a.btn.btn-secondary[href='#{user_profile_edit_path(user.profile, continue_path: user_profile_show_path(user.profile))}']"
                expect(page).to have_link "Edit profile"
                click_on "Edit profile"
                sleep 0.05
                expect(current_path).to eq user_profile_edit_path(user.profile)
            end
        end
        context "if the owner has settings set to hide their email" do
            it "must still show the owner's email" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must still show the owner's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must still show the owner's address" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must still show the owner's birthday" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must still show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when the profile does not have a user account" do
        it "must have a button labeled 'Create account'" do
            pending "Implementation"
            fail
        end
        it "must have a message saying the profile does not have a user account" do
            pending "Implementation"
            fail
        end
    end

    context "after the 'Edit profile' button is clicked" do
        before :each do
            attorney = build(:attorney) do |user|
                user.settings = build(:user_settings)
                user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
                user.save
            end
            extra_attorney = create(:attorney, organization: attorney.organization)
            adjuster = build(:adjuster) do |user|
                user.settings = build(:user_settings)
                user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
                user.save
            end
            extra_adjuster = create(:adjuster, organization: adjuster.organization)
            @owners = [attorney, adjuster]
            @extras = [extra_attorney, extra_adjuster]
        end
        it "must take the user to the edit profile page" do
            @owners.each do |owner|
                sign_in user
                visit user_profile_show_path(owner.profile)
                expect(page).to_not have_text "Last name"
                expect(page).to_not have_text owner.profile.last_name
            end
        end
    end
end