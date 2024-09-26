# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class housees the caesar shift
class Caesar < Cryptography
  def initialize
    CryptographyAsciiArt.new('caesar')
    select_caesar_mode
  end

  def select_caesar_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Shift string', value: 1 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      CryptographyAsciiArt.new('caesar')
      caesar_shift
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
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
    print "\nYour result is: "
    puts cipher_text.join.colorize(:green)

    quit_or_continue(Caesar)
  end
end
