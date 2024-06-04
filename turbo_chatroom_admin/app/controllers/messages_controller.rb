class MessagesController < ApplicationController
  include MessageParser
  API_URL = ENV.fetch('API_URL')
  API_TOKEN = ENV.fetch('API_TOKEN')

  def index
    last = params[:last]
    if last.blank?
      last = '+'
    else
      last = '(' + params[:last]
    end

    @messages = $redis.xrevrange('messages', last, '-', count: 5)
    @messages = parse_messages(@messages)
    @users = get_message_users(@messages)
  end

  def hide
    response = HTTP.basic_auth(:user => "api", :pass => API_TOKEN)
                   .post("#{API_URL}/api/messages/#{params[:id]}/hide")

    if response.status.success?
      $redis.set("message:#{params[:id]}:hidden", true)
    end

    redirect_back(fallback_location: root_path)
  end

  private
  def get_message_users(messages)
    uids = messages.map {|m| m[:user_id]}.uniq

    response = {}
    uids.each do |uid|
      response[uid] = $redis.get("user:#{uid}:username")
    end

    response
  end
end
