# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the Atbash cipher
class Atbash < Cryptography
  def initialize
    @alphabet = ('a'..'z').to_a.freeze
    @reverse_alphabet = @alphabet.reverse
    CryptographyAsciiArt.new('atbash')
    select_atbash_mode
  end

  def select_atbash_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Reverse string', value: -> { CryptographyAsciiArt.new('atbash') && atbash } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { Cryptography.new } }
    ]

    prompt.select('Please select your mode', choices, per_page: 4, cycle: true)
  end

  def atbash # rubocop:disable Metrics/MethodLength
    atbash_string = []
    puts "\nPlease enter the string you want to encode"

    char_arr = gets.chomp.downcase.split('')

    char_arr.each do |char|
      if @alphabet.include?(char)
        index = @alphabet.index(char)
        atbash_string << @reverse_alphabet[index]
      elsif char.match?(/[.!? ]/)
        atbash_string << char
      end
    end
    print "\nYour result is: #{atbash_string.join.colorize(:green)}"
    quit_or_continue(Atbash)
  end
end
