module DoxyHaml

  class Class < Compound

    def name
      remove_namespace qualified_name
    end

    def qualified_name
      @qualified_name ||= xpath_first_content %Q{/doxygen/compounddef/compoundname}
    end

    def html_qualified_name
      link_to_self qualified_name
    end
    
    def abstract?
      @abstract ||= (xpath_first_param %Q{/doxygen/compounddef}, 'abstract') == 'yes'
    end

    def public_methods
      @public_methods ||= map_xpath %Q{/doxygen/compounddef/sectiondef[@kind='public-func']/memberdef} do |method|
        Method.new method['id'], self, method
      end
    end

    def public_static_methods

    end

  end

end