# frozen_string_literal: true

require 'tty-box'
require 'tty-prompt'
require_relative 'lib/toolbox/toolbox'

@exit_flag = false

def exit? # rubocop:disable Metrics/MethodLength
  prompt = TTY::Prompt.new
  options = [
    { name: 'Exit Program', value: lambda {
      clear_terminal
      @exit_flag = true
    } },
    { name: 'Stay in program', value: -> { main } }
  ]
  clear_terminal
  puts TTY::Box.error('An error occured')
  begin
    prompt.select('Please select', options)
  rescue TTY::Reader::InputInterrupt
    exit?
  rescue Interrupt
    exit?
  rescue StandardError
    exit?
  end
end

def clear_terminal
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

def main # rubocop:disable Metrics/MethodLength
  loop do
    begin
      Toolbox.new
    rescue TTY::Reader::InputInterrupt
      exit?
    rescue Interrupt
      exit?
    rescue StandardError
      exit?
    end
    break if @exit_flag
  end

  clear_terminal
end

main
