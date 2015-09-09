module DoxyHaml

  class Method < Node
    
    def name
      xpath_first_content %Q{name}
    end

    def html_name
      link_to name, id_to_href_anchor(id)
    end

    def anchor
      id_to_a_id id
    end

    def html_anchor
      anchor_for id_to_a_id(id)
    end

    def definition
      @definition ||= (xpath_first_content(%Q{definition}) + xpath_first_content(%Q{argsstring})).squish
    end

    def brief
      @brief ||= (xpath_first_content %Q{briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{briefdescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{detaileddescription/para}
    end

    def return_brief
      @return_brief ||= (xpath_first_content %Q{detaileddescription/para/simplesect[@kind='return']/para}).squish
    end

    def html_return_brief
      @html_return_brief ||= link_to_refs xpath_first %Q{detaileddescription/para/simplesect[@kind='return']/para}
    end

    def return_type
      @returns ||= Type.new nil, self, xpath_first(%Q{type})
    end

    def virtual?
      @virtual ||= (xpath_param 'virt') == 'pure-virtual'
    end

    def has_arguments?
      not @xml.xpath(%Q{param}).empty?
    end

  end

end