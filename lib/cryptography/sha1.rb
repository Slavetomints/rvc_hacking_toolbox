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

  def select_sha1_mode
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encrypt string', value: -> { CryptographyAsciiArt.new('sha1') && encrypt_sha1 } },
      { name: 'Go to previous menu', value: -> { Cryptography.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 4, cycle: true)
  end

  def encrypt_sha1
    sha1 = Digest::SHA1.new
    puts 'Please enter your data to be encrypted'

    data = gets.chomp

    sha1.update data

    print "\nYour result is: #{sha1.hexdigest.colorize(:green)}"
    quit_or_continue(SHA1)
  end
end
