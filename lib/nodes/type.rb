module DoxyHaml

  class Type < Node
    
    def name
      content
    end

    def html_name
      link_to_refs @xml
    end

  end

end