# frozen_string_literal: true

require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class runs the RailFence cipher
class RailFence < Cryptography
  def initialize
    CryptographyAsciiArt.new('rail_fence')
    select_rail_fence_mode
  end

  def select_rail_fence_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt string', value: -> { CryptographyAsciiArt.new('rail_fence') && encrypt_rail_fence } },
      { name: 'Decrypt string', value: -> { CryptographyAsciiArt.new('rail_fence') && decrypt_rail_fence } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 5, cycle: true)
  end

  def encrypt_rail_fence # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts 'Please enter the plaintext'
    plaintext = gets.chomp.chars

    puts 'Please enter the amount of rows you want'
    rows = gets.chomp.to_i

    direction = 'down'
    current_row = 0
    rails = Array.new(rows) { Array.new(plaintext.length, '') }

    plaintext.each_with_index do |char, index|
      rails[current_row][index] = char

      if direction == 'down'
        current_row += 1
        if current_row == rows
          direction = 'up'
          current_row -= 2
        end
      else
        current_row -= 1
        if current_row == -1
          direction = 'down'
          current_row += 2
        end
      end
    end

    print "\nYour result is: #{rails.flatten.join.colorize(:green)}"
    quit_or_continue(RailFence)
  end

  def decrypt_rail_fence # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    puts 'Please enter the ciphertext'
    ciphertext = gets.chomp.chars

    puts 'Please enter the amount of rows used for encryption'
    rows = gets.chomp.to_i

    direction = 'down'
    current_row = 0
    rails = Array.new(rows) { Array.new(ciphertext.length, '') }
    positions = Array.new(ciphertext.length)

    ciphertext.each_with_index do |_char, index|
      rails[current_row][index] = '*'
      positions[index] = current_row

      if direction == 'down'
        current_row += 1
        if current_row == rows
          direction = 'up'
          current_row -= 2
        end
      else
        current_row -= 1
        if current_row == -1
          direction = 'down'
          current_row += 2
        end
      end
    end

    # Fill the rails with the ciphertext
    char_index = 0
    rails.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        if cell == '*'
          rails[row_index][col_index] = ciphertext[char_index]
          char_index += 1
        end
      end
    end

    # Read the plaintext from the rails
    result = ''
    positions.each_with_index do |row, index|
      result += rails[row][index]
    end

    puts "\nYour result is: #{result.colorize(:green)}"
    quit_or_continue(RailFence)
  end
end
