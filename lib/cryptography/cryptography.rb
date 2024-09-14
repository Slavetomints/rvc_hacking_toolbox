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
require_relative 'caesar'
require_relative 'decimal'
require_relative 'hexadecimal'
require_relative 'morse'
require_relative 'rail_fence'
require_relative 'rsa'
require_relative 'vigenere'

# houses the main cryptography functions
class Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_mode
  end

  def select_mode # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize
    prompt = TTY::Prompt.new

    choices = [
      { name: 'A1Z26', value: 1 },
      { name: 'Atbash', value: 2 },
      { name: 'Base 64', value: 3, disabled: '(In development)' },
      { name: 'Base 32', value: 4, disabled: '(In development)' },
      { name: 'Binary', value: 5, disabled: '(In development)' },
      { name: 'Caesar', value: 6 },
      { name: 'Decimal', value: 7, disabled: '(In development)' },
      { name: 'Hexadecimal', value: 8, disabled: '(In development)' },
      { name: 'Morse Code', value: 9, disabled: '(In development)' },
      { name: 'Rail Fence', value: 10, disabled: '(In development)' },
      { name: 'RSA', value: 11 },
      { name: 'Vigenere', value: 12, disabled: '(In development)' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 14, cycle: true)

    case mode
    when 1
      A1Z26.new
    when 2
      clear_terminal
      load_atbash_menu
    when 3
      clear_terminal
      load_base_32_menu
    when 4
      clear_terminal
      load_base_64_menu
    when 5
      clear_terminal
      load_binary_menu
    when 6
      load_caesar_menu
    when 7
      clear_terminal
      load_decimal_menu
    when 8
      clear_terminal
      load_hexadecimal_menu
    when 9
      clear_terminal
      load_morse_menu
    when 10
      clear_terminal
      load_rail_fence_menu
    when 11
      load_rsa_menu
    when 12
      load_vigenere_menu
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    end
  end

  def quit_or_continue # rubocop:disable Metrics/MethodLength
    puts "\n'q'uit program or 'c'ontinue hacking"
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
