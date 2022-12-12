# == Schema Information
#
# Table name: log_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#
require "test_helper"

class LogBookTest < ActiveSupport::TestCase
    test "fixtures are valid" do
        assert !log_books.empty?, "There are no LogBook fixtures to test!"
        log_books.each do |lb|
            assert lb.valid?, lb.errors.full_messages.inspect
        end
    end
end
