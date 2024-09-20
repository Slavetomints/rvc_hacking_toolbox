# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative 'main_ascii_art'
require_relative 'enumeration_and_exploitation'
require_relative 'forensics'
require_relative 'log_analysis'
require_relative 'network_traffic_analysis'
require_relative 'open_source_intelligence'
require_relative 'scanning_and_reconnaissance'
require_relative 'special_functions'

# This is the main Toolbox class that contains the functinality for the rest of the program
class Toolbox
  def initialize
    show_title
    load_main_menu
  end

  def show_title
    clear_terminal
    puts "\n\n                Welcome to the RVC Hacking Toolbox!".colorize(:green)
    show_ascii_title_image
  end

  def load_main_menu # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Open Source Intelligence', value: 1, disabled: '(In development)' },
      { name: 'Cryptography', value: 2 },
      { name: 'Password Cracking', value: 3 },
      { name: 'Forensics', value: 4, disabled: '(In development)' },
      { name: 'Log Analysis', value: 5, disabled: '(In development)' },
      { name: 'Network Traffic Analysis', value: 6, disabled: '(In development)' },
      { name: 'Scanning & Reconnaissance', value: 7, disabled: '(In development)' },
      { name: 'Web Application Exploitation', value: 8 },
      { name: 'Wireless Access Exploitation', value: 9, disabled: '(In development)' },
      { name: 'Enumeration & Exploitation', value: 10, disabled: '(In development)' },
      { name: 'Quit Program', value: 'quit' }
    ]

    mode = prompt.select('Please select your mode', choices, per_page: 11, cycle: true)
    case mode
    when 1
      clear_terminal
      OpenSourceIntelligence.load_menu
    when 2
      require_relative 'cryptography/cryptography'
      Cryptography.new
    when 3
      require_relative 'password_cracking/password_cracking'
      PasswordCracking.new
    when 4
      clear_terminal
      Forensics.select_mode
    when 5
      clear_terminal
      LogAnalysis.select_mode
    when 6
      clear_terminal
      NetworkTrafficAnalysis.select_mode
    when 7
      clear_terminal
      ScanningAndReconnaissance.select_mode
    when 8
      require_relative 'web_application_exploitation/web_application_exploitation'
      WebApplicationExploitation.new
    when 9
      clear_terminal
      WirelessAccessExploitation.select_mode
    when 10
      clear_terminal
      EnumerationAndExploitation.select_mode
    when 'quit'
      clear_terminal
      exit
    else
      puts 'Invalid mode selected, exiting now'
    end
  end

  def clear_terminal
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
  end

  def quit_or_continue(child_class) # rubocop:disable Metrics/MethodLength
    puts "\n'q'uit program or 'c'ontinue hacking"
    response = gets.chomp
    if response == 'q'
      clear_terminal
      exit
    elsif response == 'c'
      child_class.new
    else
      puts 'Invalid input detected, pick again'.colorize(:red)
      quit_or_continue(child_class)
    end
  end
end
