# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative '../ascii_art'
require_relative 'cryptography'

# This class runs the Atbash cipher
class Atbash < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_atbash_mode
  end

  def select_atbash_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Reverse string', value: 1 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      atbash
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  ALPHABET = ('a'..'z').to_a.freeze
  REVERSE_ALPHABET = ALPHABET.reverse

  def atbash # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    atbash_string = []
    puts "\nPlease enter the string you want to encode"

    char_arr = gets.chomp.downcase.split('')

    char_arr.each do |char|
      if ALPHABET.include?(char)
        index = ALPHABET.index(char)
        atbash_string << REVERSE_ALPHABET[index]
      elsif char.match?(/[.!? ]/)
        atbash_string << char
      end
    end
    print "\nYour result is: "
    puts atbash_string.join.colorize(:green)

    quit_or_continue(Atbash)
  end
end
