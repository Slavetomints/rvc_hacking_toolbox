# frozen_string_literal: true

require 'tty-prompt'
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
      { name: 'Remove x number of characters in a row', value: -> { remove_x_characters_in_a_row } },
      { name: 'Remove x number of characters in a word', value: -> { remove_x_characters } },
      { name: 'Go to previous menu', value: -> { PasswordCracking.new } },
      { name: 'Go to Main Menu', value: -> { Toolbox.new } },
      { name: 'Quit application', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select your mode', options, cycle: true, per_page: 9)
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

  def update_progress(count, total_lines)
    percentage = (count.to_f / total_lines * 100).round(2)
    remaining = total_lines - count
    print "\e[s" # Save cursor position
    print "\e[14;0H" # Move cursor to the second line (assuming the title is on the first line)
    print "\e[14K" # Clear the line
    puts "#{percentage}% completed, #{remaining} left to go!"
    print "\e[u" # Restore cursor position
  end

  def remove_x_characters
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    removed_chars_file = File.join(wordlist_path, "removed_#{File.basename(wordlist_file)}")

    puts 'Loading File...'
    total_lines = `wc -l "#{wordlist_file}"`.strip.split(' ').first.to_i
    puts 'File Loaded!'.colorize(:green)

    prompt = TTY::Prompt.new
    prompt.keypress("#{total_lines} passwords loaded, press any key to continue")

    clear_terminal
    PasswordCrackingAsciiArt.new('remove_chars')

    puts 'Enter the number of allowed character repetitions: '
    allowed_repeats = gets.chomp.to_i

    word_count = 0
    write_count = 0

    File.open(removed_chars_file, 'w') do |file|
      File.foreach(wordlist_file) do |word|
        word.chomp!
        variations = [word]

        # Create a hash to count the occurrences of each character
        char_count = Hash.new(0)
        word.each_char { |char| char_count[char] += 1 }

        # Generate variations by removing characters that appear more than the allowed repeats
        char_count.each do |char, count|
          next unless count > allowed_repeats

          (count - allowed_repeats).times do
            new_word = word.sub(char, '')
            variations << new_word unless variations.include?(new_word)
            word = new_word
          end
        end

        variations.uniq.each do |variant|
          file.puts variant
          write_count += 1
        end

        word_count += 1
        update_progress(word_count, total_lines)
      end
    end

    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    puts "Processed #{word_count} words"
    puts "Have written #{write_count} words"
    puts "Number of words with excessive characters removed written to #{removed_chars_file}"
  end

  def remove_x_characters_in_a_row
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    removed_chars_file = File.join(wordlist_path, "x_in_a_row_#{File.basename(wordlist_file)}")

    puts "How many chars in a row do you want to remove? Ex. -> 3 will turn 'aaanexample' into 'anexample'"
    number_to_remove = gets.chomp.to_i

    puts 'Loading File...'
    total_lines = `wc -l "#{wordlist_file}"`.strip.split(' ').first.to_i
    puts 'File Loaded!'.colorize(:green)

    prompt = TTY::Prompt.new
    prompt.keypress("#{total_lines} passwords loaded, press any key to continue")

    clear_terminal
    PasswordCrackingAsciiArt.new('remove_chars')

    word_count = 0
    write_count = 0

    File.open(removed_chars_file, 'w') do |file|
      File.foreach(wordlist_file) do |word|
        word.chomp!

        new_word = word.dup
        new_word_reduced = word.dup
        removed = true

        while removed
          removed = false
          (0..new_word.length - number_to_remove).each do |i|
            substr = new_word[i, number_to_remove]
            next unless substr.chars.uniq.length == 1

            new_word.slice!(i, number_to_remove)
            new_word_reduced.slice!(i + 1, number_to_remove - 1)
            removed = true
            break
          end
        end

        unless new_word.empty?
          file.puts new_word
          write_count += 1
        end

        unless new_word_reduced.empty?
          file.puts new_word_reduced
          write_count += 1
        end

        word_count += 1
        update_progress(word_count, total_lines)
      end
    end

    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    puts "Processed #{word_count} words"
    puts "Have written #{write_count} words"
    puts "Number variations written to #{removed_chars_file}"
  end

  def add_numbers(position) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    number_file = File.join(wordlist_path, "numbers_#{File.basename(wordlist_file)}")
    puts "What is the range of numbers you'd like to add? example: '1-999' "
    range = gets.chomp.split('-')
    puts 'Loading File . . .'
    total_lines = `wc -l "#{wordlist_file}"`.strip.split(' ').first.to_i
    puts 'File Loaded!'.colorize(:green)
    prompt = TTY::Prompt.new
    prompt.keypress("#{total_lines} passwords loaded, press any key to continue")
    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    low_num = range[0].to_i
    high_num = range[1].to_i
    word_count = 0
    write_count = 0
    invalid_count = 0
    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')

    File.open(number_file, 'w') do |file| # rubocop:disable Metrics/BlockLength
      File.foreach(wordlist_file) do |word|
        unless word.valid_encoding?
          invalid_count += 1
          next
        end
        word_count += 1
        word.strip!
        update_progress(word_count, total_lines)
        if position == 'front'
          (low_num..high_num).each do |number|
            (number.to_s.length.to_i..high_num.to_s.length.to_i).each do |pad|
              formatted_number = number.to_s.rjust(pad, '0')
              write_count += 1

              file.puts "#{formatted_number}#{word}"
            end
          end
        elsif position == 'end'
          (low_num..high_num).each do |number|
            (number.to_s.length.to_i..high_num.to_s.length.to_i).each do |pad|
              formatted_number = number.to_s.rjust(pad, '0')
              write_count += 1

              file.puts "#{word}#{formatted_number}"
            end
          end
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

  def make_leetspeak_wordlist # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    # gets the file to read the words from and creates the file to send words to
    # also initializes the buffer count so it may be referenced at the end of
    # the program
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    leetspeak_file = File.join(wordlist_path, "leetspeak_#{File.basename(wordlist_file)}")
    puts 'Loading File . . .'
    total_lines = `wc -l "#{wordlist_file}"`.strip.split(' ').first.to_i
    puts 'File Loaded!'.colorize(:green)
    prompt = TTY::Prompt.new
    prompt.keypress("#{total_lines} passwords loaded, press any key to continue")
    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
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
        update_progress(word_count, total_lines)
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

  def replace_characters_and_phrases # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    wordlist_file = select_file
    wordlist_path = File.dirname(wordlist_file)
    new_file = File.join(wordlist_path, "numbers_#{File.basename(wordlist_file)}")
    subs = set_substitutions
    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    puts 'Loading File . . .'
    total_lines = `wc -l "#{wordlist_file}"`.strip.split(' ').first.to_i
    puts 'File Loaded!'.colorize(:green)
    prompt = TTY::Prompt.new
    prompt.keypress("#{total_lines} passwords loaded, press any key to continue")
    clear_terminal
    PasswordCrackingAsciiArt.new('wordlist_enhancer')
    write_count = 0
    word_count = 0
    invalid_count = 0
    File.open(new_file, 'w') do |file|
      write_count = 0
      word_count = 0
      invalid_count = 0
      File.foreach(wordlist_file) do |word|
        word_count += 1
        update_progress(word_count, total_lines)
        unless word.valid_encoding?
          invalid_count += 1
          next
        end
        subs.each do |sub_arr|
          new_word = word.gsub(sub_arr[0], sub_arr[1])
          file.puts new_word
          write_count += 1
        end
      end
    end
    clear_terminal
    PasswordCrackingAsciiArt.new 'wordlist_enhancer'
    puts "Processed #{word_count} words"
    puts "Have written #{write_count} words"
    puts "#{invalid_count} words have invalid encoding and were not written"
    puts "Leetspeak variations written to #{new_file}"
  end
end
