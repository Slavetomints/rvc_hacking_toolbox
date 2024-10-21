# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the binary functions and menu
class Binary < Cryptography
  def initialize
    CryptographyAsciiArt.new('binary')
    select_binary_mode
  end

  def select_binary_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Text to binary', value: -> { CryptographyAsciiArt.new('binary') && text_to_binary } },
      { name: 'Binary to text', value: -> { CryptographyAsciiArt.new('binary') && binary_to_text } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def text_to_binary
    puts 'Please enter your string to be encoded'

    string = gets.chomp

    print "\nYour result is: "
    puts string.each_byte.map { |byte| format '%08b', byte }.join(' ').colorize(:green)

    quit_or_continue(Binary)
  end

  def binary_to_text
    puts 'Please enter your string to be decoded, please separate by spaces'

    binary_input = gets.chomp.split(' ').map { |byte| byte.to_i(2).chr }.join

    print "\nYour result is: "
    puts binary_input.colorize(:green)
    quit_or_continue(Binary)
  end
end
