require "night_write"

class NightWriteTest < MiniTest::Test

  def test_reads_the_file_message_into_a_variable
    sample = File.read("test_message.txt")
    assert_equal "hello world\n", sample
    assert_equal 12, sample.length
  end

  def test_translates_the_message_into_the_top_line_of_braille
    assert_equal "0.", NightWrite.braille_top("a")
    assert_equal "..0.", NightWrite.braille_top("A")
  end

  def test_translates_the_message_into_the_middle_line_of_baraille
    assert_equal "..", NightWrite.braille_middle("a")
    assert_equal "....", NightWrite.braille_middle("A")
  end

  def test_translates_the_message_into_the_bottom_line_of_braille
    assert_equal "..", NightWrite.braille_bottom("a")
    assert_equal ".0..", NightWrite.braille_bottom("A")
  end

  def test_outputs_the_correct_braille_translation
    message = "abcdefghijklmnopqrstuvwxyz "
    assert_equal "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0..\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000..", NightWrite.translate_to_braille(message)
    message = message.upcase
    assert_equal "..0...0...00..00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0\n......0........0...0..0...00..00..0...00......0........0...0..0...00..00..0...00\n.0...0...0...0...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00.\n..0...0....0..00..00..0...\n......0...00.......0...0..\n.000.000.0.0.000.000.000..\n", NightWrite.translate_to_braille(message)
  end

  def test_splits_the_message_into_lines_of_80_characters_each
    sample = NightWrite.translate_to_braille("my name is shannon and i am learning to code")
    assert_equal 80, sample.lines[0].chomp.chars.count
    assert_equal 80, sample.lines[1].chomp.chars.count
    assert_equal 80, sample.lines[2].chomp.chars.count
  end

  def test_spaces_are_used_in_place_of_unsupported_characters_in_the_message
    sample = NightWrite.translate_to_braille("!")
    assert_equal "..\n..\n..", sample
  end

  def test_it_can_output_a_file_with_the_same_content_of_message_dot_txt
    handle = File.read("test_message.txt")
    writer = File.open("test_output.txt", "w")
    writer.write(handle)
    writer.close
    assert_equal "hello world\n", File.read("test_output.txt")
  end
end
