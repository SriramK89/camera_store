require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    process :index,
      method: :get

    assert_response :success

    assert_equal json_response.count, 2

    assert json_response.map{ |product| product["id"] }.include?(products(:one).id)
    assert json_response.map{ |product| product["id"] }.include?(products(:two).id)
  end
end
