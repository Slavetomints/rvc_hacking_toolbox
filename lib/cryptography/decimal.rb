# frozen_string_literal: true

require_relative '../ascii_art'
require 'tty-prompt'

# This class contains the functions to
class Decimal
  def initialize
    clear_terminal
    show_cryptography
    select_decimal_mode
  end

  def select_decimal_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Encode string', value: 1 },
      { name: 'Decode string', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 5, cycle: true)

    case mode
    when 1
      clear_terminal
      show_cryptography
      puts 'hi'
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    when 'previous'
      Cryptography.new
    end
  end
end
