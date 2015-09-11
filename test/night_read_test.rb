require "night_read"

class NightReadTest < MiniTest::Test

  def test_reads_the_file_message_into_a_variable
    sample = File.read("test_message.txt")
    assert_equal "hello world\n", sample
    assert_equal 12, sample.length
  end

  def test_outputs_the_correct_non_braille_translation
    message = "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0..\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000.."
    assert_equal "abcdefghijklmnopqrstuvwxyz ", NightRead.translate_to_english(message)
    message = "..0...0...00..00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0\n......0........0...0..0...00..00..0...00......0........0...0..0...00..00..0...00\n.0...0...0...0...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00.\n..0...0....0..00..00..0...\n......0...00.......0...0..\n.000.000.0.0.000.000.000..\n"
    assert_equal "ABCDEFGHIJKLMNOPQRSTUVWXYZ ", NightRead.translate_to_english(message)
  end

  def test_unsupported_characters_in_the_braille_message_arent_translated
    sample = NightRead.translate_to_english("!\n!\n!")
    assert_equal "", sample
  end

  def test_it_can_output_a_file_with_the_same_content_of_test_message_dot_txt
    handle = File.read("test_message.txt")
    writer = File.open("test_output.txt", "w")
    writer.write(handle)
    writer.close
    assert_equal "hello world\n", File.read("test_output.txt")
  end
end
