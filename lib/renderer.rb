require 'haml'
require 'fileutils'

module DoxyHaml

  class Renderer

    def initialize index, template_folder, layout, props
      @index, @template_folder, @layout, @props = index, template_folder, layout, props

      load_helpers @template_folder
    end

    def render_to_file file, template, locals
      FileUtils.mkdir_p ::File.dirname(file)
      ::File.open(file, 'w') do |f|
        if file.end_with? ".html"
          f.write render(@layout, locals) { render template, locals }
        else
          f.write render template, locals
        end
      end
    end

    def partial haml_file, locals
      render partial_name(haml_file), locals
    end

    def method_missing method, *args
      if @index.respond_to? method
        @index.send method, *args
      end
    end

    private

    def render(haml_file, locals = {}, &block)
      haml = IO.read template_file(haml_file)
      Haml::Engine.new(haml).render(binding, locals.merge(@props), &block)
    end

    def template_path file
      ::File.join @template_folder, file
    end

    def template_file file
      path = template_path file
      ["", ".html", ".haml", ".html.haml"].each do |ext|
        filename = path + ext
        return filename if ::File.exists? filename
      end
      nil
    end

    def load_helpers path
      dynamic_requires = Dir[::File.join(".", path, "helpers", "*.rb")]
      dynamic_requires.each { |r| require r }
      dynamic_requires.map! { |r| ::File.basename(r, ".*").split('_').map { |w| w.capitalize }.join }
      dynamic_requires.each { |r| extend Object.const_get r }
    end

    def partial_name name
      name = "_#{name}" unless name.start_with?("_")
      name
    end

  end

end