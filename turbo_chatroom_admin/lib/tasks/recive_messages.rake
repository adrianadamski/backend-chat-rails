namespace :app do
  desc "This task brodcast new mesage to the frontend"
  task :recive_messages do
    puts "Start"

    while true
      $redis = Redis.new(url: ENV["REDIS_URL"])
      messages = $redis.xread("messages", '$', block: 1000)

      puts "Received message #{message}"
      messages.each do |message|
        ActionCable.server.broadcast("new_message", { body: "New message: #{message}." })
      end
    end
  end
end
