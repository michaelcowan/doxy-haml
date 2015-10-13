module DoxyHaml

  class Class < Compound
    
    def abstract?
      @abstract ||= (xpath_param 'abstract') == 'yes'
    end

    def has_public_methods?
      not public_methods.empty?
    end

    def public_methods
      @public_methods ||= sort_methods parse_public_methods
    end

    def has_public_static_methods?
      not public_static_methods.empty?
    end

    def public_static_methods
      @public_static_methods ||= sort_methods parse_public_static_methods
    end

    def has_public_enums?
      not public_enums.empty?
    end

    def public_enums
      @public_enums ||= sort_by_name parse_public_enums
    end

    def has_public_variables?
      not public_variables.empty?
    end

    def public_variables
      @public_variables ||= sort_by_name parse_public_variables
    end

    def has_public_static_variables?
      not public_static_variables.empty?
    end

    def public_static_variables
      @public_static_variables ||= sort_by_name parse_public_static_variables
    end

    def is_struct?
      @is_struct ||= (xpath_param 'kind') == 'struct'
    end

    def has_public_super_classes?
      not public_super_classes.empty?
    end

    def public_super_classes
      @public_super_classes ||= parse_public_super_classes
    end

    def has_public_derived_classes?
      not public_derived_classes.empty?
    end

    def public_derived_classes
      @public_derived_classes ||= parse_public_derived_classes
    end

    private

    def memberdef_xpath access_level, kind, static
      "sectiondef[@kind='#{access_level}']/memberdef[@kind='#{kind}' and @static='#{static}']"
    end

    def basecompoundref_xpath prot
      "basecompoundref[@prot='#{prot}']"
    end

    def derivedcompoundref_xpath prot
      "derivedcompoundref[@prot='#{prot}']"
    end

    def parse_public_methods
      map_xpath memberdef_xpath("public-func", "function", "no") do |method|
        Method.new method['id'], self, method
      end
    end

    def parse_public_static_methods
      map_xpath memberdef_xpath("public-static-func", "function", "yes") do |method|
        Method.new method['id'], self, method
      end
    end

    def parse_public_enums
      map_xpath memberdef_xpath("public-type", "enum", "no") do |enum|
        Enum.new enum['id'], self, enum
      end
    end

    def parse_public_variables
      map_xpath memberdef_xpath("public-attrib", "variable", "no") do |variable|
        Variable.new variable['id'], self, variable
      end
    end

    def parse_public_static_variables
      map_xpath memberdef_xpath("public-static-attrib", "variable", "yes") do |variable|
        Variable.new variable['id'], self, variable
      end
    end

    def parse_public_super_classes
      map_xpath basecompoundref_xpath("public") do |basecompoundref|
        find_node_by_id basecompoundref['refid']
      end
    end

    def parse_public_derived_classes
      map_xpath derivedcompoundref_xpath("public") do |derivedcompoundref|
        find_node_by_id derivedcompoundref['refid']
      end
    end

    def sort_methods methods
      methods.sort_by { |m| [m.name, m.parameters.count] }.partition { |m| m.destructor? }.flatten.partition { |m| m.constructor? }.flatten
    end

  end

end