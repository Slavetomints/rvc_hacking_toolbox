# frozen_string_literal: true

require_relative '../ascii_art'
require_relative '../special_functions'
require_relative '../main_menu'
require_relative 'cryptography'

def load_a1z26_menu
  clear_terminal
  show_cryptography
  puts "\n\nA1Z26 is a cipher where every letter is replaces by its corresponding number"
  puts "\n1 - Encode string\n
  2 - Decode string\n
  'quit' to quit\n
  'main' to go to main menu\n
  'previous' to go to previous menu"

  select_a1z26_mode
end

def select_a1z26_mode # rubocop:disable Metrics/MethodLength
  mode = validate_mode('one_two')

  case mode
  when '1'
    clear_terminal
    show_cryptography
    encode_a1z26
  when '2'
    clear_terminal
    show_cryptography
    decode_a1z26
  when 'quit'
    clear_terminal
    exit
  when 'main'
    load_main_menu
  when 'previous'
    Cryptography.load_menu
  end
end

def decode_a1z26
  puts 'Please enter only numbers seperated by a comma'

  num_arr = gets.chomp.split(',').map { |number| number.to_i + 96 }
  decoded_chars = num_arr.map(&:chr)
  puts "\n#{decoded_chars.join.colorize(:green)}"

  Cryptography.quit_or_continue
end

def encode_a1z26
  puts 'Please enter only letters with no spaces'

  char_arr = gets.chomp.downcase.chars.map { |character| character.ord - 96 }
  puts "\n#{char_arr.join(',').colorize(:green)}"

  Cryptography.quit_or_continue
end
