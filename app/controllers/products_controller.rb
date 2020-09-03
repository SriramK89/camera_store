class ProductsController < ApplicationController
  # Action method to list out all products
  def index
    render json: Product.select(:id, :name, :description, :price, :make).to_json
  end
end
