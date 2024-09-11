# frozen_string_literal: true

require 'colorize'
require_relative 'special_functions'
require_relative 'ascii_art'

# houses the cryptography functions
module Cryptography
  def self.load_menu
    show_cryptography

    puts '1 - Base 64       7 - Rail Fence'
    puts '2 - Base32        8 - Atbash'
    puts '3 - Binary        9 - Morse'
    puts '4 - Decimal       10 - Vigenère'
    puts '5 - Hexadecimal   11 - RSA'
    puts '6 - Ceaser        12 - A1Z26'
    puts "'quit' to quit    'main' to go to main menu"

    select_mode
  end

  def select_mode # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
    mode = validate_mode('cryptography_main')

    case mode
    whesn '1'
    when '2'
    when '3'
    when '4'
    when '5'
    when '6'
    when '7'
    when '8'
    when '9'
    when '10'
    when '11'
    when '12'
    when 'quit'
    when 'main'
    end
  end
end
