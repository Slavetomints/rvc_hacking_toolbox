# frozen_string_literal: true

require 'colorize'
require_relative 'lib/initialization'
require_relative 'lib/cryptography'
require_relative 'lib/enumeration_and_exploitation'
require_relative 'lib/forensics'
require_relative 'lib/log_analysis'
require_relative 'lib/network_traffic_analysis'
require_relative 'lib/open_source_intelligence'
require_relative 'lib/password_cracking'
require_relative 'lib/scanning_and_reconnaissance'
require_relative 'lib/web_application_exploitation'
require_relative 'lib/wireless_acess_exploitation'

show_title
mode = select_main_mode

case mode
when '1'
  OpenSourceIntelligence.select_mode
when '2'
  Cryptography.select_mode
when '3'
  PasswordCracking.select_mode
when '4'
  Forensics.select_mode
when '5'
  LogAnalysis.select_mode
when '6'
  NetworkTrafficAnalysis.select_mode
when '7'
  ScanningAndReconnaissance.select_mode
when '8'
  WebApplicationExploitation.select_mode
when '9'
  WirelessAccessExploitation.select_mode
when '10'
  EnumerationAndExploitation.select_mode
when 'quit'
  exit
else
  puts 'Invalid mode selected, exiting now'
end
