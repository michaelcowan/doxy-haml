require 'haml'
require 'fileutils'

module DoxyHaml

  class Renderer
    dynamic_requires = Dir[File.join(".", "helpers", "*.rb")]
    dynamic_requires.each { |r| require r }
    dynamic_requires.map! { |r| File.basename(r, ".*").split('_').map { |w| w.capitalize }.join }
    dynamic_requires.each { |r| include Object.const_get r }

    def initialize(index, layout, props)
      @index, @layout, @props = index, layout, props
    end

    def renderToFile(template, locals, file)
      FileUtils.mkdir_p File.dirname(file)
      File.open(file, 'w') do |f|
        f.write render(@layout) {
          render template, locals
        }
      end
    end

    def partial haml_file, locals
      render haml_file, locals
    end

    def method_missing method, *args
      if @index.respond_to? method
        @index.send method, *args
      else
        super
      end
    end

    private

    def render(haml_file, locals = {}, &block)
      haml = IO.read haml_file
      Haml::Engine.new(haml).render(binding, locals.merge(@props), &block)
    end

  end

end