# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  city        :string
#  country     :string
#  line1       :string
#  line2       :string
#  postal_code :string
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  public_id   :string
#
require "test_helper"

class AddressTest < ActiveSupport::TestCase
    test "fixtures are valid" do
        assert !addresses.empty?, "There are no Address fixtures to test!"
        addresses.each do |a|
            assert a.valid?, a.errors.full_messages.inspect
        end
    end
end
