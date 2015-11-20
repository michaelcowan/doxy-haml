require_relative 'helpers'

module DoxyHaml

  module HtmlUtilities
    include Helpers

    def link_to *args, &block
      if block_given?
        # TODO url = args[0]
      else
        name, url = args[0], args[1]
        "<a href='#{url}'>#{name}</a>"
      end
    end

    def anchor_for id
      "<a id='#{id}'/>"
    end

    def link_to_refs node
      list = map_node node.children do |child|
        child = (!child.text? and child.name == "ref") ? link_to_refid(child) : child
      end
      list.join.strip
    end

    def id_to_href id
      return "#{id}.html" unless /_[a-z0-9]{34,}/.match id
      *a, b = id.split('_', -1)
      "#{a.join('_')}.html##{b}"
    end

    def id_to_a_id id
      raise "String does not contain an id" unless id =~ /[a-zA-Z0-9]{34}$/
      id.split('_').last
    end

    def link_to_refid node
      link_to(node.content, id_to_href(node['refid']))
    end


  end

end