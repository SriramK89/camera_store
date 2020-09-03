require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "can create a product object successfully" do
    product_params = {
      name: "Sample Product",
      description: "Sample Product description",
      price: 100.0,
      make: 2000
    }
    product = Product.new(product_params)

    assert product.valid?

    product.save
    assert_not product.id.nil?
  end

  test "has many carts" do
    product_obj = products(:one)

    assert product_obj.carts.first.is_a?(Cart)
    assert_equal product_obj.carts.count, 1
  end
end
