# frozen_string_literal: true

require_relative '../ascii_art'
require_relative '../special_functions'
require_relative '../main_menu'
require_relative 'cryptography'

def load_caesar_menu
  clear_terminal
  show_cryptography
  puts '  Caesar Description'
  puts "\n    1 - Caesar shift\n    'quit' to quit\n    'main' to go to main menu\n    'previous' to go to previous menu" # rubocop:disable Layout/LineLength

  select_caesar_mode
end

def select_caesar_mode # rubocop:disable Metrics/MethodLength
  mode = validate_mode('one')

  case mode
  when '1'
    clear_terminal
    show_cryptography
    caesar_shift
  when 'quit'
    clear_terminal
    exit
  when 'main'
    load_main_menu
  when 'previous'
    load_cryptography
  end
end

def caesar_shift # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # Gather the input and prepare it
  puts 'What would you like to be encoded?'
  string = gets
  puts 'How much of a shift do you want?'
  shift = gets.to_i
  shift > 26 ? shift -= 26 : shift

  # execute the shift
  reg_text = string.chars
  cipher_text = []
  reg_text.each do |char|
    if char.match(/[a-zA-Z]/)
      if char == char.upcase
        # checks for looping
        if char.ord + shift > 90
          cipher_char = char.ord + shift - 26
        else
          cipher_char = char.ord + shift
          cipher_text << cipher_char.chr
        end
        cipher_text << cipher_char.chr
      elsif char == char.downcase
        # checks for looping
        if char.ord + shift > 122
          cipher_char = char.ord + shift - 26
          cipher_text << cipher_char.chr # rubocop:disable Style/IdenticalConditionalBranches
        else
          cipher_char = char.ord + shift
          cipher_text << cipher_char.chr # rubocop:disable Style/IdenticalConditionalBranches
        end

      end
    else
      cipher_text << char
    end
  end
  puts cipher_text.join

  Cryptography.quit_or_continue
end
