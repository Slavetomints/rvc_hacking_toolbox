# frozen_string_literal: true

require_relative 'password_cracking_ascii_art'

# This class enhanced wordlists by making substitutions and adds numbers before and after words
class WordlistEnhancer
  def initialize # rubocop:disable Metrics/MethodLength
    @leet_characters = {
      'a' => ['4', '@'],
      'A' => ['4', '@'],
      'b' => ['8'],
      'B' => ['8'],
      'c' => ['('],
      'C' => ['('],
      'e' => ['3'],
      'E' => ['3'],
      'i' => ['1'],
      'I' => ['1'],
      'l' => ['1'],
      'L' => ['1'],
      'o' => ['0'],
      'O' => ['0'],
      'r' => ['2'],
      'R' => ['2'],
      's' => ['$'],
      'S' => ['$'],
      't' => ['7'],
      'T' => ['7']
    }
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    select_wordlist_mode
  end

  def select_wordlist_mode
    prompt = TTY::Prompt.new

    options = [
      { name: 'Replace characters/phrases', value: -> { replace_characters_and_phrases } },
      { name: 'Prepend numbers', value: -> { add_numbers('front') } },
      { name: 'Append numbers', value: -> { add_numbers('end') } },
      { name: 'Enhanced leetspeak replacement', value: -> { make_leetspeak_wordlist } },
      { name: 'Go to previous menu', value: -> { PasswordCracking.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.multi_select('Please select your modes', options, cycle: true, per_page: 7)
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

  def replace_characters_and_phrases
  end

  def add_numbers
  end

  def make_leetspeak_wordlist
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    leetspeak_file = File.join(wordlist_path, "leetspeak_#{File.basename(wordlist_file)}")

    File.open(leetspeak_file, 'w') do |file|
      File.readlines(wordlist_file).each do |word|
        word.strip!
        leetspeak_variations = make_leetspeak_replacements(word)
        file.puts word
        leetspeak_variations.each do |variation|
          file.puts variation
        end
      end
    end

    puts "Leetspeak variations written to #{leetspeak_file}"
  end

  def make_leetspeak_replacements(word, index = 0)
    return [''] if index == word.size

    char = word[index]
    suffixes = make_leetspeak_replacements(word, index + 1)
    replacements = @leet_characters[char] ? @leet_characters[char] + [char] : [char]

    replacements.flat_map { |rep| suffixes.map { |suffix| rep + suffix } }
  end
end