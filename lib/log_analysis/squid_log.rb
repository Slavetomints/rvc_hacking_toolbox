# frozen_string_literal: true

require 'colorize'
require 'open3'
require_relative 'log_analysis_ascii_art'

# This class houses the Base64 functions
class SquidLog < LogAnalysis
  def initialize(file)
    LogAnalysisAsciiArt.new('squid')
    puts 'This only works with standard Squid logs'.colorize(:red)
    @file = file
    select_log_mode
  end

  def select_log_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Requests per IP address',
        value: "awk 'count{count[$1]++} END {for (ip in count) print ip, count [ip]}' #{@file}" },
      { name: 'All requests that resulted in a 404 error', value: "awk '$9 == 404 {print $0}' #{@file}
" },
      { name: 'Total bytes sent', value: "awk '{sum += $10} END {print sum}' #{@file}
" },
      { name: 'Different HTTP methods used',
        value: "awk '{count[$6]++} END {for (method in count) print method, count[method]}' #{@file}
" },
      [name: 'Unique user agents', value: "awk '{agents[$12]++} END {for (agent in agents) print agent}' #{@file}
"],
      { name: 'Find all POST requests', value: `awk '$6 == "POST" {print $0}' #{@file}
` },
      { name: 'Find all GET requests', value: `awk '$6 == "get" {print $0}' #{@file}
` },
      { name: 'Sort URIs by length',
        value: `awk '{print $7}' #{@file} | awk '{print length, $0}' | sort -n | cut -d" " -f2-
` },
      { name: 'Print operations with empty requester IDs', value: `awk '$13 == "-" {print $7}' #{@file}
` },
      { name: 'Go to previous menu', value: -> { LogAnalysis.new } },
      { name: 'Go to main menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    command = prompt.select('Please select your mode', choices, per_page: 30, cycle: true)
    run_command(command)
    select_log_mode
  end
end
