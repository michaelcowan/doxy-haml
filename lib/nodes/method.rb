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

    def definition
      @definition ||= xpath_first_content %Q{definition}
    end

    def brief
      @brief ||= (xpath_first_content %Q{briefdescription/para}).strip
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{briefdescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{detaileddescription/para}).strip
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{detaileddescription/para}
    end

    def return_brief
      @return_brief ||= (xpath_first_content %Q{detaileddescription/para/simplesect[@kind='return']/para}).strip
    end

    def html_return_brief
      @html_return_brief ||= link_to_refs xpath_first %Q{detaileddescription/para/simplesect[@kind='return']/para}
    end

    def returns
      @returns ||= Type.new nil, self, xpath_first(%Q{type})
    end

  end

end