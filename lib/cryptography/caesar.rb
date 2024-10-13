# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class housees the caesar shift
class Caesar < Cryptography
  def initialize
    CryptographyAsciiArt.new('caesar')
    select_caesar_mode
  end

  def select_caesar_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Shift string', value: -> { CryptographyAsciiArt.new('caesar') && caesar_shift } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 4, cycle: true)
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
            cipher_text << cipher_char.chr # rubocop:disable Style/IdenticalConditionalBranches
          else
            cipher_char = char.ord + shift
            cipher_text << cipher_char.chr # rubocop:disable Style/IdenticalConditionalBranches
          end
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
    print "\nYour result is: #{cipher_text.join.colorize(:green)}"
    quit_or_continue(Caesar)
  end
end
