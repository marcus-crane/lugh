require "./file"

require "option_parser"

module Lugh
  VERSION = "0.0.1"

  OptionParser.parse do |parser|
    parser.banner = "Lugh is a tool for literate programming\n\nUsage: lugh [flag] [argument]\n"

    parser.on "-v", "--version", "Show version" do
      puts "Running version #{VERSION}"
      exit
    end

    parser.on "-h", "--help", "Show help" do
      puts parser
      exit
    end

    parser.on "-f FILENAME", "--file=FILENAME", "Parse file" do |filename|
      if filename == ""
        puts "no filename provided"
        exit
      end
      file = File::Renderer.new
      file.load(filename)
      file.render
      exit
    end

    parser.missing_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is missing something."
      STDERR.puts ""
      STDERR.puts parser
      exit(1)
    end

    parser.invalid_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end

    if ARGV.empty?
      puts parser
      exit
    end
  end
end
