# frozen_string_literal: true

require_relative 'password_cracking_ascii_art'

# This class enhanced wordlists by making substitutions and adds numbers before and after words
class WordlistEnhancer < PasswordCracking # rubocop:disable Metrics/ClassLength
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
    quit_or_continue(WordlistEnhancer)
  end

  def select_wordlist_mode # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
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

  def add_numbers(position) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    number_file = File.join(wordlist_path, "numbers_#{File.basename(wordlist_file)}")
    puts "What is the range of numbers you'd like to add? example: '1-999' "
    range = gets.chomp.split('-')
    low_num = range[0]
    high_num = range[1]

    File.open(number_file, 'w') do |file|
      File.foreach(wordlist_file) do |word|
        word.strip!
        buffer = []
        buffer << word
        if buffer.size >= 1000
          buffer.each do |word|
            file.puts word
            (low_num.to_i..high_num.to_i).each do |number|
              if position == 'front'
                file.puts "#{number}#{word}"
              elsif position == 'end'
                file.puts "#{word}#{number}"
              end
              buffer.clear
            end
          end
        end
      end
      puts "Number variations written to #{number_file}"
    end
  end

  def make_leetspeak_wordlist # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    # gets the file to read the words from and creates the file to send words to
    # also initializes the buffer count so it may be referenced at the end of
    # the program
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    leetspeak_file = File.join(wordlist_path, "leetspeak_#{File.basename(wordlist_file)}")
    buffer_count = 0
    write_count = 0

    # Opens the file that the variations will be written into, also sets up the
    # buffer to the program stays more memory efficiant, still has problems with
    # very large files such as rockyou.txt
    File.open(leetspeak_file, 'w') do |file|
      buffer = []
      buffer_count = 0

      # Opens the file that the words will be read from, strips the word of its
      # newline character, and adds the word to the buffer
      File.foreach(wordlist_file) do |word|
        word.strip!
        buffer << word

        # Once the buffer is equal to or greater than 100, it enters the
        # processing block.
        if buffer.size >= 1
          buffer_count += 1
          puts "Processed #{buffer_count} words"

          # For every word in the buffer, you make the variations of it and then
          # adds the word to the file
          buffer.each do |word|
            variations = make_leetspeak_replacements(word)
            file.puts word

            # Adds every variation to the file
            variations.each do |variation|
              write_count += 1
              puts "Have written #{write_count}"
              file.puts variation
            end
          end
          buffer.clear
        end
      end
      # Processes the remaining words that were stuck in the buffer
      buffer.each do |word|
        variations = make_leetspeak_replacements(word)
        file.puts word

        variations.each do |variation|
          puts "Have written #{write_count}"
          file.puts variation
        end
      end
    end
    clear_terminal
    PasswordCrackingAsciiArt.new 'wordlist_enhancer'
    puts "Processed #{buffer_count} words"
    puts "Have written #{write_count}"
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
