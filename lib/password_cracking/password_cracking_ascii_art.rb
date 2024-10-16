# frozen_string_literal: true

# This classwhen initialized will display the name of the subtitle that is passed to it
class PasswordCrackingAsciiArt < PasswordCracking
  def initialize(title) # rubocop:disable Metrics/MethodLength
    @title_hash = { 'john' => '       __      __             ________
      / /___  / /_  ____     /_  __/ /_  ___
 __  / / __ \/ __ \/ __ \     / / / __ \/ _ \
/ /_/ / /_/ / / / / / / /    / / / / / /  __/
\____/\____/_/ /_/_/ /_/    /_/ /_/ /_/\___/

    ____  _
   / __ \(_)___  ____  ___  _____
  / /_/ / / __ \/ __ \/ _ \/ ___/
 / _, _/ / /_/ / /_/ /  __/ /
/_/ |_/_/ .___/ .___/\___/_/
       /_/   /_/                             ',
                    'wordlist_enhancer' => ' _       __               _____      __
| |     / /___  _________/ / (_)____/ /_
| | /| / / __ \/ ___/ __  / / / ___/ __/
| |/ |/ / /_/ / /  / /_/ / / (__  ) /_
|__/|__/\____/_/   \__,_/_/_/____/\__/

    ______           __
   / ____/___  _____/ /_  ____ _____  ________  _____
  / __/ / __ \/ ___/ __ \/ __ `/ __ \/ ___/ _ \/ ___/
 / /___/ / / / /__/ / / / /_/ / / / / /__/  __/ /
/_____/_/ /_/\___/_/ /_/\__,_/_/ /_/\___/\___/_/     ' }
    show_title(title)
  end

  def show_title(title)
    clear_terminal
    colored_title = @title_hash[title].lines.map { |line| line.colorize(:red) }.join
    puts TTY::Box.frame(colored_title,
                        title: { top_left: ' RVC Hacking Toolbox - Password Cracking'.colorize(:green),
                                 bottom_right: Toolbox.version.colorize(:green) },
                        enable_color: true,
                        style: { border: {
                          fg: :red
                        } })
  end
end
