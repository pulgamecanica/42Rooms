require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "can create user" do
    u = User.create(login: "test", email: "test@test.com")
    assert u.save
  end
end
