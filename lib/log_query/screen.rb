class Screen
  def initialize
    @old_lines = []
    @new_lines = []
    @current_line = 0
  end

  def line(value)
    @new_lines << value
  end

  def move_to(row)
    #puts "moving to #{row}"
    #puts "current line #{@current_line}"
    diff = row - @current_line
    if diff > 0
      #puts "moving down #{diff.abs}"
      @buffer += "\e[#{diff.abs}B"
    elsif diff < 0
      #puts "moving up #{diff.abs}"
      @buffer += "\e[#{diff.abs}A"
    end
    @current_line += diff
  end

  def delete_current_line
    @buffer += "\e[2K"
  end

  def print_line(line)
    @buffer += "#{line}\n"
    @current_line += 1
  end

  def draw
    @buffer = ""
    # pad line buffers
    line_count = [@old_lines.size, @new_lines.size].max
    @old_lines.fill(nil, @old_lines.size, line_count) if @old_lines.size < line_count
    @new_lines.fill(nil, @new_lines.size, line_count) if @new_lines.size < line_count

    @old_lines.zip(@new_lines).each_with_index do |(old, new), index|
      if old != new
        move_to(index)
        delete_current_line
        print_line(new) 
      end
    end
    @old_lines = @new_lines
    @new_lines = []
    print @buffer
  end
end
