require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can create an user object successfully" do
    user_params = {
      name: "Sample User",
      email: "sample.user@camerastore.com",
      password: "sample_password",
      password_confirmation: "sample_password"
    }
    user = User.new(user_params)

    assert user.valid?

    user.save
    assert_not user.id.nil?
  end

  test "cannot create an user with duplicate email" do
    new_user = users(:one).dup

    assert_not new_user.valid?
    assert new_user.errors.messages.has_key?(:email)
    assert_equal new_user.errors.full_messages[0], 'Email has already been taken'

    new_user.save
    assert new_user.id.nil?
  end

  test "has many carts" do
    user_obj = users(:one)

    assert user_obj.carts.first.is_a?(Cart)
    assert_equal user_obj.carts.count, 1
  end
end
