# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class contains the functions to the Decimal class
class Decimal < Cryptography
  def initialize
    CryptographyAsciiArt.new('decimal')
    select_decimal_mode
  end

  def select_decimal_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode string', value: -> { CryptographyAsciiArt.new('decimal') && encode_decimal } },
      { name: 'Decode string', value: -> { CryptographyAsciiArt.new('decimal') && decode_decimal } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encode_decimal
    puts 'Please enter the string you wish to have encoded'

    str_arr = gets.chomp.chars.map(&:ord)
    print "\nYour result is: "
    puts str_arr.join(' ').colorize(:green)

    quit_or_continue(Decimal)
  end

  def decode_decimal
    puts 'Please enter what you wish to decode separated by spaces'

    num_arr = gets.chomp.split(' ').map { |num| Integer(num).chr }
    print "\nYour result is: #{num_arr.join.colorize(:green)}"

    quit_or_continue(Decimal)
  end
end
