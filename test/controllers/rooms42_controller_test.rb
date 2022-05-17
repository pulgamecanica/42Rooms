require "test_helper"

class Rooms42ControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get rooms" do
    get rooms_path
    assert_response :success
  end
  
end
