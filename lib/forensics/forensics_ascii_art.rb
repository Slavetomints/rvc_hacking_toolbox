# frozen_string_literal: true

# This class when initialized will display the name of the subtitle from Forensics that is passed to it
class ForensicsAsciiArt < Forensics
  def initialize(subtitle)
    @subtitle_hash = { 'metadata' => "/======================================================================\\
||    _______ __          __  ___     __            __      __        ||
||   / ____(_) /__       /  |/  /__  / /_____ _____/ /___ _/ /_____ _ ||
||  / /_  / / / _ \\     / /|_/ / _ \\/ __/ __ `/ __  / __ `/ __/ __ `/ ||
|| / __/ / / /  __/    / /  / /  __/ /_/ /_/ / /_/ / /_/ / /_/ /_/ /  ||
||/_/   /_/_/\\___/    /_/  /_/\\___/\\__/\\__,_/\\__,_/\\__,_/\\__/\\__,_/   ||
\\======================================================================/" }
    show_subtitle(subtitle)
  end

  def show_subtitle(subtitle)
    clear_terminal
    show_forensics
    puts @subtitle_hash[subtitle].colorize(:red)
  end
end
