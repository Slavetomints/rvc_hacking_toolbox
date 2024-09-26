# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class holds the functions and menu for hexadecimal
class Hexadecimal < Cryptography
  def initialize
    CryptographyAsciiArt.new('hexadecimal')
    select_hex_mode
  end

  def select_hex_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'String to Hex', value: -> { CryptographyAsciiArt.new('hexadecimal') && string_to_hex } },
      { name: 'Hex to String', value: -> { CryptographyAsciiArt.new('hexadecimal') && hex_to_string } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def string_to_hex
    puts 'Please enter your string to be converted'
    string = gets.chomp

    hex_string = string.chars.map { |char| format('%x', char.ord) }.join(' ')

    puts "\nYour result is: #{hex_string.colorize(:green)}"
    quit_or_continue(Hexadecimal)
  end

  def hex_to_string
    puts 'Please enter hexadecimal(Base16) digits seperated by spaces'
    hex_string = gets.chomp

    string = hex_string.split.map { |hex| hex.to_i(16).chr }.join

    puts "\nYour result is: #{string.colorize(:green)}"
    quit_or_continue(Hexadecimal)
  end
end
