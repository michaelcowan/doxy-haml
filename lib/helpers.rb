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


    def qualify node
      result = node.name
      if node.has_qualifying_parent?
        p = qualify node.parent
        result = "#{p}::#{result}"
      end
      result
    end

    def html_qualify node
      result = node.html_name
      if node.has_qualifying_parent?
        p = html_qualify node.parent
        result = "#{p}::#{result}"
      end
      result
    end

    def html_qualify_except_self node
      result = node.name
      if node.has_qualifying_parent?
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
