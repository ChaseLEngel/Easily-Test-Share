module Config
  NoConfig = Class.new(StandardError)
  MissingConfigAttribute = Class.new(StandardError)

  def self.define_attributes(config, klass, attributes)
    attributes.each do |attribute|
      klass.instance_variable_set ('@' + attribute.to_s).to_sym, config[attribute]
    end
  end

  def self.validate(config, social_name, attributes)
    raise NoConfig, social_name unless config.key? social_name
    attributes.each do |attribute|
      unless config[social_name].key? attribute
        raise MissingConfigAttribute, attribute
      end
    end
  end
end
