class Markdown::Parser
  @lines : Array(String)

  def initialize
    @line = 0
    @lines = Array(String).new
    @output = Array(String).new
    @destination = ""
    @inside_fenced_code = false
    @inside_frontmatter = false
  end

  def parse(text : String)
    @lines = text.lines.map &.rstrip # Ensure we don't strip any needed whitespace
    while @line < @lines.size
      line_contents = @lines[@line]
      was_inside_fenced_code = @inside_fenced_code

      if starts_with_backticks? line_contents
        check_inside_fenced_code? line_contents
        if !@inside_fenced_code && @inside_fenced_code != was_inside_fenced_code
          @output.push("\n")
        end
      else
        if @inside_fenced_code
          @output.push(line_contents)
        end
      end

      if starts_with_dashes? line_contents
        check_inside_frontmatter? line_contents
      end

      if @inside_frontmatter
        if contains_semicolon? line_contents
          key, value = line_contents.split ":"
          if key == "output"
            @destination = value.lstrip
          end
        end
      end

      @line += 1
    end

    if @destination.empty?
      puts "No output key found in source file! No idea where to write to."
      exit(1)
    end
  end

  def export
    file_contents = @output.join "\n"
    file_contents = file_contents.gsub("\n\n\n", "\n\n") # Block separator \n's end up with their own \n
    return @destination, file_contents
  end

  def check_inside_fenced_code?(line)
    if @inside_fenced_code
      @inside_fenced_code = false
    else
      @inside_fenced_code = true
    end
  end

  def check_inside_frontmatter?(line)
    if @inside_frontmatter
      @inside_frontmatter = false
    else
      @inside_frontmatter = true
    end
  end

  def starts_with_dashes?(line)
    line.starts_with? "---"
  end

  def starts_with_backticks?(line)
    line.starts_with? "```"
  end

  def contains_semicolon?(line)
    line.includes? ":"
  end
end
