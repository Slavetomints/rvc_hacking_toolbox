# frozen_string_literal: true

require 'colorize'
require 'telegraph'
require 'tty-prompt'
require_relative 'cryptography'

# This class runs the 3456543646346536 cipher
class MorseCode < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_morse_mode
  end

  def select_morse_mode # rubocop:disable Metrics/MethodLength
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
      encode_morse_code
    when 2
      clear_terminal
      show_cryptography
      decode_morse_code
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encode_morse_code
    puts 'Please enter your message to be encoded'

    plaintext = gets.chomp

    ciphertext = Telegraph.text_to_morse(plaintext)
    print "\nYour result is: "
    puts ciphertext.colorize(:green)

    quit_or_continue(MorseCode)
  end

  def decode_morse_code
    puts 'Please enter your message to be decoded, seperate letters by spaces and words by 7 spaces'

    ciphertext = gets.chomp

    plaintext = Telegraph.morse_to_text(ciphertext)
    print "\nYour result is: "
    puts plaintext.colorize(:green)

    quit_or_continue(MorseCode)
  end
end
