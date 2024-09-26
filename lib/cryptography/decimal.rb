# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class contains the functions to the Decimal class
class Decimal < Cryptography
  def initialize
    CryptographyAsciiArt.new('decimal')
    select_decimal_mode
  end

  def select_decimal_mode # rubocop:disable Metrics/MethodLength
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
      CryptographyAsciiArt.new('decimal')
      encode_decimal
    when 2
      CryptographyAsciiArt.new('decimal')
      decode_decimal
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encode_decimal
    puts 'Please enter the string you wish to have encoded'

    str_arr = gets.chomp.chars.map(&:ord)
    print "\nYour result is: "
    puts str_arr.join(' ').colorize(:green)

    quit_or_continue(Decimal)
  end

  def decode_decimal
    puts 'Please enter what you wish to decode seperated by commas'

    num_arr = gets.chomp.split(',').map { |num| Integer(num).chr }
    print "\nYour result is: "
    puts num_arr.join.colorize(:green)

    quit_or_continue(Decimal)
  end
end
