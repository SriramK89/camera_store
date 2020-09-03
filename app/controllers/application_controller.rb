class ApplicationController < ActionController::API
  # Function to validate if a proper user is using the API end point
  def validate_user
    @current_user = User.get_from_api_token(request.headers['Authorization'])
    render_invalid_user if @current_user.nil?
  end

  # Function to fetch the logged user instance
  def current_user
    @current_user
  end

  # Function to provide response as invalid user
  def render_invalid_user
    render json: { error: "Invalid API token" }, status: :unauthorized
  end
end
