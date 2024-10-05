# frozen_string_literal: true

# This class enhanced wordlists by making substitutions and adds numbers before and after words
class WordlistEnhancer
  def initialize
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    select_wordlist_mode
  end

  def select_wordlist_mode
    prompt = TTY::Prompt.new

    options = [
      { name: 'Replace characters/phrases', value: -> { replace_characters_and_phrases } },
      { name: 'Prepend numbers', value: -> { add_numbers('front') } },
      { name: 'Append numbers', value: -> { add_numbers('end') } },
      { name: 'Enhanced leetspeak replacement', value: -> { leetspeak } },
      { name: 'Go to previous menu', value: -> { PasswordCracking.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.multi_select('Please select your modes', options, cycle: true, per_page: 7)
  end

  def replace_characters_and_phrases
  end

  def add_numbers
  end

  def leetspeak
  end
end
