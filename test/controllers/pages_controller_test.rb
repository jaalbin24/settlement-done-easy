require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "sign in as attorney" do
    get root_path
    assert_response :redirect
    post "/users/sign_in", params: {"user"=>{"email"=>"attorney1@example.com", "password"=>"password123", "remember_me"=>"0"}, "commit"=>"Log in"}
    assert_response :found
    get settlement_dashboard_url
    assert_response :success
  end
end
