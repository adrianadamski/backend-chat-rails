class MessageParser
  def parse_messages(messages)
    response = []
    messages.each do |message|
      message_body = JSON.parse(message.second['request'])

      response.push(parse_single_message(message.first, message_body))
    end

    response
  end

  def parse_single_message(id, message)
    {
      id: id,
      body: message['body'],
      message_id: message['message_id'],
      user_id: message['user_id'],
      username: $redis.get("user:#{message['user_id']}:username"),
      is_hidden: $redis.get("message:#{message['message_id']}:hidden")
    }
  end
end
