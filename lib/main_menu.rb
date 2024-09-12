# frozen_string_literal: true

require 'colorize'
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

def show_title
  clear_terminal
  puts "\n\n      Welcome to the RVC Hacking Toolbox!".colorize(:green)
  show_ascii_title_image
end

def select_main_mode
  puts '1 - Open Source Intelligence        6 - Network Traffic Analysis'
  puts '2 - Cryptography                    7 - Scanning & Reconnaissance'
  puts '3 - Password Cracking               8 - Web Application Exploitation'
  puts '4 - Forensics                       9 - Wireless Access Exploitation'
  puts '5 - Log Analysis                    10 - Enumeration & Exploitation'
  puts "'quit' to quit"

  validate_mode('main')
end

def load_title_page # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength
  show_title
  mode = select_main_mode

  case mode
  when '1'
    clear_terminal
    OpenSourceIntelligence.load_menu
  when '2'
    clear_terminal
    Cryptography.load_menu
  when '3'
    clear_terminal
    PasswordCracking.select_mode
  when '4'
    clear_terminal
    Forensics.select_mode
  when '5'
    clear_terminal
    LogAnalysis.select_mode
  when '6'
    clear_terminal
    NetworkTrafficAnalysis.select_mode
  when '7'
    clear_terminal
    ScanningAndReconnaissance.select_mode
  when '8'
    clear_terminal
    WebApplicationExploitation.select_mode
  when '9'
    clear_terminal
    WirelessAccessExploitation.select_mode
  when '10'
    clear_terminal
    EnumerationAndExploitation.select_mode
  when 'quit'
    clear_terminal
    exit
  when 'boykisser'
    show_boykisser
    exit
  else
    puts 'Invalid mode selected, exiting now'
  end
end
