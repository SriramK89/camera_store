require 'swagger_helper'

RSpec.describe 'api/products', type: :request do
   path '/' do

    get 'Fetches all products' do
      tags 'Products'
      consumes 'application/json'

      response '200', 'Products fetched' do
        run_test!
      end
    end
  end
end
