# frozen_string_literal: true

require 'colorize'
require_relative '../toolbox/toolbox_ascii_art'
require_relative '../toolbox/toolbox'

# houses the main cryptography functions
class Cryptography < Toolbox
  def initialize
    clear_terminal
    show_cryptography
    select_cryptography_mode
  end

  def select_cryptography_mode # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    prompt = TTY::Prompt.new

    choices = [
      { name: 'A1Z26', value: lambda {
        require_relative 'a1z26'
        A1Z26.new
      } },
      { name: 'Atbash', value: lambda {
        require_relative 'atbash'
        Atbash.new
      } },
      { name: 'Base 32', value: lambda {
        require_relative 'base_32'
        BASE32.new
      } },
      { name: 'Base 64', value: lambda {
        require_relative 'base_64'
        BASE64.new
      } },
      { name: 'Binary', value: lambda {
        require_relative 'binary'
        Binary.new
      } },
      { name: 'Caesar', value: lambda {
        require_relative 'caesar'
        Caesar.new
      } },
      { name: 'Decimal', value: lambda {
        require_relative 'decimal'
        Decimal.new
      } },
      { name: 'Hexadecimal', value: lambda {
        require_relative 'hexadecimal'
        Hexadecimal.new
      } },
      { name: 'Morse Code', value: lambda {
        require_relative 'morse'
        MorseCode.new
      } },
      { name: 'Rail Fence', value: lambda {
        require_relative 'rail_fence'
        RailFence.new
      } },
      { name: 'RSA', value: lambda {
        require_relative 'rsa'
        RSA.new
      } },
      { name: 'SHA1', value: lambda {
        require_relative 'sha1'
        SHA1.new
      } },
      { name: 'Vigenère', value: lambda {
        require_relative 'vigenere'
        Vigenere.new
      } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 15, cycle: true)
  end
end
