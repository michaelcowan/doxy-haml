require_relative 'helpers'

module DoxyHaml

  module HtmlUtilities

    def link_to *args, &block
      if block_given?
        # TODO url = args[0]
      else
        name, url = args[0], args[1]
        "<a href='#{url}'>#{name}</a>"
      end
    end

    def remove_namespace name
      name.split("::").last
    end

    def link_to_refs node
      list = map_node node.children do |child|
        child = (child.element? and child.name == "ref") ? link_to(child.content, "#{child['refid']}.html") : child
      end
      list.join.strip
    end

  end

end