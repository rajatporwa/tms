require "test_helper"

class MonthlyBillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get monthly_bills_new_url
    assert_response :success
  end

  test "should get create" do
    get monthly_bills_create_url
    assert_response :success
  end

  test "should get edit" do
    get monthly_bills_edit_url
    assert_response :success
  end

  test "should get update" do
    get monthly_bills_update_url
    assert_response :success
  end

  test "should get destroy" do
    get monthly_bills_destroy_url
    assert_response :success
  end
end
