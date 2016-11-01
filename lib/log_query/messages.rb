require_relative './messages/heroku_router'
require_relative './messages/heroku_web/rails'

module Messages
  def self.class_from_attributes(attrs)
    [HerokuRouter, HerokuWeb::Rails].select do |klass|
      attrs.map(&:to_sym).all? { |a| klass.attributes.include?(a) }
    end
  end

  def self.resolve_message(source, dyno)
    case [source, dyno]
    when HerokuWeb::Rails
      HerokuWeb::Rails
    when HerokuRouter
      HerokuRouter
    else
      String
    end
  end

  # A wrapper for native string class
  class String < String
    def self.attributes
      []
    end
  end
end
