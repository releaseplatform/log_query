require_relative './messages'

class LogEntry
  attr_accessor :timestamp, :source, :dyno, :message

  LOG_PARSER = /^(?<timestamp>[^\s]+) (?<source>[^\[]+)\[(?<dyno>[^\]]+)\]: (?<message>.*)$/

  def self.from_heroku_log_line(line)
    matches = line.match(LOG_PARSER)
    new(matches[:timestamp], matches[:source], matches[:dyno], matches[:message])
  end

  def initialize(timestamp, source, dyno, message)
    @timestamp, @source, @dyno = timestamp, source, dyno
    @message = Messages.resolve_message(source, dyno).new(message)
  end
end
