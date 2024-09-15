# frozen_string_literal: true

require 'base64'
require 'colorize'
require 'tty-prompt'
require_relative '../ascii_art'
require_relative 'cryptography'

# This class houses the Base64 functions
class BASE64 < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_base64_mode
  end

  def select_base64_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode', value: 1 },
      { name: 'Decode', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      encode_base64
    when 2
      clear_terminal
      show_cryptography
      decode_base64
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encode_base64
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    encoded = Base64.encode64(data)

    print "\nYour result is: "
    puts encoded.colorize(:green)

    quit_or_continue
  end

  def decode_base64
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    decoded = Base64.decode64(data)

    print "\nYour result is: "
    puts decoded.colorize(:green)

    quit_or_continue
  end
end
