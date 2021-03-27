require "./markdown"

class File::Renderer
  def initialize
    @output_directory = ""

    @parser = Markdown::Parser.new
  end

  def load(filename : String)
    file_path = File.expand_path(filename)
    @output_directory = File.dirname(file_path)
    file = File.open(file_path)
    @parser.parse file.gets_to_end
    file.close
  end

  def render
    filename, contents = @parser.export
    destination = "#{@output_directory}/#{filename}"
    File.write(destination, contents)
    puts "Wrote #{destination}"
  end
end
