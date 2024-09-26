# frozen_string_literal: true

require 'prime'
require 'openssl'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class houses the functions that make RSA decryption possible
class RSA < Cryptography
  def initialize
    CryptographyAsciiArt.new('rsa')
    select_rsa_mode
  end

  def select_rsa_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Decrypt', value: -> { CryptographyAsciiArt.new('rsa') && rsa } },
      { name: 'Find factors', value: -> { CryptographyAsciiArt.new('rsa') && find_factors } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
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
    quit_or_continue(RSA)
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
    print "The factors are \n #{factors[0..((factors.length / 2) - 1)]}\n"
    quit_or_continue(RSA)
  end
end
