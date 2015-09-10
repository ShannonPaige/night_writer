class NightWrite

  def self.translate_to_braille(message)
    top_line = translate_by_line(message, :top)
    middle_line = translate_by_line(message, :middle)
    bottom_line = translate_by_line(message, :bottom)
    if top_line.length < 80
      output_message = top_line + "\n" + middle_line + "\n" + bottom_line
    else
      output_message = line_limit(top_line, middle_line, bottom_line)
    end
    output_message
  end

  def self.line_limit(top_line, middle_line, bottom_line)
    output_message = ""
    top_line.length
    lines = top_line.length/80
    for x in 0..lines
      output_message << top_line[80*x..80*x+79] + "\n" + middle_line[80*x..80*x+79] + "\n" + bottom_line[80*x..80*x+79] + "\n"
    end
    output_message
  end

  def self.translate_by_line(message, position)
    line = ""
    message.length.times do |i|
      if position == :top
        line += braille_top(message[i])
      elsif position == :middle
        line += braille_middle(message[i])
      else
        line += braille_bottom(message[i])
      end
    end
    line
  end

  def self.braille_top(letter)
    case letter
    when "a", "b", "e", "h", "k", "l", "o", "r", "u", "v", "z"
      "0."
    when "i", "j", "s", "t", "w"
      ".0"
    when "c", "d", "f", "g", "m", "n", "p", "q", "x", "y"
      "00"
    when "A", "B", "E", "H", "K", "L", "O", "R", "U", "V", "Z"
      "..0."
    when "I", "J", "S", "T", "W"
      "...0"
    when "C", "D", "F", "G", "M", "N", "P", "Q", "X", "Y"
      "..00"
    else
       ".."
    end
  end

  def self.braille_middle(letter)
    case letter
    when "b", "f", "i", "l", "p", "s", "v"
      "0."
    when "d", "e", "n", "o", "y", "z"
      ".0"
    when "g", "h", "j", "q", "r", "t", "w"
      "00"
    when "a", "c", "k", "m", "u", "x"
      ".."
    when "B", "F", "I", "L", "P", "S", "V"
      "..0."
    when "D", "E", "N", "O", "Y", "Z"
      "...0"
    when "G", "H", "J", "Q", "R", "T", "W"
      "..00"
    when "A", "C", "K", "M", "U", "X"
      "...."
    else
      ".."
    end
  end

  def self.braille_bottom(letter)
    case letter
    when "k", "l", "m", "n", "o", "p", "q", "r", "s", "t"
      "0."
    when "w"
      ".0"
    when "u", "v", "x", "y", "z"
      "00"
    when "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"
      ".."
    when "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"
      ".00."
    when "W"
      ".0.0"
    when "U", "V", "X", "Y", "Z"
      ".000"
    when "A", "B", "C", "D", "E", "F", "G", "H", "I", "J"
      ".0.."
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
