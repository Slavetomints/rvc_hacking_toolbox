# frozen_string_literal: true

require 'colorize'

def clear_terminal
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

# validation of mode
def validate_mode(menu) # rubocop:disable Metrics/MethodLength
  print("\n\n  Please select your mode: ")
  mode = gets.chomp

  case menu
  when 'main'
    acceptable_inputs = %w[1 2 3 4 5 6 7 8 9 10 quit boykisser]
  when 'cryptography_main'
    acceptable_inputs = %w[1 2 3 4 5 6 7 8 9 10 11 12 quit main]
  when 'one_two'
    acceptable_inputs = %w[1 2 quit main previous]
  end

  acceptable_inputs.each do |input|
    return mode if input == mode
  end

  puts 'Invalid mode selected, please select a new mode'.colorize(:red)
  validate_mode(menu)
end
