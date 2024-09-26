# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the A1Z26 cipher
class A1Z26 < Cryptography
  def initialize
    CryptographyAsciiArt.new('a1z26')
    select_a1z26_mode
  end

  def select_a1z26_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode string', value: -> { CryptographyAsciiArt.new('a1z26') && encode_a1z26 } },
      { name: 'Decode string', value: -> { CryptographyAsciiArt.new('a1z26') && decode_a1z26 } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def decode_a1z26
    puts 'Please enter only numbers seperated by a comma'

    num_arr = gets.chomp.split(',').map { |number| number.to_i + 96 }
    decoded_chars = num_arr.map(&:chr)

    print "\n Your result is: "
    puts "\n#{decoded_chars.join.colorize(:green)}"

    quit_or_continue(A1Z26)
  end

  def encode_a1z26
    puts 'Please enter only letters with no spaces'

    char_arr = gets.chomp.downcase.chars.map { |character| character.ord - 96 }

    print "\n Your result is: #{char_arr.join(',').colorize(:green)}"
    quit_or_continue(A1Z26)
  end
end
