# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from NetworkTrafficAnalysis that is passed to it
class NetworkTrafficAnalysisAsciiArt < NetworkTrafficAnalysis
  def initialize(subtitle)
    @subtitle_hash = { 'option' => 'art' }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_network_traffic_analysis
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
