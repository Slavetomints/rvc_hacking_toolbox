# frozen_string_literal: true

require 'base32'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class contains the functions for the Base32 class
class BASE32 < Cryptography
  def initialize
    CryptographyAsciiArt.new('base32')
    select_base_32_mode
  end

  def select_base_32_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt', value: -> { CryptographyAsciiArt.new('base32') && encode_base32 } },
      { name: 'Decrypt', value: -> { CryptographyAsciiArt.new('base32') && decode_base32 } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encode_base32
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    encoded = Base32.encode(data)

    print "\nYour result is: #{encoded.colorize(:green)}"
    quit_or_continue(BASE32)
  end

  def decode_base32
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    decoded = Base32.decode(data)

    print "\nYour result is: #{decoded.colorize(:green)}"
    quit_or_continue(BASE32)
  end
end
