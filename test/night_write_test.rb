require "night_write"

class NightWriteTest < MiniTest::Test

  # def test_accepts_a_message_file_from_the_command_line
  #   skip
  # end
  #
  # def test_accepts_an_output_file_fromt_the_command_line
  #   skip
  # end

  def test_reads_the_file_message_into_a_variable
    sample = File.read("test_message.txt")
    assert_equal "hello world\n", sample
    assert_equal 12, sample.length
  end

  def test_translates_the_message_into_the_top_line_of_braille
    sample = "a"
    assert_equal "0.", NightWrite.braille_top("a")
  end

  def test_translates_the_message_into_the_middle_line_of_baraille
    skip
  end

  def test_translates_the_message_into_the_bottom_line_of_braille
    skip
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








  def test_accepts_a_file_from_the_command_line
    skip
    project_root = File.expand_path("..", __dir__)
    Dir.chdir project_root do
      printed = `ruby ./lib/night_write.rb message.txt braille.txt`
      message = File.read(ARGV[0])
      braille = File.open(ARGV[1], 'w')
      top_line = NightWrite.translate(message, :top)
      middle_line = NightWrite.translate(message, :middle)
      bottom_line = NightWrite.translate(message, :bottom)
      output_message = top_line + "\n" + middle_line + "\n" + bottom_line
      assert_equal "Created braille.txt containing #{message.length} characters\n", printed
      assert $?.success?
    end
  end

  def test_accepts_it_can_read_a_single_file
        skip
    sample = File.read("message.txt")
    assert_equal "hello wow\n\nwow\n", sample
    assert_equal 15, sample.length
  end

  def test_it_can_output_a_file_with_the_same_content_of_message_dot_txt
        skip
    handle = File.read("message.txt")
    writer = File.open("test.txt", "w")
    writer.write(handle)
    writer.close

    assert_equal "hello wow\n\nwow\n", File.read("test.txt")
  end

end
