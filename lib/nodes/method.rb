module DoxyHaml

  class Method < Node
    
    def name
      xpath_first_content %Q{name}
    end

  end

end