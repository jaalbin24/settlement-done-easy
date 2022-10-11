require "rails_helper"

RSpec.describe "The settlement show page" do
    include_context "devise"

    context "when an attorney visits" do
        context "with an unactivated organization" do
            context "while the settlement is locked" do
                context "and has an active payment request" do
                    context "and has settings set to" do
                        context "alert the user when the settlement is ready for payment" do
                            it "will not display a ready-for-payment modal" do

                            end
                            it "will not display a payment-requested modal" do
        
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
                        context "not alert the user when the settlement is ready for payment" do

                        end
                        context "alert the user when payment is requested" do

                        end
                        context "not alert the user when payment is requested" do

                        end
                    end
                end
                context "and completed" do
                    it "will not display a ready-for-payment modal" do

                    end
                    it "will not display a payment-requested modal" do

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
                context "and has a processing payment" do
                    it "will not display a ready-for-payment modal" do

                    end
                    it "will not display a payment-requested modal" do

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
                            it "will not display a ready-for-payment modal" do
                                # Because the settlement 

                            end
                            it "will not display a payment-requested modal" do
        
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
                            it "will not display a payment-requested modal" do
        
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
                            it "will not display a payment-requested modal" do
        
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

                    end
                    context "because it has rejected document(s)" do

                    end
                    context "because it has unapproved document(s)" do

                    end
                    context "because it has unsigned document(s) that should be signed" do

                    end
                end
            end
        end
        context "with an activated organization" do

        end
    end
end