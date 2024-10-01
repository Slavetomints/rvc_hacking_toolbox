# frozen_string_literal: true

require 'colorize'
require_relative '../toolbox/toolbox_ascii_art'
require_relative '../toolbox/toolbox'

# houses the main Log Analysis functions and the menu for it
class LogAnalysis < Toolbox
  def initialize
    ToolboxAsciiArt.new('log_analysis')
    select_log_analysis_mode
  end

  def select_log_analysis_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: '1', value: 1 },
      { name: '2', value: 2 },
      { name: '3', value: 3 },
      { name: '4', value: 4 },
      { name: '5', value: 5 },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select your mode', choices, per_page: 7, cycle: true)
  end
end
