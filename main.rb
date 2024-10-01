# frozen_string_literal: true

require_relative 'lib/toolbox/toolbox'

def clear_terminal
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

Signal.trap('INT') do
  clear_terminal
  exit
end

begin
  Toolbox.new
rescue TTY::Reader::InputInterrupt
  clear_terminal
  exit
rescue StandardError
  clear_terminal
  exit
end
