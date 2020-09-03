require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  def api_token_setup
    @api_token = 'testToken'
    @user = users(:one)
    CACHE.write(@api_token, @user.get_cache_key, expires_in: 1.minute)
  end

  test "should create a cart successfully with an existing product" do
    api_token_setup
    product = products(:one)
    quantity = 3

    @request.headers['Authorization'] = @api_token
    process :create,
      method: :post,
      params: { product_id: product.id, quantity: quantity }

    assert_response :success

    assert json_response.has_key?('id')
    assert json_response.has_key?('product_id')
    assert json_response.has_key?('quantity')

    assert_equal json_response['id'], Cart.last.id
    assert_equal json_response['product_id'], product.id
    assert_equal json_response['quantity'], quantity

    CACHE.delete(@api_token)
  end

  test "should throw invalid api token as error when unauthorized user tries to hit the create API end point" do
    process :create,
      method: :post

    assert_response :unauthorized

    assert json_response.has_key?('error')

    assert_equal json_response['error'], 'Invalid API token'
  end

  test "should display all carts of the user" do
    api_token_setup

    @request.headers['Authorization'] = @api_token
    process :index,
      method: :get

    assert_response :success

    assert json_response.has_key?('carts')

    carts = JSON.parse(json_response['carts'])
    assert_equal carts.count, 1

    assert carts[0].has_key?('id')
    assert carts[0].has_key?('product_id')
    assert carts[0].has_key?('quantity')

    assert_equal carts[0]['id'], @user.carts[0].id
    assert_equal carts[0]['product_id'], @user.carts[0].product_id
    assert_equal carts[0]['quantity'], @user.carts[0].quantity
  end

  test "should throw invalid api token as error when unauthorized user tries to hit the index API end point" do
    process :index,
      method: :post

    assert_response :unauthorized

    assert json_response.has_key?('error')

    assert_equal json_response['error'], 'Invalid API token'
  end
end
