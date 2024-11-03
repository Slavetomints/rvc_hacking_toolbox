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
      { name: 'Encrypt', value: -> { CryptographyAsciiArt.new('base64') && encrypt_base64 } },
      { name: 'Decrypt', value: -> { CryptographyAsciiArt.new('base64') && decrypt_base64 } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encrypt_base64
    puts 'Please enter your data to be encrypted'

    data = gets.chomp

    encrypted = Base64.encode64(data)

    print "\nYour result is: #{encrypted.colorize(:green)}"
    quit_or_continue(BASE64)
  end

  def decrypt_base64
    puts 'Please enter your data to be encrypted'

    data = gets.chomp

    decrypted = Base64.decode64(data)

    print "\nYour result is: #{decrypted.colorize(:green)}"
    quit_or_continue(BASE64)
  end
end
