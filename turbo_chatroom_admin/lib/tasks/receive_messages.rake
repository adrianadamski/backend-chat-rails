namespace :app do
  desc "This task brodcast new mesage to the frontend"
  task :receive_messages => :environment do
    pooling = true

    while pooling
      messages = $redis.xread("messages", '$', block: 1000)

      unless messages.empty?
        messages['messages'].each do |message|
          message_body = JSON.parse(message.second['request'])

          Turbo::StreamsChannel.broadcast_prepend_to(:messagebox, target: 'messagebox', partial: 'messages/message', locals: {
            message: MessageParser.new.parse_single_message(message.first, message_body)
          })
        end
      end
    end
  end
end
