require 'twitter'
require_relative '../config.rb'

# Interact with Twitter API
class TwitterPlugin

  SOCIAL_NAME = :twitter

  CONFIG_ATTR = [:username, :consumer_key, :consumer_secret, :access_token, :access_token_secret]

  def initialize(config)
    Config::validate config, SOCIAL_NAME, CONFIG_ATTR
    Config::define_attributes config[SOCIAL_NAME], self, CONFIG_ATTR
    @client = setup_api
  end

  def check
    @client.user_timeline(@username).first.text
  end

  private
  def setup_api
    Twitter::REST::Client.new do |config|
      config.consumer_key        = @consumer_key
      config.consumer_secret     = @consumer_secret
      config.access_token        = @access_token
      config.access_token_secret = @access_token_secret
    end
  end

end
