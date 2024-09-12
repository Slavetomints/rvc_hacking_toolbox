# frozen_string_literal: true

require 'prime'
require_relative '../ascii_art'
require_relative 'cryptography'

def load_rsa_menu
  clear_terminal
  show_cryptography
  puts '  RSA Description'
  puts "\n    1 - Decrypt\n    2 - Find factors\n    'quit' to quit\n    'main' to go to main menu\n    'previous' to go to previous menu" # rubocop:disable Layout/LineLength

  select_rsa_mode
end

def select_rsa_mode # rubocop:disable Metrics/MethodLength
  mode = validate_mode('one_two')

  case mode
  when '1'
    clear_terminal
    show_cryptography
    rsa
  when '2'
    clear_terminal
    show_cryptography
    find_factors
  when 'quit'
    clear_terminal
    exit
  when 'main'
    load_main_menu
  when 'previous'
    load_cryptography
  end
end

def rsa
  puts "  \nWhat is the first factor?"
  p = gets.chomp

  puts "  \nWhat is the second factor?"
  q = gets.chomp

  puts "  \nWhat is e?"
  e = gets.chomp

  puts "  \nWhat is c (please seperate by comma ex: 1,2,3)"
  c = gets.chomp.split(',')
end

def find_factors
  puts '  What is the number you want to find the factors of?'
  number = gets.chomp.to_i
  divisor = number
  factors = []

  until divisor.zero?
    factors << [(number / divisor), divisor] if (number % divisor).zero?
    divisor -= 1
  end
  print "#{factors[0..((factors.length / 2) - 1)]}\n"
  Cryptography.quit_or_continue
end
