# frozen_string_literal: true

require 'fileutils'
require 'tty-prompt'
require 'xattr'
require_relative 'forensics_ascii_art'

# This class display the menu and houses the funtions for a file metadata scan
class Metadata < Forensics
  def initialize
    ForensicsAsciiArt.new('metadata')
    puts 'Enter a file path:'
    file_path = ARGF.gets.chomp
    puts "Selected file: #{file_path}"
  end
end
