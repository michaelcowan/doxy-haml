module DoxyHaml

  class Type < Node
    
    def name
      content
    end

    def html_name
      doxygen_markup_to_html @xml
    end

  end

end