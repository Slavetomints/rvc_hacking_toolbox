# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from Open source Intelligence that is passed to it
class OpenSourceIntelligenceAsciiArt < OpenSourceIntelligence
  def initialize(subtitle)
    @subtitle_hash = { 'option' => 'art' }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_open_source_intelligence
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
