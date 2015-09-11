class NightRead
  def self.translate_to_english(message)
    message_array = message.split("\n")
    number_of_lines = message_array.size / 3
    nonbraille = ''
    number_of_lines.times do |i|
      line = [message_array[3 * i], message_array[3 * i + 1], message_array[3 * i + 2]]
      nonbraille << translate_line(line)
    end
    add_in_capitals(nonbraille)
  end

  def self.translate_line(line)
    message_size = line[0].length
    nonbraille = ''
    for i in 0...message_size / 2
      letter = grab_the_letter(line, i)
      nonbraille += letter
    end
    nonbraille
  end

  def self.grab_the_letter(message_array, i)
    top_array = []
    middle_array = []
    bottom_array = []
    letter = ''
    message_array.each_index do |index|
      if index % 3 == 0
        top_array << braille_top(message_array[0][2 * i..2 * i + 1])
      elsif (index - 1) % 3 == 0
        middle_array << braille_middle(message_array[1][2 * i..2 * i + 1])
      else
        bottom_array << braille_bottom(message_array[2][2 * i..2 * i + 1])
      end
      letter = top_array.flatten & middle_array.flatten & bottom_array.flatten
    end
    letter[0]
  end

  def self.add_in_capitals(nonbraille)
    nonbraille.gsub!(/\^\D/, &:upcase)
    nonbraille.gsub!(/\^/, "")
    nonbraille
  end

  def self.braille_top(letter)
    case letter
    when "0."
      ["a", "b", "e", "h", "k", "l", "o", "r", "u", "v", "z"]
    when ".0"
      ["i", "j", "s", "t", "w"]
    when "00"
      ["c", "d", "f", "g", "m", "n", "p", "q", "x", "y"]
    else
      ["^", " "]
    end
  end

  def self.braille_middle(letter)
    case letter
    when "0."
      ["b", "f", "i", "l", "p", "s", "v"]
    when ".0"
      ["d", "e", "n", "o", "y", "z"]
    when "00"
      ["g", "h", "j", "q", "r", "t", "w"]
    else
      ["a", "c", "k", "m", "u", "x", "^", " "]
    end
  end

  def self.braille_bottom(letter)
    case letter
    when "0."
      ["k", "l", "m", "n", "o", "p", "q", "r", "s", "t"]
    when ".0"
      ["w", "^"]
    when "00"
      ["u", "v", "x", "y", "z"]
    else
      ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", " "]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  message = File.read(ARGV[0])
  output_message = File.open(ARGV[1], 'w')
  output_message_from_braille = NightRead.translate_to_english(message)
  output_message.write(output_message_from_braille)
  puts "Created #{ARGV[1]} containing #{output_message_from_braille.length} characters"
end
