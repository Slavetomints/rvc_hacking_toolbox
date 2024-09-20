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
      { name: 'Create John Rules', value: 1 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit application', value: 'quit' }
    ]

    mode = prompt.select('Please select a mode', options, per_page: 4, cycle: true)

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

  def create_john_rules
    subs = set_substitutions
    rules = subs.map { |key, value| ["s#{key}#{value}"] }
    all_combinations = []

    # Generate combinations regardless of size of subs
    (1..subs.length).each do |size|
      all_combinations += rules.combination(size).to_a
    end

    # Ensures that all combinations are unique
    unique_combinations = all_combinations.uniq

    # Prints all rules for copying
    puts "\n\nRULES".colorize(:light_blue)
    unique_combinations.each do |rule|
      puts rule.join(' ')
    end
  end
end
