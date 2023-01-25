require "rails_helper"
include ActionView::Helpers::NumberHelper # For the number_to_currency helper

RSpec.describe "The overview card in the settlement show page", type: :system do
    include_context "devise"
    before :context do
        @settlement = create(:settlement)
        @attorney = @settlement.attorney
        @adjuster = @settlement.adjuster
    end
    after :context do
        User.all.each {|d| d.destroy}
    end

    it "must show the settlement start milestone as active" do
        sign_in @attorney
        visit settlement_show_path(@settlement)
        expect(page).to have_css "li.active[data-test-id='settlement_started_milestone']"
    end
    it "must have the settlement number" do
        sign_in @attorney
        visit settlement_show_path(@settlement)
        expect(find("[data-test-id='settlement_number']")).to have_text "Settlement ##{"%04d" % @settlement.public_number}"
    end

    context "when the user is an attorney" do
        it "must have the attorney's name on the visitor side" do
            sign_in @attorney
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='visitor_name']")).to have_text @attorney.name
        end
        it "must have the attorney's organization's name on the visitor side" do
            sign_in @attorney
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='visitor_organization_name']")).to have_text @attorney.organization.name
        end
        it "must have the adjuster's name on the partner side" do
            sign_in @attorney
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='partner_name']")).to have_text @adjuster.name
        end
        it "must have the adjuster's organization's name on the partner side" do
            sign_in @attorney
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='partner_organization_name']")).to have_text @adjuster.organization.name
        end
    end
    context "when the user is an adjuster" do
        it "must have the adjuster's name on the visitor side" do
            sign_in @adjuster
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='visitor_name']")).to have_text @adjuster.name
        end
        it "must have the adjuster's organization's name on the visitor side" do
            sign_in @adjuster
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='visitor_organization_name']")).to have_text @adjuster.organization.name
        end
        it "must have the attorney's name on the partner side" do
            sign_in @adjuster
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='partner_name']")).to have_text @attorney.name
        end
        it "must have the attorney's organization's name on the partner side" do
            sign_in @adjuster
            visit settlement_show_path(@settlement)
            expect(find("[data-test-id='partner_organization_name']")).to have_text @attorney.organization.name
        end
    end
    context "when the settlement has no claimant name" do
        before do
            @no_claimant_settlement = create(:settlement, claimant_name: nil)
        end
        it "must have only the settlement amount in the settlement summary" do
            sign_in @no_claimant_settlement.attorney
            visit settlement_show_path(@no_claimant_settlement)
            expect(find("[data-test-id='settlement_summary']")).to have_text number_to_currency(@no_claimant_settlement.amount)
            expect(find("[data-test-id='settlement_summary']")).to_not have_text "for"
        end
    end
    context "when the settlement has a claimant name" do
        before do
            @no_claimant_settlement = create(:settlement, claimant_name: "Johnny Test")
        end
        it "must have the settlement amount and claimant name in the settlement summary" do
            sign_in @no_claimant_settlement.attorney
            visit settlement_show_path(@no_claimant_settlement)
            expect(find("[data-test-id='settlement_summary']")).to have_text "#{number_to_currency @no_claimant_settlement.amount} for #{@no_claimant_settlement.claimant_name}"
        end
    end

    context "when the settlement has a document" do
        context "that is approved" do
            before do
                @doc_approved_settlement = create(:settlement, :ready_for_payment)
            end
            it "must show the document approved milestone as active" do
                expect(@doc_approved_settlement.reload.documents.approved.count).to eq @doc_approved_settlement.reload.documents.count
                sign_in @doc_approved_settlement.attorney
                visit settlement_show_path(@doc_approved_settlement)
                expect(page).to have_css "li.active[data-test-id='documents_approved_milestone']"
            end
        end
        context "that is not approved" do
            before do
                @doc_not_approved_settlement = create(:settlement, :needs_document_approval_from_adjuster)
            end
            it "must show the document approved milestone as inactive" do
                sign_in @doc_not_approved_settlement.attorney
                visit settlement_show_path(@doc_not_approved_settlement)
                expect(page).to_not have_css "li.active[data-test-id='documents_approved_milestone']"
                expect(page).to have_css "li[data-test-id='documents_approved_milestone']"
            end
        end
        context "that needs a signature" do
            context "and is signed" do
                it "must show the document signed milestone as active" do
                    pending "Implementation"
                    fail
                end
            end
            context "and is not signed" do
                it "must show the document signed milestone as inactive" do
                    pending "Implementation"
                    fail
                end
            end
        end
        context "that does not need a signature" do
            it "must not show the document signed milestone" do
                pending "Implementation"
                fail
            end
        end
    end
    context "when the settlement does not have a document" do
        it "must not show the documents approved milestone" do
            pending "Implementation"
            fail
        end
        it "must not show the documents signed milestone" do
            pending "Implementation"
            fail
        end
    end
    context "when the settlement has a processing payment" do
        it "must show the payment sent milestone as active" do
            pending "Implementation"
            fail
        end
    end
    context "when the settlement does not have a processing payment" do
        it "must show the payment sent milestone as inactive" do
            pending "Implementation"
            fail
        end
    end
    context "when the settlement is completed" do
        it "must show the settlement completed milestone as active" do
            pending "Implementation"
            fail
        end
    end
    context "when the settlement is not completed" do
        it "must show the settlement completed milestone as inactive" do
            pending "Implementation"
            fail
        end
    end
end