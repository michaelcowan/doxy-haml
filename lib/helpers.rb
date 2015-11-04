module DoxyHaml

  module Helpers

    def map_node node
      list = []
      node.each do |node|
        list << (yield node)
      end
      list
    end

    def remove_namespace name
      name.split("::").last
    end

    def add_namespace namespace, name
      "#{namespace}::#{name}"
    end

    def replace_file_in_id id, file
      "#{file}_#{id_to_a_id id}"
    end


    def qualify node, recursive = true
      result = node.name
      if node.has_qualifying_parent?
        p = recursive ? qualify(node.parent) : node.parent.name
        result = add_namespace p, result
      end
      result
    end

    def html_qualify node, recursive = true
      result = node.html_name
      if node.has_qualifying_parent?
        p = recursive ? html_qualify(node.parent) : node.parent.html_name
        result = add_namespace p, result
      end
      result
    end

    def html_qualify_except_self node, recursive = true
      result = node.name
      if node.has_qualifying_parent?
        p = recursive ? html_qualify(node.parent) : node.parent.html_name
        result = add_namespace p, result
      end
      result
    end
    
  end

end

class String

  def squish
    dup.squish!
  end

  def squish!
    gsub!(/\A[[:space:]]+/, '')
    gsub!(/[[:space:]]+\z/, '')
    gsub!(/[[:space:]]+/, ' ')
    self
  end

end
