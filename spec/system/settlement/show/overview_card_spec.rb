require "rails_helper"

RSpec.describe "The overview card in the settlement show page", type: :system do
    include_context "devise"
    

    context "when the user is an attorney" do
        it "must have the attorney's name on the visitor side" do

        end
        it "must have the attorney's organization's name on the visitor side" do

        end
        it "must have the adjuster's name on the partner side" do

        end
        it "must have the adjuster's organization's name on the partner side" do

        end
    end
    context "when the user is an adjuster" do
        it "must have the adjuster's name on the visitor side" do

        end
        it "must have the adjuster's organization's name on the visitor side" do

        end
        it "must have the attorney's name on the partner side" do

        end
        it "must have the attorney's organization's name on the partner side" do

        end
    end
    context "when the settlement has no claimant name" do
        it "must have only the settlement amount in the settlement summary" do

        end
    end
    context "when the settlement has a claimant name" do
        it "must have the settlement amount and claimant name in the settlement summary" do

        end
    end

    it "must show the settlement start milestone as active" do

    end

    context "when the settlement has a document" do
        context "that is approved" do
            it "must show the document approved milestone as active" do

            end
        end
        context "that is not approved" do
            it "must show the document approved milestone as inactive" do

            end
        end
        context "that needs a signature" do
            context "and is signed" do
                it "must show the document signed milestone as active" do

                end
            end
            context "and is not signed" do
                it "must show the document signed milestone as inactive" do

                end
            end
        end
        context "that does not need a signature" do
            it "must not show the document signed milestone" do

            end
        end
    end
    context "when the settlement does not have a document" do
        it "must not show the documents approved milestone" do

        end
        it "must not show the documents signed milestone" do

        end
    end
    context "when the settlement has a processing payment" do
        it "must show the payment sent milestone as active" do

        end
    end
    context "when the settlement does not have a processing payment" do
        it "must show the payment sent milestone as inactive" do

        end
    end
    context "when the settlement is completed" do
        it "must show the settlement completed milestone as active" do

        end
    end
    context "when the settlement is not completed" do
        it "must show the settlement completed milestone as inactive" do

        end
    end
end