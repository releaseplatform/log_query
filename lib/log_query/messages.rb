require_relative './messages/heroku_router'

module Messages
  def self.resolve_message(source, dyno)
    case [source, dyno]
    when HerokuRouter
      HerokuRouter
    else
      String
    end
  end
end
