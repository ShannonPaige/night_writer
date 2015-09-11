class NightWrite

  def self.translate_to_braille(message)
    top_line = translate_by_line(message, "top")
    middle_line = translate_by_line(message, "middle")
    bottom_line = translate_by_line(message, "bottom")
    compile_lines(top_line, middle_line, bottom_line)
  end

  def self.compile_lines(top_line, middle_line, bottom_line)
    if top_line.length < 80
      output_message = top_line + "\n" + middle_line + "\n" + bottom_line
    else
      output_message = line_limit(top_line, middle_line, bottom_line)
    end
  end

  def self.line_limit(top_line, middle_line, bottom_line)
    output_message = ""
    lines = top_line.length/80
    for x in 0..lines
      output_message << top_line[80*x..80*x+79] + "\n" + middle_line[80*x..80*x+79] + "\n" + bottom_line[80*x..80*x+79] + "\n"
    end
    output_message
  end

  def self.translate_by_line(message, position)
    line = ""
    message.length.times do |i|
      if position == "top"
        line += braille_top(message[i])
      elsif position == "middle"
        line += braille_middle(message[i])
      else
        line += braille_bottom(message[i])
      end
    end
    line
  end

  def self.braille_top(letter)
    line = letter.upcase == letter ? ".." : ""
    case letter.downcase
    when "a", "b", "e", "h", "k", "l", "o", "r", "u", "v", "z"
      line += "0."
    when "i", "j", "s", "t", "w"
      line += ".0"
    when "c", "d", "f", "g", "m", "n", "p", "q", "x", "y"
      line += "00"
    else
       ".."
    end
  end

  def self.braille_middle(letter)
    line = letter.upcase == letter ? ".." : ""
    case letter.downcase
    when "b", "f", "i", "l", "p", "s", "v"
      line += "0."
    when "d", "e", "n", "o", "y", "z"
      line += ".0"
    when "g", "h", "j", "q", "r", "t", "w"
      line += "00"
    when "a", "c", "k", "m", "u", "x"
      line += ".."
    else
      ".."
    end
  end

  def self.braille_bottom(letter)
    line = letter.upcase == letter ? ".0" : ""
    case letter.downcase
    when "k", "l", "m", "n", "o", "p", "q", "r", "s", "t"
      line += "0."
    when "w"
      line += ".0"
    when "u", "v", "x", "y", "z"
      line += "00"
    when "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"
      line += ".."
    else
      ".."
    end
  end
end

if $PROGRAM_NAME == __FILE__
  message = File.read(ARGV[0])
  braille = File.open(ARGV[1], 'w')
  output_message = NightWrite.translate_to_braille(message)
  braille.write(output_message)
  puts "Created #{ARGV[1]} containing #{output_message.length} characters"
end
