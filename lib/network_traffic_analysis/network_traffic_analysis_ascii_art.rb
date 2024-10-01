# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from NetworkTrafficAnalysis that is passed to it
class NetworkTrafficAnalysisAsciiArt < NetworkTrafficAnalysis
  def initialize(title)
    @subtitle_hash = { 'option' => 'art' }
    show_title(title)
  end

  def show_title(title)
    clear_terminal
    colored_title = @title_hash[title].lines.map { |line| line.colorize(:red) }.join
    puts TTY::Box.frame(colored_title,
                        title: { top_left: ' RVC Hacking Toolbox '.colorize(:green),
                                 bottom_right: Toolbox.version.colorize(:green) },
                        enable_color: true,
                        style: { border: {
                          fg: :red
                        } })
  end
end
