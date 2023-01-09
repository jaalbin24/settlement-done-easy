# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The user profile show page" do
    include_context 'devise'
    before :context do
        create(:attorney)
        create(:adjuster)
    end
    after :context do
        User.all.each {|u| u.destroy}
    end
    context "when the owner is a member-type user" do
        context "and the visitor is the owner" do
            context "in the active settlements card" do
                it "must have an index of all active settlements involving the owner" do
                    pending "Implementation"
                    fail
                end
            end
            context "in the whats next card" do
                context "when the user has no settlements" do
                    it "must not have any notices" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a message saying the user should start a settlement" do
                        pending "Implementation"
                        fail
                    end
                    context "after clicking the link in the start a settlement message" do
                        it "must take the user to the settlement new page" do
                            pending "Implementation"
                            fail
                        end
                    end
                end
                context "when the user has only 1 settlement that needs a document" do
                    it "must have a notice saying a settlement needs a document" do
                        pending "Implementation"
                        fail
                    end
                    context "after clicking the needs document notice" do
                        it "must show only 1 settlement that needs a document in the active settlement index" do
                            pending "Implementation"
                            fail
                        end
                    end
                end
                context "when the user has 5 settlements that need a document" do
                    it "must have a notice saying 5 settlements need a document" do
                        pending "Implementation"
                        fail
                    end
                    context "after clicking the needs document notice" do
                        it "must show only 5 settlements that need a document in the active settlement index" do
                            pending "Implementation"
                            fail
                        end
                    end
                end
                context "when the user has no settlements that need a document" do
                    it "must not have a notice saying a settlement needs a document" do
                        pending "Implementation"
                        fail
                    end
                end
            end
        end
        context "and the visitor is the owners organization" do

        end
        context "and the visitor is a member of the owners organization" do

        end
        context "and the visitor is a member of another organization" do

        end
        context "and the visitor is another organization" do

        end
    end
    context "when the owner is an organization-type user" do
        context "and the visitor is the owner" do

        end
        context "and the visitor is one of the owners members" do

        end
        context "and the visitor is a member of another organization" do

        end
        context "and the visitor is another organization" do

        end
    end
end
