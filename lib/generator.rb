require 'pathname'

module DoxyHaml

  class Generator

    def generate output_folder, name, input, recursive
      input = Array(input) unless input.is_a? Array
      input = relative_path_array input, output_folder

      contents = create_doxyfile name, input, recursive
      write_doxyfile output_folder, contents
      execute_doxygen output_folder
    end

    private

    def relative_path_array input, output_folder
      input.map! { |i| relative_path(output_folder, i) }
      input = input.join(' ')
    end

    def relative_path first, second
      second = Pathname.new(second).relative_path_from(Pathname.new(first))
    end

    def create_doxyfile name, input, recursive
      doxyfile = <<-EOF
# Doxyfile Generated by DoxyHaml
PROJECT_NAME     = #{name}
INPUT            = #{input}
RECURSIVE        = #{yes_no recursive}
QUIET            = YES
GENERATE_XML     = YES
GENERATE_HTML    = NO
GENERATE_LATEX   = NO
CASE_SENSE_NAMES = NO
      EOF
    end

    def write_doxyfile folder, contents
      FileUtils::mkdir_p folder
      doxyfile = File.join folder, "Doxyfile"
      File.open doxyfile, 'w' do |f|
        f.write contents
      end
    end

    def execute_doxygen folder
      Dir.chdir folder do
        system "doxygen"
      end
    end

    def yes_no value
      value ? 'YES' : 'NO'
    end

  end

end