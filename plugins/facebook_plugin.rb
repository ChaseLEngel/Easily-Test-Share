require_relative '../config.rb'

# Interact with Facebook API
class FacebookPlugin

  SOCIAL_NAME = :facebook

  CONFIG_ATTR = [:username, :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret]

  def initialize(config)
    Config::validate config, SOCIAL_NAME, CONFIG_ATTR
    Config::define_attributes config[SOCIAL_NAME]
    @client = setup_api
  end

  def check
  end

  private
  def setup_api
  end
end
