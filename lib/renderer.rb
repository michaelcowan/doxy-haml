require 'haml'
require 'fileutils'

module DoxyHaml

  class Renderer
    dynamic_requires = Dir[File.join(".", "helpers", "*.rb")]
    dynamic_requires.each { |r| require r }
    dynamic_requires.map! { |r| File.basename(r, ".*").split('_').map { |w| w.capitalize }.join }
    dynamic_requires.each { |r| include Object.const_get r }

    def initialize(template_file, locals = nil)
      @template_file = template_file
      @locals = locals
    end

    def writeToFile(file)
      FileUtils.mkdir_p File.dirname(file)
      File.open(file, 'w') do |f|
        f.write render(@template_file, @locals)
      end
    end

    def partial template_file, locals
      render template_file, locals
    end

    private

    def render(template_file, locals = {})
      template = IO.read template_file
      if locals
        Haml::Engine.new(template).render(binding, locals)
      else
        Haml::Engine.new(template).render
      end
    end

  end

end