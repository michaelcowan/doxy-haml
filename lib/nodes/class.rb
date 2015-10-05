module DoxyHaml

  class Class < Compound
    
    def abstract?
      @abstract ||= (xpath_param 'abstract') == 'yes'
    end

    def has_public_methods?
      not public_methods.empty?
    end

    def public_methods
      @public_methods ||= map_xpath memberdef_xpath("public-func", "function", "no") do |method|
        Method.new method['id'], self, method
      end
    end

    def has_public_static_methods?
      not public_static_methods.empty?
    end

    def public_static_methods
      @public_static_methods ||= map_xpath memberdef_xpath("public-static-func", "function", "yes") do |method|
        Method.new method['id'], self, method
      end
    end

    def has_public_enums?
      not public_enums.empty?
    end

    def public_enums
      @public_enums ||= map_xpath memberdef_xpath("public-type", "enum", "no") do |enum|
        Enum.new enum['id'], self, enum
      end
    end

    def has_public_variables?
      not public_variables.empty?
    end

    def public_variables
      @public_variables ||= map_xpath memberdef_xpath("public-attrib", "variable", "no") do |variable|
        Variable.new variable['id'], self, variable
      end
    end

    def has_public_static_variables?
      not public_static_variables.empty?
    end

    def public_static_variables
      @public_static_variables ||= map_xpath memberdef_xpath("public-static-attrib", "variable", "yes") do |variable|
        Variable.new variable['id'], self, variable
      end
    end

    def is_struct?
      @is_struct ||= (xpath_param 'kind') == 'struct'
    end

    private

    def memberdef_xpath access_level, kind, static
      "sectiondef[@kind='#{access_level}']/memberdef[@kind='#{kind}' and @static='#{static}']"
    end

  end

end