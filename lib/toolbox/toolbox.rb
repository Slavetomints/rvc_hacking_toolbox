# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'

# This is the main Toolbox class that contains the functinality for the rest of the program
class Toolbox
  def initialize
    require_relative 'toolbox_ascii_art'
    ToolboxAsciiArt.new('title')
    load_main_menu
  end

  def self.version
    ' v0.4.0 '
  end

  def load_main_menu # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    prompt = TTY::Prompt.new

    choices = [
      { name: 'Open Source Intelligence', value: lambda {
        require_relative '../open_source_intelligence/open_source_intelligence'
        OpenSourceIntelligence.new
      }, disabled: '(In Development)' },

      { name: 'Cryptography', value: lambda {
        require_relative '../cryptography/cryptography'
        Cryptography.new
      } },

      { name: 'Password Cracking', value: lambda {
        require_relative '../password_cracking/password_cracking'
        PasswordCracking.new
      } },

      { name: 'Forensics', value: lambda {
        require_relative '../forensics/forensics'
        Forensics.new
      } },

      { name: 'Log Analysis', value: lambda {
        require_relative '../log_analysis/log_analysis'
        LogAnalysis.new
      } },
      { name: 'Network Traffic Analysis', value: lambda {
        require_relative '../network_traffic_analysis/network_traffic_analysis'
        NetworkTrafficAnalysis.new
      }, disabled: '(In Development)' },

      { name: 'Scanning & Reconnaissance', value: lambda {
        require_relative '../scanning_and_reconnaissance/scanning_and_reconnaissance'
        ScanningAndReconnaissance.new
      }, disabled: '(In Development)' },

      { name: 'Web Application Exploitation', value: lambda {
        require_relative '../web_application_exploitation/web_application_exploitation'
        WebApplicationExploitation.new
      } },

      { name: 'Wireless Access Exploitation', value: lambda {
        require_relative '../wireless_access_exploitation/wireless_access_exploitation'
        WirelessAccessExploitation.new
      }, disabled: '(In Development)' },

      { name: 'Enumeration & Exploitation', value: lambda {
        require_relative '../enumeration_and_exploitation/enumeration_and_exploitation'
        EnumerationAndExploitation.new
      }, disabled: '(In Development)' },

      { name: 'Quit Program', value: lambda {
        clear_terminal
        exit
      } }
    ]

    prompt.select('Please select your mode', choices, per_page: 11, cycle: true)
  end

  def clear_terminal
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
  end

  def quit_or_continue(child_class)
    prompt = TTY::Prompt.new
    options = [
      { name: 'Continue', value: -> { child_class.new } },
      { name: 'Quit', value: -> { clear_terminal && exit } }

    ]
    prompt.select("\nQuit the program or continue hacking", options, per_page: 2, cycle: true)
  end
end
