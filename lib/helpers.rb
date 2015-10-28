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

    def is_namespaceable? node
      not node.is_a? DoxyHaml::Global and not node.is_a? DoxyHaml::Index and not node.is_a? DoxyHaml::File
    end

    def qualify node
      result = node.name
      if is_namespaceable? node.parent
        p = qualify node.parent
        result = "#{p}::#{result}"
      end
      result
    end

    def html_qualify node
      result = node.html_name
      if is_namespaceable? node.parent
        p = html_qualify node.parent
        result = "#{p}::#{result}"
      end
      result
    end

    def html_qualify_except_self node
      result = node.name
      if is_namespaceable? node.parent
        p = html_qualify node.parent
        result = "#{p}::#{result}"
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
