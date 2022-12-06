# == Schema Information
#
# Table name: log_book_entries
#
#  id          :bigint           not null, primary key
#  message     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  log_book_id :bigint
#  public_id   :string
#  user_id     :bigint
#
# Indexes
#
#  index_log_book_entries_on_log_book_id  (log_book_id)
#  index_log_book_entries_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (user_id => users.id)
#
class LogBookEntry < ApplicationRecord
    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        inverse_of: :entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
