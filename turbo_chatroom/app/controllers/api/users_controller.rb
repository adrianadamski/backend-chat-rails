class Api::UsersController < ActionController::Base

  skip_forgery_protection

  def index
    users = User.pluck(:id, :username).to_h;

    render json: users.to_json
  end
  
end
