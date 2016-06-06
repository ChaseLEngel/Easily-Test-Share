require 'yaml'
require_relative 'config.rb'

config = YAML.load_file('config.yml')

# Require all social media plugins.
klassnames = Dir[__dir__ + '/plugins/*_plugin.rb'].map do |file|
  require file
  File.basename(file).chomp!('.rb').split('_').map(&:capitalize).join
end

# Initialize social media classes.
klasses = []
klassnames.each do |klassname|
  klass = Object.const_get(klassname)
  begin
    klasses << klass.new(config)
  rescue Config::NoConfig
    next
  end
end

# Check for social media messages
klasses.each do |klass|
  puts klass.check
end
