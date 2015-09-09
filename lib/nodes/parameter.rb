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

  end

end