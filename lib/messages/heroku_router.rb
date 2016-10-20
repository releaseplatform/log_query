require_relative './message_type_matcher'

module Messages
  class HerokuRouter < MessageTypeMatcher
    source 'heroku'
    dyno 'router'

    # 2016-10-12T11:54:02.902066+00:00 heroku[router]: at=info method=GET path="/javascript/popup.js?email=graham.dodgson@gmail.com&locale=UK&name=Graham%20Dodgson" host=merrell.refer.gift request_id=bf7a23e0-3c5c-4df2-9eff-f7812d96f665 fwd="62.252.0.138" dyno=web.1 connect=0ms service=126ms status=200 bytes=1414
    ATTRIBUTES = [:sock, :at, :code, :desc, :method, :path, :host, :request_id, :fwd, :dyno, :connect, :service, :status, :bytes]
    attr_accessor *ATTRIBUTES

    def initialize(message)
      ATTRIBUTES.
        select { |attr| message.include?(" #{attr}=") }.
        map do |attribute|
          value = message.match(/#{attribute}=([^\s]*|"[^"]*")/)[1]
          value = value.match(/"?([^"]*)"?/)[1]
          value = parse_value(value, attribute)
          [attribute, value]
        end.each do |(key, value)|
          instance_variable_set("@#{key}", value)
        end
    end

    def parse_value(value, attribute)
      case attribute
      when :sock, :at, :code, :desc, :method, :host, :request_id, :fwd, :dyno, :status
        value
      when :path
        value.split('?')[0]
      when :connect, :service
        Integer(value.match(/([0-9]*)ms/)[1])
      when :bytes
        Integer(value) rescue 0
      end
    end
  end
end
