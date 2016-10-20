class Screen
  def initialize
    @buffer = ""
    @lines = 0
  end

  def line(value)
    @buffer += "#{value}\n"
    @lines += 1
  end

  def reset
    @buffer = "\e[K\e[1A" * [0, @lines].max
    @lines = 0
  end

  def draw
    print @buffer
  end
end
