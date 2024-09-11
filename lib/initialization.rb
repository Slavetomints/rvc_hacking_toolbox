# frozen_string_literal: true

require_relative 'ascii_art'
require 'colorize'

def show_title
  puts "\n\n      Welcome to the RVC Hacking Toolbox!".colorize(:green)
  show_ascii_title_image
end

def select_main_mode # rubocop:disable Metrics/MethodLength
  acceptable_inputs = %w[1 2 3 4 5 6 7 8 9 10 quit]
  puts '1 - Open Source Intelligence        6 - Network Traffic Analysis'
  puts '2 - Cryptography                    7 - Scanning & Reconnaissance'
  puts '3 - Password Cracking               8 - Web Application Exploitation'
  puts '4 - Forensics                       9 - Wireless Access Exploitation'
  puts '5 - Log Analysis                    10 - Enumeration & Exploitation'
  puts "'quit' to quit"

  puts("\n\nPlease select your mode: ")
  mode = gets.chomp

  # validation of mode
  acceptable_inputs.each do |input|
    puts mode
    puts mode.class
    puts input
    puts input.class
    return mode if input == mode
  end

  puts 'Invalid mode selected, please select a new mode'
  select_main_mode
end
