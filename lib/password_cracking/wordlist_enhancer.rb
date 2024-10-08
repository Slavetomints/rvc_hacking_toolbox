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

    prompt.select('Please select your mode', options, cycle: true, per_page: 7)
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
    word_count = 0
    write_count = 0
    invalid_count = 0

    File.open(number_file, 'w') do |file|
      File.foreach(wordlist_file) do |word|
        unless word.valid_encoding?
          invalid_count += 1
          next
        end
        word_count += 1
        word.strip!
        (low_num.to_i..high_num.to_i).each do |number|
          write_count += 1
          puts "On #{word}: number #{number}"
          if position == 'front'
            file.puts "#{number}#{word}"
          elsif position == 'end'
            file.puts "#{word}#{number}"
          end
        end
      end
      clear_terminal
      PasswordCrackingAsciiArt.new('wordlist_enhancer')
      puts "Processed #{word_count} words"
      puts "Have written #{write_count} words"
      puts "#{invalid_count} words have invalid encoding and were not written"
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
    word_count = 0
    write_count = 0
    invalid_count = 0
    complex_words = 0
    complex_arr = []

    # Opens the file that the variations will be written into, also sets up the
    # buffer to the program stays more memory efficiant, still has problems with
    # very large files such as rockyou.txt
    File.open(leetspeak_file, 'w') do |file|
      word_count = 0
      invalid_count = 0
      complex_words = 0

      # Opens the file that the words will be read from, strips the word of its
      # newline character, and adds the word to the buffer
      File.foreach(wordlist_file) do |word|
        unless word.valid_encoding?
          invalid_count += 1
          next
        end

        word.strip!
        word_count += 1
        puts "Processed #{word_count} words"

        # For every word, check it, then you make the variations of it and then
        # adds the word to the file
        if check(word) == false
          complex_arr << word
          puts word.colorize(:red)
          complex_words += 1
          next
        end
        variations = make_leetspeak_replacements(word)
        file.puts word

        # Adds every variation to the file
        variations.each do |variation|
          write_count += 1
          puts "Have written #{write_count}"
          file.puts variation
        end
      end
    end

    clear_terminal
    PasswordCrackingAsciiArt.new 'wordlist_enhancer'
    puts "Processed #{word_count} words"
    puts "Have written #{write_count} words"
    puts "#{invalid_count} words have invalid encoding and were not written"
    puts "#{complex_words} words were too complex and skipped for program integrity reasons"
    puts complex_arr unless complex_arr == []
    puts "Leetspeak variations written to #{leetspeak_file}"
  end

  def make_leetspeak_replacements(word, index = 0)
    return [''] if index == word.size

    char = word[index]
    suffixes = make_leetspeak_replacements(word, index + 1)
    replacements = @leet_characters[char] ? @leet_characters[char] + [char] : [char]

    replacements.flat_map { |rep| suffixes.map { |suffix| rep + suffix } }
  end

  def check(word)
    leet_count = 0
    word_arr = word.split('')
    word_arr.each do |character|
      leet_count += 1 if @leet_characters.include?(character)
    end
    leet_count < 20
  end
end
