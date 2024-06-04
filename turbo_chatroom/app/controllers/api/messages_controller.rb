class Api::MessagesController < ActionController::Base

  skip_forgery_protection
  http_basic_authenticate_with(
    name: "api",
    password: ENV.fetch('API_TOKEN')
  )

  def hide
    message = Message.find(params[:id])
    message.update(hidden: true)
    render json: { hidden: true }
  end

end
