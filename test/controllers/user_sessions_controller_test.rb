require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "should login an existing user and give api_token as response" do
    user = users(:one)
    process :create,
      method: :post,
      params: { email: user.email, password: 'some_password' }

    assert_response :success

    assert json_response.has_key?('api_token')
    assert json_response.has_key?('user')
    assert json_response['user'].has_key?('id')
    assert json_response['user'].has_key?('name')
    assert json_response['user'].has_key?('email')

    assert_equal CACHE.read(json_response['api_token']), user.get_cache_key
    assert_equal json_response['user']['id'], user.id
    assert_equal json_response['user']['name'], user.name
    assert_equal json_response['user']['email'], user.email
  end

  test "should not login a non existing user and give error message as response" do
    process :create,
      method: 'POST',
      params: { email: 'non_existing_user@camerastore.com', password: 'some_random_password' }

    assert_response :unauthorized

    assert json_response.has_key?('error')

    assert_equal json_response['error'], 'Email/Password does not match'
  end
end
