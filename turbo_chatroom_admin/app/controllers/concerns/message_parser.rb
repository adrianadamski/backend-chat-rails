module MessageParser
  extend ActiveSupport::Concern
  API_URL = ENV.fetch('API_URL')
  API_TOKEN = ENV.fetch('API_TOKEN')

  def parse_messages(messages)
    response = []
    messages.each do |message|
      message_body = JSON.parse(message.second['request'])

      response.push({
                   id: message.first,
                   body: message_body['body'],
                   message_id: message_body['message_id'],
                   user_id: message_body['user_id'],

                   is_hidden: $redis.get("message:#{message_body['message_id']}:hidden")
                 })
    end

    response
  end
end
