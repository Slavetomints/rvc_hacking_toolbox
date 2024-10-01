# frozen_string_literal: true

require 'colorize'
require_relative '../toolbox/toolbox_ascii_art'
require_relative '../toolbox/toolbox'

# houses the main cryptography functions
class Forensics < Toolbox
  def initialize
    ToolboxAsciiArt.new('forensics')
    select_forensics_mode
  end

  def select_forensics_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'File Metadata', value: lambda {
        require_relative 'metadata'
        Metadata.new
      } },
      { name: '2', value: 2 },
      { name: '3', value: 3 },
      { name: '4', value: 4 },
      { name: '5', value: 5 },
      { name: 'Go to Main Menu', value: lambda {
        Toolbox.new
      } },
      { name: 'Quit Program', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select your mode', choices, per_page: 7, cycle: true)
  end
end
