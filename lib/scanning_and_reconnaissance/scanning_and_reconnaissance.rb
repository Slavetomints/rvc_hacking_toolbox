# frozen_string_literal: true

require 'colorize'
require_relative '../toolbox/toolbox_ascii_art'
require_relative '../toolbox/toolbox'

# houses the main cryptography functions
class ScanningAndReconnaissance < Toolbox
  def initialize
    ToolboxAsciiArt.new('scanning_and_reconnaissance')
    select_scanning_and_reconnaissance_mode
  end

  def select_scanning_and_reconnaissance_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: '1', value: 1 },
      { name: '2', value: 2 },
      { name: '3', value: 3 },
      { name: '4', value: 4 },
      { name: '5', value: 5 },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 7, cycle: true)

    case mode
    when 'quit'
      clear_terminal
      exit
    when 'main'
      Toolbox.new
    end
  end
end
