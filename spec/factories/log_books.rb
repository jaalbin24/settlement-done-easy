# == Schema Information
#
# Table name: log_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#
FactoryBot.define do
    factory :log_book, class: "LogBook" do

    end
end