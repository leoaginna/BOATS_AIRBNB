require "test_helper"

class BoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boats_index_url
    assert_response :success
  end

  test "should get new" do
    get boats_new_url
    assert_response :success
  end

  test "should get create" do
    get boats_create_url
    assert_response :success
  end

  test "should get edit" do
    get boats_edit_url
    assert_response :success
  end

  test "should get update" do
    get boats_update_url
    assert_response :success
  end

  test "should get delete" do
    get boats_delete_url
    assert_response :success
  end
end
