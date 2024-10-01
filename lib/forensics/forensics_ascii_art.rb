# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from Forensics that is passed to it
class ForensicsAsciiArt < Forensics
  def initialize(title)
    @title_hash = { 'metadata' => '    _______ __          __  ___     __            __      __
   / ____(_) /__       /  |/  /__  / /_____ _____/ /___ _/ /_____ _
  / /_  / / / _ \     / /|_/ / _ \/ __/ __ `/ __  / __ `/ __/ __ `/
 / __/ / / /  __/    / /  / /  __/ /_/ /_/ / /_/ / /_/ / /_/ /_/ /
/_/   /_/_/\___/    /_/  /_/\___/\__/\__,_/\__,_/\__,_/\__/\__,_/  ' }
    show_title(title)
  end

  def show_title(title)
    clear_terminal
    colored_title = @title_hash[title].lines.map { |line| line.colorize(:red) }.join
    puts TTY::Box.frame(colored_title,
                        title: { top_left: ' RVC Hacking Toolbox - Forensics'.colorize(:green),
                                 bottom_right: Toolbox.version.colorize(:green) },
                        enable_color: true,
                        style: { border: {
                          fg: :red
                        } })
  end
end
