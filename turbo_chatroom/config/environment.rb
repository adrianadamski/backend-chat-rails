# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!


$redis = Redis.new(url: ENV["REDIS_URL"])
