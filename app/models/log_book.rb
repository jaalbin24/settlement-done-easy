# == Schema Information
#
# Table name: log_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#
class LogBook < ApplicationRecord
    has_many(
        :entries,
        class_name: "LogBookEntry",
        foreign_key: "log_book_id",
        inverse_of: :log_book,
        dependent: :destroy
    )
end
