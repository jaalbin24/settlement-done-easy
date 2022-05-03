require "test_helper"

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "get index" do
    settlements.each do |s|
      get document_index_url(s)
      assert_response :found
    end
  end

  test "show document" do
    documents.each do |d|
      get document_show_url(d)
      assert_response :found
    end
  end

  test "new document" do
    settlements.each do |s|
      get document_new_url(s)
      assert_response :found
    end
  end

  test "create document" do
    documents.each do |d|
      post document_create_url(d)
      assert_response :found
    end
  end

end
