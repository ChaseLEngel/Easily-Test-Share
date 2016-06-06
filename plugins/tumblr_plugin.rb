require 'tumblr_client'
require_relative '../config.rb'

# Interact with Tumblr API
class TumblrPlugin

  SOCIAL_NAME = :tumblr

  CONFIG_ATTR = [:username, :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret]

  def initialize(config)
    Config::validate config, SOCIAL_NAME, CONFIG_ATTR
    Config::define_attributes config[SOCIAL_NAME], self, CONFIG_ATTR
    @client = setup_api
  end

  def check
    @client.posts("#{@username}.tumblr.com", limit: 1)['posts'].first['summary']
  end

  private
  def setup_api
    Tumblr::Client.new({
      consumer_key: @consumer_key,
      consumer_secret: @consumer_secret,
      oauth_token: @oauth_token,
      oauth_token_secret: @oauth_token_secret
    })
  end
end
