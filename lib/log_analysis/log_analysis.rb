# frozen_string_literal: true

require 'colorize'
require_relative '../toolbox/toolbox_ascii_art'
require_relative '../toolbox/toolbox'

# houses the main Log Analysis functions and the menu for it
class LogAnalysis < Toolbox
  def initialize
    ToolboxAsciiArt.new('log_analysis')
    select_log_analysis_mode
  end

  def select_log_analysis_mode # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    @file = select_file
    prompt = TTY::Prompt.new

    choices = [
      { name: 'AWS S3 Log', value: lambda {
        require_relative 'aws_log'
        AWSLog.new(@file)
      } },
      { name: 'Nginx Log', value: lambda {
        require_relative 'nginx_log'
        NGINXLog.new(@file)
      } },
      { name: 'Squid Log', value: lambda {
        require_relative 'squid_log'
        SquidLog.new(@file)
      } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select your mode', choices, per_page: 7, cycle: true)
  end

  def select_file # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    prompt = TTY::Prompt.new
    current_path = File.expand_path('~')

    loop do
      entries = Dir.entries(current_path).select { |entry| entry != '.' && !entry.start_with?('.') }
      entries.unshift('..') unless current_path == File.expand_path('~')
      file_path = prompt.select('Please select a file or directory:', entries, cycle: true, per_page: 20)

      selected_path = File.join(current_path, file_path)
      if file_path == '..'
        current_path = File.expand_path('..', current_path)
      elsif File.directory?(selected_path)
        current_path = selected_path
      else
        puts "You selected: #{selected_path}"
        return selected_path
      end
    end
  end

  def run_command(command, child_class)
    system(command)
    prompt = TTY::Prompt.new
    prompt.keypress('Press space or enter to continue', keys: %i[space return])
    child_class.new(@file)
  end
end
