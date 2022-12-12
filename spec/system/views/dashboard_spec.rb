require "rails_helper"

RSpec.describe "The dashboard" do
    include_context "devise"
    context "when an attorney visits" do
        context "with a settlement that requires a document" do
            it "must have an accordian dropdown with a link to that document's show page" do
                pending "Can be implemented now"
                fail
            end
        end
        context "without a settlement that requires a document" do
            it "must not have an accordian dropdown with a link to that document's show page" do
                pending "Can be implemented now"
                fail
            end
        end
        context "with a settlement that needs detail approval from the attorney" do
            it "must have an accordian dropdown with a link to that settlement" do
                pending "Can be implemented now"
                fail
            end
        end
        context "without a settlement that needs detail approval from the attorney" do
            it "must not have an accordian dropdown with a link to that settlement" do
                pending "Can be implemented now"
                fail
            end
        end
        context "with a settlement that is ready for payment" do
            context "and has an active payment request" do
                it "must not have an accordian dropdown with a link to that settlement" do # Because a payment request cannot be made.
                    pending "Can be implemented now"
                    fail
                end
            end
            context "and does not have an active payment request" do
                it "must have an accordian dropdown with a link to that settlement" do # Because a payment request can be made.
                    pending "Can be implemented now"
                    fail
                end
            end
        end
        context "without a settlement that is ready for payment" do
            it "must not have an accordian dropdown with a link to that settlement" do
                pending "Can be implemented now"
                fail
            end
        end
    end
    context "when an adjuster visits" do
    end
    context "when a law firm visits" do
    end
    context "when an insurance company visits" do
    end
end