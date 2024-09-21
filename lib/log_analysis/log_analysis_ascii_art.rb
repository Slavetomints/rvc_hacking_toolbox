# frozen_string_literal: true

# This classwhen initialized will display the name of the subtitle from Log Analysis that is passed to it
class LogAnalysisAsciiArt < LogAnalysis
  def initialize(subtitle)
    @subtitle_hash = { 'option' => 'art' }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_log_analysis
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
