# frozen_string_literal: true

require 'tty-prompt'

# This class wil hold the menu and base functions for the password cracking section of the project
class PasswordCracking < Toolbox
  def initialize
    ToolboxAsciiArt.new('password_cracking')
    select_password_cracking_mode
  end

  def select_password_cracking_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    options = [
      { name: 'John', value: lambda {
        require_relative 'john'
        John.new
      } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select a mode', options, per_page: 3, cycle: true)
  end
end
