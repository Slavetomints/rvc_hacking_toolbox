# frozen_string_literal: true

require_relative '../main_menu'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the A1Z26 cipher
class A1Z26 < Cryptography
  def initialize
    CryptographyAsciiArt.new('a1z26')
    select_a1z26_mode
  end

  def select_a1z26_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode string', value: 1 },
      { name: 'Decode string', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 5, cycle: true)

    case mode
    when 1
      CryptographyAsciiArt.new('a1z26')
      encode_a1z26
    when 2
      CryptographyAsciiArt.new('a1z26')
      decode_a1z26
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
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

    print "\n Your result is: "
    puts "\n#{char_arr.join(',').colorize(:green)}"

    quit_or_continue(A1Z26)
  end
end
