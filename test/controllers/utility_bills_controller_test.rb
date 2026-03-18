require "test_helper"

class UtilityBillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get utility_bills_new_url
    assert_response :success
  end

  test "should get create" do
    get utility_bills_create_url
    assert_response :success
  end

  test "should get edit" do
    get utility_bills_edit_url
    assert_response :success
  end

  test "should get update" do
    get utility_bills_update_url
    assert_response :success
  end

  test "should get destroy" do
    get utility_bills_destroy_url
    assert_response :success
  end
end
