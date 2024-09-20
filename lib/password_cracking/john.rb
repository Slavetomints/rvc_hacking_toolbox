# frozen_string_literal: true

require 'tty-prompt'

# This class houses the functiona and menu for john
class John < PasswordCracking
  def initialize
    # PasswordCrackingAsciiArt.new('john')
    select_john_mode
  end

  def select_john_mode
    prompt = TTY::Prompt.new

    options = [
      { name: 'Creat John Rules', value: 1 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit application', value: 'quit' }
    ]

    mode = prompt.select('Please select a mode', options)

    case mode
    when 1
      create_john_rules
    when 'previous'
      PasswordCracking.new
    when 'main'
      Toolbox.new
    when 'quit'
      clear_terminal
      exit
    end
  end

  def create_john_rules # rubocop:disable Metrics/MethodLength
    subs = {
      'a' => '@',
      'A' => '@',
      'o' => '0',
      'O' => '0'
    }

    single_rules = []
    double_rules = []

    subs.each { |key, value| single_rules << "s#{key}#{value}" }

    print single_rules
    single_rules.each do |rule|
      subs.each do |key, value|
        new_rule = "#{rule} s#{key}#{value}"
        double_rules << new_rule
      end
    end

    double_rules.uniq!
    quit_or_continue(John)
  end
end
