require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get owner" do
    get dashboard_owner_url
    assert_response :success
  end
end
