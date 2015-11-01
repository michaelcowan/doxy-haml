module DoxyHaml

  class Class < Compound
    
    def abstract?
      @abstract ||= (xpath_param 'abstract') == 'yes'
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

  end

end