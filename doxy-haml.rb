require 'optparse'
require 'html/proofer'
require 'colored'

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
  name: "My Project",
  skip_validation: false
}

def main
  start_time = Time.now

  puts "Generating Doxygen XML".yellow.underline
  generator = DoxyHaml::Generator.new
  generator.generate @opt[:xml_folder], @opt[:headers_folder], true

  puts "Parsing Doxygen XML".yellow.underline
  parser = DoxyHaml::Parser.new File.join(@opt[:xml_folder], "xml")

  puts "Rendering HAML".yellow.underline
  renderer = DoxyHaml::Renderer.new parser.index, @opt[:template_folder], "_layout", {title: @opt[:name]}

  static_pages(@opt[:template_folder]).each do |page|
    renderer.render_to_file static_page_output_path(page), page, {index: parser.index, title: @opt[:name]}
  end

  parser.index.namespaces.each do |namespace|
    renderer.render_to_file output_path(namespace.filename), "_namespace", {namespace: namespace, compound: namespace}
  end

  parser.index.classes.each do |clazz|
    renderer.render_to_file output_path(clazz.filename), "_clazz", {clazz: clazz, compound: clazz}
  end

  parser.index.files.each do |file|
    renderer.render_to_file output_path(file.filename), "_file", {file: file, compound: file}
  end

  unless @opt[:skip_validation]
    puts "Validating HTML".yellow.underline
    HTML::Proofer.new(@opt[:output_folder], {verbosity: :error, disable_external: true}).run
  end

  puts "Finished in #{(Time.now - start_time).round(1)} seconds!".green
end

def output_path filename
  File.join @opt[:output_folder], filename
end

def static_pages folder
  files = Dir[File.join(folder, "*")].select { |file| File.file? file }
  files.map! { |file| Pathname.new(file).basename.to_s }
  files.select { |file| not file.start_with?("_") }
end

def static_page_output_path page
  output_path File.basename(page, ".*")
end

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"
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
  opts.on("--skip-validation", "Skip validation of generated HTML") do |v|
    @opt[:skip_validation] = v
  end
end

opt_parser.parse!(ARGV)

main