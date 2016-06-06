require 'google_plus'
require_relative '../config.rb'

# Interact with Google+ API
class GooglePlusPlugin

  SOCIAL_NAME = :googleplus

  CONFIG_ATTR = [:username, :api_key]

  def initialize(config)
    Config::validate config, SOCIAL_NAME, CONFIG_ATTR
    Config::define_attributes config[SOCIAL_NAME], self, CONFIG_ATTR
    @client = setup_api
  end

  def check
    GooglePlus::Person.search(@username)
                      .items
                      .first
                      .list_activities
                      .items
                      .first
                      .title
  end

  private
  def setup_api
    GooglePlus.api_key = @api_key
  end

end
