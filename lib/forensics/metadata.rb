# frozen_string_literal: true

require 'tty-prompt'
require 'fileutils'
require 'exifr/jpeg'
require 'exifr/tiff'
require 'mini_exiftool'
require 'mp3info'
require 'pdf-reader'
require 'mini_magick'
require_relative 'forensics_ascii_art'

# This class displays the menu and houses the functions for a file metadata scan
class Metadata < Forensics # rubocop:disable Metrics/ClassLength
  def initialize # rubocop:disable Metrics/MethodLength
    ForensicsAsciiArt.new('metadata')
    prompt = TTY::Prompt.new
    file_path = prompt.ask('Enter a file path (absolute path from root):')
    absolute_path = File.expand_path(file_path, '/')
    if File.exist?(absolute_path)
      puts "Selected file: #{absolute_path}"
      print_metadata(absolute_path)
      quit_or_continue(Metadata)
    else
      puts 'File not found. Please try again.'
      Metadata.new
    end
  end

  def print_metadata(file_path) # rubocop:disable Metrics/MethodLength
    case File.extname(file_path).downcase
    when '.jpg', '.jpeg'
      print_jpeg_metadata(file_path)
    when '.tiff', '.tif'
      print_tiff_metadata(file_path)
    when '.mp3'
      print_mp3_metadata(file_path)
    when '.png'
      print_png_metadata(file_path)
    when '.pdf'
      print_pdf_metadata(file_path)
    else
      puts 'Unsupported file type, please raise an issue on the GitHub for this project if you think it should be added'
    end
  end

  def print_jpeg_metadata(file_path) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
    metadata = EXIFR::JPEG.new(file_path)
    puts "\nAvaliable metadata for #{file_path}:\n\n".colorize(:green)
    puts "Camera Model: #{metadata.model}" if metadata.model
    puts "Date Time: #{metadata.date_time}" if metadata.date_time
    puts "Exposure Time: #{metadata.exposure_time}" if metadata.exposure_time
    puts "F-Number: #{metadata.f_number}" if metadata.f_number
    puts "ISO Speed Ratings: #{metadata.iso_speed_ratings}" if metadata.iso_speed_ratings
    puts "GPS Latitude: #{metadata.gps&.latitude}" if metadata.gps&.latitude
    puts "GPS Longitude: #{metadata.gps&.longitude}" if metadata.gps&.longitude
    puts "Image Width: #{metadata.width}" if metadata.width
    puts "Image Height: #{metadata.height}" if metadata.height
    puts "Orientation: #{metadata.orientation}" if metadata.orientation
    puts "Software: #{metadata.software}" if metadata.software
    puts "Maker Note: #{metadata.maker_note}" if metadata.maker_note
    puts "Flash: #{metadata.flash}" if metadata.flash
    puts "White Balance: #{metadata.white_balance}" if metadata.white_balance
    puts "Exposure Program: #{metadata.exposure_program}" if metadata.exposure_program
    puts "Exposure Bias: #{metadata.exposure_bias_value}" if metadata.exposure_bias_value
    puts "Max Aperture Value: #{metadata.max_aperture_value}" if metadata.max_aperture_value
    puts "Metering Mode: #{metadata.metering_mode}" if metadata.metering_mode
    puts "Light Source: #{metadata.light_source}" if metadata.light_source
    puts "Color Space: #{metadata.color_space}" if metadata.color_space
    puts "File Source: #{metadata.file_source}" if metadata.file_source
    puts "Scene Type: #{metadata.scene_type}" if metadata.scene_type
    puts "Custom Rendered: #{metadata.custom_rendered}" if metadata.custom_rendered
    puts "Exposure Mode: #{metadata.exposure_mode}" if metadata.exposure_mode
    puts "Digital Zoom Ratio: #{metadata.digital_zoom_ratio}" if metadata.digital_zoom_ratio
    puts "Focal Length: #{metadata.focal_length}" if metadata.focal_length
    puts "Focal Length in 35mm: #{metadata.focal_length_in_35mm_film}" if metadata.focal_length_in_35mm_film
    puts "Scene Capture Type: #{metadata.scene_capture_type}" if metadata.scene_capture_type
    puts "Gain Control: #{metadata.gain_control}" if metadata.gain_control
    puts "Contrast: #{metadata.contrast}" if metadata.contrast
    puts "Saturation: #{metadata.saturation}" if metadata.saturation
    puts "Sharpness: #{metadata.sharpness}" if metadata.sharpness
    puts "Image Description: #{metadata.image_description}" if metadata.image_description
    puts "Artist: #{metadata.artist}" if metadata.artist
    puts "Copyright: #{metadata.copyright}" if metadata.copyright
  end

  def print_tiff_metadata(file_path) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    metadata = EXIFR::TIFF.new(file_path)
    puts "\nAvaliable metadata for #{file_path}:\n\n".colorize(:green)
    puts "Camera Model: #{metadata.model}" if metadata.model
    puts "Date Time: #{metadata.date_time}" if metadata.date_time
    puts "Exposure Time: #{metadata.exposure_time}" if metadata.exposure_time
    puts "F-Number: #{metadata.f_number}" if metadata.f_number
    puts "ISO Speed Ratings: #{metadata.iso_speed_ratings}" if metadata.iso_speed_ratings
    puts "GPS Latitude: #{metadata.gps&.latitude}" if metadata.gps&.latitude
    puts "GPS Longitude: #{metadata.gps&.longitude}" if metadata.gps&.longitude
    puts "Image Width: #{metadata.width}" if metadata.width
    puts "Image Height: #{metadata.height}" if metadata.height
    puts "Orientation: #{human_readable_orientation(metadata.orientation)}" if metadata.orientation
    puts "Software: #{metadata.software}" if metadata.software
    puts "Maker Note: #{metadata.maker_note}" if metadata.maker_note
    puts "Flash: #{metadata.flash}" if metadata.flash
    puts "White Balance: #{metadata.white_balance}" if metadata.white_balance
    puts "Exposure Program: #{metadata.exposure_program}" if metadata.exposure_program
    puts "Exposure Bias: #{metadata.exposure_bias_value}" if metadata.exposure_bias_value
    puts "Max Aperture Value: #{metadata.max_aperture_value}" if metadata.max_aperture_value
    puts "Metering Mode: #{metadata.metering_mode}" if metadata.metering_mode
    puts "Light Source: #{metadata.light_source}" if metadata.light_source
    puts "Color Space: #{metadata.color_space}" if metadata.color_space
    puts "File Source: #{metadata.file_source}" if metadata.file_source
    puts "Scene Type: #{metadata.scene_type}" if metadata.scene_type
    puts "Custom Rendered: #{metadata.custom_rendered}" if metadata.custom_rendered
    puts "Exposure Mode: #{metadata.exposure_mode}" if metadata.exposure_mode
    puts "Digital Zoom Ratio: #{metadata.digital_zoom_ratio}" if metadata.digital_zoom_ratio
    puts "Focal Length: #{metadata.focal_length}" if metadata.focal_length
    puts "Focal Length in 35mm: #{metadata.focal_length_in_35mm_film}" if metadata.focal_length_in_35mm_film
    puts "Scene Capture Type: #{metadata.scene_capture_type}" if metadata.scene_capture_type
    puts "Gain Control: #{metadata.gain_control}" if metadata.gain_control
    puts "Contrast: #{metadata.contrast}" if metadata.contrast
    puts "Saturation: #{metadata.saturation}" if metadata.saturation
    puts "Sharpness: #{metadata.sharpness}" if metadata.sharpness
    puts "Image Description: #{metadata.image_description}" if metadata.image_description
    puts "Artist: #{metadata.artist}" if metadata.artist
    puts "Copyright: #{metadata.copyright}" if metadata.copyright
  end

  def human_readable_orientation(orientation) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
    case orientation.to_i
    when 1
      'Top-left'
    when 2
      'Top-right'
    when 3
      'Bottom-right'
    when 4
      'Bottom-left'
    when 5
      'Left-top'
    when 6
      'Right-top'
    when 7
      'Right-bottom'
    when 8
      'Left-bottom'
    else
      'Unknown'
    end
  end

  def print_mp3_metadata(file_path) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    Mp3Info.open(file_path) do |mp3| # rubocop:disable Metrics/BlockLength
      puts "\nAvaliable metadata for #{file_path}:\n\n".colorize(:green)
      puts "Title: #{mp3.tag.title}" if mp3.tag.title
      puts "Artist: #{mp3.tag.artist}" if mp3.tag.artist
      puts "Album: #{mp3.tag.album}" if mp3.tag.album
      puts "Year: #{mp3.tag.year}" if mp3.tag.year
      puts "Track: #{mp3.tag.tracknum}" if mp3.tag.tracknum
      puts "Genre: #{mp3.tag.genre_s}" if mp3.tag.genre_s
      puts "Length: #{mp3.length} seconds" if mp3.length
      puts "Bitrate: #{mp3.bitrate} kbps" if mp3.bitrate
      puts "Samplerate: #{mp3.samplerate} Hz" if mp3.samplerate
      puts "MPEG Version: #{mp3.mpeg_version}" if mp3.mpeg_version
      puts "Layer: #{mp3.layer}" if mp3.layer
      puts "Copyright: #{mp3.tag2['TCOP']}" if mp3.tag2['TCOP']
      puts "Original: #{mp3.tag2['TOPE']}" if mp3.tag2['TOPE']
      puts "Composer: #{mp3.tag2['TCOM']}" if mp3.tag2['TCOM']
      puts "Publisher: #{mp3.tag2['TPUB']}" if mp3.tag2['TPUB']
      puts "Encoded By: #{mp3.tag2['TENC']}" if mp3.tag2['TENC']
      puts "Album Artist: #{mp3.tag2['TPE2']}" if mp3.tag2['TPE2']
      puts "Disc Number: #{mp3.tag2['TPOS']}" if mp3.tag2['TPOS']
      puts "BPM: #{mp3.tag2['TBPM']}" if mp3.tag2['TBPM']
      puts "Language: #{mp3.tag2['TLAN']}" if mp3.tag2['TLAN']
      puts "Media Type: #{mp3.tag2['TMED']}" if mp3.tag2['TMED']
      puts "Mood: #{mp3.tag2['TMOO']}" if mp3.tag2['TMOO']
      puts "ISRC: #{mp3.tag2['TSRC']}" if mp3.tag2['TSRC']
      puts "Length: #{mp3.tag2['TLEN']}" if mp3.tag2['TLEN']
      puts "Track Gain: #{mp3.tag2['TXXX:replaygain_track_gain']}" if mp3.tag2['TXXX:replaygain_track_gain']
      puts "Track Peak: #{mp3.tag2['TXXX:replaygain_track_peak']}" if mp3.tag2['TXXX:replaygain_track_peak']
      puts "Album Gain: #{mp3.tag2['TXXX:replaygain_album_gain']}" if mp3.tag2['TXXX:replaygain_album_gain']
      puts "Album Peak: #{mp3.tag2['TXXX:replaygain_album_peak']}" if mp3.tag2['TXXX:replaygain_album_peak']
    end
  end

  def print_png_metadata(file_path)
    image = MiniMagick::Image.open(file_path)
    puts "\nAvaliable metadata for #{file_path}:\n\n".colorize(:green)
    format_data(file_path, image.data)
    quit_or_continue(Metadata)
  end

  def format_data(file_path, data, indent = 0)
    data.each do |key, value|
      value = file_path if key == 'name' && indent.zero?
      if value.is_a?(Hash)
        puts "#{' ' * indent}#{key.capitalize}:"
        format_data(file_path, value, indent + 2)
      else
        puts "#{' ' * indent}#{key.capitalize}: #{value}"
      end
    end
  end

  def print_pdf_metadata(file_path) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    reader = PDF::Reader.new(file_path)
    info = reader.info
    puts "\nAvaliable metadata for #{file_path}:\n\n".colorize(:green)

    # Define a list of metadata fields to check and print if they exist
    metadata_fields = {
      title: 'Title',
      author: 'Author',
      subject: 'Subject',
      keywords: 'Keywords',
      creator: 'Creator',
      producer: 'Producer',
      creation_date: 'Creation Date',
      mod_date: 'Modification Date',
      trapped: 'Trapped',
      format: 'Format',
      version: 'Version',
      encrypt: 'Encryption',
      perms: 'Permissions',
      linearized: 'Linearized'
    }

    # Print each metadata field if it exists
    metadata_fields.each do |key, label|
      value = info[key]
      puts "#{label}: #{value}" if value
    end

    # Additional metadata
    puts "Page Count: #{reader.page_count}" if reader.page_count
    page_size = begin
      reader.pages.first.attributes[:MediaBox]
    rescue StandardError
      nil
    end
    puts "Page Size: #{page_size}" if page_size

    quit_or_continue(Metadata)
  end
end
