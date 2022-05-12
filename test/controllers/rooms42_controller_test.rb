require "test_helper"

class Rooms42ControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get rooms42_home_url
    assert_response :success
  end
end
