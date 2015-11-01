module DoxyHaml

  class Class < Compound
    
    def abstract?
      @abstract ||= (xpath_param 'abstract') == 'yes'
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

    def basecompoundref_xpath prot
      "basecompoundref[@prot='#{prot}']"
    end

    def derivedcompoundref_xpath prot
      "derivedcompoundref[@prot='#{prot}']"
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