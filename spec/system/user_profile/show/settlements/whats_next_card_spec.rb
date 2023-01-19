# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The whats next card in the settlement section of the user profile show page" do
    include_context 'devise'
    before :context do
        create(:attorney)
        create(:adjuster)
    end
    after :context do
        User.all.each {|u| u.destroy}
    end
    context "when the owner is an attorney" do
        before :context do
            @owner = create(:attorney)
        end
        after :context do
            @owner.organization.destroy
        end
        context "that has 0 settlements needing a document" do
            before :context do
                @needs_documents = create_list(:settlement, 0, :needs_document)
                @owner.settlements += @needs_documents
            end
            after :context do
                @needs_documents.each {|s| s.destroy}
            end
            context "and 0 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 0, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 1 settlement needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 1, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 2 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 2, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must not have the needs document message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_message']"
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
        end
        context "that has 1 settlement needing a document" do
            before :context do
                @needs_documents = create_list(:settlement, 1, :needs_document)
                @owner.settlements += @needs_documents
            end
            after :context do
                @needs_documents.each {|s| s.destroy}
            end
            context "and 0 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 0, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 1 settlement needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 1, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 2 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 2, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 1 settlement needs a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text 'A settlement needs a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
        end
        context "that has 2 settlements needing a document" do
            before :context do
                @needs_documents = create_list(:settlement, 2, :needs_document)
                @owner.settlements += @needs_documents
            end
            after :context do
                @needs_documents.each {|s| s.destroy}
            end
            context "and 0 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 0, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must not have the needs document approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_document_approval_message']"
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 1 settlement needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 1, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 1 settlement needs document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text 'A documents needs approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
            context "and 2 settlements needing document approval" do
                before :context do
                    @needs_doc_approval = create_list(:settlement, 2, :needs_document_approval_from_attorney)
                    @owner.settlements += @needs_doc_approval
                end
                after :context do
                    @needs_doc_approval.each {|s| s.destroy}
                end
                context "and 0 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 0, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must not have the needs attr approval message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_attr_approval_message']"
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 1 settlement needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 1, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 1 settlement needs approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text 'A settlement needs your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
                context "and 2 settlements needing attribute approval" do
                    before :context do
                        @needs_attr_approval = create_list(:settlement, 2, :needs_attr_approval)
                        @owner.settlements += @needs_attr_approval
                    end
                    after :context do
                        @needs_attr_approval.each {|s| s.destroy}
                    end
                    context "and 0 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 0, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must not have the needs signature message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='needs_signature_message']"
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 1 settlement with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 1, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 1 settlement needs a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '1 documents needs a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                    context "and 2 settlements with a document needing a signature" do
                        before :context do
                            @needs_signature = create_list(:settlement, 2, :needs_signature)
                            @owner.settlements += @needs_signature
                        end
                        after :context do
                            @needs_signature.each {|s| s.destroy}
                        end
                        context "and 0 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 0, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must not have the ready for payment message" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to_not have_css "[data-test-id='ready_for_payment_message']"
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 1 settlement ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 1, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 1 settlement is ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '1 settlement is ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                        context "and 2 settlements ready for payment" do
                            before :context do
                                @ready_for_payment = create_list(:settlement, 2, :ready_for_payment)
                                @owner.settlements += @ready_for_payment
                            end
                            after :context do
                                @ready_for_payment.each {|s| s.destroy}
                            end
                            context "and the visitor is the owner" do
                                before :context do
                                    @visitor = @owner
                                end
                                it "must have a message saying 2 settlements need a document" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_message']"
                                    expect(find("[data-test-id='needs_document_message']")).to have_text '2 settlements need a document'
                                end
                                it "must have a message saying 2 settlements need document approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_document_approval_message']"
                                    expect(find("[data-test-id='needs_document_approval_message']")).to have_text '2 documents need approval'
                                end
                                it "must have a message saying 2 settlements need approval" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_attr_approval_message']"
                                    expect(find("[data-test-id='needs_attr_approval_message']")).to have_text '2 settlements need your approval'
                                end
                                it "must have a message saying 2 settlements need a signature" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='needs_signature_message']"
                                    expect(find("[data-test-id='needs_signature_message']")).to have_text '2 documents need a signature'
                                end
                                it "must have a message saying 2 settlements are ready for payment" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: :settlements)
                                    expect(page).to have_css "[data-test-id='ready_for_payment_message']"
                                    expect(find("[data-test-id='ready_for_payment_message']")).to have_text '2 settlements are ready for payment'
                                end
                            end
                            context "and the visitor is not the owner" do
                            end
                        end
                    end
                end
            end
        end
    end
end
