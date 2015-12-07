module DoxyHaml

  class Type < Node
    
    def name
      content
    end

    def html_name
      parse_doxygen_description_to_html @xml
    end

  end

end