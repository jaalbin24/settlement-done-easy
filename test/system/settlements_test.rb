require "application_system_test_case"

class SettlementsTest < ApplicationSystemTestCase
  test "visiting root page" do
    puts "====================== ENTERED TEST METHOD"
    visit root_path
    puts "====================== VISITED ROOT PAGE"
    assert_selector "h1", text: "Log In"
  end
end
