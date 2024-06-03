class Api::MessagesController < ActionController::Base

  skip_forgery_protection

  def hide
    message = Message.find(params[:id])
    message.update(hidden: true)
    render json: { hidden: true }
  end

end
