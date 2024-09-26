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

  def select_cryptography_mode # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize,Metrics/PerceivedComplexity
    prompt = TTY::Prompt.new

    choices = [
      { name: 'A1Z26', value: -> { require_relative 'a1z26' && A1Z26.new } },
      { name: 'Atbash', value: -> { require_relative 'atbash' && Atbash.new } },
      { name: 'Base 32', value: -> { require_relative 'base_32' && BASE32.new } },
      { name: 'Base 64', value: -> { require_relative 'base_64' && BASE64.new } },
      { name: 'Binary', value: -> { require_relative 'binary' && Binary.new } },
      { name: 'Caesar', value: -> { require_relative 'caesar' && Caesar.new } },
      { name: 'Decimal', value: -> { require_relative 'decimal' && Decimal.new } },
      { name: 'Hexadecimal', value: -> { require_relative 'hexadecimal' && Hexadecimal.new } },
      { name: 'Morse Code', value: -> { require_relative 'morse' && MorseCode.new } },
      { name: 'Rail Fence', value: -> { require_relative 'rail_fence' && RailFence.new } },
      { name: 'RSA', value: -> { require_relative 'rsa' && RSA.new } },
      { name: 'SHA1', value: -> { require_relative 'sha1' && SHA1.new } },
      { name: 'Vigenère', value: -> { require_relative 'vigenere' && Vigenere.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', choices, per_page: 15, cycle: true)
  end
end
