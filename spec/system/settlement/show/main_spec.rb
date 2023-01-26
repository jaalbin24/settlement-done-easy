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

    context "when the visitor is not signed in" do
        it "must redirect the user to the log in page" do
            pending "Implementation"
            fail
        end
    end

    context "when the visitor is an unrelated attorney" do
        it "must redirect the user to the root page" do
            pending "Implementation"
            fail
        end
        it "must show a flash message saying the user is not allowed to see that page" do
            pending "Implementation"
            fail
        end
    end
    context "when the visitor is an unrelated adjuster" do
        it "must redirect the user to the root page" do
            pending "Implementation"
            fail
        end
        it "must show a flash message saying the user is not allowed to see that page" do
            pending "Implementation"
            fail
        end
    end
    context "when the visitor is an unrelated law firm" do
        it "must redirect the user to the root page" do
            pending "Implementation"
            fail
        end
        it "must show a flash message saying the user is not allowed to see that page" do
            pending "Implementation"
            fail
        end
    end
    context "when the visitor is an unrelated insurance company" do
        it "must redirect the user to the root page" do
            pending "Implementation"
            fail
        end
        it "must show a flash message saying the user is not allowed to see that page" do
            pending "Implementation"
            fail
        end
    end
end