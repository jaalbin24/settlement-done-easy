# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The active settlements card in the settlement section of the user profile show page" do
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
        context "with 0 unrelated settlements" do
            before :context do
                @unrelated = create_list(:settlement, 0, attorney: @owner, adjuster: User.adjusters.sample)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements. Click here to start one."
                end
                context "after 'here' is clicked" do
                    it "must take the user to the settlement new page" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        find("[data-test-id='empty_active_settlement_link']").click
                        sleep 0.05
                        expect(current_path).to eq(settlement_new_path)
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:attorney, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "#{@owner.name} does not have any active settlements."
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "#{@owner.name} does not have any active settlements."
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
        context "with 1 unrelated settlement" do
            before :context do
                @unrelated = create_list(:settlement, 1, attorney: @owner, adjuster: User.adjusters.sample)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:attorney, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
        context "with 3 unrelated settlements" do
            before :context do
                @unrelated = create_list(:settlement, 3, attorney: @owner, adjuster: User.adjusters.sample)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:attorney, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @visitor, attorney: @owner)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
    end
    context "when the owner is an adjuster" do
        before :context do
            @owner = create(:adjuster)
        end
        after :context do
            @owner.organization.destroy
        end
        context "with 0 unrelated settlements" do
            before :context do
                @unrelated = create_list(:settlement, 0, attorney: User.attorneys.sample, adjuster: @owner)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements. Click here to start one."
                end
                context "after 'here' is clicked" do
                    it "must take the user to the settlement new page" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        find("[data-test-id='empty_active_settlement_link']").click
                        sleep 0.05
                        expect(current_path).to eq(settlement_new_path)
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:adjuster, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "#{@owner.name} does not have any active settlements."
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the owner has no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "#{@owner.name} does not have any active settlements."
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has 0 settlements with the owner" do
                    it "must have 0 settlements" do
                        pending 'Implementation'
                        fail
                    end
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:attorney, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:attorney, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
        context "with 1 unrelated settlement" do
            before :context do
                @unrelated = create_list(:settlement, 1, attorney: User.attorneys.sample, adjuster: @owner)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:adjuster, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must show 1 settlement" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has 0 settlements with the owner" do
                    it "must have 0 settlements" do
                        pending 'Implementation'
                        fail
                    end
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:attorney, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:attorney, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
        context "with 3 unrelated settlements" do
            before :context do
                @unrelated = create_list(:settlement, 3, attorney: User.attorneys.sample, adjuster: @owner)
            end
            after :context do
                @unrelated.each {|s| s.destroy}
            end
            context "and the visitor is the owner" do
                before :context do
                    @visitor = @owner
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is a member of the owners organization" do
                before :context do
                    @visitor = create(:adjuster, organization: @owner.organization)
                end
                after :context do
                    @visitor.destroy
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is the owners organization" do
                before :context do
                    @visitor = @owner.organization
                end
                it "must show 3 settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
            end
            context "and the visitor is an attorney from another law firm" do
                before :context do
                    @visitor = create(:attorney)
                end
                after :context do
                    @visitor.organization.destroy
                end
                context "that has 0 settlements with the owner" do
                    it "must have 0 settlements" do
                        pending 'Implementation'
                        fail
                    end
                end
                context "that has no settlements with the owner" do
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}. Click here to start one."
                    end
                    context "after 'here' is clicked" do
                        it "must take the user to the settlement new page" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            find("[data-test-id='empty_active_settlement_link']").click
                            sleep 0.05
                            expect(current_path).to eq(settlement_new_path)
                        end
                    end
                end
                context "that has 1 settlement with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 1, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "that has 3 settlements with the owner" do
                    before :context do
                        @visitor.settlements += create_list(:settlement, 3, adjuster: @owner, attorney: @visitor)
                    end
                    after :context do
                        @visitor.settlements.each {|s| s.destroy}
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "and the visitor is another law firm" do
                before :context do
                    @visitor = create(:law_firm)
                end
                after :context do
                    @visitor.destroy
                end
                context "with 0 members" do
                    before :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    it "must have 0 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                    it "must show a message saying the visitor has no settlements with the owner" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                    end
                end
                context "with 1 member" do
                    before :context do
                        @visitor.members = create_list(:attorney, 1, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that has 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1 settlement with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "with 3 members" do
                    before :context do
                        @visitor.members = create_list(:attorney, 3, organization: @visitor)
                    end
                    after :context do
                        @visitor.members.each {|m| m.destroy}
                    end
                    context "that each have 0 settlements with the owner" do
                        it "must have 0 settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                        it "must show a message saying the visitor has no settlements with the owner" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You do not have any active settlements with #{@owner.name}."
                        end
                    end
                    context "that each have 1 unrelated settlement" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that each have 3 unrelated settlements" do
                        before :context do
                            @visitor.members.each do |m|
                                m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.without(@owner).sample)
                            end
                        end
                        after :context do
                            @visitor.members.each do |m|
                                m.settlements.each {|s| s.destroy}
                            end
                        end
                        context "and 0 settlements with the owner" do
                            it "must have 0 settlements" do
                                pending 'Implementation'
                                fail
                            end
                        end
                        context "and 1, 2, and 3 settlements with the owner" do
                            before :context do
                                @visitor.members.each_with_index do |m, i|
                                    m.settlements += create_list(:settlement, i+1, adjuster: @owner, attorney: m)
                                end
                            end
                            after :context do
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
            end
            context "and the visitor is another insurance company" do
                before :context do
                    @visitor = create(:insurance_company)
                end
                after :context do
                    @visitor.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
            context "and the visitor is an adjuster from another insurance company" do
                before :context do
                    @visitor = create(:adjuster)
                end
                after :context do
                    @visitor.organization.destroy
                end
                it "must have no settlements" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(all('tr').count).to eq(0)
                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                        expect(page).to have_text s.public_number
                    end
                end
                it "must show a message saying the visitor cannot have settlements with the owner" do
                    sign_in @visitor
                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                    expect(find("[data-test-id='empty_active_settlement_message']")).to have_text "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
                end
            end
        end
    end
    context "when the owner is a law firm" do
        before :context do
            @owner = create(:law_firm)
        end
        after :context do
            @owner.destroy
        end
        context "with 1 member" do
            before :context do
                @owner.members = create_list(:attorney, 1, organization: @owner)
            end
            after :context do
                @owner.members.each {|m| m.destroy}
            end
            context "that has 1 unrelated settlement" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "that has 3 unrelated settlements" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
        end
        context "with 3 members" do
            before :context do
                @owner.members = create_list(:attorney, 3, organization: @owner)
            end
            after :context do
                @owner.members.each {|m| m.destroy}
            end
            context "that each have 1 unrelated settlement" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "that each have 3 unrelated settlements" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 9 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(9 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 9 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(9 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, adjuster: @visitor, attorney: User.attorneys.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: @visitor, attorney: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, adjuster: vm, attorney: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
        end
    end
    context "when the owner is an insurance company" do
        before :context do
            @owner = create(:insurance_company)
        end
        after :context do
            @owner.destroy
        end
        context "with 1 member" do
            before :context do
                @owner.members = create_list(:adjuster, 1, organization: @owner)
            end
            after :context do
                @owner.members.each {|m| m.destroy}
            end
            context "that has 1 unrelated settlement" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 1 settlement" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:attorney, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:attorney, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "that has 3 unrelated settlements" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1 settlement with the owners member" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 1 settlement" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:attorney, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 1 settlement" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(1 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:attorney, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1 settlement with the owners member" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 3 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
        end
        context "with 3 members" do
            before :context do
                @owner.members = create_list(:adjuster, 3, organization: @owner)
            end
            after :context do
                @owner.members.each {|m| m.destroy}
            end
            context "that each have 1 unrelated settlement" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 3 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(3 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:attorney, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:attorney, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
            context "that each have 3 unrelated settlements" do
                before :context do
                    @owner.members.each do |m|
                        m.settlements = create_list(:settlement, 3, adjuster: m, attorney: User.attorneys.sample)
                    end
                end
                after :context do
                    @owner.members.each do |m|
                        m.settlements.each {|s| s.destroy}
                    end
                end
                context "and the visitor is the owner" do
                    before :context do
                        @visitor = @owner
                    end
                    it "must have 9 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(9 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is one of the owners members" do
                    before :context do
                        @visitor = @owner.members.first
                    end
                    it "must have 9 settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(9 + 1) # +1 because the table header counts as a row
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    before :context do
                        @visitor = create(:attorney)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    context "that has 0 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 0, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 1 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 1, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                    context "that has 3 unrelated settlements" do
                        before :context do
                            @visitor.settlements = create_list(:settlement, 3, attorney: @visitor, adjuster: User.adjusters.where.not(organization: @owner).sample)
                        end
                        after :context do
                            @visitor.settlements.each {|s| s.destroy}
                        end
                        context "and 1, 2, and 3 settlements with the owners members" do
                            before :context do
                                @owner.members.each_with_index do |m, i|
                                    (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: @visitor, adjuster: m)
                                end
                            end
                            after :context do
                                @related_settlements.each {|s| s.destroy}
                            end
                            it "must have 6 settlements" do
                                sign_in @visitor
                                visit user_profile_show_path(@owner.profile, section: 'settlements')
                                expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                    expect(page).to have_text s.public_number
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    before :context do
                        @visitor = create(:law_firm)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "with no members" do
                        before :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        it "must have no settlements" do
                            sign_in @visitor
                            visit user_profile_show_path(@owner.profile, section: 'settlements')
                            expect(all('tr').count).to eq(0)
                            Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                expect(page).to have_text s.public_number
                            end
                        end
                    end
                    context "with 1 member" do
                        before :context do
                            @visitor.members = create_list(:attorney, 1, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that has 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 6 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(6 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 3 members" do
                        before :context do
                            @visitor.members = create_list(:attorney, 3, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
                        end
                        context "that each have 1 unrelated settlement" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 1, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 3 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 3, attorney: m, adjuster: User.adjusters.where.not(organization: @owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, and 3 settlements with the owners members" do
                                before :context do
                                    @visitor.members.each do |vm|
                                        @owner.members.each_with_index do |om, i|
                                            (@related_settlements ||= []).join create_list(:settlement, i+1, attorney: vm, adjuster: om)
                                        end
                                    end
                                end
                                after :context do
                                    @related_settlements.each {|s| s.destroy}
                                end
                                it "must have 18 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile, section: 'settlements')
                                    expect(all('tr').count).to eq(18 + 1) # +1 because the table header counts as a row
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another insurance company" do
                    before :context do
                        @visitor = create(:insurance_company)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.organization.destroy
                    end
                    it "must have no settlements" do
                        sign_in @visitor
                        visit user_profile_show_path(@owner.profile, section: 'settlements')
                        expect(all('tr').count).to eq(0)
                        Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                            expect(page).to have_text s.public_number
                        end
                    end
                end
            end
        end
    end
end
