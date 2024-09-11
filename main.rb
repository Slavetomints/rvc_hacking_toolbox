# frozen_string_literal: true

require 'colorize'
require_relative 'lib/initialization'

show_title
mode = select_mode

case mode
when '1'
  puts '1'
when '2'
  puts '2'
when '3'
  puts '3'
when '4'
  puts '4'
when '5'
  puts '5'
when '6'
  puts '6'
when '7'
  puts '7'
when '8'
  puts '8'
when '9'
  puts '9'
when '10'
  puts '10'
when 'quit'
  exit
else
  puts 'Invalid mode selected'
end
