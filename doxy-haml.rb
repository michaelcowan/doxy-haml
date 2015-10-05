require 'optparse'
require 'byebug'

def root_path
  File.expand_path File.dirname(__FILE__)
end

$LOAD_PATH.unshift File.join(root_path, "lib")

%w(lib).each do |r|
  Dir["#{r}/*.rb"].each {|f| require_relative f}
end

@options = {
  headers_folder: "src/inc",
  xml_folder: "tmp/doc/doxygen",
  output_folder: "doc/api"
}

def main
  puts "Parsing Doxygen XML"
  parser = DoxyHaml::Parser.new File.join(@options[:xml_folder], "xml")

  puts "Rendering"
  parser.index.namespaces.each do |namespace|
    render_namespace namespace
    namespace.classes.each do |clazz|
      render_class clazz
    end
  end

end

def render_namespace namespace
  render "templates/_namespace.html.haml", {namespace: namespace}, output_full_path(namespace)
end

def render_class clazz
  render "templates/_clazz.html.haml", {clazz: clazz}, output_full_path(clazz)
end

def render template, locals, file
  DoxyHaml::Renderer.new(template, locals).writeToFile file
end

def output_full_path node
  File.join(@options[:output_folder], node.html_filename)
end

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{ARGV[0]} [options]" # TODO Get command name
  opts.separator "Specific options:"

  opts.on("-i FOLDER", "--in FOLDER", "C++ (input) folder. Default: #{@options[:headers_folder]}") do |v|
    @options[:headers_folder] = v
  end
  opts.on("-o FOLDER", "--out FOLDER", "HTML (output) folder. Default: #{@options[:output_folder]}") do |v|
    @options[:output_folder] = v
  end
end

opt_parser.parse!(ARGV)

main