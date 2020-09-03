require 'swagger_helper'

RSpec.describe 'api/user_sessions', type: :request do
  path '/user_sessions' do

    post 'Authenticates an user' do
      tags 'User Sessions'
      consumes 'application/json'
      parameter name: 'user_sessions', in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'User authenticated' do
        let(:user_sessions) { { user_sessions: { email: 'sample@email.com', password: 'sample_password' } } }
        run_test!
      end

      response '401', 'User not authenticated' do
        let(:user_sessions) { { email: 'sample@email.com' } }
        run_test!
      end
    end
  end
end
