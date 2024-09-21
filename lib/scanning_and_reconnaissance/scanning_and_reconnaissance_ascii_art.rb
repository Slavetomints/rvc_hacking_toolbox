# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from Scanning And Reconnaissance that is passed to it
class ScanningAndReconnaissanceAsciiArt < ScanningAndReconnaissance
  def initialize(subtitle)
    @subtitle_hash = { 'option' => 'art' }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_scanning_and_reconnaissance
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
