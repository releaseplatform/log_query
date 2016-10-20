module Messages
  class MessageTypeMatcher
    class << self
      attr_accessor :source, :dyno

     def source(source)
       @source = source
     end

     def dyno(dyno)
       @dyno = dyno
     end
    end

    def self.===((source, dyno))
      source.match("^#{@source}$") and dyno.match("^#{dyno}$")
    end
  end
end
