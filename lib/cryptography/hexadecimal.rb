# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class holds the functions and menu for hexadecimal
class Hexadecimal < Cryptography
  def initialize
    CryptographyAsciiArt.new('hexadecimal')
    select_hex_mode
  end

  def select_hex_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'String to Hex', value: 1 },
      { name: 'Hex to String', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 5, cycle: true)

    case mode
    when 1
      CryptographyAsciiArt.new('hexadecimal')
      string_to_hex
    when 2
      CryptographyAsciiArt.new('hexadecimal')
      hex_to_string
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
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
  end
end
