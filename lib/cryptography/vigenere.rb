# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class houses the function and menus for the vigenere cipher
class Vigenere < Cryptography
  def initialize
    @ALPHABET = ('A'..'Z').to_a.freeze
    @ALPHABET_LOWER = ('a'..'z').to_a.freeze
    CryptographyAsciiArt.new('vigenere')
    select_vigenere_mode
  end

  def select_vigenere_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt string', value: 1 },
      { name: 'Decrypt string', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 5)

    case mode
    when 1
      CryptographyAsciiArt.new('vigenere')
      encrypt_vigenere
    when 2
      CryptographyAsciiArt.new('vigenere')
      decrypt_vigenere
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encrypt_vigenere
    puts 'Please enter the plaintext'
    plaintext = gets.chomp

    puts 'Please enter the key'
    key = gets.chomp.downcase

    ciphertext = process_text(plaintext, :+, key)

    print "\nYour result is: "
    puts ciphertext.colorize(:green)

    quit_or_continue(Vigenere)
  end

  def decrypt_vigenere
    puts 'Please enter the ciphertext'
    ciphertext = gets.chomp

    puts 'Please enter the key'
    key = gets.chomp.downcase

    plaintext = process_text(ciphertext, :-, key)

    print "\nYour result is: "
    puts plaintext.colorize(:green)

    quit_or_continue(Vigenere)
  end

  def process_text(text, operation, key) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    key_index = 0
    text.chars.map do |char|
      if @ALPHABET.include?(char)
        shift = key[key_index % key.length].upcase.ord - 'A'.ord
        new_index = @ALPHABET.index(char).send(operation, shift) % @ALPHABET.size
        key_index += 1
        @ALPHABET[new_index]
      elsif @ALPHABET_LOWER.include?(char)
        shift = key[key_index % key.length].downcase.ord - 'a'.ord
        new_index = @ALPHABET_LOWER.index(char).send(operation, shift) % @ALPHABET_LOWER.size
        key_index += 1
        @ALPHABET_LOWER[new_index]
      else
        char
      end
    end.join
  end
end
