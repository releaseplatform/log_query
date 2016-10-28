require_relative './messages/heroku_router'
require_relative './messages/heroku_web/rails'

module Messages
  def self.class_from_attribute(attr)
    [HerokuRouter, HerokuWeb::Rails].select do |klass|
      klass.attributes.include?(attr.to_sym)
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
