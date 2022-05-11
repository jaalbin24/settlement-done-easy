require "application_system_test_case"

class SettlementsTest < ApplicationSystemTestCase
  test "visiting root page" do
    sign_in users(:attorney)
    visit root_path
    assert_selector "h1", "Attorney Dashboard"
  end
end
