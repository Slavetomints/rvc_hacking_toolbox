# frozen_string_literal: true

require 'colorize'
require 'open3'
require_relative 'log_analysis_ascii_art'

# This class houses the AWSLog functions
class AWSLog < LogAnalysis
  def initialize(file)
    LogAnalysisAsciiArt.new('aws')
    puts 'This only works with standard AWS S3 logs'.colorize(:red)
    @file = file
    select_log_mode
  end

  def select_log_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Requests per IP address',
        value: "awk '{count[$5]++} END {for (ip in count) print ip, count [ip]}' #{@file}" },
      { name: 'All requests that resulted in a 404 error', value: "awk '$13 == 404 {print $0}' #{@file}" },
      { name: 'Total bytes sent', value: "awk '{sum += $15} END {print sum}' #{@file}" },
      { name: 'Different HTTP methods used',
        value: "awk '{count[$10]++} END {for (method in count) print method, count[method]}' #{@file}" },
      { name: 'Unique user agents', value: "awk '{agents[$24]++} END {for (agent in agents) print agent}' #{@file}" },
      { name: 'Find all POST requests', value: "awk '$10 ~ /POST/ {print $0}' #{@file}" },
      { name: 'Find all GET requests', value: "awk '$10 ~ /GET/ {print $0}' #{@file}" },
      { name: 'Sort URIs by length',
        value: "awk '{print $11}' #{@file} | awk '{print length, $0}' | sort -n | cut -d' ' -f2-" },
      { name: 'Print operations with empty requester IDs', value: `awk '$8 == "-" {print $7}' #{@file}` },
      { name: 'Go to previous menu', value: -> { LogAnalysis.new } },
      { name: 'Go to main menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    command = prompt.select('Please select your mode', choices, per_page: 30, cycle: true)
    run_command(command, AWSLog)
    select_log_mode
  end
end
