class UserSessionsController < ApplicationController
  # Action method to login a user if credentials are used rightly
  def create
    user = User.where(email: params[:email]).first
    response_msg, status = if user && user.authenticate(params[:password])
        api_token = user.get_api_token

        [{
          api_token: api_token,
          user: {
            id: user.id,
            name: user.name,
            email: user.email
          }
        }, :ok]
      else
        [{
          error: "Email/Password does not match"
        }, :unauthorized]
      end

    render json: response_msg, status: status
  end
end
