# frozen_string_literal: true

require 'colorize'
require_relative '../main_ascii_art'
require_relative '../main_menu'

# houses the main cryptography functions
class Cryptography < Toolbox
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
      { name: 'Base 32', value: 3 },
      { name: 'Base 64', value: 4 },
      { name: 'Binary', value: 5 },
      { name: 'Caesar', value: 6 },
      { name: 'Decimal', value: 7 },
      { name: 'Hexadecimal', value: 8 },
      { name: 'Morse Code', value: 9 },
      { name: 'Rail Fence', value: 10 },
      { name: 'RSA', value: 11 },
      { name: 'SHA1', value: 12 },
      { name: 'Vigenère', value: 13 },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 15, cycle: true)

    case mode
    when 1
      require_relative 'a1z26'
      A1Z26.new
    when 2
      require_relative 'atbash'
      Atbash.new
    when 3
      require_relative 'base_32'
      BASE32.new
    when 4
      require_relative 'base_64'
      BASE64.new
    when 5
      require_relative 'binary'
      Binary.new
    when 6
      require_relative 'caesar'
      Caesar.new
    when 7
      require_relative 'decimal'
      Decimal.new
    when 8
      require_relative 'hexadecimal'
      Hexadecimal.new
    when 9
      require_relative 'morse'
      MorseCode.new
    when 10
      require_relative 'rail_fence'
      RailFence.new
    when 11
      require_relative 'rsa'
      RSA.new
    when 12
      require_relative 'sha1'
      SHA1.new
    when 13
      require_relative 'vigenere'
      Vigenere.new
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    end
  end

  def quit_or_continue(child_class) # rubocop:disable Metrics/MethodLength
    puts "\n'q'uit program or 'c'ontinue hacking"
    response = gets.chomp
    if response == 'q'
      clear_terminal
      exit
    elsif response == 'c'
      child_class.new
    else
      puts 'Invalid input detected, pick again'.colorize(:red)
      quit_or_continue(child_class)
    end
  end
end
