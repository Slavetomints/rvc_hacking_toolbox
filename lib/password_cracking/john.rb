# frozen_string_literal: true

require 'tty-prompt'
require_relative 'password_cracking_ascii_art'

# This class houses the functiona and menu for john
class John < PasswordCracking
  def initialize
    PasswordCrackingAsciiArt.new('john')
    select_john_mode
    display_john_rules
  end

  def select_john_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    options = [
      { name: 'Create John Substitution Rules', value: -> { create_john_substitutions } },
      { name: 'Creare John Substitution Rules with numbers after', value: lambda {
        create_john_substitutions
        append_john_numbers
      } },
      { name: 'Go to previous menu', value: -> { PasswordCracking.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: -> { clear_terminal && exit } }
    ]

    prompt.select('Please select your mode', options, per_page: 5, cycle: true)
  end

  def create_john_substitutions
    subs = set_substitutions
    rules = subs.map { |key, value| ["s#{key}#{value}"] }
    all_combinations = []

    # Generate combinations regardless of size of subs
    (1..subs.length).each do |size|
      all_combinations += rules.combination(size).to_a
    end

    # Ensures that all combinations are unique
    @unique_combinations = all_combinations.uniq
  end

  def append_john_numbers
    puts 'Please select the amount of numbers to be appended'
    amount_of_numbers = gets.chomp.to_i

    puts 'Please select the lowest and highest number, separated by a space'
    low_high_num = gets.chomp.split(' ').map(&:to_i).join('..')
    @number_brackets = "[#{low_high_num}]" * amount_of_numbers
  end

  def display_john_rules # rubocop:disable Metrics/MethodLength
    puts "\n\nSUBSTITUTIONS".colorize(:light_blue)
    output = []
    if @number_brackets.nil?
      @unique_combinations.each do |rule|
        output << rule.join(' ')
      end
    else
      @unique_combinations.each do |rule|
        output << rule.join(' ')
        output << "#{rule.join(' ')} cAz\"#{@number_brackets}\""
      end
    end
    puts output.join("\n")
  end
end
