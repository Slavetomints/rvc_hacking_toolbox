# frozen_string_literal: true

require 'colorize'
require 'open3'
require_relative 'log_analysis_ascii_art'

# This class houses the NGINX functions
class NGINXLog < LogAnalysis
  def initialize(file)
    LogAnalysisAsciiArt.new('aws')
    puts 'This only works with standard NGINX logs'.colorize(:red)
    @file = file
    select_log_mode
  end

  def select_log_mode # rubocop:disable Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Requests per IP address',
        value: "awk '{count[$1]++} END {for (ip in count) print ip, count[ip]}' #{@file} | sort -nk2
" },
      { name: 'All requests that resulted in a 404 error', value: "awk '$9 == 404 {print $0}' #{@file}
" },
      { name: 'Different HTTP methods used',
        value: "awk '{count[$6]++} END {for (method in count) print method, count[method]}' #{@file}
" },
      [name: 'Unique user agents', value: "awk '{agents[$12]++} END {for (agent in agents) print agent}' #{@file}
"],
      { name: 'Find all POST requests', value: "awk '$6 ~ /POST/ {print $0}' #{@file}
" },
      { name: 'Find all GET requests', value: "awk '$6 ~ /GET/ {print $0}' #{@file}" },
      { name: 'Sort URIs by length',
        value: "awk '{print $7}' #{@file} | awk '{print length, $0}' | sort -n | cut -d' ' -f2-
" },
      { name: 'Find requests with Query Parameters', value: "awk '$7 ~ /\\?/ {print $0}' #{@file}
" },
      { name: 'Count requests by User Agent',
        value: "awk '{count[$12]++} END {for (agent in count) print agent, count[agent]}' #{@file} | sort -nk2
" },
      { name: 'Go to previous menu', value: -> { LogAnalysis.new } },
      { name: 'Go to main menu', value: -> { Toolbox.new } },
      { name: 'Quit Program', value: -> { clear_terminal && exit } }
    ]

    command = prompt.select('Please select your mode', choices, per_page: 30, cycle: true)
    run_command(command, NGINXLog)
    select_log_mode
  end
end
