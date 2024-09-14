# frozen_string_literal: true

require 'colorize'
require_relative '../ascii_art'
require_relative 'cryptography'
require_relative '../special_functions'

def load_atbash_menu
  clear_terminal
  show_cryptography
  puts "\n\nAtbash description"
  puts "\n1 - Reverse string\n'quit' to quit\n'main' to go to main menu\n'previous' to go to previous menu"

  select_atbash_mode
end

def select_atbash_mode # rubocop:disable Metrics/MethodLength
  mode = validate_mode('one')

  case mode
  when '1'
    clear_terminal
    show_cryptography
    atbash
  when 'quit'
    clear_terminal
    exit
  when 'main'
    load_main_menu
  when 'previous'
    Cryptography.load_menu
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
  print "\nYour string is: "
  puts atbash_string.join.colorize(:green)

  Cryptography.quit_or_continue
end
