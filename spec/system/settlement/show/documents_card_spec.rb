require "rails_helper"
include ActionView::Helpers::NumberHelper # For the number_to_currency helper

RSpec.describe "The documents card in the settlement show page", type: :system do
    include_context "devise"
    before :context do
        @settlement = create(:settlement)
        @attorney = @settlement.attorney
        @adjuster = @settlement.adjuster
    end
    after :context do
        User.all.each {|d| d.destroy}
    end

    it "must have all documents" do
        pending "Implementation"
        fail
    end
    
    context "when a document needs a signature" do
        it "must have a yellow exclamation mark icon next to that document" do
            pending "Implementation"
            fail
        end
    end

    context "when a document needs the visitors approval" do
        it "must have a yellow exclamation mark icon next to that document" do
            pending "Implementation"
            fail
        end
    end

    context "when the settlement is complete" do
        context "and the visitor is the attorney" do
            it "must not have the new document button" do
                pending "Implementation"
                fail
            end
        end
        context "and the visitor is the adjuster" do
            it "must not have the new document button" do
                pending "Implementation"
                fail
            end
        end
        context "and the visitor is the attorneys organization" do
            it "must not have the new document button" do
                pending "Implementation"
                fail
            end
        end
        context "and the visitor is the adjusters organization" do
            it "must not have the new document button" do
                pending "Implementation"
                fail
            end
        end
    end
    context "when the settlement is active" do
        context "with a processing payment" do
            context "and the visitor is the attorney" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the adjuster" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the attorneys organization" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the adjusters organization" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
        end
        context "without a processing payment" do
            context "and the visitor is the attorney" do
                it "must have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the adjuster" do
                it "must have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the attorneys organization" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the visitor is the adjusters organization" do
                it "must not have the new document button" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
end