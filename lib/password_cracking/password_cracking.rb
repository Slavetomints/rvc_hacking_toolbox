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
      { name: 'Wordlist enhancer', value: lambda {
        require_relative 'wordlist_enhancer'
        WordlistEnhancer.new
      } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select a mode', options, per_page: 3, cycle: true)
  end

  def set_substitutions
    subs = {}
    loop do
      puts "\nEnter what you want to replace, then the value you want to replace it with seperated by a space. Ex 's $'"
      puts "Enter 'qq' to stop entering values".colorize(:red)
      sub_arr = gets.chomp
      return subs if sub_arr == 'qq'

      sub_arr = sub_arr.split(' ')
      subs[sub_arr[0]] = sub_arr[1]
    end
  end
end
