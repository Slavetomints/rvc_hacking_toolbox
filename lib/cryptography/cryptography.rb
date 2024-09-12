# frozen_string_literal: true

require 'colorize'
require_relative '../special_functions'
require_relative '../ascii_art'
require_relative '../main_menu'
require_relative 'a1z26'
require_relative 'atbash'
require_relative 'base_32'
require_relative 'base_64'
require_relative 'binary'
require_relative 'ceaser'
require_relative 'decimal'
require_relative 'hexadecimal'
require_relative 'morse'
require_relative 'rail_fence'
require_relative 'rsa'
require_relative 'vigenere'

# houses the main cryptography functions
module Cryptography
  def self.load_menu
    clear_terminal
    show_cryptography

    puts '  1 - Base 64       7 - Rail Fence'
    puts '  2 - Base32        8 - Atbash'
    puts '  3 - Binary        9 - Morse'
    puts '  4 - Decimal       10 - Vigenère'
    puts '  5 - Hexadecimal   11 - RSA'
    puts '  6 - Ceaser        12 - A1Z26'
    puts "  'quit' to quit    'main' to go to main menu"

    select_mode
  end

  def self.select_mode # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize
    mode = validate_mode('cryptography_main')

    case mode
    when '1'
      clear_terminal
      load_base_64_menu
    when '2'
      clear_terminal
      load_base_32_menu
    when '3'
      clear_terminal
      load_binary_menu
    when '4'
      clear_terminal
      load_decimal_menu
    when '5'
      clear_terminal
      load_hexadecimal_menu
    when '6'
      clear_terminal
      load_ceaser_menu
    when '7'
      clear_terminal
      load_rail_fence_menu
    when '8'
      clear_terminal
      load_atbash_menu
    when '9'
      clear_terminal
      load_morse_menu
    when '10'
      clear_terminal
      load_vigenere_menu
    when '11'
      clear_terminal
      load_rsa_menu
    when '12'
      clear_terminal
      load_a1z26_menu
    when 'quit'
      clear_terminal
      exit
    when 'main'
      load_main_menu
    end
  end

  def self.quit_or_continue # rubocop:disable Metrics/MethodLength
    puts "'q'uit program or 'c'ontinue hacking"
    response = gets.chomp
    if response == 'q'
      clear_terminal
      exit
    elsif response == 'c'
      load_menu
    else
      puts 'Invalid input detected, pick again'.colorize(:red)
      quit_or_continue
    end
  end
end
