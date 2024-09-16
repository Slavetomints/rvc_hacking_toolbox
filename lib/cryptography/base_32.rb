# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require 'base32'
require_relative 'cryptography'

# This class contains the functions for the Base32 class
class BASE32 < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_base_32_mode
  end

  def select_base_32_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt', value: 1 },
      { name: 'Decrypt', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      encode_base32
    when 2
      clear_terminal
      show_cryptography
      decode_base32
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encode_base32
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    encoded = Base32.encode(data)

    print "\nYour result is: "
    puts encoded.colorize(:green)

    quit_or_continue(BASE32)
  end

  def decode_base32
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    decoded = Base32.decode(data)

    print "\nYour result is: "
    puts decoded.colorize(:green)

    quit_or_continue(BASE32)
  end
end
