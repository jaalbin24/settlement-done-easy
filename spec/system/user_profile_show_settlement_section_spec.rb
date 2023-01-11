# ==================================================================================== #
#                                                                                      #
# This file was automatically generated.                                               #
# Instead of editing this file, edit the generator file then run the following command #
#                                                                                      #
# rails generate_specs:system                                                          #
#                                                                                      #
# ==================================================================================== #

require 'rails_helper'

RSpec.describe "The settlement section of the user profile show page" do
    include_context 'devise'
    before :context do
        create(:attorney)
        create(:adjuster)
    end
    after :context do
        User.all.each {|u| u.destroy}
    end
    context "in the active settlements card" do
        context "when the owner is an attorney" do
            before :context do
                @owner = create(:attorney)
            end
            after :context do
                @owner.destroy
            end
            context "with 1 unrelated settlement" do
                before :context do
                    @unrelated = create(:settlement, attorney: @owner)
                end
                after :context do
                    @unrelated.destroy
                end
                context "and the visitor is an adjuster from another insurance company" do
                    before :context do
                        @visitor = create(:adjuster)
                    end
                    after :context do
                        @visitor.destroy
                    end
                    context "that has 1 settlement with the owner" do
                        it "must have 1 settlement" do
                            pending 'Implementation'
                            fail
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
                        it "must have 0 settlements" do
                            pending 'Implementation'
                            fail
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
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(2)
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(2)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that has 5 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 5, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(2)
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
                                    m.settlements = create_list(:settlement, 1, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(7)
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(7)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 5 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 5, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
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
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(7)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                    context "with 5 members" do
                        before :context do
                            @visitor.members = create_list(:adjuster, 5, organization: @visitor)
                        end
                        after :context do
                            @visitor.members.each {|m| m.destroy}
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
                            context "and 1, 2, 3, 4, and 5 settlements with the owner" do
                                before :context do
                                    @visitor.members.each_with_index do |m, i|
                                        m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                    end
                                end
                                after :context do
                                end
                                it "must have 15 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(16)
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
                            context "and 1, 2, 3, 4, and 5 settlements with the owner" do
                                before :context do
                                    @visitor.members.each_with_index do |m, i|
                                        m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                    end
                                end
                                after :context do
                                end
                                it "must have 15 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(16)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                        context "that each have 5 unrelated settlements" do
                            before :context do
                                @visitor.members.each do |m|
                                    m.settlements = create_list(:settlement, 5, adjuster: m, attorney: User.attorneys.without(@owner).sample)
                                end
                            end
                            after :context do
                                @visitor.members.each do |m|
                                    m.settlements.each {|s| s.destroy}
                                end
                            end
                            context "and 1, 2, 3, 4, and 5 settlements with the owner" do
                                before :context do
                                    @visitor.members.each_with_index do |m, i|
                                        m.settlements += create_list(:settlement, i+1, adjuster: m, attorney: @owner)
                                    end
                                end
                                after :context do
                                end
                                it "must have 15 settlements" do
                                    sign_in @visitor
                                    visit user_profile_show_path(@owner.profile)
                                    click_on 'Settlements'
                                    expect(all('tr').count).to eq(16)
                                    Settlement.belonging_to(@owner).merge(Settlement.belonging_to(@visitor)).each do |s|
                                        expect(page).to have_text s.public_number
                                    end
                                end
                            end
                        end
                    end
                end
                context "and the visitor is another law firm" do
                    it "must not show any settlements" do
                        pending 'Implementation'
                        fail
                    end
                end
                context "and the visitor is an attorney from another law firm" do
                    it "must not show any settlements" do
                        pending 'Implementation'
                        fail
                    end
                end
            end
        end
        context "when the owner is a law firm" do
            context "with 1 member" do
                context "and the members have 1,2 and 5 settlements respectively" do
                end
            end
        end
    end
end
