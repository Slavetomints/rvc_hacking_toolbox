# frozen_string_literal: true

require 'prime'
require 'openssl'
require 'colorize'
require_relative '../ascii_art'
require_relative 'cryptography'

# This class houses the functions that make RSA decryption possible
class RSA < Cryptography
  def initialize
    clear_terminal
    show_cryptography
    select_rsa_mode
  end

  def select_rsa_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Decrypt', value: 1 },
      { name: 'Find factors', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 5, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      rsa
    when 2
      clear_terminal
      show_cryptography
      find_factors
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def rsa # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    puts "\nWhat is the first factor?"
    p = gets.chomp.to_i

    puts "\nWhat is the second factor?"
    q = gets.chomp.to_i

    puts "\nWhat is e?"
    e = gets.chomp.to_i

    puts "\nWhat is the message? (please seperate by comma ex: 1,2,3)"
    c = gets.chomp.split(',')

    print "\nYour result is: "
    phi = (p - 1) * (q - 1)

    d = OpenSSL::BN.new(e.to_s).mod_inverse(OpenSSL::BN.new(phi.to_s))

    c.each do |i|
      m = OpenSSL::BN.new(i.to_s).mod_exp(d, OpenSSL::BN.new((p * q).to_s))
      print m.to_i.chr.colorize(:green)
    end
    puts "\n"
    quit_or_continue
  end

  def find_factors
    puts 'What is the number you want to find the factors of?'
    number = gets.chomp.to_i
    divisor = number
    factors = []

    until divisor.zero?
      factors << [(number / divisor), divisor] if (number % divisor).zero?
      divisor -= 1
    end
    print "#{factors[0..((factors.length / 2) - 1)]}\n"
    quit_or_continue
  end
end
