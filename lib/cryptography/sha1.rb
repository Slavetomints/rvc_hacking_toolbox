# frozen_string_literal: true

require 'digest'
require_relative 'cryptography'
require_relative 'cryptography_ascii_art'

# This class contains the functions for the SHA1 class
class SHA1 < Cryptography
  def initialize
    CryptographyAsciiArt.new('sha1')
    select_sha1_mode
  end

  def select_sha1_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt string', value: 1 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 4, cycle: true)

    case mode
    when 1
      CryptographyAsciiArt.new('sha1')
      encode_sha1
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end

  def encode_sha1
    sha1 = Digest::SHA1.new
    puts 'Please enter your data to be encoded'

    data = gets.chomp

    sha1.update data

    print "\nYour result is: "
    puts sha1.hexdigest.colorize(:green)

    quit_or_continue(SHA1)
  end
end
