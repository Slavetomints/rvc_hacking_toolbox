# frozen_string_literal: true

require 'base64'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class houses the Base64 functions
class BASE64 < Cryptography
  def initialize
    CryptographyAsciiArt.new('base64')
    select_base64_mode
  end

  def select_base64_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode', value: -> { CryptographyAsciiArt.new('base64') && encode_base64 } },
      { name: 'Decode', value: -> { CryptographyAsciiArt.new('base64') && decode_base64 } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encode_base64
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    encoded = Base64.encode64(data)

    print "\nYour result is: #{encoded.colorize(:green)}"
    quit_or_continue(BASE64)
  end

  def decode_base64
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    decoded = Base64.decode64(data)

    print "\nYour result is: #{decoded.colorize(:green)}"
    quit_or_continue(BASE64)
  end
end
