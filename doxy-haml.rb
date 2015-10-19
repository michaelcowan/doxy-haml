require 'optparse'
require 'byebug'

def root_path
  File.expand_path File.dirname(__FILE__)
end

$LOAD_PATH.unshift File.join(root_path, "lib")

%w(lib).each do |r|
  Dir["#{r}/*.rb"].each {|f| require_relative f}
end

@opt = {
  xml_folder: "tmp/doc/doxygen",
  headers_folder: "src/inc",
  output_folder: "doc/api",
  template_folder: "templates/default",
  name: "My Project"
}

def main
  start_time = Time.now

  puts "Generating Doxygen XML"
  generator = DoxyHaml::Generator.new
  generator.generate @opt[:xml_folder], @opt[:headers_folder], true

  puts "Parsing Doxygen XML"
  parser = DoxyHaml::Parser.new File.join(@opt[:xml_folder], "xml")

  puts "Rendering"
  renderer = DoxyHaml::Renderer.new parser.index, @opt[:template_folder], "_layout", {title: @opt[:name]}

  parser.index.namespaces.each do |namespace|
    render renderer, "_namespace", {namespace: namespace, compound: namespace}, output_full_path(namespace)
  end

  parser.index.classes.each do |clazz|
    render renderer, "_clazz", {clazz: clazz, compound: clazz}, output_full_path(clazz)
  end

  puts "Finished in #{(Time.now - start_time).round(1)} seconds!"
end

def render renderer, template, locals, file
  renderer.renderToFile(template, locals, file)
end

def output_full_path compound
  File.join @opt[:output_folder], compound.filename
end

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{ARGV[0]} [options]"
  opts.separator "Specific options:"

  opts.on("-i FOLDER", "--in FOLDER", "C++ (input) folder. Default: '#{@opt[:headers_folder]}'") do |v|
    @opt[:headers_folder] = v
  end
  opts.on("-o FOLDER", "--out FOLDER", "HTML (output) folder. Default: '#{@opt[:output_folder]}'") do |v|
    @opt[:output_folder] = v
  end
  opts.on("-t TEMPLATE", "--template", "Template (theme) folder. Default: '#{@opt[:template_folder]}'") do |v|
    @opt[:template_folder] = v
  end
  opts.on("-n NAME", "--name", "The name of the project. Default: '#{@opt[:name]}'") do |v|
    @opt[:name] = v
  end
end

opt_parser.parse!(ARGV)

main