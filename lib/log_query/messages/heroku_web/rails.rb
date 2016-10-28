module Messages
  module HerokuWeb
    # 2016-10-20T17:19:51.396574+00:00 app[web.1]: Started HEAD "/" for 127.0.0.1 at 2016-10-20 17:19:51 +0000
    # 2016-10-20T17:19:51.508781+00:00 app[web.1]: Processing by HomeController#index as HTML
    # 2016-10-20T17:19:51.575265+00:00 app[web.1]: Rendered home/index.html.erb (53.0ms)
    # 2016-10-20T17:19:51.575470+00:00 app[web.1]: Completed 500 Internal Server Error in 67ms (ActiveRecord: 0.0ms)
    class Rails < MessageTypeMatcher
      source 'app'
      dyno 'web.*'

      ATTRIBUTES = {
        method: /Started ([^\s]+)/,
        route: /"([^"]+)"/,
        ip_address: /for (([0-9]{1,3}\.){4})/,
        timestamp: /at (.*)$/,
        controller: /Processing by ([^\s]+)/,
        format: /as (.*)$/,
        template: /Rendered ([^\s]+)/,
        render_time: /\(([0-9\.]+?)ms\)/,
        status: /Completed ([^\s]+)/,
        total_time: /in ([0-9\.]+)ms/,
        active_record_time: /ActiveRecord: ([0-9\.])ms/
      }

      attr_accessor *(ATTRIBUTES.keys)

      def self.attributes
        ATTRIBUTES.keys
      end

      def initialize(message)
        ATTRIBUTES.
          select { |attr, regexp| message.match(regexp) }.
          map do |attr, regexp|
            value = message.match(regexp)[0]
            value = Integer(value) rescue value
            [attr, value]
          end.each do |(key, value)|
            instance_variable_set("@#{key}", value)
          end
      end
    end
  end
end
