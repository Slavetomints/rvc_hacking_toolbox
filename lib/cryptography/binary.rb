# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative 'cryptography'

# This class runs the binary functions and menu
class Binary < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_binary_mode
  end

  def select_binary_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Text to binary', value: 1 },
      { name: 'Binary to text', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      text_to_binary
    when 2
      clear_terminal
      show_cryptography
      binary_to_text
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def text_to_binary
    puts 'Please enter your string to be encoded'

    string = gets.chomp

    print "\nYour result is: "
    puts string.each_byte.map { |byte| format '%08b', byte }.join(' ').colorize(:green)

    quit_or_continue(Binary)
  end

  def binary_to_text
    puts 'Please enter your string to be decoded, please seperate by spaces'

    binary_input = gets.chomp.split(' ').map { |byte| byte.to_i(2).chr }.join

    print "\nYour result is: "
    puts binary_input.colorize(:green)
    quit_or_continue(Binary)
  end
end
