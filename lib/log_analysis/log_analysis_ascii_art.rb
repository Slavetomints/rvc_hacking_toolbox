# frozen_string_literal: true

# This classwhen initialized will display the name of the subtitle from Log Analysis that is passed to it
class LogAnalysisAsciiArt < LogAnalysis
  def initialize(title) # rubocop:disable Metrics/MethodLength
    @title_hash = { 'aws' => '    ___ _       _______     __
   /   | |     / / ___/    / /   ____  ____ _
  / /| | | /| / /\__ \    / /   / __ \/ __ `/
 / ___ | |/ |/ /___/ /   / /___/ /_/ / /_/ /
/_/  |_|__/|__//____/   /_____/\____/\__, /
                                    /____/   ',
                    'nginx' => '    _   _____________   ___  __     __
   / | / / ____/  _/ | / / |/ /    / /   ____  ____ _
  /  |/ / / __ / //  |/ /|   /    / /   / __ \/ __ `/
 / /|  / /_/ // // /|  //   |    / /___/ /_/ / /_/ /
/_/ |_/\____/___/_/ |_//_/|_|   /_____/\____/\__, /
                                            /____/   ',
                    'squid' => '   _____             _     __   __
  / ___/____ ___  __(_)___/ /  / /   ____  ____ _
  \__ \/ __ `/ / / / / __  /  / /   / __ \/ __ `/
 ___/ / /_/ / /_/ / / /_/ /  / /___/ /_/ / /_/ /
/____/\__, /\__,_/_/\__,_/  /_____/\____/\__, /
        /_/                             /____/   ' }
    show_title(title)
  end

  def show_title(title)
    clear_terminal
    colored_title = @title_hash[title].lines.map { |line| line.colorize(:red) }.join
    puts TTY::Box.frame(colored_title,
                        title: { top_left: ' RVC Hacking Toolbox - Log Analysis'.colorize(:green),
                                 bottom_right: Toolbox.version.colorize(:green) },
                        enable_color: true,
                        style: { border: {
                          fg: :red
                        } })
  end
end
