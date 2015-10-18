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
  start_time = Time.now

  puts "Generating Doxygen XML"
  generator = DoxyHaml::Generator.new
  generator.generate @options[:xml_folder], @options[:headers_folder], true

  puts "Parsing Doxygen XML"
  parser = DoxyHaml::Parser.new File.join(@options[:xml_folder], "xml")

  puts "Rendering"
  renderer = DoxyHaml::Renderer.new parser.index, "templates/_layout.html.haml", {title: "The Zoo"}

  parser.index.namespaces.each do |namespace|
    render renderer, "templates/_namespace.html.haml", {namespace: namespace, compound: namespace}, output_full_path(namespace)
  end

  parser.index.classes.each do |clazz|
    render renderer, "templates/_clazz.html.haml", {clazz: clazz, compound: clazz}, output_full_path(clazz)
  end

  puts "Finished in #{(Time.now - start_time).round(1)} seconds!"
end

def render renderer, template, locals, file
  renderer.renderToFile(template, locals, file)
end

def output_full_path compound
  File.join(@options[:output_folder], compound.filename)
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