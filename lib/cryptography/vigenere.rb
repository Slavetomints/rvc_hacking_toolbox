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

  def select_vigenere_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt string', value: -> { CryptographyAsciiArt.new('vigenere') && encrypt_vigenere } },
      { name: 'Decrypt string', value: -> { CryptographyAsciiArt.new('vigenere') && decrypt_vigenere } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5)
  end

  def encrypt_vigenere
    puts 'Please enter the plaintext'
    plaintext = gets.chomp

    puts 'Please enter the key'
    key = gets.chomp.downcase

    ciphertext = process_text(plaintext, :+, key)

    print "\nYour result is: #{ciphertext.colorize(:green)}"
    quit_or_continue(Vigenere)
  end

  def decrypt_vigenere
    puts 'Please enter the ciphertext'
    ciphertext = gets.chomp

    puts 'Please enter the key'
    key = gets.chomp.downcase

    plaintext = process_text(ciphertext, :-, key)

    print "\nYour result is: #{plaintext.colorize(:green)}"
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
