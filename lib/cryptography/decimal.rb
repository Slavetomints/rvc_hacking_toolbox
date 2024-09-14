# frozen_string_literal: true

require_relative '../ascii_art'
require 'tty-prompt'

def load_decimal_menu
  clear_terminal
  show_cryptography
  puts "\n\nDecimal Description"
  puts "\n1 - Encode\n2 - Decode\n'quit' to quit\n'main' to go to main menu\n'previous' to go to previous menu"

  select_decimal_mode
end

def select_decimal_mode # rubocop:disable Metrics/MethodLength
  prompt = TTY::Prompt.new
  choices = [
    { name: '1', value: 1 },
    { name: 'medium', value: 2, disabled: '(out of stock)' },
    { name: 'large', value: 3 }
  ]
  mode = prompt.select('Choose your mode', choices)
  p mode.class
  p mode
  case mode
  when 1
    clear_terminal
    show_cryptography
    caesar_shift
    puts 'hi'
  when 'quit'
    clear_terminal
    exit
  when 'main'
    load_main_menu
  when 'previous'
    Cryptography.load_menu
  end
end
