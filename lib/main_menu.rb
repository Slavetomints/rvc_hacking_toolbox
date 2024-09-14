# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative 'ascii_art'
require_relative 'cryptography/cryptography'
require_relative 'enumeration_and_exploitation'
require_relative 'forensics'
require_relative 'log_analysis'
require_relative 'network_traffic_analysis'
require_relative 'open_source_intelligence'
require_relative 'password_cracking'
require_relative 'scanning_and_reconnaissance'
require_relative 'web_application_exploitation'
require_relative 'wireless_acess_exploitation'
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
      { name: 'Password Cracking', value: 3, disabled: '(In development)' },
      { name: 'Forensics', value: 4, disabled: '(In development)' },
      { name: 'Log Analysis', value: 5, disabled: '(In development)' },
      { name: 'Network Traffic Analysis', value: 6, disabled: '(In development)' },
      { name: 'Scanning & Reconnaissance', value: 7, disabled: '(In development)' },
      { name: 'Web Application Exploitation', value: 8, disabled: '(In development)' },
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
      Cryptography.new
    when 3
      clear_terminal
      PasswordCracking.select_mode
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
      clear_terminal
      WebApplicationExploitation.select_mode
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
end
