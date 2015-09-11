module DoxyHaml

  class Parameter < Node

    def initialize id, parent, xml, params
      super id, parent, xml
      @params = params
    end

    def name
      xpath_first_content @params, %Q{declname}
    end

    def type
      @type ||= Type.new nil, self, @params.xpath(%Q{type}).first
    end

    def has_default_value?
      not xpath_empty? @params, %Q{defval}
    end

    def default_value
      xpath_first_content @params, %Q{defval}
    end

    def has_direction?
      not xpath_first_param(%Q{parameternamelist/parametername}, "direction").nil?
    end

    def direction
      xpath_first_param %Q{parameternamelist/parametername}, "direction"
    end

    def html_definition
      "#{type.html_name} #{name}" + ("=#{default_value}" if has_default_value?).to_s
    end
  end

end