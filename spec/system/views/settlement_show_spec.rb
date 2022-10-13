require "rails_helper"

RSpec.describe "The settlement show page" do
    include_context "devise"

    context "when an attorney visits" do
        context "with an unactivated organization" do
            context "while the settlement is locked" do
                context "due to an active payment request" do
                    context "and has settings set to" do
                        context "alert the user when the settlement is ready for payment" do
                            before(:each) do
                                @user = create(:attorney, :with_unactivated_organization)
                                @settlement = create(:settlement, :with_unanswered_payment_request, attorney: @user)
                            end
                            it "will not display a ready-for-payment modal" do # Because the attorney's organization is not activated, and there is an active payment request
                                sign_in @user
                                visit settlement_show_path(@settlement)
                                expect(page).to_not have_css('div[name="ready-for-payment-modal"]')
                            end
                            it "will not display a payment-requested modal" do # Because this is an attorney
                                sign_in @user
                                visit settlement_show_path(@settlement)
                                expect(page).to_not have_css('div[name="payment-requested-modal"]')
                            end
                            it "will have a disabled 'Upload' button" do # Because the settlement is locked (from the active payment request)
                                sign_in @user
                                visit settlement_show_path(@settlement)
                                click_on "Documents"
                                expect(page).to have_button("disabled-upload-document-button")
                            end
                            it "will display the right message when hovering over the 'Upload' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have a disabled 'Generate' button" do # Because the settlement is locked (from the active payment request)
                                sign_in @user
                                visit settlement_show_path(@settlement)
                                click_on "Documents"
                                expect(page).to have_button("disabled-generate-document-button")
                            end
                            it "will display the right message when hovering over the 'Generate' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have a disabled 'Update details' button" do # Because the settlement is locked (from the active payment request)
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'Update details' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have a disabled 'Request payment' button" do # Because the settlement already has an unanswered payment request
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'Request payment' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will not have a 'Send payment' button" do # Because this is an attorney
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have a disabled 'Update bank account' button" do # Because the settlement is locked (from the active payment request)
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'Update bank account' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have an active link to each document's show page" do # Always
                                pending "Can be implemented now"
                                fail
                            end
                            it "will display the right message when hovering over the 'View document' button" do
                                pending "Can be implemented now"
                                fail
                            end
                            it "will have 'organization account needs to be activated' as an item on the checklist" do # Because the attorney's organization is not activated.
                                pending "Can be implemented now"
                                fail
                            end
                        end
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
        context "with an activated organization" do

        end
    end
end