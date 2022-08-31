require "test_helper"

class AddressTest < ActiveSupport::TestCase
    test "fixtures are valid" do
        assert !addresses.empty?, "There are no Address fixtures to test!"
        addresses.each do |a|
            assert a.valid?, a.errors.full_messages.inspect
        end
    end
end
