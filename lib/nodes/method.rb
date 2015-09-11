module DoxyHaml

  class Method < Node

    def initialize id, parent, xml
      super id, parent, xml
      @params = xpath %Q{param}
    end
    
    def name
      xpath_first_content %Q{name}
    end

    def html_name
      link_to name, id_to_href_anchor(id)
    end

    def qualified_name
      qualify self
    end

    def html_qualified_name
      html_qualify self
    end

    def html_qualified_name_except_self
      html_qualify_except_self self
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

    def html_definition
      p = parameters.map { |p| p.html_definition }.join(', ')
      s = "#{return_type.html_name} #{html_qualified_name_except_self}(#{p})"
      s.prepend "virtual " if virtual? or pure_virtual?
      s += (" const " if const?).to_s + ("=0" if pure_virtual?).to_s
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

    def has_return_brief?
      not xpath_empty? %Q{detaileddescription/para/simplesect[@kind='return']/para}
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
      @virtual ||= (xpath_param 'virt') == 'virtual'
    end

    def pure_virtual?
      @pure_virtual ||= (xpath_param 'virt') == 'pure-virtual'
    end

    def const?
      @const ||= (xpath_param 'const') == 'yes'
    end

    def has_parameters?
      not xpath_empty? %Q{param}
    end

    def parameters
      @parameters ||= map_xpath_with_index %Q{detaileddescription/para/parameterlist[@kind='param']/parameteritem} do |parameter, index|
        Parameter.new parameter['id'], self, parameter, @params[index]
      end
    end

  end

end