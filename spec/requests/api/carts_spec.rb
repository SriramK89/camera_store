require 'swagger_helper'

RSpec.describe 'api/carts', type: :request do
  path '/carts' do

    post 'Creates a cart with logged-in user' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :api_token, :in => :header, schema: {
        type: :object,
        properties: {
          Authorization: { type: :string }
        },
        required: ['Authorization']
      }
      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          quantity: { type: :integer },
          product_id: { type: :integer }
        },
        required: [ 'quantity', 'product_id' ]
      }

      response '200', 'Cart created' do
        run_test!
      end

      response '404', 'Product not found' do
        run_test!
      end
    end
  end

  path '/carts' do

    get 'Displays the cart items with logged-in user' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: 'Authorization', :in => :header, :type => :string

      response '200', 'Cart items displayed' do
        run_test!
      end
    end
  end
end
