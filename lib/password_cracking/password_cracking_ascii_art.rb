# frozen_string_literal: true

# This classwhen initialized will display the name of the subtitle that is passed to it
class PasswordCrackingAsciiArt < PasswordCracking
  def initialize(subtitle) # rubocop:disable Metrics/MethodLength
    @subtitle_hash = { 'john' => "/================================================\\
||       __      __             ________        ||
||      / /___  / /_  ____     /_  __/ /_  ___  ||
|| __  / / __ \\/ __ \\/ __ \\     / / / __ \\/ _ \\ ||
||/ /_/ / /_/ / / / / / / /    / / / / / /  __/ ||
||\\____/\\____/_/ /_/_/ /_/    /_/ /_/ /_/\\___/  ||
||                                              ||
||    ____  _                                   ||
||   / __ \\(_)___  ____  ___  _____             ||
||  / /_/ / / __ \\/ __ \\/ _ \\/ ___/             ||
|| / _, _/ / /_/ / /_/ /  __/ /                 ||
||/_/ |_/_/ .___/ .___/\\___/_/                  ||
||       /_/   /_/                              ||
\\================================================/" }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_password_cracking
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
