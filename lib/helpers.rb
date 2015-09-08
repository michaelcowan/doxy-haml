module DoxyHaml

  module Helpers

    def map_node node
      list = []
      node.each do |node|
        list << (yield node)
      end
      list
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
