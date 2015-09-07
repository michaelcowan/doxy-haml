module DoxyHaml

  class Method < Node
    
    def name
      xpath_first_content %Q{name}
    end

    def anchor
      id.to_s
    end

    def html_anchor
      link_to name, "##{anchor}"
    end

  end

end