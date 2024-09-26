# frozen_string_literal: true

require 'tty-prompt'
require_relative 'password_cracking_ascii_art'

# This class houses the functiona and menu for john
class John < PasswordCracking
  def initialize
    PasswordCrackingAsciiArt.new('john')
    select_john_mode
  end

  def select_john_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    options = [
      { name: 'Create John Substitutions', value: 1 },
      { name: 'Add numbers to end of rules', value: 2 },
      { name: 'Go to previous menu', value: 'previous' },
      { name: 'Go to Main Menu', value: 'main' },
      { name: 'Quit application', value: 'quit' }
    ]

    mode = prompt.multi_select('Please select a mode', options, per_page: 4, cycle: true)

    case mode
    when [1]
      create_john_substitutions(true)
    when [2]
      append_john_numbers(true)
    when [1, 2]
      create_john_substitutions(false)
      append_john_numbers(false)
    when 'previous'
      PasswordCracking.new
    when 'main'
      Toolbox.new
    when 'quit'
      clear_terminal
      exit
    else
      puts 'Invalid combination, select again'.colorize(:red)
      select_john_mode
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

  def create_john_substitutions(alone)
    subs = set_substitutions
    rules = subs.map { |key, value| ["s#{key}#{value}"] }
    all_combinations = []

    # Generate combinations regardless of size of subs
    (1..subs.length).each do |size|
      all_combinations += rules.combination(size).to_a
    end

    # Ensures that all combinations are unique
    @unique_combinations = all_combinations.uniq

    display_john_rules('subs') if alone
  end

  def append_john_numbers(alone)
    puts 'Please select the amount of numbers to be appended'
    amount_of_numbers = gets.chomp.to_i

    puts 'Please select the lowest and highest number, separated by a space'
    low_high_num = gets.chomp.split(' ').map(&:to_i).join('..')
    number_brackets = "[#{low_high_num}]" * amount_of_numbers

    alone ? display_john_rules('nums', number_brackets) : display_john_rules('both', number_brackets)
  end

  def display_john_rules(mode, *number_brackets) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts "\n\nSUBSTITUTIONS".colorize(:light_blue)
    output = []

    case mode
    when 'subs'
      @unique_combinations.each do |rule|
        output << rule.join(' ')
      end
    when 'nums'
      @unique_combinations.each do |rule|
        output << "#{rule.join(' ')} cAz\"#{number_brackets.join}\""
      end
    when 'both'
      @unique_combinations.each do |rule|
        output << rule.join(' ')
        output << "#{rule.join(' ')} cAz\"#{number_brackets.join}\""
      end
    end
    puts output.join("\n")
  end
end
