class CartsController < ApplicationController
  before_action :validate_user

  # Action method to create a cart for a logged in user
  def create
    product = Product.where(id: params[:product_id]).select(:id).first
    if product
      cart = current_user.carts.create(product_id: params[:product_id], quantity: params[:quantity])
      render json: { id: cart.id, product_id: cart.product_id, quantity: cart.quantity }
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  # Action method to list out the cart items of a logged in user
  def index
    render json: { carts: current_user.carts.select(:id, :product_id, :quantity).to_json }
  end
end
