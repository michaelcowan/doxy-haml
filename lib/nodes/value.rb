module DoxyHaml

  class Value < Node

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

    def has_brief?
      not xpath_empty? %Q{briefdescription/para}
    end

    def brief
      @brief ||= (xpath_first_content %Q{briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{briefdescription/para}
    end

    def has_description?
      not xpath_empty? %Q{detaileddescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{detaileddescription/para}
    end

  end

end