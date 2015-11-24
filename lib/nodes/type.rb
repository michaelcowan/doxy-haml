module DoxyHaml

  class Type < Node
    
    def name
      content
    end

    def html_name
      doxygen_markup @xml
    end

  end

end