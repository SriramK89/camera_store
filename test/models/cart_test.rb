require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "can create a cart object successfully" do
    cart_params = {
      user: users(:one),
      product: products(:one),
      quantity: 10
    }
    cart = Cart.new(cart_params)

    assert cart.valid?

    cart.save
    assert_not cart.id.nil?
  end

  test "belongs to user" do
    cart_obj = carts(:one)

    assert cart_obj.user.is_a?(User)
  end

  test "belongs to product" do
    cart_obj = carts(:one)

    assert cart_obj.product.is_a?(Product)
  end
end
