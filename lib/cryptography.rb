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
    puts "'quit' to quit"

    validate_mode('cryptography_main')
  end
end
