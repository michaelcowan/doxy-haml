module DoxyHaml

  class Method < Definition

    def initialize id, parent, xml
      super id, parent, xml
      @params = xpath %Q{param}
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

    def has_return_brief?
      not xpath_empty? %Q{detaileddescription/para/simplesect[@kind='return']/para}
    end

    def return_brief
      @return_brief ||= (xpath_first_content %Q{detaileddescription/para/simplesect[@kind='return']/para}).squish
    end

    def html_return_brief
      @html_return_brief ||= link_to_refs xpath_first %Q{detaileddescription/para/simplesect[@kind='return']/para}
    end

    def has_return_type?
      not xpath_empty? %Q{type} and not return_type.name.eql?("void")
    end

    def return_type
      @returns ||= Type.new nil, self, xpath_first(%Q{type})
    end

    def constructor?
      name == parent.name
    end

    def destructor?
      name == "~#{parent.name}"
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
      @parameters ||= parse_parameters
    end

    def reimplements?
      not xpath_empty? %Q{reimplements}
    end

    def reimplements
      @reimplements ||= parse_reimplements
    end

    def reimplementedby?
      not xpath_empty? %Q{reimplementedby}
    end

    def reimplementedby
      @reimplementedby ||= parse_reimplementedby
    end

    private

    def parse_reimplements
      if reimplements?
        refid = xpath_first_param %Q{reimplements}, "refid"
        @reimplements = find_node_by_id refid
      end
    end

    def parse_reimplementedby
      if reimplementedby?
        @reimplementedby = map_xpath %Q{reimplementedby} do |method|
          find_node_by_id method['refid']
        end
      end
    end

    def parse_parameters
      if has_parameters? and xpath_empty? %Q{detaileddescription/para/parameterlist[@kind='param']/parameteritem}
        return @params.map do |param|
          Parameter.new "", self, nil, param
        end
      else
        return map_xpath_with_index %Q{detaileddescription/para/parameterlist[@kind='param']/parameteritem} do |parameter, index|
          Parameter.new "", self, parameter, @params[index]
        end
      end
    end

  end

end