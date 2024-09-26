# frozen_string_literal: true

require 'telegraph'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the MorseCode cipher
class MorseCode < Cryptography
  def initialize
    CryptographyAsciiArt.new('morse')
    select_morse_mode
  end

  def select_morse_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode', value: -> { CryptographyAsciiArt.new('morse') && encode_morse_code } },
      { name: 'Decode', value: -> { CryptographyAsciiArt.new('morse') && decode_morse_code } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encode_morse_code
    puts 'Please enter your message to be encoded'

    plaintext = gets.chomp

    ciphertext = Telegraph.text_to_morse(plaintext)

    print "\nYour result is: #{ciphertext.colorize(:green)}"
    quit_or_continue(MorseCode)
  end

  def decode_morse_code
    puts 'Please enter your message to be decoded, seperate letters by spaces and words by 7 spaces'

    ciphertext = gets.chomp

    plaintext = Telegraph.morse_to_text(ciphertext)

    print "\nYour result is: #{plaintext.colorize(:green)}"
    quit_or_continue(MorseCode)
  end
end
