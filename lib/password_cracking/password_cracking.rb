# frozen_string_literal: true

require 'tty-prompt'

# This class wil hold the menu and base functions for the password cracking section of the project
class PasswordCracking < Toolbox
  def initialize
    select_password_cracking_mode
  end

  def select_password_cracking_mode
    prompt = TTY::Prompt.new

    options = [
      { name: 'John', value: 1 },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit application', value: 'quit' }
    ]

    mode = prompt.select('Please select a mode', options)

    case mode
    when 1
      require_relative 'john'
      John.new
    when 'main'
      Toolbox.new
    when 'quit'
      clear_terminal
      exit
    end
  end
end
