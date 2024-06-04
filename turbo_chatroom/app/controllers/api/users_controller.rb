class Api::UsersController < ActionController::Base

  skip_forgery_protection
  http_basic_authenticate_with(
    name: "api",
    password: ENV.fetch('API_TOKEN')
  )

  def index
    users = User.pluck(:id, :username).to_h;
    render json: users.to_json
  end
  
end
